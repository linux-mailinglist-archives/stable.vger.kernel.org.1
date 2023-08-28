Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB3178AA07
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjH1KSH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjH1KRx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:17:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD11118
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:17:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E360463746
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D66C433C8;
        Mon, 28 Aug 2023 10:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693217861;
        bh=HgWyuBtbh0wZqjC4Bp9BsFdyE2kryrz6E70ioROZqv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U0u8zyXMh2XOTXIU/uKgH699QU3DAdquBGbI/bItAQg1o2SNVKNhp+/2u5SG1W0f5
         FwfOa1G+fBKFEAWuqtgnnY8/K3oj5PF2nGUbE0alWv4osw7rHA4dF24zbjKDb4Dnyw
         GefvVCMflXRUGwVtIpX5oMC7FPOJV7zWf7Chxlz4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fedor Pchelkin <pchelkin@ispras.ru>,
        Benjamin Coddington <bcodding@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 001/129] NFSv4.2: fix error handling in nfs42_proc_getxattr
Date:   Mon, 28 Aug 2023 12:11:20 +0200
Message-ID: <20230828101157.435582071@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fedor Pchelkin <pchelkin@ispras.ru>

[ Upstream commit 4e3733fd2b0f677faae21cf838a43faf317986d3 ]

There is a slight issue with error handling code inside
nfs42_proc_getxattr(). If page allocating loop fails then we free the
failing page array element which is NULL but __free_page() can't deal with
NULL args.

Found by Linux Verification Center (linuxtesting.org).

Fixes: a1f26739ccdc ("NFSv4.2: improve page handling for GETXATTR")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs42proc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 93e306bf4430f..5d7e0511f3513 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -1360,7 +1360,6 @@ ssize_t nfs42_proc_getxattr(struct inode *inode, const char *name,
 	for (i = 0; i < np; i++) {
 		pages[i] = alloc_page(GFP_KERNEL);
 		if (!pages[i]) {
-			np = i + 1;
 			err = -ENOMEM;
 			goto out;
 		}
@@ -1384,8 +1383,8 @@ ssize_t nfs42_proc_getxattr(struct inode *inode, const char *name,
 	} while (exception.retry);
 
 out:
-	while (--np >= 0)
-		__free_page(pages[np]);
+	while (--i >= 0)
+		__free_page(pages[i]);
 	kfree(pages);
 
 	return err;
-- 
2.40.1



