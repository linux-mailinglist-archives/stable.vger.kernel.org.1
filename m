Return-Path: <stable+bounces-108782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF4EA1203B
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD1F1647EE
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6723248BAF;
	Wed, 15 Jan 2025 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YCsb+H4r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84103248BA1;
	Wed, 15 Jan 2025 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937788; cv=none; b=SHFYpFcVKYrFeMC+oqOc8US45WnhXPs+pV/ItXyzS5IajIwgX4ke+JVk80o1ZUbnNj5KqSG5aoEn9DkWTcFk1CFJ28SnNShV7M4V8/q7RjapTV2IFM+pj8BNT0Gdmm7ZiIwSQmPPlYKVpu+QAxI93TJDGGduXEQ2cHk4GwgTBAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937788; c=relaxed/simple;
	bh=hWE0CoLED1yAYeIL0LHHk/VNsXtZ10CFRIyr3jSFP4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7NVyDNCn4yuhMT2A697hedH+pY4IlnZwnS1GzGYEws0EcKIqP2C2/zTn8JTbtB2p0pCQgOjKNWYtjLZQRM1TRTtD3IZyPq3T8zt7GSY6GAHU3WJlqYuAupGRJZiIoevgOaNri3wKEQbhGxUbD/VGn855a4L9PSqIRQPtCIoxtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YCsb+H4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115C4C4CEE1;
	Wed, 15 Jan 2025 10:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736937788;
	bh=hWE0CoLED1yAYeIL0LHHk/VNsXtZ10CFRIyr3jSFP4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YCsb+H4rpj+dSIg4lETZapIweecPEmnHH51+6xu1JYSF+9LoviWASRnlQJ4T9iWjA
	 YIbNs3r79/b/hYOE/zRwUe9JRTKOoi9jlyE4YdORbPHA8gSIQEhaRr8AIhdR1AeC6i
	 GQMoVniQRX0qLYHr++J9eWFVHtt2Ub9z4RlW9gkc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Geis <pgwipeout@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 82/92] arm64: dts: rockchip: add hevc power domain clock to rk3328
Date: Wed, 15 Jan 2025 11:37:40 +0100
Message-ID: <20250115103550.837334369@linuxfoundation.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115103547.522503305@linuxfoundation.org>
References: <20250115103547.522503305@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Geis <pgwipeout@gmail.com>

[ Upstream commit 3699f2c43ea9984e00d70463f8c29baaf260ea97 ]

There is a race condition at startup between disabling power domains not
used and disabling clocks not used on the rk3328. When the clocks are
disabled first, the hevc power domain fails to shut off leading to a
splat of failures. Add the hevc core clock to the rk3328 power domain
node to prevent this condition.

rcu: INFO: rcu_sched detected expedited stalls on CPUs/tasks: { 3-.... }
1087 jiffies s: 89 root: 0x8/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 0 to CPUs 3:
NMI backtrace for cpu 3
CPU: 3 UID: 0 PID: 86 Comm: kworker/3:3 Not tainted 6.12.0-rc5+ #53
Hardware name: Firefly ROC-RK3328-CC (DT)
Workqueue: pm genpd_power_off_work_fn
pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : regmap_unlock_spinlock+0x18/0x30
lr : regmap_read+0x60/0x88
sp : ffff800081123c00
x29: ffff800081123c00 x28: ffff2fa4c62cad80 x27: 0000000000000000
x26: ffffd74e6e660eb8 x25: ffff2fa4c62cae00 x24: 0000000000000040
x23: ffffd74e6d2f3ab8 x22: 0000000000000001 x21: ffff800081123c74
x20: 0000000000000000 x19: ffff2fa4c0412000 x18: 0000000000000000
x17: 77202c31203d2065 x16: 6c6469203a72656c x15: 6c6f72746e6f632d
x14: 7265776f703a6e6f x13: 2063766568206e69 x12: 616d6f64202c3431
x11: 347830206f742030 x10: 3430303034783020 x9 : ffffd74e6c7369e0
x8 : 3030316666206e69 x7 : 205d383738353733 x6 : 332e31202020205b
x5 : ffffd74e6c73fc88 x4 : ffffd74e6c73fcd4 x3 : ffffd74e6c740b40
x2 : ffff800080015484 x1 : 0000000000000000 x0 : ffff2fa4c0412000
Call trace:
regmap_unlock_spinlock+0x18/0x30
rockchip_pmu_set_idle_request+0xac/0x2c0
rockchip_pd_power+0x144/0x5f8
rockchip_pd_power_off+0x1c/0x30
_genpd_power_off+0x9c/0x180
genpd_power_off.part.0.isra.0+0x130/0x2a8
genpd_power_off_work_fn+0x6c/0x98
process_one_work+0x170/0x3f0
worker_thread+0x290/0x4a8
kthread+0xec/0xf8
ret_from_fork+0x10/0x20
rockchip-pm-domain ff100000.syscon:power-controller: failed to get ack on domain 'hevc', val=0x88220

Fixes: 52e02d377a72 ("arm64: dts: rockchip: add core dtsi file for RK3328 SoCs")
Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Link: https://lore.kernel.org/r/20241214224339.24674-1-pgwipeout@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 75ea512e9724..ce7c1d3c345e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -302,6 +302,7 @@
 
 			power-domain@RK3328_PD_HEVC {
 				reg = <RK3328_PD_HEVC>;
+				clocks = <&cru SCLK_VENC_CORE>;
 				#power-domain-cells = <0>;
 			};
 			power-domain@RK3328_PD_VIDEO {
-- 
2.39.5




