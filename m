Return-Path: <stable+bounces-212391-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6P9NAaYyeml+4gEAu9opvQ
	(envelope-from <stable+bounces-212391-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:00:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4789A4E95
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1857E3230E00
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32263064B3;
	Wed, 28 Jan 2026 15:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FdhfqOeI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60B6288C22;
	Wed, 28 Jan 2026 15:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615361; cv=none; b=O/VP9CYlez5Lau0d68VxtR3ioPpNcXliOOwoiiGK0CrpVu0K9U3THhonwviaK6u0Qgg1dVNly119W+o3m5FSF+6SM8gMcu/QDZuF8+Fq8W71jtJrsqgF6mGUk0LVaGDmG6ZVOH3IvzHzF+zlDIi+A5NEhNpJz0MyFQPtDwwn4+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615361; c=relaxed/simple;
	bh=hbizAjs2WfZZ9OCqgC4G1/JYVeHvDournV4zhJqNLPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZcHZyjt4dfpjeddawsZmZpJN8b6l5BYyjV48QYe1E0WFN7GfE1FBPRfwEaTe2Wcaef5Voc3KbfpiSpu4XKWr5S1DUh9sqYqePWHb8EIyj9zZOqbmsn7iJQO2DyyRCiXK2lnIoryF9yYmCclnUMXu38GXn6IXu7+zX5Si7Te5FXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FdhfqOeI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43576C4CEF1;
	Wed, 28 Jan 2026 15:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615361;
	bh=hbizAjs2WfZZ9OCqgC4G1/JYVeHvDournV4zhJqNLPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FdhfqOeI00QER/TR6qpErZ848JtIYU01pRkqTWzEXA9tHz3OFfNkO9KgahWD+tNjR
	 J9NLSBHLrPRZ4dmxxoNUYNZcMf+rJX7rKur4M9IxOT8Rm2ZBWC8m46E0hNo7Dy22Cj
	 50PBIDNBDlXxEHFx8ehhwx0JVmwDflne3kUhUpls=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Schwartz <matthew.schwartz@linux.dev>,
	Ricky WU <ricky_wu@realtek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.12 114/169] mmc: rtsx_pci_sdmmc: implement sdmmc_card_busy function
Date: Wed, 28 Jan 2026 16:23:17 +0100
Message-ID: <20260128145338.107099578@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
References: <20260128145334.006287341@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212391-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RSPAMD_EMAILBL_FAIL(0.00)[ulf.hansson.linaro.org:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A4789A4E95
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Schwartz <matthew.schwartz@linux.dev>

commit 122610220134b32c742cc056eaf64f7017ac8cd9 upstream.

rtsx_pci_sdmmc does not have an sdmmc_card_busy function, so any voltage
switches cause a kernel warning, "mmc0: cannot verify signal voltage
switch."

Copy the sdmmc_card_busy function from rtsx_pci_usb to rtsx_pci_sdmmc to
fix this.

Fixes: ff984e57d36e ("mmc: Add realtek pcie sdmmc host driver")
Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Tested-by: Ricky WU <ricky_wu@realtek.com>
Reviewed-by: Ricky WU <ricky_wu@realtek.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c |   41 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -1308,6 +1308,46 @@ out:
 	return err;
 }
 
+static int sdmmc_card_busy(struct mmc_host *mmc)
+{
+	struct realtek_pci_sdmmc *host = mmc_priv(mmc);
+	struct rtsx_pcr *pcr = host->pcr;
+	int err;
+	u8 stat;
+	u8 mask = SD_DAT3_STATUS | SD_DAT2_STATUS | SD_DAT1_STATUS
+	| SD_DAT0_STATUS;
+
+	mutex_lock(&pcr->pcr_mutex);
+
+	rtsx_pci_start_run(pcr);
+
+	err = rtsx_pci_write_register(pcr, SD_BUS_STAT,
+				      SD_CLK_TOGGLE_EN | SD_CLK_FORCE_STOP,
+			       SD_CLK_TOGGLE_EN);
+	if (err)
+		goto out;
+
+	mdelay(1);
+
+	err = rtsx_pci_read_register(pcr, SD_BUS_STAT, &stat);
+	if (err)
+		goto out;
+
+	err = rtsx_pci_write_register(pcr, SD_BUS_STAT,
+				      SD_CLK_TOGGLE_EN | SD_CLK_FORCE_STOP, 0);
+out:
+	mutex_unlock(&pcr->pcr_mutex);
+
+	if (err)
+		return err;
+
+	/* check if any pin between dat[0:3] is low */
+	if ((stat & mask) != mask)
+		return 1;
+	else
+		return 0;
+}
+
 static int sdmmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct realtek_pci_sdmmc *host = mmc_priv(mmc);
@@ -1420,6 +1460,7 @@ static const struct mmc_host_ops realtek
 	.get_ro = sdmmc_get_ro,
 	.get_cd = sdmmc_get_cd,
 	.start_signal_voltage_switch = sdmmc_switch_voltage,
+	.card_busy = sdmmc_card_busy,
 	.execute_tuning = sdmmc_execute_tuning,
 	.init_sd_express = sdmmc_init_sd_express,
 };



