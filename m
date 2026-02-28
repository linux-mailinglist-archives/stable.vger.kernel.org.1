Return-Path: <stable+bounces-220194-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLs3Om0zo2mX+QQAu9opvQ
	(envelope-from <stable+bounces-220194-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:26:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FED1C5CC2
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E11FC31E7439
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A884C9547;
	Sat, 28 Feb 2026 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CT1jYF21"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866114C901C;
	Sat, 28 Feb 2026 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300100; cv=none; b=pDXsXmxW4CWJkY5KqSY9dk1S9gGH4Hpa2Yl64GrlnWZxZjQ2GSq1I5fCCqGbf6qpSi4rrkUO91C4NgVIKH5GBR8qbTyZu5dDyY13FmbwuVDCUhUlYCPt3kR6/6eFFhSck92YyjierI0WDjc9gqi4MWE3JwZ56uAgXphX9q7SIiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300100; c=relaxed/simple;
	bh=KZzFRZBpSG0W8DPwDPhrbD6AABynbOqamuy0NSCIbNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOFivm07uudhcNOFExcIcV5Hd8qLzypNldSe0Tzf3bInP0sa9AA5Ai8lO/bZBKl0yq5Ku3Srii8U/zaT4k9RICDZsMzw5GxYyUjnv6VXmPbWMDhIuynWFARymBgbwYpKojs2AXCAtsovVxpc1c3z7QwQa8rlUno6+VPDfnS7pKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CT1jYF21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77DDC19423;
	Sat, 28 Feb 2026 17:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300100;
	bh=KZzFRZBpSG0W8DPwDPhrbD6AABynbOqamuy0NSCIbNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CT1jYF21wUKv7wik9IrscruDF2xaecEU+kp/vmcn4TpsqvaC750pGXZ/jTPneQDrK
	 cOJoaktG4CsNWJCdl/czbV7e1ak4GxipRIrMSGOossjPNzRCq7vEFquP/IjyqXf2GZ
	 mQW4DwclLHEqiLNAGHCvV7e7q9MUqZa47U+gNmtbLKQRyMIGAnjktXKIZ2vq8C8LJN
	 FaK/H75e/tKtJ+ZTbq0T8Rcty98qOMsYn6/+Gep0G2EAS7uCqhcvvJSsbQ4G7MeItV
	 XeP/mukWCOd/24eQmm55/hQFfiE3mqe/0157N0tulVdD12mb28nSjr58qB3p55SVN9
	 q3wFQxAdxDeIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Jianfeng Gao <jianfeng.gao@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 116/844] EDAC/igen6: Add two Intel Amston Lake SoCs support
Date: Sat, 28 Feb 2026 12:20:29 -0500
Message-ID: <20260228173244.1509663-117-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-220194-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 12FED1C5CC2
X-Rspamd-Action: no action

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

[ Upstream commit 41ca2155d62b0b0d217f59e1bce18362d0c2446f ]

Intel Amston Lake SoCs with IBECC (In-Band ECC) capability share the same
IBECC registers as Alder Lake-N SoCs. Add two new compute die IDs for
Amston Lake SoC products to enable EDAC support.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Tested-by: Jianfeng Gao <jianfeng.gao@intel.com>
Link: https://patch.msgid.link/20251124065457.3630949-2-qiuxu.zhuo@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/igen6_edac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 839b6dd3629e9..f2c9270c1893c 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -246,6 +246,8 @@ static struct work_struct ecclog_work;
 
 /* Compute did IDs for Amston Lake with IBECC */
 #define DID_ASL_SKU1	0x464a
+#define DID_ASL_SKU2	0x4646
+#define DID_ASL_SKU3	0x4652
 
 /* Compute die IDs for Raptor Lake-P with IBECC */
 #define DID_RPL_P_SKU1	0xa706
@@ -628,6 +630,8 @@ static struct pci_device_id igen6_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, DID_ADL_N_SKU12), (kernel_ulong_t)&adl_n_cfg },
 	{ PCI_VDEVICE(INTEL, DID_AZB_SKU1), (kernel_ulong_t)&adl_n_cfg },
 	{ PCI_VDEVICE(INTEL, DID_ASL_SKU1), (kernel_ulong_t)&adl_n_cfg },
+	{ PCI_VDEVICE(INTEL, DID_ASL_SKU2), (kernel_ulong_t)&adl_n_cfg },
+	{ PCI_VDEVICE(INTEL, DID_ASL_SKU3), (kernel_ulong_t)&adl_n_cfg },
 	{ PCI_VDEVICE(INTEL, DID_RPL_P_SKU1), (kernel_ulong_t)&rpl_p_cfg },
 	{ PCI_VDEVICE(INTEL, DID_RPL_P_SKU2), (kernel_ulong_t)&rpl_p_cfg },
 	{ PCI_VDEVICE(INTEL, DID_RPL_P_SKU3), (kernel_ulong_t)&rpl_p_cfg },
-- 
2.51.0


