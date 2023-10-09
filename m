Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3AB7BDFD2
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377145AbjJINe2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377146AbjJINe1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:34:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6924594
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:34:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD25DC433C7;
        Mon,  9 Oct 2023 13:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858465;
        bh=RtbrMGkIgsVOGsTrpPZ3QyoxvdDNF6ZeeGZ+M0QS5PY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y8ff15DiDAvQhiTVL66mOJHSD9VqfOB6ROMNl/GOnwpLrUasSIi1L/5gYKKlq1Tr/
         A3oUUKoFbU7xm+jlWDefUnrRJiR8YUnau1z+B1mblYM24z9B7hi8foNOhIJQWDlCOC
         M2TlLiF8G3Xonymt8cvGS/+Q+1QERJxtjlw6dKNY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Junxiao Bi <junxiao.bi@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 104/131] scsi: target: core: Fix deadlock due to recursive locking
Date:   Mon,  9 Oct 2023 15:02:24 +0200
Message-ID: <20231009130119.601393073@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
References: <20231009130116.329529591@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junxiao Bi <junxiao.bi@oracle.com>

[ Upstream commit a154f5f643c6ecddd44847217a7a3845b4350003 ]

The following call trace shows a deadlock issue due to recursive locking of
mutex "device_mutex". First lock acquire is in target_for_each_device() and
second in target_free_device().

 PID: 148266   TASK: ffff8be21ffb5d00  CPU: 10   COMMAND: "iscsi_ttx"
  #0 [ffffa2bfc9ec3b18] __schedule at ffffffffa8060e7f
  #1 [ffffa2bfc9ec3ba0] schedule at ffffffffa8061224
  #2 [ffffa2bfc9ec3bb8] schedule_preempt_disabled at ffffffffa80615ee
  #3 [ffffa2bfc9ec3bc8] __mutex_lock at ffffffffa8062fd7
  #4 [ffffa2bfc9ec3c40] __mutex_lock_slowpath at ffffffffa80631d3
  #5 [ffffa2bfc9ec3c50] mutex_lock at ffffffffa806320c
  #6 [ffffa2bfc9ec3c68] target_free_device at ffffffffc0935998 [target_core_mod]
  #7 [ffffa2bfc9ec3c90] target_core_dev_release at ffffffffc092f975 [target_core_mod]
  #8 [ffffa2bfc9ec3ca0] config_item_put at ffffffffa79d250f
  #9 [ffffa2bfc9ec3cd0] config_item_put at ffffffffa79d2583
 #10 [ffffa2bfc9ec3ce0] target_devices_idr_iter at ffffffffc0933f3a [target_core_mod]
 #11 [ffffa2bfc9ec3d00] idr_for_each at ffffffffa803f6fc
 #12 [ffffa2bfc9ec3d60] target_for_each_device at ffffffffc0935670 [target_core_mod]
 #13 [ffffa2bfc9ec3d98] transport_deregister_session at ffffffffc0946408 [target_core_mod]
 #14 [ffffa2bfc9ec3dc8] iscsit_close_session at ffffffffc09a44a6 [iscsi_target_mod]
 #15 [ffffa2bfc9ec3df0] iscsit_close_connection at ffffffffc09a4a88 [iscsi_target_mod]
 #16 [ffffa2bfc9ec3df8] finish_task_switch at ffffffffa76e5d07
 #17 [ffffa2bfc9ec3e78] iscsit_take_action_for_connection_exit at ffffffffc0991c23 [iscsi_target_mod]
 #18 [ffffa2bfc9ec3ea0] iscsi_target_tx_thread at ffffffffc09a403b [iscsi_target_mod]
 #19 [ffffa2bfc9ec3f08] kthread at ffffffffa76d8080
 #20 [ffffa2bfc9ec3f50] ret_from_fork at ffffffffa8200364

Fixes: 36d4cb460bcb ("scsi: target: Avoid that EXTENDED COPY commands trigger lock inversion")
Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
Link: https://lore.kernel.org/r/20230918225848.66463-1-junxiao.bi@oracle.com
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/target_core_device.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index 20fe287039857..8ba134ccd3b9c 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -856,7 +856,6 @@ sector_t target_to_linux_sector(struct se_device *dev, sector_t lb)
 EXPORT_SYMBOL(target_to_linux_sector);
 
 struct devices_idr_iter {
-	struct config_item *prev_item;
 	int (*fn)(struct se_device *dev, void *data);
 	void *data;
 };
@@ -866,11 +865,9 @@ static int target_devices_idr_iter(int id, void *p, void *data)
 {
 	struct devices_idr_iter *iter = data;
 	struct se_device *dev = p;
+	struct config_item *item;
 	int ret;
 
-	config_item_put(iter->prev_item);
-	iter->prev_item = NULL;
-
 	/*
 	 * We add the device early to the idr, so it can be used
 	 * by backend modules during configuration. We do not want
@@ -880,12 +877,13 @@ static int target_devices_idr_iter(int id, void *p, void *data)
 	if (!target_dev_configured(dev))
 		return 0;
 
-	iter->prev_item = config_item_get_unless_zero(&dev->dev_group.cg_item);
-	if (!iter->prev_item)
+	item = config_item_get_unless_zero(&dev->dev_group.cg_item);
+	if (!item)
 		return 0;
 	mutex_unlock(&device_mutex);
 
 	ret = iter->fn(dev, iter->data);
+	config_item_put(item);
 
 	mutex_lock(&device_mutex);
 	return ret;
@@ -908,7 +906,6 @@ int target_for_each_device(int (*fn)(struct se_device *dev, void *data),
 	mutex_lock(&device_mutex);
 	ret = idr_for_each(&devices_idr, target_devices_idr_iter, &iter);
 	mutex_unlock(&device_mutex);
-	config_item_put(iter.prev_item);
 	return ret;
 }
 
-- 
2.40.1



