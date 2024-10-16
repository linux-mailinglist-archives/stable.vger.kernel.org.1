Return-Path: <stable+bounces-86511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BDF9A0D56
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 16:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061021C2171C
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 14:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64B820E02E;
	Wed, 16 Oct 2024 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSZFgEMT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D1720CCE2;
	Wed, 16 Oct 2024 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090362; cv=none; b=TD6BBI5htyaVgdyKLPoLxcnrzX1AztrcXA2EDt37r/CsBMhu5VgBE+tWfvwj+VbNe2lr/9sN8gDS6MYS7jze5gu7EkVnene8i4gVp4N75+fXsnCbmPw9CnHOhNhNCbc4HrIit33rNMyCFhxHZ/RP0ZoG7usnL62dOJNCqstrGco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090362; c=relaxed/simple;
	bh=gQJ2ZNN9iztmLyYP1MYI3qr6tvjDhsrZlq0iaKB2RZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=up4UPvgghMKNAQJYPRA1hxGx5aXiLuPUzPvFcsLss1F/tERnTDRVuit6ydaLdp5qCkAnAS1BIyyik162y/rFRE3coVZBqXOMltEQ8s5XwaHlhRYs8Keh71bXjwr59gfO/XjDxs1lhZ77d4YTIl/1rrZxsvqTVCgj3rNyUSmBdyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSZFgEMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D969C4CED0;
	Wed, 16 Oct 2024 14:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729090362;
	bh=gQJ2ZNN9iztmLyYP1MYI3qr6tvjDhsrZlq0iaKB2RZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RSZFgEMTei/9G6Sy0Qsf2cy4YF/DTNfdpm4EFavjo4r9uiK375L/ZqdO+FaLYfq5+
	 DFYoidHTLV6+h92T3nQG1NxrYbyriN3uMJI9DJ14h9O511ucou/32VVdC7h/DQayc8
	 Wkj+WrvYvv0lxur7tzh7UUBi1N/zacyd1NrbGS6HsuHV3kmHg3AwBXgeXtAKVrIiN9
	 wVZYijfh/3ZEc76W97eH2qniWdHdejx0t3s7dzeJ7Mb4hT+j4htMQoRKqq82V6IrXg
	 oNsc1SnXKPTJAG7tfGYH1z1szrtv7zbZvdQqqPr+mrniRcilH57VbVsHpOgNUt9vrT
	 Z1SR0Vp43QOOQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1t15OL-000000006UL-3ZVJ;
	Wed, 16 Oct 2024 16:52:49 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org,
	Xilin Wu <wuxilin123@gmail.com>
Subject: [PATCH 3/6] arm64: dts: qcom: x1e80100-vivobook-s15: fix nvme regulator boot glitch
Date: Wed, 16 Oct 2024 16:51:09 +0200
Message-ID: <20241016145112.24785-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241016145112.24785-1-johan+linaro@kernel.org>
References: <20241016145112.24785-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NVMe regulator has been left enabled by the boot firmware. Mark it
as such to avoid disabling the regulator temporarily during boot.

Fixes: d0e2f8f62dff ("arm64: dts: qcom: Add device tree for ASUS Vivobook S 15")
Cc: stable@vger.kernel.org	# 6.11
Cc: Xilin Wu <wuxilin123@gmail.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
index 20616bd4aa6c..fb4a48a1e2a8 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
@@ -134,6 +134,8 @@ vreg_nvme: regulator-nvme {
 
 		pinctrl-0 = <&nvme_reg_en>;
 		pinctrl-names = "default";
+
+		regulator-boot-on;
 	};
 };
 
-- 
2.45.2


