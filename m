Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780BF79BA98
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244532AbjIKWZm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241460AbjIKPJ1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:09:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6145FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:09:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B42C433C7;
        Mon, 11 Sep 2023 15:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444962;
        bh=FogAvOrNQ4kq7tdWLC+z8FWu1S98DY7L8XGM5cHuqs8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dQCvjFIk260kFD0I/OvRdcp0aFlPBDygyVkkFQzUrJCIm6vHOd9lsAKEuFM3BcoHM
         sOG6ULtAMbsiVsGCKaicEyFsoHD5ffGdt8LG2ep8IZTM/t1+dKMPr3WyZ3HnqG219S
         OB45NkJ/Fs3x4INDLEc7ykbZUTW2ayFOKTC0mfVg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jacob Keller <jacob.e.keller@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Simon Horman <horms@kernel.org>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH 6.1 179/600] ice: ice_aq_check_events: fix off-by-one check when filling buffer
Date:   Mon, 11 Sep 2023 15:43:32 +0200
Message-ID: <20230911134638.885899376@linuxfoundation.org>
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

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

[ Upstream commit e1e8a142c43336e3d25bfa1cb3a4ae7d00875c48 ]

Allow task's event buffer to be filled also in the case that it's size
is exactly the size of the message.

Fixes: d69ea414c9b4 ("ice: implement device flash update via devlink")
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 7a00d297be3a9..3f98781e74b28 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1356,6 +1356,7 @@ int ice_aq_wait_for_event(struct ice_pf *pf, u16 opcode, unsigned long timeout,
 static void ice_aq_check_events(struct ice_pf *pf, u16 opcode,
 				struct ice_rq_event_info *event)
 {
+	struct ice_rq_event_info *task_ev;
 	struct ice_aq_task *task;
 	bool found = false;
 
@@ -1364,15 +1365,15 @@ static void ice_aq_check_events(struct ice_pf *pf, u16 opcode,
 		if (task->state || task->opcode != opcode)
 			continue;
 
-		memcpy(&task->event->desc, &event->desc, sizeof(event->desc));
-		task->event->msg_len = event->msg_len;
+		task_ev = task->event;
+		memcpy(&task_ev->desc, &event->desc, sizeof(event->desc));
+		task_ev->msg_len = event->msg_len;
 
 		/* Only copy the data buffer if a destination was set */
-		if (task->event->msg_buf &&
-		    task->event->buf_len > event->buf_len) {
-			memcpy(task->event->msg_buf, event->msg_buf,
+		if (task_ev->msg_buf && task_ev->buf_len >= event->buf_len) {
+			memcpy(task_ev->msg_buf, event->msg_buf,
 			       event->buf_len);
-			task->event->buf_len = event->buf_len;
+			task_ev->buf_len = event->buf_len;
 		}
 
 		task->state = ICE_AQ_TASK_COMPLETE;
-- 
2.40.1



