Return-Path: <stable+bounces-210285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AB5D3A2D5
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 10:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7C9330838F2
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 09:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1524735505B;
	Mon, 19 Jan 2026 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoLLPcSm"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491E435502D
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814559; cv=none; b=iD+Gq37qDKovhmBEPEEcf8l/2ycNHYOayD3uRr0nmewpgeksdjJCtY1loplUGjQgnI7ZIkGp32UOI8CllwTZRhenMMtctLUhS0Jxx1j4qSzfFLnXXRHcV41p1ibT5jTlzjFnTOrFzyrPC7fUZqHjn4Q329Hky54/zbmRwyOl3cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814559; c=relaxed/simple;
	bh=Q5L1vRcMlZIpl7txxOw3lzUvlYNyoF2f3P4G6tmb3IU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YqLenvHSX4vtjnMhDxJQ1VgjQpkkcl/xrXlcX6s1/xIYdBDmzcoZel5CA9ba26f57JOUCSVtDiD2zX/xcMY2mGYoLV+6RTAEgTRjz8xG6RPZaWb6c7k185f+VQFZSvAfuZgnghmsZVEnisVZe6aQMZxzUFvGB+8A9oK5y3Yne2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoLLPcSm; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa4so3566972f8f.1
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 01:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768814556; x=1769419356; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a1TGTP9bNu4UHfSQMVaG1aEb1WfL6DST40MmwW/KTbs=;
        b=BoLLPcSmfeQr40mG9cahGSWYvdVyCkxnHgBb7Q1vQtsxhYd9eZL3R5zpjysJ3wCdO6
         YgxpR8epFEvLyTDW5posQfDHbohtbtbRPoVfI03lcne9gOhKU61EDAiwXMy10exKhySh
         g6VjiCaL6RI4jpSA0N6tmhpgE0sfOw0t3bGfryTl+cFLOBLvKWWj5/2PY80eC+BQlHx2
         D4bVL+WgBg+C/lIXi+BJPdFUu/X+b5BJPetZAP3Byq1L2x9CceIwHltWioZs9gCOJTD7
         Ef8CWk29GV+l6nkz7eOlbc4Nq1Hiz4VcjgCN5E+a5Bc2UD0Y2I02ecJTf4ZWgFZ/xIIt
         KpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768814556; x=1769419356;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1TGTP9bNu4UHfSQMVaG1aEb1WfL6DST40MmwW/KTbs=;
        b=uzstn1i/xCIvT0PTbNJRY3PIIPfuttuXyyHXoKXQFoVX1f5TBn+whyw2pQQl3ZRcyC
         dxaUtJzpHjg00WoySakKWY2GMMwt2muZj5VM+jg3Q/5zqFNBAl1CSJe3JRNQibRE+IQn
         95usVFxyDy4O3r8uy8IAS8CztNKRqqdh+/5vFeClvSmnyWlKNhRt5vdF5qrgouTXmuE5
         PiLEfL4yk7cuI7+U7zjY9ULSUsY6T/QPSEYxEr+LcZKO42GTNmxvwdvMh7CwogfjCLZ4
         pYz1JGYnJ/sdx5xO3wMNnxPbjGJ1a6AzUmSK1DhuR4+iAmfXP8ZxWB/ANbsi6vQc4/90
         3dzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTKIjypxqxxppNjwv1F9QJgiOqQHrFMM0hqNNozN2Rz5b5OUp4kaEJxN+nFnio67ijk4hnADw=@vger.kernel.org
X-Gm-Message-State: AOJu0YywgReblZLoUHkm3CG+pCyCN72UZUkx8hzjcr6gqCNZ2ad5u7Tt
	E1KqMX3oiY/Nw2yTl72Ku5H947Wo4Gn83HaYIbkD7nRF2k9GpoWuiHE+
X-Gm-Gg: AZuq6aJsD4UZWu2aeMQ9sFBu+iiZrj3A5FcdUDT85/M7WwMy4o1rPQkHlltRPnHbqao
	9cT182WIhFDqkoZKLyy6idUVi+FyMw417AYwTPVf5yVOvQve7Ne04wjO0ItV8hDETjtYE8foq2n
	BjjPcw+CJ3B9Jw10tib0TzzOjSb9GF4QtXZf7CffkF8jReKFUOzY9UH2DadfSiyvksBnUgaI2K/
	3n9eSRQCh6XJ8kEh8YiaNiF5+T+ko9gmVtepihJk0JdzUgzqnuPW6THcoNgRLFmMe+TDmsBlQZ4
	MhN1WrYUYFJ6ND8zec8NBFpfPYAByCVDO1c+j4vLn8o9ke8gfb7kzN6Qjzi3iabhrU1wJT+s6A3
	Pw9BeM0wh8dThEbd14mTb28bUenuWkFnM4tpLqOQX6FZctWEhVVvZggdKYW3p4zh66GzXZxwVCZ
	x4k/VEAlUyGM8iSk7S8aR6uh+ZkcqZVwySwedjXhG+L4iwC4tAtFe6xw6ehdPXi5xxrFD9kS96j
	Q==
X-Received: by 2002:a05:6000:2306:b0:434:32cc:6c86 with SMTP id ffacd0b85a97d-4356a039819mr13103624f8f.14.1768814556321;
        Mon, 19 Jan 2026 01:22:36 -0800 (PST)
