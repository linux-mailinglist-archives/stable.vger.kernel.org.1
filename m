Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B071379BA04
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238048AbjIKVaj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241965AbjIKPTM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:19:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F27FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:19:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB9CC433C7;
        Mon, 11 Sep 2023 15:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445547;
        bh=qGcd7qRDux0RXtA1dRWOAh7f0Xz9gPXf5QSalVachBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rqFRv0xzHHbiXl4ZSo8SOJcWBTYHnx/3FO3YGFH0I9Wc8t0kMjaYsY8Be/2gRBRt6
         rB7RKywo+udNuag5OiGZ3S7kIz55d3xlOJdq0hpe4rU0qBcI6jivpnYj1LYUbWndJI
         UsL0IX37cBNloHx9otg3PC/eHGvPMTv7Zqd8WODk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Benjamin Coddington <bcodding@redhat.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 386/600] NFS: Guard against READDIR loop when entry names exceed MAXNAMELEN
Date:   Mon, 11 Sep 2023 15:46:59 +0200
Message-ID: <20230911134645.069997889@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Coddington <bcodding@redhat.com>

[ Upstream commit f67b55b6588bcf9316a1e6e8d529100a5aa3ebe6 ]

Commit 64cfca85bacd asserts the only valid return values for
nfs2/3_decode_dirent should not include -ENAMETOOLONG, but for a server
that sends a filename3 which exceeds MAXNAMELEN in a READDIR response the
client's behavior will be to endlessly retry the operation.

We could map -ENAMETOOLONG into -EBADCOOKIE, but that would produce
truncated listings without any error.  The client should return an error
for this case to clearly assert that the server implementation must be
corrected.

Fixes: 64cfca85bacd ("NFS: Return valid errors from nfs2/3_decode_dirent()")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs2xdr.c | 2 +-
 fs/nfs/nfs3xdr.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
index 05c3b4b2b3dd8..c190938142960 100644
--- a/fs/nfs/nfs2xdr.c
+++ b/fs/nfs/nfs2xdr.c
@@ -949,7 +949,7 @@ int nfs2_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 
 	error = decode_filename_inline(xdr, &entry->name, &entry->len);
 	if (unlikely(error))
-		return -EAGAIN;
+		return error == -ENAMETOOLONG ? -ENAMETOOLONG : -EAGAIN;
 
 	/*
 	 * The type (size and byte order) of nfscookie isn't defined in
diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index 3b0b650c9c5ab..60f032be805ae 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -1991,7 +1991,7 @@ int nfs3_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 
 	error = decode_inline_filename3(xdr, &entry->name, &entry->len);
 	if (unlikely(error))
-		return -EAGAIN;
+		return error == -ENAMETOOLONG ? -ENAMETOOLONG : -EAGAIN;
 
 	error = decode_cookie3(xdr, &new_cookie);
 	if (unlikely(error))
-- 
2.40.1



