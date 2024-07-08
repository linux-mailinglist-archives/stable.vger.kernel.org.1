Return-Path: <stable+bounces-58231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B75192A350
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 14:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508591F21CA4
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 12:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F394824A3;
	Mon,  8 Jul 2024 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T1y0RcdM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C321E7E563
	for <stable@vger.kernel.org>; Mon,  8 Jul 2024 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720443273; cv=none; b=kTQ+BUH57XlCqHM1ClC28wLBrphstC5WpxWnnK0xE4DKdxDd31EiQ/FcEJuPtxto+cxzGBHS4fd7DmEcHdQ0V/deJSmmP6ZD8iw7HyxUr8JbvxRlCEhjTAffH+LW/aZ/8wVn/2F8XPCa67FgBV3jgqrpMiCRkfF8Qkehh0CVtIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720443273; c=relaxed/simple;
	bh=714SRbLt+hgxy/WZgPQbCxS3hFVcqxMrydONBMERKSY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lFB+1hlmYQ7Pb6xKsYbqZBZJaFWF3Ha66J7itd1diUkcx8BhwGhrKks9hJYNQeTM+oy1hrEVwD/DdOF5O7XjBeJHcgOu6+aMfLI63wjbq2GpReFx2/PwqkdJax5tich6fSqSy9SUDMo3WxTtdR1U3l4OezT1HEd2vtMY5QWi9pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T1y0RcdM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADC4C116B1;
	Mon,  8 Jul 2024 12:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720443273;
	bh=714SRbLt+hgxy/WZgPQbCxS3hFVcqxMrydONBMERKSY=;
	h=Subject:To:Cc:From:Date:From;
	b=T1y0RcdMtcYyVWSkVAQ0QDhzHtfvsOfZ7B5Trz5og7hCdBxuxNpey4ZeV7O0+ZQxc
	 ECqKpKk/gBGwPeaUvYzcPZ01iWwgD7ArlbHEKhO41ZQiqAzhX5vrr1pLp/Uj2ZQcwH
	 avUVQdtD6hoJ3jVL60mBsiy5jhScSAAmwuulHN0Q=
Subject: FAILED: patch "[PATCH] riscv: dts: starfive: Set EMMC vqmmc maximum voltage to 3.3V" failed to apply to 6.6-stable tree
To: wiagn233@outlook.com,conor.dooley@microchip.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 08 Jul 2024 14:54:22 +0200
Message-ID: <2024070822-unfixed-paced-a31d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 3c1f81a1b554f49e99b34ca45324b35948c885db
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070822-unfixed-paced-a31d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

3c1f81a1b554 ("riscv: dts: starfive: Set EMMC vqmmc maximum voltage to 3.3V on JH7110 boards")
ac9a37e2d6b6 ("riscv: dts: starfive: introduce a common board dtsi for jh7110 based boards")
07da6ddf510b ("riscv: dts: starfive: visionfive 2: add "disable-wp" for tfcard")
0ffce9d49abd ("riscv: dts: starfive: visionfive 2: add tf cd-gpios")
ffddddf4aa8d ("riscv: dts: starfive: visionfive 2: use cpus label for timebase freq")
b9a1481f259c ("riscv: dts: starfive: visionfive 2: update sound and codec dt node name")
e0503d47e93d ("riscv: dts: starfive: visionfive 2: Remove non-existing I2S hardware")
dcde4e97b122 ("riscv: dts: starfive: visionfive 2: Remove non-existing TDM hardware")
0f74c64f0a9f ("riscv: dts: starfive: Remove PMIC interrupt info for Visionfive 2 board")
28ecaaa5af19 ("riscv: dts: starfive: jh7110: Add camera subsystem nodes")
8d01f741a046 ("riscv: dts: starfive: jh7110: Add PWM node and pins configuration")
79384a047535 ("Merge tag 'riscv-dt-for-v6.7' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux into soc/dt")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3c1f81a1b554f49e99b34ca45324b35948c885db Mon Sep 17 00:00:00 2001
From: Shengyu Qu <wiagn233@outlook.com>
Date: Wed, 12 Jun 2024 18:33:31 +0800
Subject: [PATCH] riscv: dts: starfive: Set EMMC vqmmc maximum voltage to 3.3V
 on JH7110 boards

Currently, for JH7110 boards with EMMC slot, vqmmc voltage for EMMC is
fixed to 1.8V, while the spec needs it to be 3.3V on low speed mode and
should support switching to 1.8V when using higher speed mode. Since
there are no other peripherals using the same voltage source of EMMC's
vqmmc(ALDO4) on every board currently supported by mainline kernel,
regulator-max-microvolt of ALDO4 should be set to 3.3V.

Cc: stable@vger.kernel.org
Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
Fixes: 7dafcfa79cc9 ("riscv: dts: starfive: enable DCDC1&ALDO4 node in axp15060")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
index 8ff6ea64f048..68d16717db8c 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
@@ -244,7 +244,7 @@ emmc_vdd: aldo4 {
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-name = "emmc_vdd";
 			};
 		};


