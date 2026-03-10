Return-Path: <stable+bounces-223898-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHzEL9X8r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223898-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:13:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E5B24A238
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B2A93043D6E
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECF1387577;
	Tue, 10 Mar 2026 11:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aREIpUQN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2667386C02;
	Tue, 10 Mar 2026 11:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140797; cv=none; b=cCf+lMnDKfQ8935FZZaeNhPmtsHMfCSYUfArhrL7bjNcWcufJw2R2igvTOlR6UuKDYthJ1sguQtS+ZBetw2RkkZ19AoaSgywwhtiWqGdXM4xzrot4PhGe//wjbt7Wu4HCqU8U3+g81KxagtMrjUu6InyAdJdRUdVvX9OfFnNO7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140797; c=relaxed/simple;
	bh=UBkE7B3y+8cTE4i2+DWlPLjgyfJTgWtmD4EsWNvY8L8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GF96ZpYQQufkX6HKu/g1kMB+PelvQRfsJWVDUyJfUWjdylC9OxXy+7dv5T82Yf2FyJq6kUxYNiXljOUkb0Z+N18EmDlR61mko83TaHtTiBMRVGZIkg2k5EWHEXtV/quOChbMm+uPlZcdB8m458qprCh/Pog253MyZTqWXn/uCuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aREIpUQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE632C2BCAF;
	Tue, 10 Mar 2026 11:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773140797;
	bh=UBkE7B3y+8cTE4i2+DWlPLjgyfJTgWtmD4EsWNvY8L8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aREIpUQN6ImrASxVedNDC3BAIq5R1GY3Kq0jZtBE5Vw5L4A6HOnPZ/ZX5py/GeEt8
	 5pLscGnLRPf8hLlJugjQApejsuNFB7ZmdVoMPPkykcMxfgrobBLTtEXgGh7H8bLZng
	 NwmQeRmPcjiKQ5rVTNls4PZIuy+6o8cUiETQdI8GxIrVAC+exm0zFLrHrqn9Z8wWKe
	 g/6+EbL9Bglb6STqq9+9/WfjWdsLkGZZMWDizCi68Ap+FRC0VW4ZlpWLX34hYrUgvG
	 2DVrzi+fIG+sgo3Bs6rY5Sr0obzLC7FejvZF4VdEdSkjZIrIrw1zfG8K65snOdZzXt
	 oW2KzFUQ/e/Hw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Lizhi Hou <lizhi.hou@amd.com>,
	Karol Wachowski <karol.wachowski@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 034/311] accel/amdxdna: Fix crash when destroying a suspended hardware context
Date: Tue, 10 Mar 2026 07:01:21 -0400
Message-ID: <2f9000382038695bd00687f9c087e087915c76c8.1773140655.git.sashal@kernel.org>
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
X-Rspamd-Queue-Id: 28E5B24A238
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223898-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Action: no action

From: Lizhi Hou <lizhi.hou@amd.com>

[ Upstream commit 8363c02863332992a1822688da41f881d88d1631 ]

If userspace issues an ioctl to destroy a hardware context that has
already been automatically suspended, the driver may crash because the
mailbox channel pointer is NULL for the suspended context.

Fix this by checking the mailbox channel pointer in aie2_destroy_context()
before accessing it.

Fixes: 97f27573837e ("accel/amdxdna: Fix potential NULL pointer dereference in context cleanup")
Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Link: https://patch.msgid.link/20260206060306.4050531-1-lizhi.hou@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/amdxdna/aie2_message.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
index 2c5b27d90563e..43657203d22b7 100644
--- a/drivers/accel/amdxdna/aie2_message.c
+++ b/drivers/accel/amdxdna/aie2_message.c
@@ -274,6 +274,9 @@ int aie2_destroy_context(struct amdxdna_dev_hdl *ndev, struct amdxdna_hwctx *hwc
 	struct amdxdna_dev *xdna = ndev->xdna;
 	int ret;
 
+	if (!hwctx->priv->mbox_chann)
+		return 0;
+
 	xdna_mailbox_stop_channel(hwctx->priv->mbox_chann);
 	ret = aie2_destroy_context_req(ndev, hwctx->fw_ctx_id);
 	xdna_mailbox_destroy_channel(hwctx->priv->mbox_chann);
-- 
2.51.0


