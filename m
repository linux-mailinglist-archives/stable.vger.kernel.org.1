Return-Path: <stable+bounces-250529-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AUXL/MQDmrw5wUAu9opvQ
	(envelope-from <stable+bounces-250529-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:52:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2758F598D39
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4ECD83266E08
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1174633AD9D;
	Wed, 20 May 2026 16:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1/0qgaj1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1C93AC00;
	Wed, 20 May 2026 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295648; cv=none; b=tNzD41s6g0t7wxOkSALJCm9fEMb98O9+7XhS94y3F3BofAhkPG4QXafjfFYyUEw6USoMJtfpCDxnKbY/hLJbHwlBOlgHswEpD3CjPcID7dYJarD1dGn++vbjOqbdLTWmQekMQjQyBxV2JGYy6CROMhoDHbQf21AyrV06SUokwYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295648; c=relaxed/simple;
	bh=QpBJy3agHhM/YTswXpcACZXsDfIOJwGEENIgMIV758c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/epLstv/+aB5uq/F2tWM2DqAsZBdkiHHoY/gphZ7s1bRTNWM/GoJJhyTnYjFhsauNgYwauE71OjwdRAwBWgefBz5SIrsPYqQgRYV8RmULmmJIp1iQEYzLeqTP8Jo7oDOHrFWvEdW03xSmxAoHbc+nPh+lDOZop65FxhA5biHEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1/0qgaj1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5071F000E9;
	Wed, 20 May 2026 16:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295647;
	bh=KwHCK8eDQmicvzGEua83gnyRhow6/x5ID2vlFbRiZoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=1/0qgaj1VjisirW41hTRnPOD2jVwt9o01hm26smx1MNtWHUqwBKahBe99sBmShOPh
	 4HSrGIdFGXsNRxGNGOUXnewU2ejnusg5NXlfzjAEG+wJK9ELjOAuaiQLylFLlUJI8i
	 vMJ2OZhGyY9asy1KVP6NVfJbxh6qMGNsflMUFAHQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Hewitt <christianshewitt@gmail.com>,
	Alex Bee <knaerzche@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0499/1146] Revert "arm64: dts: rockchip: add SPDIF audio to Beelink A1"
Date: Wed, 20 May 2026 18:12:29 +0200
Message-ID: <20260520162159.484682753@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250529-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,arm.com,sntech.de,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,sntech.de:email,msgid.link:url,arm.com:email]
X-Rspamd-Queue-Id: 2758F598D39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit 03978cb18059ecd27e3d955508b18cf2a1196142 ]

This reverts commit bdc4d388c6452498ab62ef2564589f40e0c8c262.

While Beelink A1 mostly follows the high-end RK3328 reference design,
it does not in fact have the S/PDIF connector, only HDMI and a 3.5mm
jack for the analog audio/TV codecs - the tiny form factor literally
doesn't have room to fit more!

Cc: Christian Hewitt <christianshewitt@gmail.com>
Cc: Alex Bee <knaerzche@gmail.com>
Fixes: bdc4d388c645 ("arm64: dts: rockchip: add SPDIF audio to Beelink A1")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Link: https://patch.msgid.link/0af77a02c2b0806d4ca72066392a5453fcc89a8f.1767111968.git.robin.murphy@arm.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3328-a1.dts | 23 ----------------------
 1 file changed, 23 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-a1.dts b/arch/arm64/boot/dts/rockchip/rk3328-a1.dts
index 30bdb38f0727a..e810ed146451c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-a1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-a1.dts
@@ -58,24 +58,6 @@ ir-receiver {
 		gpios = <&gpio2 RK_PA2 GPIO_ACTIVE_LOW>;
 		linux,rc-map-name = "rc-beelink-gs1";
 	};
-
-	spdif_dit: spdif-dit {
-		compatible = "linux,spdif-dit";
-		#sound-dai-cells = <0>;
-	};
-
-	spdif_sound: spdif-sound {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "SPDIF";
-
-		simple-audio-card,cpu {
-			sound-dai = <&spdif>;
-		};
-
-		simple-audio-card,codec {
-			sound-dai = <&spdif_dit>;
-		};
-	};
 };
 
 &analog_sound {
@@ -343,11 +325,6 @@ &sdmmc {
 	status = "okay";
 };
 
-&spdif {
-	pinctrl-0 = <&spdifm0_tx>;
-	status = "okay";
-};
-
 &tsadc {
 	rockchip,hw-tshut-mode = <0>;
 	rockchip,hw-tshut-polarity = <0>;
-- 
2.53.0




