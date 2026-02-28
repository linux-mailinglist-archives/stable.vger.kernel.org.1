Return-Path: <stable+bounces-220319-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJWcNMowo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220319-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:15:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FDA1C5955
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 75CFB30C1B38
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE0136C9C7;
	Sat, 28 Feb 2026 17:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EORSqVAz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2160447ECF5;
	Sat, 28 Feb 2026 17:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300221; cv=none; b=ubLjJN67xeEaZSsDF5AYMfZdeuvdhFWEm99oZDDYFVcffKLjcbfk5C7Xj4alsITPUwCWbAKUCjXb58lBA63+4ShA0c0fvlMaE3NVkH0HuMj8JETi/3VJM10M8sYn4bDag4SUmGzltPBeoteR0lcEwWHK7el62lrPc1Ip+c1eH1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300221; c=relaxed/simple;
	bh=9DePG+3ApJLWUkuXD2BkxLNtgVIC0JyRLY+gVS8vJo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEYjw7c07qwqTdykxG3iuACy5w1ur9s6JRiPopGWhPcD0yPSI6anlxgHaG9F/dNigW6xdIykNQOd2jg0iO54D3Vn/VYupmaE8ecAwwKRlSzj/q+SV4igVucKCDLYyF+21Xd6Z6ahUCNrgPjMMSebS/ISCcEx3vzg2Jwwqbp15hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EORSqVAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529BBC2BC87;
	Sat, 28 Feb 2026 17:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300221;
	bh=9DePG+3ApJLWUkuXD2BkxLNtgVIC0JyRLY+gVS8vJo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EORSqVAzmXAe46sm31kE4d/8ZsPNCGPdeU1ANOzeW5JF0mm2gCd6QFOaP+YWkyiB2
	 FU+B8UKdicPRh8F3tVLCn9bT/DJ7fnBxo2z9ozCMrROojIl8qAApduM0S94AGQEU6t
	 JNvy9IxMGofSpN1pt63L5nCsuPMyUUA/OeUhV9z0KFUiLyLlorIMkH+L1os70PMF7H
	 vLrjAnwdsXJO5GfbXiO1PCDUCEwUdgrtZg22WXOKZYtP3FObQfDo2ba889AvPRIMcp
	 6Z8OHP0KrysttrMtHQ1DuFFaTTVvahM2w2NJxuta/wslHaCc8epV5gN0zZWz3l2I2r
	 Ccbigfp4wSszw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 241/844] spi: geni-qcom: Fix abort sequence execution for serial engine errors
Date: Sat, 28 Feb 2026 12:22:34 -0500
Message-ID: <20260228173244.1509663-242-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220319-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 92FDA1C5955
X-Rspamd-Action: no action

From: Praveen Talari <praveen.talari@oss.qualcomm.com>

[ Upstream commit 96e041647bb0f9d92f95df1d69cb7442d7408b79 ]

The driver currently skips the abort sequence for target mode when serial
engine errors occur. This leads to improper error recovery as the serial
engine may remain in an undefined state without proper cleanup, potentially
causing subsequent operations to fail or behave unpredictably.

Fix this by ensuring the abort sequence and DMA reset always execute during
error recovery, as both are required for proper serial engine error
handling.

Co-developed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://patch.msgid.link/20260204162854.1206323-3-praveen.talari@oss.qualcomm.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-geni-qcom.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 5ab20d7955121..acfcf870efd84 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -160,24 +160,20 @@ static void handle_se_timeout(struct spi_controller *spi,
 	xfer = mas->cur_xfer;
 	mas->cur_xfer = NULL;
 
-	if (spi->target) {
-		/*
-		 * skip CMD Cancel sequnece since spi target
-		 * doesn`t support CMD Cancel sequnece
-		 */
+	/* The controller doesn't support the Cancel commnand in target mode */
+	if (!spi->target) {
+		reinit_completion(&mas->cancel_done);
+		geni_se_cancel_m_cmd(se);
+
 		spin_unlock_irq(&mas->lock);
-		goto reset_if_dma;
-	}
 
-	reinit_completion(&mas->cancel_done);
-	geni_se_cancel_m_cmd(se);
-	spin_unlock_irq(&mas->lock);
+		time_left = wait_for_completion_timeout(&mas->cancel_done, HZ);
+		if (time_left)
+			goto reset_if_dma;
 
-	time_left = wait_for_completion_timeout(&mas->cancel_done, HZ);
-	if (time_left)
-		goto reset_if_dma;
+		spin_lock_irq(&mas->lock);
+	}
 
-	spin_lock_irq(&mas->lock);
 	reinit_completion(&mas->abort_done);
 	geni_se_abort_m_cmd(se);
 	spin_unlock_irq(&mas->lock);
-- 
2.51.0


