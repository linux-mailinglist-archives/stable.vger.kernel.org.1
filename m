Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DAE726AFE
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjFGUVl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbjFGUVg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:21:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30602693
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:21:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4E9A64367
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4AAC4339B;
        Wed,  7 Jun 2023 20:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169266;
        bh=D5VTqr5ulOBjssvO6c+3ZgE5wL9xut81xojr8puHmiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ppEYybcHj+FN4+EepR6/fm0/qVvtkVoeymsLP/KU4hfAWWjjSyJNHnsf5Tj55ry/K
         jtAqVNNPb1x0+msbbU8MNPfeAuNmJNH+YndMDkSNQU1J1LGcG4smk6oPzX91KDTJ9D
         fRF+AyS054gr4I+cLRnjhND9jmWHTXJBmffITZ7c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhi Li <yieli@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 016/286] nfsd: make a copy of struct iattr before calling notify_change
Date:   Wed,  7 Jun 2023 22:11:55 +0200
Message-ID: <20230607200923.538751938@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit d53d70084d27f56bcdf5074328f2c9ec861be596 ]

notify_change can modify the iattr structure. In particular it can
end up setting ATTR_MODE when ATTR_KILL_SUID is already set, causing
a BUG() if the same iattr is passed to notify_change more than once.

Make a copy of the struct iattr before calling notify_change.

Reported-by: Zhi Li <yieli@redhat.com>
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2207969
Tested-by: Zhi Li <yieli@redhat.com>
Fixes: 34b91dda7124 ("NFSD: Make nfsd4_setattr() wait before returning NFS4ERR_DELAY")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/vfs.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 5783209f17fc5..e4884dde048ce 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -536,7 +536,15 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	inode_lock(inode);
 	for (retries = 1;;) {
-		host_err = __nfsd_setattr(dentry, iap);
+		struct iattr attrs;
+
+		/*
+		 * notify_change() can alter its iattr argument, making
+		 * @iap unsuitable for submission multiple times. Make a
+		 * copy for every loop iteration.
+		 */
+		attrs = *iap;
+		host_err = __nfsd_setattr(dentry, &attrs);
 		if (host_err != -EAGAIN || !retries--)
 			break;
 		if (!nfsd_wait_for_delegreturn(rqstp, inode))
-- 
2.39.2



