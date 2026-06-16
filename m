Return-Path: <stable+bounces-264368-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l++ANH92MWrYjwUAu9opvQ
	(envelope-from <stable+bounces-264368-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:14:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B37691D9D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:14:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=pQsTwUgw;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264368-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-264368-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E0B7317D0BC
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420EB47A0CD;
	Tue, 16 Jun 2026 15:58:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071E847A0BC;
	Tue, 16 Jun 2026 15:58:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625510; cv=none; b=fMeXabGoIJwRJPew6c6e/W+etUV26G1qVKsac2/1YbD5UQbBdKKrT/9A6996cQapYsGwn6wdkzZkXvlp0E7Ag5vlbztLXn6sZH35W6xiH6g68A1vWkHLz+h5mVDvlmhfSLzEFT8hihco2Zdl8/uD07v+WJ+RukD10iP0loT4bkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625510; c=relaxed/simple;
	bh=Ei9A7othE+TsRKMuh6FwLehDk4NugdBMTracOWiIB/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iO3j/Tl/Yi+BjFxffGHPH4q3hFrPqmtT9SJmeAGB8yC0+M5JiA1gnyNWSBgbHat5zquD6kzUTuH2f/as2MUGq3nYcqcaH53KlqYZO7zYH1lCTFtkFqRYzY7ugjibDsP+WhNUCVtG59wKzzFqoGQTtoC94sJUBHFUprPNCj7XW7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pQsTwUgw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B031F00A3A;
	Tue, 16 Jun 2026 15:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781625508;
	bh=VLRnb9cSn4bqPh4afu2vFZ7NgbW1wdG2XCWLt4yRpEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pQsTwUgwmc0BYhFAEDtZsjl9eVFU6V2qzo1ni+K3z+OGHGYaB89/Um49r6PU+ytUO
	 xg5rCSpqyET+wUPQEmWFaqtutpNwfOwV+PlEBSU7mK5ERo5WwP0HysmkPJcucVX8n0
	 gOkRTbU67nb3ByYjUmj0busGZyJm5JIJhY7dNbjw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Umang Jain <uajain@igalia.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 114/325] ASoC: SOF: amd: fix for ipc flags check
Date: Tue, 16 Jun 2026 20:28:30 +0530
Message-ID: <20260616145103.378936346@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264368-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:Vijendar.Mukunda@amd.com,m:uajain@igalia.com,m:broonie@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:email,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,igalia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67B37691D9D

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

[ Upstream commit 6042c91df60e825625bc7d5c5c3b5a87b91d5805 ]

Firmware will set dsp_ack to 1 when firmware sends response for the IPC
command issued by host. Similarly dsp_msg flag will be updated to 1.

During ACP D0 entry, the value read from the sof_dsp_ack_write scratch
flag can be uninitialized. A non-zero garbage value is treated as a
pending DSP IPC ack before SOF_FW_BOOT_COMPLETE, causing a spurious
"IPC reply before FW_BOOT_COMPLETE" log.

Fix the condition checks for ipc flags.

Fixes: 738a2b5e2cc9 ("ASoC: SOF: amd: Add IPC support for ACP IP block")
Link: https://github.com/thesofproject/linux/pull/5642
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Tested-by: Umang Jain <uajain@igalia.com>
Link: https://patch.msgid.link/20260609160938.3717513-1-Vijendar.Mukunda@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/amd/acp-ipc.c | 4 ++--
 sound/soc/sof/amd/acp.h     | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/amd/acp-ipc.c b/sound/soc/sof/amd/acp-ipc.c
index 22d4b807e1bb75..1c3f7601a8c4ce 100644
--- a/sound/soc/sof/amd/acp-ipc.c
+++ b/sound/soc/sof/amd/acp-ipc.c
@@ -181,14 +181,14 @@ irqreturn_t acp_sof_ipc_irq_thread(int irq, void *context)
 	}
 
 	dsp_msg = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP_SCRATCH_REG_0 + dsp_msg_write);
-	if (dsp_msg) {
+	if (dsp_msg == ACP_DSP_MSG_SET) {
 		snd_sof_ipc_msgs_rx(sdev);
 		acp_dsp_ipc_host_done(sdev);
 		ipc_irq = true;
 	}
 
 	dsp_ack = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP_SCRATCH_REG_0 + dsp_ack_write);
-	if (dsp_ack) {
+	if (dsp_ack == ACP_DSP_ACK_SET) {
 		if (likely(sdev->fw_state == SOF_FW_BOOT_COMPLETE)) {
 			spin_lock_irq(&sdev->ipc_lock);
 
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 2b7ea8c6410602..7bcb76676a984a 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -116,6 +116,8 @@
 #define ACP_SRAM_PAGE_COUNT			128
 #define ACP6X_SDW_MAX_MANAGER_COUNT		2
 #define ACP70_SDW_MAX_MANAGER_COUNT		ACP6X_SDW_MAX_MANAGER_COUNT
+#define ACP_DSP_MSG_SET				1
+#define ACP_DSP_ACK_SET				1
 
 enum clock_source {
 	ACP_CLOCK_96M = 0,
-- 
2.53.0




