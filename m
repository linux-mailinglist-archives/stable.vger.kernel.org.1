Return-Path: <stable+bounces-250514-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJDsOhXpDWrM4gUAu9opvQ
	(envelope-from <stable+bounces-250514-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:02:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2139F592D7F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC42D305AF1F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9647F362153;
	Wed, 20 May 2026 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OTTuf8y0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF6C31F9BE;
	Wed, 20 May 2026 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295609; cv=none; b=uvWegMr2nFRsUICi5Ow+Yd82/oE0t9JwbQCaN+tUt24/DWEDlEErfw5ZfaW75VVY36Kayjv9soZlUqGnr3ijyIsfKes0Hxu3FaHAdYx9UpEOVV+v0jkogYh5Vu4pKAsv+tcytW6ZICE1PT3WftZgkiEmusZjoTbVylApTXc/Ypg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295609; c=relaxed/simple;
	bh=8Mih9Snwnm4dIw0yMGsXVTt1byzMXmLbd/gm39rUU58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HL5kmt7qnFmG6Kvg69I20YE48w8+Z70zoO4K7yz/4aJCSmoXO73jEJqOFWJhn+R2MxlKi18OOuZzsTQj8wWyfizUiZF6WqU4z5U3O9oLczcCBYwpzmQZ5aYM7KKumxPLFUCLitF9+CIYUx+zAbKYKAP7bsjZzC87D/K+jscGe7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OTTuf8y0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F9B1F000E9;
	Wed, 20 May 2026 16:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295608;
	bh=Gy2CefHcUsGraI7/hWXhhhTFsPWBn9L/sCRWGksghd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OTTuf8y0hjR6bQgsYfjtwDD00EX2h5d6fqbhwygfZ/WfK1YHBz/CG2yKUCzEyjozy
	 gmlxKAVQ4LiZr8+NbWI8CQi12dcet1ODqsAdmeYeHkCrhxMAU0QzUWuZ01kdRyXtO9
	 KItNoAdEYjZkwlUiC9iNsdzYeJSeJWDIUO5lWC7s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0485/1146] arm64: dts: mediatek: mt7981b: Fix gpio-ranges pin count
Date: Wed, 20 May 2026 18:12:15 +0200
Message-ID: <20260520162159.167765522@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-250514-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,collabora.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,collabora.com:email,11d00000:email]
X-Rspamd-Queue-Id: 2139F592D7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Akari Tsuyukusa <akkun11.open@gmail.com>

[ Upstream commit b62a927f4a46a7f58d88ba3d5fb6e88e1a4b4603 ]

The gpio-ranges in the MT7981B pinctrl node were incorrectly defined,
therefore, pin 56 cannot be used.
Correct the range count to match the driver.

Fixes: 62b24c7fdf0a ("arm64: dts: mediatek: mt7981: add pinctrl")
Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
index 4084f4dfa3e5e..1bbe219380f99 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -332,7 +332,7 @@ pio: pinctrl@11d00000 {
 			interrupt-controller;
 			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-parent = <&gic>;
-			gpio-ranges = <&pio 0 0 56>;
+			gpio-ranges = <&pio 0 0 57>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			#interrupt-cells = <2>;
-- 
2.53.0




