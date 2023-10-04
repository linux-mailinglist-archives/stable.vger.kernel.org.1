Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBEE7B8919
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244099AbjJDSWr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244089AbjJDSWq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:22:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68D7BF
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:22:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5B5C433CC;
        Wed,  4 Oct 2023 18:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443763;
        bh=c5KR1Ns+JvozaVufj6vwrrNTWvJE/EtduLjanQhwTts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JNmXxXXueQ5V0ZB/z2alH1oikkZapo5N/wvPRl0Blkmga2FS2gLVb0BsjuYr4JZlK
         3AQfbZUV4cV3tVZenZF0yDbkPEW7cxRFjT4fN1c/2Lv3ohluH00cir2+ZagAawPrV+
         ubh8hjvADdlrDzGx1ssOzd9lsT1QRVkMWZiA3DeU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 012/321] gfs2: Fix another freeze/thaw hang
Date:   Wed,  4 Oct 2023 19:52:37 +0200
Message-ID: <20231004175229.766915048@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit 52954b750958dcab9e44935f0c32643279091c85 ]

On a thawed filesystem, the freeze glock is held in shared mode.  In
order to initiate a cluster-wide freeze, the node initiating the freeze
drops the freeze glock and grabs it in exclusive mode.  The other nodes
recognize this as contention on the freeze glock; function
freeze_go_callback is invoked.  This indicates to them that they must
freeze the filesystem locally, drop the freeze glock, and then
re-acquire it in shared mode before being able to unfreeze the
filesystem locally.

While a node is trying to re-acquire the freeze glock in shared mode,
additional contention can occur.  In that case, the node must behave in
the same way as above.

Unfortunately, freeze_go_callback() contains a check that causes it to
bail out when the freeze glock isn't held in shared mode.  Fix that to
allow the glock to be unlocked or held in shared mode.

In addition, update a reference to trylock_super() which has been
renamed to super_trylock_shared() in the meantime.

Fixes: b77b4a4815a9 ("gfs2: Rework freeze / thaw logic")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/glops.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 54319328b16b5..0a3b069386ec9 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -567,15 +567,16 @@ static void freeze_go_callback(struct gfs2_glock *gl, bool remote)
 	struct super_block *sb = sdp->sd_vfs;
 
 	if (!remote ||
-	    gl->gl_state != LM_ST_SHARED ||
+	    (gl->gl_state != LM_ST_SHARED &&
+	     gl->gl_state != LM_ST_UNLOCKED) ||
 	    gl->gl_demote_state != LM_ST_UNLOCKED)
 		return;
 
 	/*
 	 * Try to get an active super block reference to prevent racing with
-	 * unmount (see trylock_super()).  But note that unmount isn't the only
-	 * place where a write lock on s_umount is taken, and we can fail here
-	 * because of things like remount as well.
+	 * unmount (see super_trylock_shared()).  But note that unmount isn't
+	 * the only place where a write lock on s_umount is taken, and we can
+	 * fail here because of things like remount as well.
 	 */
 	if (down_read_trylock(&sb->s_umount)) {
 		atomic_inc(&sb->s_active);
-- 
2.40.1



