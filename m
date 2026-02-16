Return-Path: <stable+bounces-216659-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GP4ONRK2kmkLwwEAu9opvQ
	(envelope-from <stable+bounces-216659-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 07:15:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DD414115D
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 07:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD7133019923
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 06:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B1E2DC783;
	Mon, 16 Feb 2026 06:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b="dFBevirs"
X-Original-To: stable@vger.kernel.org
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1120.securemx.jp [210.130.202.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AE62EFD86
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 06:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771222515; cv=none; b=kg4u2NNzFwNFj0F0OrDgahwcCf0MuX1KS5twNcpCiGtRlBebkQeIG5aDmuQMPyGr1Ux71lxkz/5EwpWPejqQAuI3cxXrDLuGZTPSx477FDs9oNBrxfN+5pR+SxFvgrEwQU+PVReDBWINkN3Qn41dLLk5kT6F5ddPW/kYMlLr7CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771222515; c=relaxed/simple;
	bh=dpXo+LMKk+rrl4uzwzgxjAf/U3S6+yJSlfRyiR33yRs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=TG2zApG+jKKmpitw/lhmevHbdrAxZXv6uk/o1K14bhiG1By1id5UHQvCsV18LNvPRQ6mQASo0JjNoa0yOszO37Ac/wUtW/AXs2jzIoG1f/k1FNwOhPtk4VU7+dvBlSzFQZOv/l53RAgxdVW8lwYpvzHzVv6bby58/p27snk0rYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba; spf=pass smtp.mailfrom=mail.toshiba; dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b=dFBevirs; arc=none smtp.client-ip=210.130.202.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.toshiba
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1120) id 61G4o5iS1534024; Mon, 16 Feb 2026 13:50:06 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id;i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key1.smx;t=
	1771217342;x=1772426942;bh=dpXo+LMKk+rrl4uzwzgxjAf/U3S6+yJSlfRyiR33yRs=;b=dFB
	evirsaYHjpb2e1fxSBzYBFQ1uqJKCoSNQIns50ZmXbcVVUi8CBFDreVdFLcYKf27ROrBk2pnLBDph
	4B82XjxNo7sYdbMBy7sG/zwVoG4yJk8OErxVH9M4ZGNY1gV3Cpr7nmQHXda5qvIXY4m3jDJ0lvFs7
	T0gdrL2BUHRI+r7LTLmM6U2kUFXmAWFOaww+HwFSVuecdKJ/3smWPwwdD1lwMvCQv2Pa1qF6KpilP
	Au3SKM+P52LzKnixX3IJvz58qUxhvIG/5FTfkApCCr5UOXn5N6d7VIgOeofFvi8975CbRkca756YQ
	7esdlOAp8b3NB4x4rZP4pE30uirTVIA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 61G4n2Bk3549330; Mon, 16 Feb 2026 13:49:02 +0900
X-Iguazu-Qid: 2rWhnGXnE6AAI4B7qj
X-Iguazu-QSIG: v=2; s=0; t=1771217341; q=2rWhnGXnE6AAI4B7qj; m=NXkeewkucHTS54lMsBpHOmcfVfntTjEACkhRkXgEZ78=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fDqzx48nvz1xnj; Mon, 16 Feb 2026 13:49:01 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org,
        Sarthak Garg <sartgarg@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH for 5.10.y 1/2] mmc: sdhci: Introduce max_timeout_count variable in sdhci_host
Date: Mon, 16 Feb 2026 13:48:41 +0900
X-TSB-HOP2: ON
Message-Id: <1771217321-26246-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mail.toshiba,quarantine];
	R_DKIM_ALLOW(-0.20)[mail.toshiba:s=key1.smx];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216659-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nobuhiro.iwamatsu.x90@mail.toshiba,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mail.toshiba:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,intel.com:email,codeaurora.org:email,mail.toshiba:mid,mail.toshiba:dkim,mail.toshiba:email]
X-Rspamd-Queue-Id: 42DD414115D
X-Rspamd-Action: no action

From: Sarthak Garg <sartgarg@codeaurora.org>

commit e30314f255117f37412d41e918f941a9ae0835f3 upstream.

Introduce max_timeout_count variable in the sdhci_host structure
and use in timeout calculation. By default its set to 0xE
(max timeout register value as per SDHC spec). But at the same time
vendors drivers can update it if they support different max timeout
register value than 0xE.

Signed-off-by: Sarthak Garg <sartgarg@codeaurora.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/1628232901-30897-2-git-send-email-sartgarg@codeaurora.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 drivers/mmc/host/sdhci.c | 16 +++++++++-------
 drivers/mmc/host/sdhci.h |  1 +
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9091930f58591..435df5ccaba62 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -948,21 +948,21 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
 
 	/*
 	 * If the host controller provides us with an incorrect timeout
-	 * value, just skip the check and use 0xE.  The hardware may take
+	 * value, just skip the check and use the maximum. The hardware may take
 	 * longer to time out, but that's much better than having a too-short
 	 * timeout value.
 	 */
 	if (host->quirks & SDHCI_QUIRK_BROKEN_TIMEOUT_VAL)
-		return 0xE;
+		return host->max_timeout_count;
 
 	/* Unspecified command, asume max */
 	if (cmd == NULL)
-		return 0xE;
+		return host->max_timeout_count;
 
 	data = cmd->data;
 	/* Unspecified timeout, assume max */
 	if (!data && !cmd->busy_timeout)
-		return 0xE;
+		return host->max_timeout_count;
 
 	/* timeout in us */
 	target_timeout = sdhci_target_timeout(host, cmd, data);
@@ -982,15 +982,15 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
 	while (current_timeout < target_timeout) {
 		count++;
 		current_timeout <<= 1;
-		if (count >= 0xF)
+		if (count > host->max_timeout_count)
 			break;
 	}
 
-	if (count >= 0xF) {
+	if (count > host->max_timeout_count) {
 		if (!(host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT))
 			DBG("Too large timeout 0x%x requested for CMD%d!\n",
 			    count, cmd->opcode);
-		count = 0xE;
+		count = host->max_timeout_count;
 	} else {
 		*too_big = false;
 	}
@@ -4012,6 +4012,8 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 	host->adma_table_cnt = SDHCI_MAX_SEGS * 2 + 1;
 	host->max_adma = 65536;
 
+	host->max_timeout_count = 0xE;
+
 	return host;
 }
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index a188bf241a117..9947098ff1ef5 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -516,6 +516,7 @@ struct sdhci_host {
 
 	unsigned int max_clk;	/* Max possible freq (MHz) */
 	unsigned int timeout_clk;	/* Timeout freq (KHz) */
+	u8 max_timeout_count;	/* Vendor specific max timeout count */
 	unsigned int clk_mul;	/* Clock Muliplier value */
 
 	unsigned int clock;	/* Current clock (MHz) */
-- 
2.51.0



