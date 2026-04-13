Return-Path: <stable+bounces-236370-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Aw/CYsY3WnoZwkAu9opvQ
	(envelope-from <stable+bounces-236370-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:23:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7AD3EEC78
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D83C030CBB61
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B01A2472A2;
	Mon, 13 Apr 2026 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p6pY9Aqh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1831B24E4AF;
	Mon, 13 Apr 2026 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096731; cv=none; b=RS7ToyqnSnU27qXqkA0UuKtgeN+eOMB7/EhUBFJCASEtzGdG8k5+kY409aIc1t2i5cvLJtPOHQTFUdLJwzz89hmN60fsfWN7W290ZiukL4S2AZLMHyKCiAitvAOo8VquL/Fg1g7hiYnMLYv6AGnigvlggY+opPPUQK53QFzsv5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096731; c=relaxed/simple;
	bh=A6L2uBe7DcWg/NziCIN7B7R7afWvSL4cwYtLwnhLqMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6w4qP3rBq+h77w4+hZnClowuuOtCQbroErB2wdx3pHCPNd8sitwnOFbLlYqzQOt7chsZJNPzvbq6q9i5E/r76Cz4pQNGVEeRoz7+2+b8ZPlFD3JZi1qcpCDbgBusYjgKKSktWh9h0CeDE9g8ciY+9npAb7oUhM7ns4d3om6I2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p6pY9Aqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65126C2BCAF;
	Mon, 13 Apr 2026 16:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096730;
	bh=A6L2uBe7DcWg/NziCIN7B7R7afWvSL4cwYtLwnhLqMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p6pY9Aqhj2Kz0nG7eE9YWtwQDS9qk9eWYw5K2Y+zD7LEXX8h6Lnv3Do9vKQVI9024
	 FpTfZoYkVR5h25rUawJ98ij7OQuhqq2h1iWKQQw1tOvS+Qm4ZYuoDka4UKgKd8erIN
	 ZX8SH7byG6O4Rk3KEg4j9ZTJtN0W5W9gojKXhCi4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shawn Guo <shawnguo@kernel.org>,
	Wei Xu <xuwei5@hisilicon.com>
Subject: [PATCH 6.12 40/70] arm64: dts: hisilicon: hi3798cv200: Add missing dma-ranges
Date: Mon, 13 Apr 2026 18:00:35 +0200
Message-ID: <20260413155729.676559359@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155728.181580293@linuxfoundation.org>
References: <20260413155728.181580293@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-236370-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[8a22000:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hisilicon.com:email]
X-Rspamd-Queue-Id: 9A7AD3EEC78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shawn Guo <shawnguo@kernel.org>

commit 1af997cad473d505248df6d9577183bb91f69670 upstream.

Reboot starts failing on Poplar since commit 8424ecdde7df ("arm64: mm:
Set ZONE_DMA size based on devicetree's dma-ranges"), which effectively
changes zone_dma_bits from 30 to 32 for arm64 platforms that do not
properly define dma-ranges in device tree.  It's unclear how Poplar reboot
gets broken by this change exactly, but a dma-ranges limiting zone_dma to
the first 1 GB fixes the regression.

Fixes: 2f20182ed670 ("arm64: dts: hisilicon: add dts files for hi3798cv200-poplar board")
Cc: stable@vger.kernel.org
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
@@ -122,6 +122,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0xf0000000 0x10000000>;
+		dma-ranges = <0x0 0x0 0x0 0x40000000>;
 
 		crg: clock-reset-controller@8a22000 {
 			compatible = "hisilicon,hi3798cv200-crg", "syscon", "simple-mfd";



