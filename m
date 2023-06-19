Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09227735548
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 13:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjFSLDX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 07:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjFSLCq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 07:02:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1ED19B6
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 04:01:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 763A960B7F
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 11:01:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2C6C433C0;
        Mon, 19 Jun 2023 11:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172510;
        bh=ERqVmWdpMJU1thQQ/nOlfnOZhQz6BrPisq2C5hvVqrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CD0IRstvdjPN0+QtMAFi+a3yw6FSSgXr8uJaH2Iy46bwtW7KWBZdtgY5ErcGPhjQk
         vOBKfcEEGUY5XUfqhDxQYrgX79vpWqUhPNFb3KCXc6apOUFrdFlZVd2ezSXy61kjCJ
         8pSK42zzUdNbN4WUNH9zToU+U4ylVOXyLM0EPDck=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Lingfeng <lilingfeng3@huawei.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 095/107] dm: dont lock fs when the map is NULL during suspend or resume
Date:   Mon, 19 Jun 2023 12:31:19 +0200
Message-ID: <20230619102145.895702780@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102141.541044823@linuxfoundation.org>
References: <20230619102141.541044823@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Li Lingfeng <lilingfeng3@huawei.com>

[ Upstream commit 2760904d895279f87196f0fa9ec570c79fe6a2e4 ]

As described in commit 38d11da522aa ("dm: don't lock fs when the map is
NULL in process of resume"), a deadlock may be triggered between
do_resume() and do_mount().

This commit preserves the fix from commit 38d11da522aa but moves it to
where it also serves to fix a similar deadlock between do_suspend()
and do_mount().  It does so, if the active map is NULL, by clearing
DM_SUSPEND_LOCKFS_FLAG in dm_suspend() which is called by both
do_suspend() and do_resume().

Fixes: 38d11da522aa ("dm: don't lock fs when the map is NULL in process of resume")
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-ioctl.c | 5 +----
 drivers/md/dm.c       | 4 ++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 438c0b77bb48c..815c41e1ebdb8 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1145,13 +1145,10 @@ static int do_resume(struct dm_ioctl *param)
 	/* Do we need to load a new map ? */
 	if (new_map) {
 		sector_t old_size, new_size;
-		int srcu_idx;
 
 		/* Suspend if it isn't already suspended */
-		old_map = dm_get_live_table(md, &srcu_idx);
-		if ((param->flags & DM_SKIP_LOCKFS_FLAG) || !old_map)
+		if (param->flags & DM_SKIP_LOCKFS_FLAG)
 			suspend_flags &= ~DM_SUSPEND_LOCKFS_FLAG;
-		dm_put_live_table(md, srcu_idx);
 		if (param->flags & DM_NOFLUSH_FLAG)
 			suspend_flags |= DM_SUSPEND_NOFLUSH_FLAG;
 		if (!dm_suspended_md(md))
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 8bc121d394471..d6285a23dc3ed 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2526,6 +2526,10 @@ int dm_suspend(struct mapped_device *md, unsigned suspend_flags)
 	}
 
 	map = rcu_dereference_protected(md->map, lockdep_is_held(&md->suspend_lock));
+	if (!map) {
+		/* avoid deadlock with fs/namespace.c:do_mount() */
+		suspend_flags &= ~DM_SUSPEND_LOCKFS_FLAG;
+	}
 
 	r = __dm_suspend(md, map, suspend_flags, TASK_INTERRUPTIBLE, DMF_SUSPENDED);
 	if (r)
-- 
2.39.2



