Return-Path: <stable+bounces-50287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D98AF9056D2
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 17:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614271F230A1
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 15:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A17117F4E0;
	Wed, 12 Jun 2024 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jj1c2bv4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EF517C7C8
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718206004; cv=none; b=jWf5i8sCaRVxA+ZJ3UneBELklKR6bXJs0+fheChVTz/JOoXMbq82hHcJ8F9ksFv+ozRfAkayvy4/mDCMGaaxNaXoumyfSSwVzTSoC9fqGE/hp6xDAShCIyj99vjbUA0niBSHO4GSLgEzSC4lIhtbgkGw9JX9zSk0oKZ1OKzqOGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718206004; c=relaxed/simple;
	bh=ufsculBOG2lL+7WWwygVgmDhtd0Uf4Ez7VGdme3VxSM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AJDXNXHg7kVkIp175oQLMsNnEb3UkLfRkPh2xdPn7hmUqXMrhkQkgiGSSmLo8Z/Bps7IY7cM84sI5aj+efA+sv/1ZC1mfYY3JaeTCF4wzGIJ+EeXimu4I0Ihc2bWfNKPIKHxKkMFviFTtdl6Pm7PLbQO9Yy5PNbXLnO8C+FEl3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jj1c2bv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADBAC32786;
	Wed, 12 Jun 2024 15:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718206003;
	bh=ufsculBOG2lL+7WWwygVgmDhtd0Uf4Ez7VGdme3VxSM=;
	h=Subject:To:Cc:From:Date:From;
	b=Jj1c2bv4c2RUyrzbHz4eFRPMZp1rSFLR4JBlW0SHH6SPsm4My8JgjBM4GYm+VryaN
	 o3I0xQ4+eWOdKDW/XBGDIbBqxbZOPX87DIO6iC23nnUOoc9HZZIgsM4p8lG9Y8cgHH
	 cRPctKvPHPDuOBLw1YF9gCp6KBFJUZf3lDTGX4BQ=
Subject: FAILED: patch "[PATCH] soc: qcom: rpmh-rsc: Enhance check for VRM in-flight request" failed to apply to 5.10-stable tree
To: quic_mkshah@quicinc.com,andersson@kernel.org,konrad.dybcio@linaro.org,quic_eberman@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 12 Jun 2024 17:26:40 +0200
Message-ID: <2024061240-pointing-endanger-621b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x f592cc5794747b81e53b53dd6e80219ee25f0611
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061240-pointing-endanger-621b@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

f592cc579474 ("soc: qcom: rpmh-rsc: Enhance check for VRM in-flight request")
778279f4f5e4 ("soc: qcom: cmd-db: allow loading as a module")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f592cc5794747b81e53b53dd6e80219ee25f0611 Mon Sep 17 00:00:00 2001
From: Maulik Shah <quic_mkshah@quicinc.com>
Date: Thu, 15 Feb 2024 10:55:44 +0530
Subject: [PATCH] soc: qcom: rpmh-rsc: Enhance check for VRM in-flight request

Each RPMh VRM accelerator resource has 3 or 4 contiguous 4-byte aligned
addresses associated with it. These control voltage, enable state, mode,
and in legacy targets, voltage headroom. The current in-flight request
checking logic looks for exact address matches. Requests for different
addresses of the same RPMh resource as thus not detected as in-flight.

Add new cmd-db API cmd_db_match_resource_addr() to enhance the in-flight
request check for VRM requests by ignoring the address offset.

This ensures that only one request is allowed to be in-flight for a given
VRM resource. This is needed to avoid scenarios where request commands are
carried out by RPMh hardware out-of-order leading to LDO regulator
over-current protection triggering.

