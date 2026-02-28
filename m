Return-Path: <stable+bounces-220430-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNN1NKY6o2nO+gQAu9opvQ
	(envelope-from <stable+bounces-220430-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:57:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D131C6745
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C055930634EF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8743B3BE5;
	Sat, 28 Feb 2026 17:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O05iDDkp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEE1480DE3;
	Sat, 28 Feb 2026 17:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300320; cv=none; b=LA+E7XoeQFcqwg4JCOPC5pwPgLyB6UM5NIyKHlHHsvz9DwJQ0ctPJUOsXW3DBiFoeasbkeGj3Ysfcl/jUmv1fwgbc564E91izzkZRkQfn/wyFpaVz8FGiSgiU9/C51wR3FelPmj6ckn0Pnixo1ccxcAjfSkKDmLIV249pqzSqP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300320; c=relaxed/simple;
	bh=LI3nJcniRFCBMxwaHH5p2OMkM78vXd6UDnApdfZt3/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NbZdqtLCP5mVs5cfMy91e5QXq4wL8akRGG4C4hOqzBwpuXT8G5Vp6xp0E4dWPdCnSXaGd/t5aKCIF8j+30QTyz1twyO3jauPXENEG7o3KirNS7XLHhYVTbACyKG1n66VKdlrSTIXOX1ljfam94snREAqwBDQdyenOfKtQlFFBfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O05iDDkp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E15C116D0;
	Sat, 28 Feb 2026 17:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300319;
	bh=LI3nJcniRFCBMxwaHH5p2OMkM78vXd6UDnApdfZt3/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O05iDDkpKH6Q14Zrqvme4z1ycd6n9rqgxfR/jfNS/HCc2CkwzFTrQ4GKzXlmYLSL6
	 QA0XCbxuLYm4dm/Id2vS7NXKAQmo93wfkhdnHBYC0G832EycRgo6910iaN4WQNGJuL
	 /NwbolANTt5U6UzOLKX0bz1wMqBRv2dfgMNXx6G6f8iEmuKfBZL02bQfkpniUpsiH4
	 xdPgyn+ExofFV5uX7u2tQU3+ft69BDEYailR9ag2GH1A/4ydl25sgaRjOfB+nGVWn8
	 pn9lnhRNFRnFFutcLZs3zn/c81poNYPgZ26f8DL4OMzEVRILtXG4j7VYjXs5bHlveT
	 Tz476QX7Ch5Gg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Iuliana Prodan <iuliana.prodan@nxp.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 351/844] remoteproc: imx_dsp_rproc: Skip RP_MBOX_SUSPEND_SYSTEM when mailbox TX channel is uninitialized
Date: Sat, 28 Feb 2026 12:24:24 -0500
Message-ID: <20260228173244.1509663-352-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220430-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 10D131C6745
X-Rspamd-Action: no action

From: Iuliana Prodan <iuliana.prodan@nxp.com>

[ Upstream commit d62e0e92e589c53c4320ed5914af5fe103f5ce7e ]

Firmwares that do not use mailbox communication (e.g., the hello_world
sample) leave priv->tx_ch as NULL. The current suspend logic
unconditionally sends RP_MBOX_SUSPEND_SYSTEM, which is invalid without
an initialized TX channel.

Detect the no_mailboxes case early and skip sending the suspend
message. Instead, proceed directly to the runtime PM suspend path,
which is the correct behavior for firmwares that cannot respond to
mailbox requests.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Link: https://lore.kernel.org/r/20251204122825.756106-1-iuliana.prodan@oss.nxp.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/imx_dsp_rproc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index 5a9a8fa031f6d..9e4f50e0e822d 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -1260,6 +1260,15 @@ static int imx_dsp_suspend(struct device *dev)
 	if (rproc->state != RPROC_RUNNING)
 		goto out;
 
+	/*
+	 * No channel available for sending messages;
+	 * indicates no mailboxes present, so trigger PM runtime suspend
+	 */
+	if (!priv->tx_ch) {
+		dev_dbg(dev, "No initialized mbox tx channel, suspend directly.\n");
+		goto out;
+	}
+
 	reinit_completion(&priv->pm_comp);
 
 	/* Tell DSP that suspend is happening */
-- 
2.51.0


