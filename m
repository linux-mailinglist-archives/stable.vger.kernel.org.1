Return-Path: <stable+bounces-218184-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JIDMi1RnmmbUgQAu9opvQ
	(envelope-from <stable+bounces-218184-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:32:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE6718EEF9
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C65F23053A24
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9BF251793;
	Wed, 25 Feb 2026 01:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZeMS/lgm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0DB4369A;
	Wed, 25 Feb 2026 01:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982971; cv=none; b=VIaEWC05dWBh9tnghAuUd/x8mBHFfcv9HsFI1VSPLxql/OBOKpmZo1lr1TcEMiWFf0pF82rvp2WCG0XcZD8DxroVZCjCtDftKXeaTB8UtMhxsQytRy2xPvIpUENoi05qCVsEF10L5sXm+1But0hI6PyVouadfDrggMJf5IgCvsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982971; c=relaxed/simple;
	bh=HIpLFK90hO3b8eIdae5jBt6pTiaXQzs3a4LDipKI8KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=isf5RI1nTmlHzi8drA+ASZU4twwpEB6hYTJDmJZIPYEjE9x+0txQGw8Inwjl6dSuoRgnoXlEONF8in+DqxLXjvVQC4pQ14x3tHeZ0cFQN3FfHGLprGVrMwjwhPbmCrmBfl6KpxgRaArTSe1/2POKYUaSN8WlbQ63hhieDWTFkiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZeMS/lgm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D99C116D0;
	Wed, 25 Feb 2026 01:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982971;
	bh=HIpLFK90hO3b8eIdae5jBt6pTiaXQzs3a4LDipKI8KE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZeMS/lgmcqwnyIvGt/hEzpSK5F8AuSR8QUDBkiKD9iQcsiXnkNY2GXhAsPPi1sj1o
	 JhmOUa9iMUbA8Z2mMTaFNvLF2pAOsOvLM4Q9Frd8bVU2PeOjpFOvIUKVA9ZxRfh1DO
	 VfidH2mib1zcGFUu1PqF3aTlfvFA52/WA8MTXquI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Anton D. Stavinskii" <stavinsky@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Chen Wang <wangchen20@iscas.ac.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 145/781] riscv: dts: sophgo: cv180x: fix USB dwc2 FIFO sizes
Date: Tue, 24 Feb 2026 17:14:14 -0800
Message-ID: <20260225012403.220956149@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-218184-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,outlook.com,iscas.ac.cn,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0BE6718EEF9
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anton D. Stavinskii <stavinsky@gmail.com>

[ Upstream commit 03ea8676919af21b99bea01f18ef1a271d19f92f ]

I've tested the current dwc2 FIFO configuration and found that USB
device mode breaks in ECM mode when transmitting frames larger than
128 bytes. For example, large ICMP packets or iperf3 traffic cause
the USB link to hang and eventually disconnect without any messages in
dmesg.

After switching to more conservative FIFO sizes, ECM becomes stable
and no longer drops the connection. iperf3 now shows ~130 Mbit/s RX
and ~100 Mbit/s TX on SG2002 (MilkV Duo 256M).

Fix the FIFO sizes accordingly.

Signed-off-by: Anton D. Stavinskii <stavinsky@gmail.com>
Reviewed-by: Inochi Amaoto <inochiama@gmail.com>
Fixes: e307248a3c2d ("riscv: dts: sophgo: Add USB support for cv18xx")
Link: https://lore.kernel.org/r/20251126172115.1894190-2-stavinsky@gmail.com
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/boot/dts/sophgo/cv180x.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/sophgo/cv180x.dtsi b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
index 1b2b1969a6484..06b0ce5a2db7a 100644
--- a/arch/riscv/boot/dts/sophgo/cv180x.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
@@ -438,8 +438,8 @@ usb: usb@4340000 {
 			clocks = <&clk CLK_AXI4_USB>, <&clk CLK_APB_USB>;
 			clock-names = "otg", "utmi";
 			g-np-tx-fifo-size = <32>;
-			g-rx-fifo-size = <536>;
-			g-tx-fifo-size = <768 512 512 384 128 128>;
+			g-rx-fifo-size = <1536>;
+			g-tx-fifo-size = <128 128 64 64 64 64 32 32>;
 			interrupts = <SOC_PERIPHERAL_IRQ(14) IRQ_TYPE_LEVEL_HIGH>;
 			phys = <&usbphy>;
 			phy-names = "usb2-phy";
-- 
2.51.0




