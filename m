Return-Path: <stable+bounces-252441-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8I6AMmYUDmoW6AUAu9opvQ
	(envelope-from <stable+bounces-252441-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:07:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D75599277
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 024933103743
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E209C3F871A;
	Wed, 20 May 2026 18:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X+HBzVXC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C393EAC82;
	Wed, 20 May 2026 18:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300681; cv=none; b=paGGuzagmIKIWjHlHi/j4WyqV98vHVJ53NULjmmr2BCtST7diozc+Fp6Zhc1zK/lQRtQdKpQjFn3CzrsnOICMJ84lpKI8Z7ZZDbFokQL+wp+z8EyZJMJSabmODscX5VEmVMlyI1S+W2Jd8ycLuPfg3sgf0N8ZGJMW56+g7RpzQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300681; c=relaxed/simple;
	bh=i0vDDr68pht7/xPK2eLw/5F2+30epmPo2Byga2Kbbto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7dqzVp5PB1HZqZ4u4L9GlE30mBX+S9S5nSG2nNfX/sGX49yTahEo8PyPW458IxR7Ayut2BiUAYwmmkXSDMX8PfUWOLf33Fes/eWmJPLyh/O5Bqzjp0Z8F2JZPDafI4kuv3wsmN5WiwtxAzHtpaRVFTNRE/FBWK8BAdTCUzErOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X+HBzVXC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18F01F000E9;
	Wed, 20 May 2026 18:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300680;
	bh=aqfJlShfrd9Kgegpsg0Gbgt3W9SuV4fX/6WVXKbUA5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X+HBzVXCJeYY31YkdoU+fmJg66Nm0AnAtbt11yCFj+tvsDlwf6YjVnLS1YCm3MPE5
	 9Q3RgNcUxhn1MqADMnzZ8Gc+PMQ1Rju7btLDSzAFqeJG6XdoNLT68p/na+oBHpg53N
	 nepptLYqaNHwwFASW2Qy65MWsOdMuAUNjyd51Pgc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 268/666] arm64: dts: rockchip: Make Jaguar PCIe-refclk pin use pull-up config
Date: Wed, 20 May 2026 18:17:59 +0200
Message-ID: <20260520162117.024962026@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252441-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,cherry.de:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: C5D75599277
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Stuebner <heiko.stuebner@cherry.de>

[ Upstream commit f45d4356feeba1c8dac3414b688f59292ddfc9f9 ]

The hardware PU/PD config of the pin after reset is to pull-up and on
Jaguar this will also keep the device in reset until the driver actually
enables the pin. So restore this boot pull-up config of the pin on Jaguar
instead of setting it to pull-none.

Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>
Fixes: 0ec7e1096332 ("arm64: dts: rockchip: add PCIe3 support on rk3588-jaguar")
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Link: https://patch.msgid.link/20260210080303.680403-5-heiko@sntech.de
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
index e61c5731fb99f..46834d9ae565e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
@@ -424,7 +424,7 @@ led1_pin: led1-pin {
 
 	pcie30x4 {
 		pcie30x4_clkreqn_m0: pcie30x4-clkreqn-m0 {
-			rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
+			rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 
 		pcie30x4_perstn_m0: pcie30x4-perstn-m0 {
-- 
2.53.0




