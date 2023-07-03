Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B794B7462F9
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 20:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjGCS4X (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 14:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjGCS4W (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 14:56:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B46E70
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 11:56:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 495E760FF1
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 18:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63614C433C7;
        Mon,  3 Jul 2023 18:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688410580;
        bh=TE0mFY3Must18Ex0giXvU+DY/z4D7YzXzozS8O1LrOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=queoqXX9J9b5Rh/nbWQIJIEJyPnM4+wpAhXM+kx0/s3W+pvrAKSjKnNAivsmMCuT0
         MNPFNyGwVd6zRDVl5iwEORZjeoZHLCSLuZprT6ZbafvpmChvdj6TBapn92uQVpTHlc
         Q12HGlKNQ4wg8RdAj/aT6mHAXkAWyum71uhwZF0A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jeff Layton <jlayton@kernel.org>,
        Boyang Xue <bxue@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 6.3 06/13] nfs: dont report STATX_BTIME in ->getattr
Date:   Mon,  3 Jul 2023 20:54:16 +0200
Message-ID: <20230703184519.387886611@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703184519.206275653@linuxfoundation.org>
References: <20230703184519.206275653@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

commit cded49ba366220ae7009d71c5804baa01acfb860 upstream.

NFS doesn't properly support reporting the btime in getattr (yet), but
61a968b4f05e mistakenly added it to the request_mask. This causes statx
for STATX_BTIME to report a zeroed out btime instead of properly
clearing the flag.

Cc: stable@vger.kernel.org # v6.3+
Fixes: 61a968b4f05e ("nfs: report the inode version in getattr if requested")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2214134
Reported-by: Boyang Xue <bxue@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index a910b9a638c5..8172dd4135a1 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -845,7 +845,7 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 
 	request_mask &= STATX_TYPE | STATX_MODE | STATX_NLINK | STATX_UID |
 			STATX_GID | STATX_ATIME | STATX_MTIME | STATX_CTIME |
-			STATX_INO | STATX_SIZE | STATX_BLOCKS | STATX_BTIME |
+			STATX_INO | STATX_SIZE | STATX_BLOCKS |
 			STATX_CHANGE_COOKIE;
 
 	if ((query_flags & AT_STATX_DONT_SYNC) && !force_sync) {
-- 
2.41.0



