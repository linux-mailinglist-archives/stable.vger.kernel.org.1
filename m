Return-Path: <stable+bounces-251853-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIdoB4n8DWru5AUAu9opvQ
	(envelope-from <stable+bounces-251853-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:25:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3432F596149
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AF38372C357
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130563F1AB8;
	Wed, 20 May 2026 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R2CVhXTW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24B536405A;
	Wed, 20 May 2026 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299057; cv=none; b=NQaEH1biEUODnxBsbBeQrgOz80NzXQavlFABUGWW3SoZ1qolIyxoQJaRirQdWxPM51MJ5p3Ghu5ZUVaQQ8UZVF/WNL6sXdBvx2eCS/oO/+uVe85fAEFRfOi9xAwY3WM8xEaMS2cRYvfsT0E8rFKz4fZ9z0dggagjmE6KIuaF4uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299057; c=relaxed/simple;
	bh=m/nQk2tBXFeBvxLhU2k9bHm9oqtszAFn3VUP+FCFO8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPclWIxt8pQmIFRbNXdZKY40sUG//ZRY/6c7GfIwSPeir7x9PCtcsvGgrETJAvok2bj7QfZW1ybGpKGfSlc2ic0azVlpVqwtoVoOja0fHeFRSebFf8oY6iTb5zPIqPoYpPJWXHV2DxkfX+Ph1lu6C40yEqAV5ZjAGaMrm47Q7K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R2CVhXTW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AFA1F000E9;
	Wed, 20 May 2026 17:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299056;
	bh=3gu168ikoXD6Yd1awfog9fb8bajYRyPYJdSwL4FXP/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R2CVhXTWSg8DNoI+m37uo9XU7A2esssxaYwiyhwKMKmgp7dDhC6K3zO0481GoNdwY
	 IPMFNELLlFtVe4FJrB3/QDwG/gnmJJanzZYM12E15kX38/tMHACMpYc191b4khUO3P
	 fFRZ4bjt8fck9K76StfO9G3Se+at5SrCK5rieHiA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 619/957] net: airoha: Wait for NPU PPE configuration to complete in airoha_ppe_offload_setup()
Date: Wed, 20 May 2026 18:18:22 +0200
Message-ID: <20260520162147.957230704@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251853-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3432F596149
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit f3206328bb52c2787197d80d7cbd687946047d5f ]

In order to properly enable flowtable hw offloading, poll
REG_PPE_FLOW_CFG register in airoha_ppe_offload_setup routine and
wait for NPU PPE configuration triggered by ppe_init callback to complete
before running airoha_ppe_hw_init().

Fixes: 00a7678310fe3 ("net: airoha: Introduce flowtable offload support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://patch.msgid.link/20260414-airoha-wait-for-npu-config-offload-setup-v2-1-5a9bf6d43aee@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 28 ++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 81a7056e3510a..e9994c794c703 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -1321,6 +1321,29 @@ static struct airoha_npu *airoha_ppe_npu_get(struct airoha_eth *eth)
 	return npu;
 }
 
+static int airoha_ppe_wait_for_npu_init(struct airoha_eth *eth)
+{
+	int err;
+	u32 val;
+
+	/* PPE_FLOW_CFG default register value is 0. Since we reset FE
+	 * during the device probe we can just check the configured value
+	 * is not 0 here.
+	 */
+	err = read_poll_timeout(airoha_fe_rr, val, val, USEC_PER_MSEC,
+				100 * USEC_PER_MSEC, false, eth,
+				REG_PPE_PPE_FLOW_CFG(0));
+	if (err)
+		return err;
+
+	if (airoha_ppe_is_enabled(eth, 1))
+		err = read_poll_timeout(airoha_fe_rr, val, val, USEC_PER_MSEC,
+					100 * USEC_PER_MSEC, false, eth,
+					REG_PPE_PPE_FLOW_CFG(1));
+
+	return err;
+}
+
 static int airoha_ppe_offload_setup(struct airoha_eth *eth)
 {
 	struct airoha_npu *npu = airoha_ppe_npu_get(eth);
@@ -1334,6 +1357,11 @@ static int airoha_ppe_offload_setup(struct airoha_eth *eth)
 	if (err)
 		goto error_npu_put;
 
+	/* Wait for NPU PPE configuration to complete */
+	err = airoha_ppe_wait_for_npu_init(eth);
+	if (err)
+		goto error_npu_put;
+
 	ppe_num_stats_entries = airoha_ppe_get_total_num_stats_entries(ppe);
 	if (ppe_num_stats_entries > 0) {
 		err = npu->ops.ppe_init_stats(npu, ppe->foe_stats_dma,
-- 
2.53.0




