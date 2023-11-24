Return-Path: <stable+bounces-270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB007F7618
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 15:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0831C20BE8
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD3E2C85B;
	Fri, 24 Nov 2023 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P0ygAKtC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E15D2C1AE
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 14:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581D2C433CA;
	Fri, 24 Nov 2023 14:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700835311;
	bh=FtVK9WTHrE6KQiPKJYCvgWPt7WKmCv022fKEFr1muQ4=;
	h=Subject:To:Cc:From:Date:From;
	b=P0ygAKtCGIS2IdY5yuqpJao5v4S2Ja6gZF6cEGlPFFoZW7FNj+LW2sCnuZp/DWXHH
	 nSP9wwhQ00wOsm+G9+9whGyHHrhglpx7IlPE1qJ3sgkQZuUAcZrWC3wDSoG5QBrk7Z
	 PpzsbwtpTsoZutQeZUNrnob1m23GdsFrqhh1BP60=
Subject: FAILED: patch "[PATCH] drm/amd/display: Add smu write msg id fail retry process" failed to apply to 6.5-stable tree
To: fudong.wang@amd.com,alexander.deucher@amd.com,charlene.liu@amd.com,hamza.mahfooz@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 14:15:01 +0000
Message-ID: <2023112401-dwarf-gossip-5724@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x 302be1cb9f4b02995f3b10c50494d5eb8fdaf5c1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112401-dwarf-gossip-5724@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

302be1cb9f4b ("drm/amd/display: Add smu write msg id fail retry process")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 302be1cb9f4b02995f3b10c50494d5eb8fdaf5c1 Mon Sep 17 00:00:00 2001
From: Fudong Wang <fudong.wang@amd.com>
Date: Fri, 11 Aug 2023 08:24:59 +0800
Subject: [PATCH] drm/amd/display: Add smu write msg id fail retry process

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

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
index 3e0da873cf4c..1042cf1a3ab0 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
@@ -32,6 +32,7 @@
 
 #define MAX_INSTANCE                                        6
 #define MAX_SEGMENT                                         6
+#define SMU_REGISTER_WRITE_RETRY_COUNT                      5
 
 struct IP_BASE_INSTANCE {
     unsigned int segment[MAX_SEGMENT];
@@ -132,6 +133,8 @@ static int dcn315_smu_send_msg_with_param(
 		unsigned int msg_id, unsigned int param)
 {
 	uint32_t result;
+	uint32_t i = 0;
+	uint32_t read_back_data;
 
 	result = dcn315_smu_wait_for_response(clk_mgr, 10, 200000);
 
@@ -148,10 +151,19 @@ static int dcn315_smu_send_msg_with_param(
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
 