Received: from alchark-surface.localdomain (bba-83-110-134-52.alshamil.net.ae. [83.110.134.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996d02dsm22113042f8f.23.2026.01.19.01.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 01:22:35 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 19 Jan 2026 13:22:26 +0400
Subject: [PATCH] arm64: dts: rockchip: Explicitly request UFS reset pin on
 RK3576
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-ufs-rst-v1-1-c8e96493948c@gmail.com>
X-B4-Tracking: v=1; b=H4sIANH3bWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQ0NL3dK0Yt2i4hLdtLSkZIPUZAuLVANzJaDqgqLUtMwKsEnRsbW1AKC
 VxLdZAAAA
X-Change-ID: 20260119-ufs-rst-ffbc0ec88e07
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3764; i=alchark@gmail.com;
 h=from:subject:message-id; bh=Q5L1vRcMlZIpl7txxOw3lzUvlYNyoF2f3P4G6tmb3IU=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTmfr9z0OzeiQfiskqxnP0RL1N4F7mxMF4OqUgu35l3e
 /YKsZW8HRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oaGOsY4RAxenAEx1bAbD/6I50yV3xV3vE7SI9HdKsisNjiz9La7tYf7EfFr0o0g/HkaG5ucJ8v5
 6rTtqNlzUcMqa5uBT7b+zOOL6lqJt34UFtuSxAAA=
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Rockchip RK3576 UFS controller uses a dedicated pin to reset the connected
UFS device, which can operate either in a hardware controlled mode or as a
GPIO pin.

Power-on default is GPIO mode, but the boot ROM reconfigures it to a
hardware controlled mode if it uses UFS to load the next boot stage.

Given that existing bindings (and rk3576.dtsi) expect a GPIO-controlled
device reset, request the required pin config explicitly.

This doesn't appear to affect Linux, but it does affect U-boot:

Before:
=> md.l 0x2604b398
2604b398: 00000011 00000000 00000000 00000000  ................
< ... snip ... >
=> ufs init
ufshcd-rockchip ufshc@2a2d0000: [RX, TX]: gear=[3, 3], lane[2, 2], pwr[FASTAUTO_MODE, FASTAUTO_MODE], rate = 2
=> md.l 0x2604b398
2604b398: 00000011 00000000 00000000 00000000  ................

After:
=> md.l 0x2604b398
2604b398: 00000011 00000000 00000000 00000000  ................
< ... snip ...>
=> ufs init
ufshcd-rockchip ufshc@2a2d0000: [RX, TX]: gear=[3, 3], lane[2, 2], pwr[FASTAUTO_MODE, FASTAUTO_MODE], rate = 2
=> md.l 0x2604b398
2604b398: 00000010 00000000 00000000 00000000  ................

(0x2604b398 is the respective pin mux register, with its BIT0 driving the
mode of UFS_RST: unset = GPIO, set = hardware controlled UFS_RST)

This helps ensure that GPIO-driven device reset actually fires when the
system requests it, not when whatever black box magic inside the UFSHC
decides to reset the flash chip.

Cc: stable@vger.kernel.org
Fixes: c75e5e010fef ("scsi: arm64: dts: rockchip: Add UFS support for RK3576 SoC")
Reported-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
This has originally surfaced during the review of UFS patches for U-boot
at [1], where it was found that the UFS reset line is not requested to be
configured as GPIO but used as such. This leads in some cases to the UFS
driver appearing to control device resets, while in fact it is the
internal controller logic that drives the reset line (perhaps in
unexpected ways).

Thanks Quentin Schulz for spotting this issue.

[1] https://lore.kernel.org/u-boot/259fc358-f72b-4a24-9a71-ad90f2081335@cherry.de/
---
 arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi | 7 +++++++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi         | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi b/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi
index 0b0851a7e4ea..20cfd3393a75 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576-pinctrl.dtsi
@@ -5228,6 +5228,13 @@ ufs_rst: ufs-rst {
 				/* ufs_rstn */
 				<4 RK_PD0 1 &pcfg_pull_none>;
 		};
+
+		/omit-if-no-ref/
+		ufs_rst_gpio: ufs-rst-gpio {
+			rockchip,pins =
+				/* ufs_rstn */
+				<4 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
 	};
 
 	ufs_testdata0 {
diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index 3a29c627bf6d..db610f57c845 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1865,7 +1865,7 @@ ufshc: ufshc@2a2d0000 {
 			assigned-clock-parents = <&cru CLK_REF_MPHY_26M>;
 			interrupts = <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&power RK3576_PD_USB>;
-			pinctrl-0 = <&ufs_refclk>;
+			pinctrl-0 = <&ufs_refclk &ufs_rst_gpio>;
 			pinctrl-names = "default";
 			resets = <&cru SRST_A_UFS_BIU>, <&cru SRST_A_UFS_SYS>,
 				 <&cru SRST_A_UFS>, <&cru SRST_P_UFS_GRF>;

---
base-commit: 46fe65a2c28ecf5df1a7475aba1f08ccf4c0ac1b
change-id: 20260119-ufs-rst-ffbc0ec88e07

Best regards,
-- 
Alexey Charkov <alchark@gmail.com>


