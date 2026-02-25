Return-Path: <stable+bounces-218967-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANq8JxJanmkjUwQAu9opvQ
	(envelope-from <stable+bounces-218967-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:10:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D221D190A3C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D0CE3094922
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2C3284682;
	Wed, 25 Feb 2026 01:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q7TNWvGI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875CD2BEC2E;
	Wed, 25 Feb 2026 01:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983869; cv=none; b=FxPjNme52p2ZlWJ1UPwI/7qoVjo45jihJYW1MA/mqYKpresv3Rr0ZOcu3kWKO8Yeoj0F+PlBSdlPND2tWknmW548WcDpHVBJK05Fha0WD9nrMKi2u5Nx6xRgu2ePfrkzL7EAyoWaNJBH4Dyu2Ae7PlO6C8OTVUakz2GEGDG0FkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983869; c=relaxed/simple;
	bh=WWTb9Z41gNLs8LGrnZEcaOp6GiF+ScvqUkedXWW8+Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fa51XUlzYnEX+wll4vD9XhZCsuopSE8GosgREb1tCSscAM8avUZchQkRPlHFUvxHH1ngWbJ2nvmtNWw1Ij6dVG5IoouACOdDgZ4FROlB0P9k5bdklDGBMmBi9QfSSJbDllx2cDR+HiHGcdL+OEWhZyQ4aXG+OYn7XBw7hwjBNDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q7TNWvGI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B8DC116D0;
	Wed, 25 Feb 2026 01:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983869;
	bh=WWTb9Z41gNLs8LGrnZEcaOp6GiF+ScvqUkedXWW8+Fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q7TNWvGITwc9ACSYtA9WH9uDeelw9LuXAsWzEQHUU5pFRZTqGV2Sz8fw81Bn32d4b
	 bH2Oswm5bWYxBSYws+z3dwD8dn8OUi/ANQAHe/G4MEJNB8+qvVpedgEtn62LZ2eeRR
	 IPJm2B9SUPIXmAOdHk8++9yxMnbFzWHtnQba3N4o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 146/641] arm64: dts: renesas: rzt2h-n2h-evk-common: Use GPIO for SD0 write protect
Date: Tue, 24 Feb 2026 17:17:52 -0800
Message-ID: <20260225012352.644717301@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-218967-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[stable,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,glider.be:email,renesas.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: D221D190A3C
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit a1b1ee0348f889ec262482e16e9ff670617db7b0 ]

Switch SD0 write-protect detection to a GPIO on the RZ/T2H and RZ/N2H
EVKs. Both boards use a full-size SD card slot on the SD0 channel with
a dedicated WP pin.

The RZ/T2H and RZ/N2H SoCs use of_data_rcar_gen3, which sets
MMC_CAP2_NO_WRITE_PROTECT and causes the core to ignore the WP signal
unless a wp-gpios property is provided. Describe the WP pin as a GPIO
to allow the MMC core to evaluate the write-protect status correctly.

Fixes: d065453e5ee0 ("arm64: dts: renesas: rzt2h-rzn2h-evk: Enable SD card slot")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260106131319.643084-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
index 5c91002c99c48..5384a43837c1d 100644
--- a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
@@ -154,8 +154,7 @@ data-pins {
 		ctrl-pins {
 			pinmux = <RZT2H_PORT_PINMUX(12, 0, 0x29)>, /* SD0_CLK */
 				 <RZT2H_PORT_PINMUX(12, 1, 0x29)>, /* SD0_CMD */
-				 <RZT2H_PORT_PINMUX(22, 5, 0x29)>, /* SD0_CD */
-				 <RZT2H_PORT_PINMUX(22, 6, 0x29)>; /* SD0_WP */
+				 <RZT2H_PORT_PINMUX(22, 5, 0x29)>; /* SD0_CD */
 		};
 	};
 
@@ -212,6 +211,7 @@ &sdhi0 {
 	pinctrl-names = "default", "state_uhs";
 	vmmc-supply = <&reg_3p3v>;
 	vqmmc-supply = <&vqmmc_sdhi0>;
+	wp-gpios = <&pinctrl RZT2H_GPIO(22, 6) GPIO_ACTIVE_HIGH>;
 	bus-width = <4>;
 	sd-uhs-sdr50;
 	sd-uhs-sdr104;
-- 
2.51.0




