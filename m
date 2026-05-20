Return-Path: <stable+bounces-250530-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIdzJFbpDWrM4gUAu9opvQ
	(envelope-from <stable+bounces-250530-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:03:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF53592DCB
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88D5730337FE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A7A352016;
	Wed, 20 May 2026 16:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ivTm0GMk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2A53AC00;
	Wed, 20 May 2026 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295651; cv=none; b=b0xn56GDzmNNyIVsXpBU2X0JE3O7kzsZ+8YPkfeTq4pBayxIY0bDcx0S7nLdPjYb2shIOCpYIDCQoSeyqL3jCUw9d38zE77yWWaCytUylevBCNWvslnijUTBhoGdnMT3Unc56BZDz3MEgzdoWSldnNBpvmp2GiXwEIFvjoRJfu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295651; c=relaxed/simple;
	bh=F4DdFezdZIPtSj3JL4d7S7lquhpLzYuBJYrx5nHyEzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyxTVIAKXlMvhRvqOP8wEfhKvUkFuPiX/55MS+I67Gt6/Wkt6XqZkvC03p89dxyHPKI/7ISskleH4v81qx6RQ9h1BcsxNjQXNjKYlPUY2WmYUN2EPFRkoK3mDiI8pG4V0p9FZmBKVw8fxK0X97Kjkb4YylmQ9BXG7219dyduldY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ivTm0GMk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6DA1F000E9;
	Wed, 20 May 2026 16:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295650;
	bh=RdfxuEsWResutZG/FNhAn0CcTRZTu1h6Sn+/uKvM990=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ivTm0GMkBIufXjPv7acK5K9R814mNFMoq0Ydp+g+wiVaA5PrErdA/T6oI/jv84gw7
	 n2USe8F66xaZxu6ltyvafMaE/lwAW7pRxuc211JtTCO2A4RU5eCWe7VCbmNatcbfE+
	 1BAiqjU0V9fH9RrDL8qSPBCmiarMaTuTQfi94T/U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chris Morgan <macromorgan@hotmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0500/1146] arm64: dts: rockchip: Correct Fan Supply for Gameforce Ace
Date: Wed, 20 May 2026 18:12:30 +0200
Message-ID: <20260520162159.505964896@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-250530-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,hotmail.com,sntech.de,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url,sntech.de:email]
X-Rspamd-Queue-Id: 2AF53592DCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Morgan <macromorgan@hotmail.com>

[ Upstream commit c7079215b7dbf88b84a95ff13982bf3dab3cfbe1 ]

Correct the regulator providing power to the PWM controlled fan.
Without this fix the fan only runs when the audio path is playing
audio (because the speaker amplifier and PWM fan share the same
regulator).

Fixes: 4e946c447a04 ("arm64: dts: rockchip: Add GameForce Ace")
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Link: https://patch.msgid.link/20260310134648.550006-1-macroalpha82@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts b/arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts
index e8ad525ba3f9b..59d2494c45100 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts
@@ -318,7 +318,7 @@ pwm_fan: pwm-fan {
 		compatible = "pwm-fan";
 		#cooling-cells = <2>;
 		cooling-levels = <0 120 150 180 210 240 255>;
-		fan-supply = <&vcc5v0_sys>;
+		fan-supply = <&vcc5v0_spk>;
 		interrupt-parent = <&gpio4>;
 		interrupts = <RK_PB2 IRQ_TYPE_EDGE_RISING>;
 		pulses-per-revolution = <4>;
-- 
2.53.0




