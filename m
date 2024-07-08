Return-Path: <stable+bounces-58230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBF592A34F
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 14:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69E2F281A2D
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 12:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E79481AD2;
	Mon,  8 Jul 2024 12:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="krR+5QfT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E114E3FB94
	for <stable@vger.kernel.org>; Mon,  8 Jul 2024 12:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720443265; cv=none; b=ZJfduYgkCxyvhR310ZDI3BV/IBoELQurghdcAJ497FG6q0bfIhXBUVQ42kgVZxncbv/Ei5IAhvBKfZFiEqWPZHzddtTBpF9QMEEb5jWwmUWI0baQfvixbC2D/XMzyP7XwFq4qibkVkz5It/7YeB2tZQ5ibyn+teJML+Yvbh5jPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720443265; c=relaxed/simple;
	bh=sipBxqj//6lHI8+oDZ4W/2uVDKertmQLwTYQBZ2iSTc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oSwa6JUZQyyhlz0/qKZPVompkQXgScjEfyHPgmVO2DMSbaVTbw+ZTLFPEQOtKBUUitMUQUSTQFjSrH1PxIJA87S7n5gh5ZE5F4ZFlfu/TvdHRj7+cWYFSEGAmrmJgwl/9RAjyzB2BSZl4jGx/qvLzq5wfnl25v/bSnNENuuQunw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=krR+5QfT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD05C116B1;
	Mon,  8 Jul 2024 12:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720443264;
	bh=sipBxqj//6lHI8+oDZ4W/2uVDKertmQLwTYQBZ2iSTc=;
	h=Subject:To:Cc:From:Date:From;
	b=krR+5QfTUmbfYfjHVa8euJlwcD33Olvsaeh/ZKodJZRKQsuCj1IdBYVc1IhOe1XHp
	 jT86Z8k5PP9uRCp0Ul2ZxZYQaEK72YMSdWNgqnaw+rKALMRJefeoRv4FG0ikhYJXDb
	 qeioeNoOth0cCja0fDVmZIP1gaZaNLeAvNh6ryy8=
Subject: FAILED: patch "[PATCH] riscv: dts: starfive: Set EMMC vqmmc maximum voltage to 3.3V" failed to apply to 6.9-stable tree
To: wiagn233@outlook.com,conor.dooley@microchip.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 08 Jul 2024 14:54:21 +0200
Message-ID: <2024070821-ascent-stiffen-9101@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.9-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.9.y
git checkout FETCH_HEAD
git cherry-pick -x 3c1f81a1b554f49e99b34ca45324b35948c885db
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070821-ascent-stiffen-9101@gregkh' --subject-prefix 'PATCH 6.9.y' HEAD^..

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


