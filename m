Return-Path: <stable+bounces-268947-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6TPiEZ6QPmphIAkAu9opvQ
	(envelope-from <stable+bounces-268947-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 16:45:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FFB6CE112
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 16:45:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0leil.net header.s=20231125 header.b=kbfEwjZs;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268947-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268947-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=0leil.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84BDF30ED312
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 14:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB7B3F8EB9;
	Fri, 26 Jun 2026 14:41:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF10E3F88B8
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 14:40:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782484862; cv=none; b=J9ZOiwaLmh/8JYF88fsIkk0F7BB5jJMOVTZiH5NTDgOvIcygr0VHsBIoYyJSewaf1UmEF65ivf7Z5swYKmOPwjmTJM31ZFWCGKcrvq3z7yMHeDS83agdSldiStu3URCFM09c5jNe7030aKSxleXMTIFXOY29ksEo0XHZm9q9QUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782484862; c=relaxed/simple;
	bh=6l7FWNwrOpVINMRwUfgz2uZH0x6IDs6mXntrNhPogtQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=m/HRyPfoxOw/9TQ4IQlLzkBtMEWQn2+k3m6e3ifFRK5igGnm83NCwB3pHvq5AKsBB01sioNZ8YWrTnw016NdRULOD3sYw5hf33KjwR7U6mzhbmUzUuRLfcUu08vtjKhLcZdXenzeILbA7aTNLcwYFOxvKUrwwqhBQSHPT7wrkOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.b=kbfEwjZs; arc=none smtp.client-ip=45.157.188.13
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gmyyq3sCRzspR;
	Fri, 26 Jun 2026 16:40:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1782484851;
	bh=0HPhwFtkXvquAUDYvZqrHytOvvPkaGYk3vsC80cW3dk=;
	h=From:Date:Subject:To:Cc:From;
	b=kbfEwjZs5NrTcHkqTfsl8NYqNIp7n77UhG5v9cIkEvGqsLft0Cy/9flMNyDAEbeCV
	 ruUSAHxJKTe3Cfs/6aHMrY877vtXzB4++d4g/JN3m4/YvwrxUqb1c1kDUlyUbrF/bl
	 IpFUGfvdDkqbDQn+7oeavtf2TdN1X49hdfxJSkfvrxI0bEFCrmbznKRGE/BOmuwbOy
	 aEcECZ4kyL5AovQ9i805jDSu9z0JqoX4Z++YdElO24NLTIv/oSPa7cYOgiKITJKJjt
	 SIrbR3wtKq97A42IfdwULZdR8sZPbKBDx20zRgOJ4quVoO/dIB2F6abLf5OsqtlLIx
	 r9Iav44fT9Vsw==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gmyyp1m8tz3Fy;
	Fri, 26 Jun 2026 16:40:50 +0200 (CEST)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Fri, 26 Jun 2026 16:40:38 +0200
Subject: [PATCH] arm64: dts: rockchip: fix eMMC reset polarity on PX30
 Ringneck
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-ringneck-emmc-polarity-v1-1-90cefe57b316@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMAyA4VchPdukG8kwvorxAKXOqgzSoYEQ3
 t2px+/w/xtkMZUMp2oDk7dmHVOBO1TAtzZFQe2LwZMPFHxA0xST8ANlGBin8dmazis2riGqOXR
 H8lDiyeSqy298vvydX91deP7eYN8/sFCo3HoAAAA=
X-Change-ID: 20260626-ringneck-emmc-polarity-717003c6b802
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Quentin Schulz <quentin.schulz@cherry.de>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[0leil.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[0leil.net:s=20231125];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-268947-lists,stable=lfdr.de,kernel];
	FORGED_SENDER(0.00)[foss@0leil.net,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:quentin.schulz@theobroma-systems.com,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:quentin.schulz@cherry.de,m:stable@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[0leil.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[foss@0leil.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cherry.de:mid,cherry.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,0leil.net:dkim,0leil.net:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99FFB6CE112

From: Quentin Schulz <quentin.schulz@cherry.de>

According to the Jedec 5.1 specification, the device is held in reset
when RST_n is low, therefore the polarity of the line must be that, as
specified in the Device Tree binding (mmc/mmc-pwrseq-emmc.yaml).

Due to the wrong polarity, eMMC devices with RST_n_FUNCTION[162]
bitfield [1:0] set to 0x1 (the default is 0x0) will be held in reset
forever.

Cc: stable@vger.kernel.org
Fixes: c484cf93f61b ("arm64: dts: rockchip: add PX30-µQ7 (Ringneck) SoM with Haikou baseboard")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
PX30 Ringneck is affected by the same issue that Cobra and PP-1516 have
and for which patches[1][2] have already been sent.

Out of the other boards I own, RK3588 Tiger and Jaguar also have an
inverted polarity but I tried making the eMMC chip care about the reset
line polarity to no avail, therefore I'm not changing them until we
figure out a setup in which we can reproduce the issue.

There are a handful of other Rockchip boards with an inverted polarity
but I don't own any of them so I will not change them either.

[1] https://lore.kernel.org/linux-rockchip/20260609081728.30616-2-jakobunt@gmail.com/
[2] https://lore.kernel.org/linux-rockchip/20260612-pp1516-emmc-polarity-v1-1-4816c1c909f7@cherry.de/
---
 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
index 973b4c5880e24..29794216592d8 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
@@ -26,7 +26,7 @@ emmc_pwrseq: emmc-pwrseq {
 		compatible = "mmc-pwrseq-emmc";
 		pinctrl-0 = <&emmc_reset>;
 		pinctrl-names = "default";
-		reset-gpios = <&gpio1 RK_PB3 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio1 RK_PB3 GPIO_ACTIVE_LOW>;
 	};
 
 	leds {

---
base-commit: 4edcdefd4083ae04b1a5656f4be6cd83ae919ef4
change-id: 20260626-ringneck-emmc-polarity-717003c6b802

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>


