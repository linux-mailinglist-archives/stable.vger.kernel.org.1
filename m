Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7707D79BE66
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239420AbjIKWZ6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239605AbjIKOYa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:24:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277ADDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:24:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7367EC433C8;
        Mon, 11 Sep 2023 14:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442265;
        bh=6Rl6GFHVbzz+gW2bdI27MplD/1sigFHPCXGGGCjQDAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NimIgUzC7UydmfWTJGuoDEnRF6+lTtbpsSXYEUDKsveYXaVCtHfumLL3f4xHzEaKm
         tssUaOGfjzbZtO7SC/qFoJ6mL8gpwJW57S8rATrM/N+KKQymq4oEBeBAOrAxSmc+/x
         thBtHYcVuAkZMle+fNaLK0dy4asB0RLSmqXcmxmo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Charlene Liu <charlene.liu@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Fudong Wang <fudong.wang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.5 697/739] drm/amd/display: Add smu write msg id fail retry process
Date:   Mon, 11 Sep 2023 15:48:16 +0200
Message-ID: <20230911134710.561366434@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fudong Wang <fudong.wang@amd.com>

commit 72105dcfa3d12b5af49311f857e3490baa225135 upstream.

A benchmark stress test (12-40 machines x 48hours) found that DCN315 has
cases where DC writes to an indirect register to set the smu clock msg
id, but when we go to read the same indirect register the returned msg
id doesn't match with what we just set it to. So, to fix this retry the
write until the register's value matches with the requested value.

Cc: stable@vger.kernel.org # 6.1+
Fixes: f94903996140 ("drm/amd/display: Add DCN315 CLK_MGR")
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Fudong Wang <fudong.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c |   20 ++++++++++---
 1 file changed, 16 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
@@ -32,6 +32,7 @@
 
 #define MAX_INSTANCE                                        6
 #define MAX_SEGMENT                                         6
+#define SMU_REGISTER_WRITE_RETRY_COUNT                      5
 
 struct IP_BASE_INSTANCE
 {
@@ -134,6 +135,8 @@ static int dcn315_smu_send_msg_with_para
 		unsigned int msg_id, unsigned int param)
 {
 	uint32_t result;
+	uint32_t i = 0;
+	uint32_t read_back_data;
 
 	result = dcn315_smu_wait_for_response(clk_mgr, 10, 200000);
 
@@ -150,10 +153,19 @@ static int dcn315_smu_send_msg_with_para
 	/* Set the parameter register for the SMU message, unit is Mhz */
 	REG_WRITE(MP1_SMN_C2PMSG_37, param);
 
-	/* Trigger the message transaction by writing the message ID */
-	generic_write_indirect_reg(CTX,
-		REG_NBIO(RSMU_INDEX), REG_NBIO(RSMU_DATA),
-		mmMP1_C2PMSG_3, msg_id);
+	for (i = 0; i < SMU_REGISTER_WRITE_RETRY_COUNT; i++) {
+		/* Trigger the message transaction by writing the message ID */
+		generic_write_indirect_reg(CTX,
+			REG_NBIO(RSMU_INDEX), REG_NBIO(RSMU_DATA),
+			mmMP1_C2PMSG_3, msg_id);
+		read_back_data = generic_read_indirect_reg(CTX,
+			REG_NBIO(RSMU_INDEX), REG_NBIO(RSMU_DATA),
+			mmMP1_C2PMSG_3);
+		if (read_back_data == msg_id)
+			break;
+		udelay(2);
+		smu_print("SMU msg id write fail %x times. \n", i + 1);
+	}
 
 	result = dcn315_smu_wait_for_response(clk_mgr, 10, 200000);
 


