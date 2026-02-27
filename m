Return-Path: <stable+bounces-219926-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULLgKzdGoWkirwQAu9opvQ
	(envelope-from <stable+bounces-219926-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 08:22:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAC21B3C88
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 08:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C23B030420B5
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 07:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92205369233;
	Fri, 27 Feb 2026 07:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSzmV6Tp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5474536495C;
	Fri, 27 Feb 2026 07:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772176938; cv=none; b=cihBwZ6tZVD8Bz6e4gCNA83TAoOuAs2ox7BcMN0iid/mWiIRxl406UfQG/1JCHtwaqJJaMllDPJRP8ZolSK1nieZkCTKWvkp4IGTFPPCmlNcV7zsSySzkoVsJfbzuLPhrNqVsASJ8Hm7wjMAQbxxnlG7RHLUNYiNjN4LbIO8NrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772176938; c=relaxed/simple;
	bh=z+dkaNvhlWyuSR+41jisptO92s8T16Uh6hMmGKmav1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N950CfcYat94tx8LTHzqcb0P3C4QJHsusOF2XMne6N6setdP06A7qvI/c/qRzz9dHWLmlPxTGtdxRSfYFR3vAnulTgn/qYfsbgF6MynffJrMgKn/VWVa4zvBpd1RT7I4KFlZRFYh1bXAMXmX+VAE2hF0lVhOewW9cRPZlhw8acs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSzmV6Tp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D81C19421;
	Fri, 27 Feb 2026 07:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772176938;
	bh=z+dkaNvhlWyuSR+41jisptO92s8T16Uh6hMmGKmav1s=;
	h=From:To:Cc:Subject:Date:From;
	b=bSzmV6TpnkDmJfT6r9mzcs6qtvqJPsnKKJDn9LxJasfEBXGAys6x3ddF1dWJClGs+
	 M8T1TtID6NI2glSAzjEgh3kIfXsnE05IUlXy2qevGQ6nvE7Ave9NBIRxPR91vvlWJK
	 dOZsO5KXwkjQb+QWsKyPIuZQa/wYe88sfAHWqwchEn2MrClmIBbS+MYmU8KNaIOgKQ
	 uN5kInDTt8FX61J6WN78MjE5/C4gTz8CAe0bAihoYo3wmh06Zec6jRoKvqRJUTADzS
	 NySHkJpEVsVjmrEAezvdtVgi1QDjHLZZPwijJLRxHEg+YfXNTTWSpjr+RnpMgilv1V
	 vCCWzP0zSJalg==
From: Shawn Guo <shawnguo@kernel.org>
To: Wei Xu <xuwei5@hisilicon.com>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Guo <shawnguo@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] arm64: dts: hisilicon: hi3798cv200: Add missing dma-ranges
Date: Fri, 27 Feb 2026 15:22:10 +0800
Message-ID: <20260227072210.1350159-1-shawnguo@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
	TAGGED_FROM(0.00)[bounces-219926-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shawnguo@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,f0000000:email]
X-Rspamd-Queue-Id: 9DAC21B3C88
X-Rspamd-Action: no action

Reboot starts failing on Poplar since commit 8424ecdde7df ("arm64: mm:
Set ZONE_DMA size based on devicetree's dma-ranges"), which effectively
changes zone_dma_bits from 30 to 32 for arm64 platforms that do not
properly define dma-ranges in device tree.  It's unclear how Poplar reboot
gets broken by this change exactly, but a dma-ranges limiting zone_dma to
the first 1 GB fixes the regression.

Fixes: 2f20182ed670 ("arm64: dts: hisilicon: add dts files for hi3798cv200-poplar board")
Cc: stable@vger.kernel.org
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
index f6bc001c3832..2f4ad5da5e33 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
@@ -122,6 +122,7 @@ soc: soc@f0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0xf0000000 0x10000000>;
+		dma-ranges = <0x0 0x0 0x0 0x40000000>;
 
 		crg: clock-reset-controller@8a22000 {
 			compatible = "hisilicon,hi3798cv200-crg", "syscon", "simple-mfd";
-- 
2.47.3


