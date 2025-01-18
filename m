Return-Path: <stable+bounces-109452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1ABA15E0C
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 17:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAAE318865FA
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 16:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B77519D890;
	Sat, 18 Jan 2025 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="QA/hRL0x";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="k9A26UUi"
X-Original-To: stable@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880C9189BAC;
	Sat, 18 Jan 2025 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737217663; cv=pass; b=YalOPCWjCNxvN+E+q4xmUzml+m8q+RvyXXtOd96/0hak1aSm2vfDiz9I9KmcH+xbtbWxOsICpNdGgH13gOuBNwSwPhTQSkhoAxorX7KBfnPwnH/tAuX4a93BjOatEIt0Av1opQR4lF6LfQ/MegHOiUc/gocjVQ5uyotUwng75To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737217663; c=relaxed/simple;
	bh=Brw7OfMfjvuPokfGFOcEpB6SUYrTLdtJW6Lejz1fCwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SaSVkX/AW7FR3NPvumplfOvDfvocyfa/vRbDarmevNI8KxKe60dIRpwHuhse2y8N9HnI4vvEtXvj+QZBNhClL++5li9QN/AUj8bmYQpMZeRzoOlsNVUejd69qAJ382DOO6C2UKqYCmixoygL/Giqo3H1w989b9VuU53KViSwnFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=QA/hRL0x; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=k9A26UUi; arc=pass smtp.client-ip=85.215.255.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
ARC-Seal: i=1; a=rsa-sha256; t=1737217633; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ccIaQsb3BHfYH+KCA7utCbjOM3Tz98o/a/P5ePWbPTKUYJnxL/efz0uCaBCQzIkZcC
    5hAWc+vo6yviwi152FdtCkT8eGWavv8ASJKdJWuHH7BZ1C6PJ6uHg3y4ocfmHttLMjR7
    k24AC6OYSJFVEkYCDD8ne4JC7MX/NWjGFMn9UMDHw8IYLI+hwb+L5oZMpghleInAnlqN
    AcybBQBV9uanqJP5Ef2Zu9hKh0rAbebNt2e+Z5XEiO7ZFjlsqQ+7VuzFivWFJaR+t/UM
    JkBCkQFloIEXmvBQScW6+vn0HXwxl3CrQ+HgzDU+6IZ044YU09Ecn1Jy3Uvgj79gyVXI
    zZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1737217633;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ALNYgGIU0bOwCAXhii7PEb5qykvoBzksseibl7WN1AY=;
    b=DiOnJ8mn6k8KA2AUCGuUZU3aaylENHT8KyyYlBc/rXcZZXfOmgAyFyl1Xd0WcswOCn
    GSD9/SyMM3l6c94FMZXtgGvJzi1iknzPHoEiZxF/Xccjv/fuRC7Crb+wo1SFqm1zcnSa
    XPH3y/wxjDVPkB3TE4DFkQMPm/BUQuaC+Wjit6XeGSMwWZZcX36Qyy0PL8tDvnoWbTH8
    4bfAeR1MrxXW8B/GJmeYNYtXnz88F7Vh0wUE1astlUDudlSoP3QSc/j2RNV3MvJQ5EP0
    8R0jXjFMHC0QX8GsFUEAmtKAlCy5mmj0133vT2WmN3/antRuuLGI1hWoSFIHWQQNnjEW
    ecTw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1737217633;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ALNYgGIU0bOwCAXhii7PEb5qykvoBzksseibl7WN1AY=;
    b=QA/hRL0xixeYf6hjHOTBhoIk6Ly16r/wMLfl4jzweimY7G5JNl5x2uRkogpAX5XBlj
    iN2f6JZOlxcqAPkxp5EgGrb3z4p/hQ4d/d0wHuyeOxaFPk3ItbF6HUPzgsAhhM+AIPYu
    ovf7WGYDH9MtPmScLZSLn89Xg/2PDc9FEK6A8QbGkZjdl3ps5tMjju/tjedP+QFV47hx
    4eEF2XdUWKtlp2kGL9VDhYw7l2GV5QuDrxSo0ENqlBethSe6r2iZMO8HagV2Mh4h5e8k
    /50W4JpEGu8RjmwE8RrI/0DLdWt6kExLCaQh5vQFIr7Y/XV2JmOu3W7lgDsvIlOZfxZJ
    2b0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1737217633;
    s=strato-dkim-0003; d=goldelico.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ALNYgGIU0bOwCAXhii7PEb5qykvoBzksseibl7WN1AY=;
    b=k9A26UUi/ySHqXwC2NyrvY8uQRpI5NfZwBu7pZok74fhcY8ONDpbk+9YyyejutQTkR
    PlWMiPfAOvBd2uhi87Bg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lFzL1yeTwZ"
Received: from localhost.localdomain
    by smtp.strato.de (RZmta 51.2.21 DYNA|AUTH)
    with ESMTPSA id Qeb5b110IGRDRLm
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 18 Jan 2025 17:27:13 +0100 (CET)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	letux-kernel@openphoenux.org,
	stable@vger.kernel.org,
	"H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2] Revert v6.2-rc1 and later "ARM: dts: bcm2835-rpi: Use firmware clocks for display"
Date: Sat, 18 Jan 2025 17:27:07 +0100
Message-ID: <cb9e10dfb4f50207e33ddac16794ee6b806744da.1737217627.git.hns@goldelico.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

This reverts commit 27ab05e1b7e5c5ec9b4f658e1b2464c0908298a6.

I tried to upgrade a RasPi 3B+ with Waveshare 7inch HDMI LCD
from 6.1.y to 6.6.y but found that the display is broken with
this log message:

[   17.776315] vc4-drm soc:gpu: bound 3f400000.hvs (ops vc4_drm_unregister [vc4])
[   17.784034] platform 3f806000.vec: deferred probe pending

Some tests revealed that while 6.1.y works, 6.2-rc1 is already broken but all
newer kernels as well. And a bisect did lead me to this patch.

I could repair several versions up to 6.13-rc7 by doing
this revert. Newer kernels have just to take care of

commit f702475b839c ("ARM: dts: bcm2835-rpi: Move duplicate firmware-clocks to bcm2835-rpi.dtsi")

but that is straightforward.

Fixes: 27ab05e1b7e5 ("ARM: dts: bcm2835-rpi: Use firmware clocks for display")
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/bcm2835-rpi-common.dtsi | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-common.dtsi b/arch/arm/boot/dts/bcm2835-rpi-common.dtsi
index 4e7b4a592da7c..8a55b6cded592 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-common.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi-common.dtsi
@@ -7,23 +7,6 @@
 
 #include <dt-bindings/power/raspberrypi-power.h>
 
-&firmware {
-	firmware_clocks: clocks {
-		compatible = "raspberrypi,firmware-clocks";
-		#clock-cells = <1>;
-	};
-};
-
-&hdmi {
-	clocks = <&firmware_clocks 9>,
-		 <&firmware_clocks 13>;
-	clock-names = "pixel", "hdmi";
-};
-
 &v3d {
 	power-domains = <&power RPI_POWER_DOMAIN_V3D>;
 };
-
-&vec {
-	clocks = <&firmware_clocks 15>;
-};
-- 
2.47.0