Fixes: 658628e7ef78 ("drivers: qcom: rpmh-rsc: add RPMH controller for QCOM SoCs")
Cc: stable@vger.kernel.org
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Tested-by: Elliot Berman <quic_eberman@quicinc.com> # sm8650-qrd
Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
Link: https://lore.kernel.org/r/20240215-rpmh-rsc-fixes-v4-1-9cbddfcba05b@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index c344107bc36c..b4e613c34a5c 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -1,6 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (c) 2016-2018, 2020, The Linux Foundation. All rights reserved. */
+/*
+ * Copyright (c) 2016-2018, 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
 
+#include <linux/bitfield.h>
 #include <linux/debugfs.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -17,6 +21,8 @@
 #define MAX_SLV_ID		8
 #define SLAVE_ID_MASK		0x7
 #define SLAVE_ID_SHIFT		16
+#define SLAVE_ID(addr)		FIELD_GET(GENMASK(19, 16), addr)
+#define VRM_ADDR(addr)		FIELD_GET(GENMASK(19, 4), addr)
 
 /**
  * struct entry_header: header for each entry in cmddb
@@ -220,6 +226,30 @@ const void *cmd_db_read_aux_data(const char *id, size_t *len)
 }
 EXPORT_SYMBOL_GPL(cmd_db_read_aux_data);
 
+/**
+ * cmd_db_match_resource_addr() - Compare if both Resource addresses are same
+ *
+ * @addr1: Resource address to compare
+ * @addr2: Resource address to compare
+ *
+ * Return: true if two addresses refer to the same resource, false otherwise
+ */
+bool cmd_db_match_resource_addr(u32 addr1, u32 addr2)
+{
+	/*
+	 * Each RPMh VRM accelerator resource has 3 or 4 contiguous 4-byte
+	 * aligned addresses associated with it. Ignore the offset to check
+	 * for VRM requests.
+	 */
+	if (addr1 == addr2)
+		return true;
+	else if (SLAVE_ID(addr1) == CMD_DB_HW_VRM && VRM_ADDR(addr1) == VRM_ADDR(addr2))
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(cmd_db_match_resource_addr);
+
 /**
  * cmd_db_read_slave_id - Get the slave ID for a given resource address
  *
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index c4c7aad957e6..561d8037b50a 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #define pr_fmt(fmt) "%s " fmt, KBUILD_MODNAME
@@ -557,7 +558,7 @@ static int check_for_req_inflight(struct rsc_drv *drv, struct tcs_group *tcs,
 		for_each_set_bit(j, &curr_enabled, MAX_CMDS_PER_TCS) {
 			addr = read_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_ADDR], i, j);
 			for (k = 0; k < msg->num_cmds; k++) {
-				if (addr == msg->cmds[k].addr)
+				if (cmd_db_match_resource_addr(msg->cmds[k].addr, addr))
 					return -EBUSY;
 			}
 		}
diff --git a/include/soc/qcom/cmd-db.h b/include/soc/qcom/cmd-db.h
index c8bb56e6852a..47a6cab75e63 100644
--- a/include/soc/qcom/cmd-db.h
+++ b/include/soc/qcom/cmd-db.h
@@ -1,5 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (c) 2016-2018, The Linux Foundation. All rights reserved. */
+/*
+ * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
 
 #ifndef __QCOM_COMMAND_DB_H__
 #define __QCOM_COMMAND_DB_H__
@@ -21,6 +24,8 @@ u32 cmd_db_read_addr(const char *resource_id);
 
 const void *cmd_db_read_aux_data(const char *resource_id, size_t *len);
 
+bool cmd_db_match_resource_addr(u32 addr1, u32 addr2);
+
 enum cmd_db_hw_type cmd_db_read_slave_id(const char *resource_id);
 
 int cmd_db_ready(void);
@@ -31,6 +36,9 @@ static inline u32 cmd_db_read_addr(const char *resource_id)
 static inline const void *cmd_db_read_aux_data(const char *resource_id, size_t *len)
 { return ERR_PTR(-ENODEV); }
 
+static inline bool cmd_db_match_resource_addr(u32 addr1, u32 addr2)
+{ return false; }
+
 static inline enum cmd_db_hw_type cmd_db_read_slave_id(const char *resource_id)
 { return -ENODEV; }
 


