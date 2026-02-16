Return-Path: <stable+bounces-216656-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JVRMELKykmmBwgEAu9opvQ
	(envelope-from <stable+bounces-216656-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 07:01:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E15EA1410C4
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 07:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CB7E300A767
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 06:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AE924A078;
	Mon, 16 Feb 2026 06:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b="tbw+yvVj"
X-Original-To: stable@vger.kernel.org
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1121.securemx.jp [210.130.202.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3E24A32
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 06:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771221677; cv=none; b=MTGe23cwhH87IBhxf9ZJJ4i4pi/7FCnx0gyE80neKQPhcjfYyNKkQUdB0/fRn1gGPbMSXfV4+9izowpJF5TXtmwXcGoX7uNNV8KWsXXJjo5IDfNQJmK/2L83nqA95B3xP44aa0zJUUjwEdNJQ+e2jERnG8m4CUVpOb7wTI1sicI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771221677; c=relaxed/simple;
	bh=AAWaAigaq9kIOnIMZAvlQM+erXJZNDpzcO3Ru2EBKo8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Tzem9ubeq63YzyYLe8VCPYmssDlY+TW0se/M63rQLNwK9vzdiWN+4JpXuKGiz9bD6BQqg6JxmyKAZUWYFYcnCBwhdduYxvtekDm2qyU0OyLw+b/kUgfcjRbEVyybi+pqqsVwD9srKUpdrLiYqwZPMoSJvSiwz4Kci8JF3DqfzXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba; spf=pass smtp.mailfrom=mail.toshiba; dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b=tbw+yvVj; arc=none smtp.client-ip=210.130.202.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.toshiba
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1121) id 61G4nrKm1299704; Mon, 16 Feb 2026 13:49:53 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id;i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key1.smx;t=
	1771217364;x=1772426964;bh=AAWaAigaq9kIOnIMZAvlQM+erXJZNDpzcO3Ru2EBKo8=;b=tbw
	+yvVj2l86jp/8YW9wIFgafJ2GmcALIERaU/lmsFNxyCuIg5oNz4NEEmncVyWg4k62ueh2X2fQaYzk
	Vdov0NCVAsPJ4794IoxOy2nCoUVp2zcXlxz8yJpKlaP8irzBDRsWot6D1/pXrSf+VSkr4MK65XjII
	3z/UUK0Esui2M+lm52qQBAOOauhfrKHcNrxuRj21L9J4MBVOBdpeXXbY/d4+UJd13NtqWx+RooK9L
	Cijn0kFtjKs8mcw13Dwb3AKE3jEl6S3DxzKBQgCg6mcqX65wrGiBDw5fUjWrl0GT0VeBAaprr283d
	zem7wj/ADhHaM9cVP1mU8OxQp9I2q+Q==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 61G4nOj8021826; Mon, 16 Feb 2026 13:49:24 +0900
X-Iguazu-Qid: 2rWhPDSx1FMdX6kLHA
X-Iguazu-QSIG: v=2; s=0; t=1771217364; q=2rWhPDSx1FMdX6kLHA; m=Ye0/B0nd8QclItPdW4U+/MKatWyaZAjwy+DdawlRL5w=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fDr0N2C57z4vym; Mon, 16 Feb 2026 13:49:24 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org,
        Bean Huo <beanhuo@micron.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH for 5.10.y 2/2] mmc: sdhci: Return true only when timeout exceeds capacity of the HW timer
Date: Mon, 16 Feb 2026 13:49:17 +0900
X-TSB-HOP2: ON
Message-Id: <1771217357-26296-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
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
	TAGGED_FROM(0.00)[bounces-216656-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linaro.org:email,micron.com:email,mail.toshiba:mid,mail.toshiba:dkim,mail.toshiba:email]
X-Rspamd-Queue-Id: E15EA1410C4
X-Rspamd-Action: no action

From: Bean Huo <beanhuo@micron.com>

commit 9c6bb8c6a1a48608692f3c8c21be13b759ec9056 upstream.

Clean up sdhci_calc_timeout() a bit,  and let it set too_big to be true only
when the timeout value required by the eMMC device exceeds the capability of
the host hardware timer.

Signed-off-by: Bean Huo <beanhuo@micron.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20210917172727.26834-2-huobean@gmail.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 drivers/mmc/host/sdhci.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 435df5ccaba62..decf70e560e35 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -944,7 +944,7 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
 	struct mmc_data *data;
 	unsigned target_timeout, current_timeout;
 
-	*too_big = true;
+	*too_big = false;
 
 	/*
 	 * If the host controller provides us with an incorrect timeout
@@ -955,7 +955,7 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
 	if (host->quirks & SDHCI_QUIRK_BROKEN_TIMEOUT_VAL)
 		return host->max_timeout_count;
 
-	/* Unspecified command, asume max */
+	/* Unspecified command, assume max */
 	if (cmd == NULL)
 		return host->max_timeout_count;
 
@@ -982,17 +982,14 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
 	while (current_timeout < target_timeout) {
 		count++;
 		current_timeout <<= 1;
-		if (count > host->max_timeout_count)
+		if (count > host->max_timeout_count) {
+			if (!(host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT))
+				DBG("Too large timeout 0x%x requested for CMD%d!\n",
+				    count, cmd->opcode);
+			count = host->max_timeout_count;
+			*too_big = true;
 			break;
-	}
-
-	if (count > host->max_timeout_count) {
-		if (!(host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT))
-			DBG("Too large timeout 0x%x requested for CMD%d!\n",
-			    count, cmd->opcode);
-		count = host->max_timeout_count;
-	} else {
-		*too_big = false;
+		}
 	}
 
 	return count;
-- 
2.51.0



