Return-Path: <stable+bounces-212504-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGZ8MJQ3eml+4gEAu9opvQ
	(envelope-from <stable+bounces-212504-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:21:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD343A5783
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4AC0A30EED9C
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3B63064B3;
	Wed, 28 Jan 2026 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qlJip/n5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F2B305057;
	Wed, 28 Jan 2026 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615739; cv=none; b=mQ47HKi+JCnMmXdDsXjmI3jdEXnpr6DGjN6vpOoFFw7k5ROlA/kmVgSadW/XkkErBU+eCh3Ubx3c6E3gz7yMZLGXFyhMghINv/17Z7qP7Lqr4m0WFKlF/mxGqF2Yv2SxdfJcRV9mrgUNzR0DgIysFsUEnRZHmyLQL6kQHpMaKJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615739; c=relaxed/simple;
	bh=owQPXdkguI6A8itoVNR5kSOX7FfLllMEj6wpzhKGsss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d86iIF8zJ5dQU9oXV9tF57jg2RXX0ZPpR8L1F2efB+GgPMQiZwFCjnogjGFXzuCP3zIdWIyhzBWp0Cdag2wbI0evxJK0ISK7zjXXjbVAdwIn8kGIn42J57Q5ggKL6oE5pPrm5uGgAKM6cRw7o3K2zatpiA/yLwf+39cAyZdEIuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qlJip/n5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328CDC4CEF1;
	Wed, 28 Jan 2026 15:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615739;
	bh=owQPXdkguI6A8itoVNR5kSOX7FfLllMEj6wpzhKGsss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qlJip/n5hFhu+zOfN7tYBEnbZdJLhAWIwKYuSCV7+91jm/TKPWKU4fnuBfZ8LpkEV
	 fI9K++E+QYKnd0/gvDF7lRDinvPcuS++MJQoEqDXNBMQempYjsNJBuO0CdfLiZHJT1
	 LOx9xOyAq4q01Xx1ot3nhMgfxf/sc0qOx8OxcnuA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexey Charkov <alchark@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 6.18 067/227] arm64: dts: rockchip: Configure MCLK for analog sound on NanoPi M5
Date: Wed, 28 Jan 2026 16:21:52 +0100
Message-ID: <20260128145346.751637368@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212504-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,sntech.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sntech.de:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: CD343A5783
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Charkov <alchark@gmail.com>

commit 3e4a81881c0929b21a0577bc6e69514c09da5c3f upstream.

NanoPi M5 derives its analog sound signal from SAI2 in M0 pin mode, so the
MCLK pin should be configured accordingly for the sound codec to get its
I2S signal from the SoC. Request the required pin config.

The clock itself should also be CLK_SAI2_MCLKOUT_TO_IO for the sound to
work (otherwise there is only silence out of the audio out jack).

Fixes: 96cbdfdd3ac2 ("arm64: dts: rockchip: Add FriendlyElec NanoPi M5 support")
Cc: stable@vger.kernel.org
Signed-off-by: Alexey Charkov <alchark@gmail.com>
Link: https://patch.msgid.link/20251229-rk3576-sound-v1-2-2f59ef0d19b1@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts b/arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts
index 37184913f918..bb2cc2814b83 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts
@@ -201,6 +201,7 @@ sound {
 		pinctrl-names = "default";
 		pinctrl-0 = <&hp_det_l>;
 
+		simple-audio-card,bitclock-master = <&masterdai>;
 		simple-audio-card,format = "i2s";
 		simple-audio-card,hp-det-gpios = <&gpio2 RK_PD6 GPIO_ACTIVE_LOW>;
 		simple-audio-card,mclk-fs = <256>;
@@ -218,8 +219,9 @@ simple-audio-card,codec {
 			sound-dai = <&rt5616>;
 		};
 
-		simple-audio-card,cpu {
+		masterdai: simple-audio-card,cpu {
 			sound-dai = <&sai2>;
+			system-clock-frequency = <12288000>;
 		};
 	};
 };
@@ -727,10 +729,12 @@ &i2c5 {
 	rt5616: audio-codec@1b {
 		compatible = "realtek,rt5616";
 		reg = <0x1b>;
-		assigned-clocks = <&cru CLK_SAI2_MCLKOUT>;
+		assigned-clocks = <&cru CLK_SAI2_MCLKOUT_TO_IO>;
 		assigned-clock-rates = <12288000>;
-		clocks = <&cru CLK_SAI2_MCLKOUT>;
+		clocks = <&cru CLK_SAI2_MCLKOUT_TO_IO>;
 		clock-names = "mclk";
+		pinctrl-0 = <&sai2m0_mclk>;
+		pinctrl-names = "default";
 		#sound-dai-cells = <0>;
 	};
 };
-- 
2.52.0




