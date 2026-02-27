Return-Path: <stable+bounces-219930-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIXLAKVPoWkfsAQAu9opvQ
	(envelope-from <stable+bounces-219930-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 09:02:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F2F1B437B
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 09:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3487A301187B
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 08:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A175F3019D9;
	Fri, 27 Feb 2026 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NzKVv/MF"
X-Original-To: stable@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503FE368943
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 08:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772179296; cv=none; b=evDXpnddfNZZYCHqSplLROCH6ZEEPjaftCdygJOB1te0EEpWJJ/VicjLRn0m0XbNV2EahSGzDeIsgHVFBcs6n10lX4J7FF5oUbH45Zh/SjCJ3kexr9qVFXtiWPBR/xdWzKzuz7vtiZZTDqzXTYA2zikPyf3tgp+q/SY0nAoPLhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772179296; c=relaxed/simple;
	bh=L7F+r3J84syV47PIHgh5dYdBtE03Cg3oMvvoDQtZg0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n8x5deLGfSwtQ6xxAKzw6MVvssozzqggWBTYw6Jbkbrye4Ky4JXiIZ1SFePSmQQQtzNPhKUyIp8c24rP8ZF38ZVX1ZJY5B1nbwd2oHs0rUhFjJuQgsKyZsKaZ97zRTMFkHX6TtCcRD1E5ldi/MbgmmtzkQLgdZm82MTU/Y6N8IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NzKVv/MF; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772179292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gwJj1+FJ2SrTq0V7rniC+F/sZrYY8oLo+nmrkZurdaU=;
	b=NzKVv/MFap2TqTkBEF6cTQrHZv4DusJdFAyqM3WkGP7K8NN0wrllvynbzy7pwDSrxSHP0t
	6oSL9MBy0hbrV57+XAoipepr+Ls23ybDk5raGA+9ZhFZqDgVpH2a1F8WI4euonRm0o+P9i
	exkeuDtH97qAOFJl61s2YwQTOFfOvYI=
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthew Schwartz <matthew.schwartz@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH] mmc: sdhci-pci-gli: fix GL9750 DMA write corruption
Date: Thu, 26 Feb 2026 23:59:09 -0800
Message-ID: <20260227075909.3860183-1-matthew.schwartz@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219930-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.schwartz@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 57F2F1B437B
X-Rspamd-Action: no action

The GL9750 SD host controller has intermittent data corruption during
DMA write operations. The GM_BURST register's R_OSRC_Lmt field
(bits 17:16), which limits outstanding DMA read requests from system
memory, is not being cleared during initialization. The Windows driver
sets R_OSRC_Lmt to zero, limiting requests to the smallest unit.

Clear R_OSRC_Lmt to match the Windows driver behavior. This eliminates
write corruption verified with f3write/f3read tests while maintaining
DMA performance.

Cc: stable@vger.kernel.org
Fixes: e51df6ce668a ("mmc: host: sdhci-pci: Add Genesys Logic GL975x support")
Closes: https://lore.kernel.org/linux-mmc/33d12807-5c72-41ce-8679-57aa11831fad@linux.dev/
Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
---
Link to RFC: https://lore.kernel.org/all/20260117234800.931664-1-matthew.schwartz@linux.dev/
Changes from RFC -> v1: use the proper name for the register field 
---
 drivers/mmc/host/sdhci-pci-gli.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index b0f91cc9e40e4..7a7be3f7bee6b 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -26,6 +26,9 @@
 #define   GLI_9750_WT_EN_ON	    0x1
 #define   GLI_9750_WT_EN_OFF	    0x0
 
+#define SDHCI_GLI_9750_GM_BURST_SIZE		  0x510
+#define   SDHCI_GLI_9750_GM_BURST_SIZE_R_OSRC_LMT	    GENMASK(17, 16)
+
 #define SDHCI_GLI_9750_CFG2          0x848
 #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
 #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
@@ -629,6 +632,11 @@ static void gl9750_hw_setting(struct sdhci_host *host)
 
 	gl9750_wt_on(host);
 
+	/* clear R_OSRC_Lmt to avoid DMA write corruption */
+	value = sdhci_readl(host, SDHCI_GLI_9750_GM_BURST_SIZE);
+	value &= ~SDHCI_GLI_9750_GM_BURST_SIZE_R_OSRC_LMT;
+	sdhci_writel(host, value, SDHCI_GLI_9750_GM_BURST_SIZE);
+
 	value = sdhci_readl(host, SDHCI_GLI_9750_CFG2);
 	value &= ~SDHCI_GLI_9750_CFG2_L1DLY;
 	/* set ASPM L1 entry delay to 7.9us */
-- 
2.53.0


