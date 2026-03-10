Return-Path: <stable+bounces-224094-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMdLCNn+r2mQeQIAu9opvQ
	(envelope-from <stable+bounces-224094-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:22:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9482624A80C
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1709321E977
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA16338758D;
	Tue, 10 Mar 2026 11:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNX76c1x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8CC2BF3E2;
	Tue, 10 Mar 2026 11:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141227; cv=none; b=qGzw9vY12xuYAsxI0lJ/PBviMP26V5i9qnRm1o9sO7AY8u/UbiWLP8q08lSkYIUjBx6dDGwvGOBOFLLTgfj4mS/HROzW6fR0sZMedfKM1WIl9PSw0+9T4/k25or2Ba7rskbFD6/0ar1bVKdbArZjWpmvtUSfTMaf9Cay4YOleTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141227; c=relaxed/simple;
	bh=+pxHu9umMBuA/Pm+HTi8LaHYiw0lD0kX+Tl0xJlhcfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahIoyjgHtIPfaPeEBMaJRhD/v2Qm0imLS/ADTD4fbBaFz34B8MroJ/5rY393/0bCxxsgXAQgSVe3ktSNy2g17VeehGWM+0Snpm9A2uIifQFuwkmMpC1e6dz1WBechcMfsE76ihpf7qadSIvL8j6xoKXgpMznKSka8ezexAVuQLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNX76c1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2CAC2BCAF;
	Tue, 10 Mar 2026 11:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141227;
	bh=+pxHu9umMBuA/Pm+HTi8LaHYiw0lD0kX+Tl0xJlhcfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HNX76c1xVQF2ja8GA0oqIRr1RSjGVg/IF5DtaP5iBB9T1yg5KbE7NlyGQ4ea79q2+
	 m+6r9xWwj7k/3MRgdJ4PkdYeSN3ewjf9JLVcIhsLAVUKEW8s7FO8Jka5DVgFmuJ0ex
	 cUKj/c10LOcYLYe7XmZFsK/QPmf7Wtv5GfjfiLzgfuVJQGJHh8ZafBhGwz6kEyuWVk
	 xOac3Zp/W6h5rpCZ0wgzXURQf4nUP/enJem9142gOkjpHZ/vdJFTsca0T3GCoHod+Q
	 /CE7ZYF1bZk2CxaGkpBqA3Cv5MDkZYEjQI2/6On43+GhdDRNc4EWbOfVnsEL1mKWHi
	 9yj4qOv6shGdg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Lizhi Hou <lizhi.hou@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 229/311] accel/amdxdna: Fix NULL pointer dereference of mgmt_chann
Date: Tue, 10 Mar 2026 07:04:36 -0400
Message-ID: <95bd7374b1662da5c9de055f2e6a9827e4deccd3.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9482624A80C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224094-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Action: no action

From: Lizhi Hou <lizhi.hou@amd.com>

[ Upstream commit 6270ee26e1edd862ea17e3eba148ca8fb2c99dc9 ]

mgmt_chann may be set to NULL if the firmware returns an unexpected
error in aie2_send_mgmt_msg_wait(). This can later lead to a NULL
pointer dereference in aie2_hw_stop().

Fix this by introducing a dedicated helper to destroy mgmt_chann
and by adding proper NULL checks before accessing it.

Fixes: b87f920b9344 ("accel/amdxdna: Support hardware mailbox")
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Link: https://patch.msgid.link/20260226213857.3068474-1-lizhi.hou@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/amdxdna/aie2_message.c | 21 ++++++++++++++++-----
 drivers/accel/amdxdna/aie2_pci.c     |  7 ++-----
 drivers/accel/amdxdna/aie2_pci.h     |  1 +
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
index a758c11a05a9c..f0fb98131068c 100644
--- a/drivers/accel/amdxdna/aie2_message.c
+++ b/drivers/accel/amdxdna/aie2_message.c
@@ -40,11 +40,8 @@ static int aie2_send_mgmt_msg_wait(struct amdxdna_dev_hdl *ndev,
 		return -ENODEV;
 
 	ret = xdna_send_msg_wait(xdna, ndev->mgmt_chann, msg);
-	if (ret == -ETIME) {
-		xdna_mailbox_stop_channel(ndev->mgmt_chann);
-		xdna_mailbox_destroy_channel(ndev->mgmt_chann);
-		ndev->mgmt_chann = NULL;
-	}
+	if (ret == -ETIME)
+		aie2_destroy_mgmt_chann(ndev);
 
 	if (!ret && *hdl->status != AIE2_STATUS_SUCCESS) {
 		XDNA_ERR(xdna, "command opcode 0x%x failed, status 0x%x",
@@ -871,6 +868,20 @@ void aie2_msg_init(struct amdxdna_dev_hdl *ndev)
 		ndev->exec_msg_ops = &legacy_exec_message_ops;
 }
 
+void aie2_destroy_mgmt_chann(struct amdxdna_dev_hdl *ndev)
+{
+	struct amdxdna_dev *xdna = ndev->xdna;
+
+	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
+
+	if (!ndev->mgmt_chann)
+		return;
+
+	xdna_mailbox_stop_channel(ndev->mgmt_chann);
+	xdna_mailbox_destroy_channel(ndev->mgmt_chann);
+	ndev->mgmt_chann = NULL;
+}
+
 static inline struct amdxdna_gem_obj *
 aie2_cmdlist_get_cmd_buf(struct amdxdna_sched_job *job)
 {
diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index 3356c9ed079a8..0a8e7a8710eea 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -343,9 +343,7 @@ static void aie2_hw_stop(struct amdxdna_dev *xdna)
 
 	aie2_runtime_cfg(ndev, AIE2_RT_CFG_CLK_GATING, NULL);
 	aie2_mgmt_fw_fini(ndev);
-	xdna_mailbox_stop_channel(ndev->mgmt_chann);
-	xdna_mailbox_destroy_channel(ndev->mgmt_chann);
-	ndev->mgmt_chann = NULL;
+	aie2_destroy_mgmt_chann(ndev);
 	drmm_kfree(&xdna->ddev, ndev->mbox);
 	ndev->mbox = NULL;
 	aie2_psp_stop(ndev->psp_hdl);
@@ -454,8 +452,7 @@ static int aie2_hw_start(struct amdxdna_dev *xdna)
 	return 0;
 
 destroy_mgmt_chann:
-	xdna_mailbox_stop_channel(ndev->mgmt_chann);
-	xdna_mailbox_destroy_channel(ndev->mgmt_chann);
+	aie2_destroy_mgmt_chann(ndev);
 stop_psp:
 	aie2_psp_stop(ndev->psp_hdl);
 fini_smu:
diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
index 4fdc032bc171b..482ee555f6c47 100644
--- a/drivers/accel/amdxdna/aie2_pci.h
+++ b/drivers/accel/amdxdna/aie2_pci.h
@@ -302,6 +302,7 @@ int aie2_get_array_async_error(struct amdxdna_dev_hdl *ndev,
 
 /* aie2_message.c */
 void aie2_msg_init(struct amdxdna_dev_hdl *ndev);
+void aie2_destroy_mgmt_chann(struct amdxdna_dev_hdl *ndev);
 int aie2_suspend_fw(struct amdxdna_dev_hdl *ndev);
 int aie2_resume_fw(struct amdxdna_dev_hdl *ndev);
 int aie2_set_runtime_cfg(struct amdxdna_dev_hdl *ndev, u32 type, u64 value);
-- 
2.51.0


