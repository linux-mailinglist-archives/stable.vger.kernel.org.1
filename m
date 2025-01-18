Return-Path: <stable+bounces-109450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A39A15DB8
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 16:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCD3F7A266E
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 15:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF281974FE;
	Sat, 18 Jan 2025 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="BG5lu52V";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="MPUhhcqM"
X-Original-To: stable@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A099C2FB;
	Sat, 18 Jan 2025 15:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737215197; cv=pass; b=WmZHM/L8y+pK5cgM7I5WRilVzzhESKBdDw8Idh0/Ymdy/Q9QiskeHaQmccU7PpUkgRcMDhpHKGNEx7zwtx2FShH6x/vCNUpSNbUiAqVxQ4fwZ/xQluF/ByXd3R+LyTTbVwq6UZcpX4zTCZIJpMFf7MXHuihZQsU+SRyBCEycPek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737215197; c=relaxed/simple;
	bh=5IykHw27f8zyU1LubhmYfpjACsCcrziNvapXbY+I52s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gnatcH2374mxcstKMzy/YKlR+bs9apUbsaRSwjxmMLJAbsDrsv8r+xqSo9e7mRkQqm8PXOcIyw4+iLr6Yqnxs4R6scZ6+Zyol9uGiJGjitZkst4/JaMdKt+X+wN+f0A+aBPSmqkGvb8w/dydE+KaTLrGZrIty1X27nqcy8J+06o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=BG5lu52V; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=MPUhhcqM; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
ARC-Seal: i=1; a=rsa-sha256; t=1737215000; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=H3EQAMP10XQjkBVfkZYL7ELNphlDGPqaW3lqcm5NgwE4OWzoRLk/pl5BIFarkurF9x
    8Eelk22QHG4WDM/xRmJ4e7rdLjVRyI11SQSoF2FZEeZ+vT+MLFdvQuqb+5G8YFsncoJY
    n4tUM+TP0qZcWnFkA+AnLO54zU6d6eYTs5OEEw14MCqaQFzmeadl4d5uEdsVJxFhFWd6
    smYaljqM/OjM5WdCN0azc0X61uMRjMcOIoXGVWEFQh/yVrBHZgEvzvDysoIY2qJ9jidO
    oS/xfG+AQCRBCywQdJ2tW2i6qzN9DPoJiZhGW9h2QcsOX1y8hD9ZR5CVsXrYZRh3aYTJ
    RoQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1737215000;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=DpV0Z/Ptfym1f8BBR+xdJmVJ0zJrXdBpxO92bdBAsdE=;
    b=d3AuJ8azc1X/FAtrxGMqAlDYsrHyERci/l11SwS/1f72pbmgyr/2Pe/cx+eqeeGpLI
    wDnTT/rKBoOfhzHWZK0vYl/1wGFbWUjlK38H8TGqYuNPurCkcG4jk8+AAZMFhGqZnppl
    3XXTCpptLFoT2kGmAU2OBuQEm6yRf6/dyfZQ9SuUQcO8sBu/trve5OurSwO4ZnSjsXWY
    8hE63t3a0E9+sTt6bllAUGM9u8xYYOySJWyhjHjN/nm1Be3eyJ8G2bN36PKG1CswD/gu
    Ta1djeUdsFAsAuI9JOpmRPf+BgTFVzYFnuj0MZ+COa+YBxhJG3BjD2GzAV66yTGR/Lvn
    hfLg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1737215000;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=DpV0Z/Ptfym1f8BBR+xdJmVJ0zJrXdBpxO92bdBAsdE=;
    b=BG5lu52VrTrq/s8hw8VuA9TVtukTRpPh+v81Gfz8xO41C6nG+oCyHal89NeqAZ4lMI
    ZWfimDbGl+ae54J3suE9MraVMeSUDs9k+Asj2LGWOu5AkW96qyu1p0Sj1COuJZ9W1xoR
    naRCm5KJPE2suTq9vgikXIsNsC5f88YjPUL9Wu6L5iCjoayWwqUq5F35os7cfTy9QOf6
    tIm9GpxwQMQr53JXYXD50Sqgly6srLrYBQAM1LyVOp9x0WGiH9HM5e1uf5C/dq0hfINm
    eBTuC02dfrCQrsn7l4XiVKMkfCFpFgP8F+oxhZxKvLMT+ahX/9PzwT3i3hbeeb428OPm
    xiVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1737215000;
    s=strato-dkim-0003; d=goldelico.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=DpV0Z/Ptfym1f8BBR+xdJmVJ0zJrXdBpxO92bdBAsdE=;
    b=MPUhhcqMoTKdX2oNBJcZLbH19/6hzS1U3w1894mfZ21FwPDkOF2e6WMqNPe9sG1oQw
    rmMBg2hpD8tvuHiSf9BQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lFzL1yeTwZ"
Received: from localhost.localdomain
    by smtp.strato.de (RZmta 51.2.21 DYNA|AUTH)
    with ESMTPSA id Qeb5b110IFhJQlS
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 18 Jan 2025 16:43:19 +0100 (CET)
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
Subject: [PATCH] Revert v6.2-rc1 and later "ARM: dts: bcm2835-rpi: Use firmware clocks for display"
Date: Sat, 18 Jan 2025 16:43:14 +0100
Message-ID: <7ba92b281cea785358551c8de99845c6345a2391.1737214993.git.hns@goldelico.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

This reverts commit d02f02c28f5561cf5b2345f8b4c910bd98d18553.

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

Fixes: d02f02c28f55 ("ARM: dts: bcm2835-rpi: Use firmware clocks for display")
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


