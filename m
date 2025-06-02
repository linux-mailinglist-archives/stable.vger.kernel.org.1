Return-Path: <stable+bounces-149088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C98ACB039
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0D548202B
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216E421CC4F;
	Mon,  2 Jun 2025 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WCgJmoTl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D334835968;
	Mon,  2 Jun 2025 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872857; cv=none; b=NN+2FwqDJX6E0i4a0JAVz1BQ8BCzafOsWeW1iy47SqeFE6tdYYdg5siJ1Jl2MIzBC71jBXV/ueR5LEngh85QXJt8coqbnn9ARExXgkwUeOoUzZ+dCBvkI3gp1jqZbEw2VmAfUE2SyIFyWJNLdESECtlCGNjxsGjnqCqNKxYemO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872857; c=relaxed/simple;
	bh=2HfAMChMXe39XXhg3ZvjYJ5MbXhhqWTCibOpROqgH2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VR8N9ECi0M8wbqw2yy9YX6cAeVHsQpJLJbuYuZu20gjv+yOv+AdbhPQxZmJLf5DFfCAOIqaOmwaAkuIBt9J7fV2VmQXtvymSFovAL1XE7XLKqkVykdg3WtzRfJCy2bgOuSt0ggLRRHkVtIJSn+CccB7LBVpMmPL/L8PQrjA11Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WCgJmoTl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43131C4CEEB;
	Mon,  2 Jun 2025 14:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748872857;
	bh=2HfAMChMXe39XXhg3ZvjYJ5MbXhhqWTCibOpROqgH2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WCgJmoTl+5s4l+o16lGKJVgWzm9MIqoRMVEQzvWb3KVhk3bbSDvWwlaLGAMnlHOvH
	 oWAbZwwKM64UKzUEH1IDmC1EvMndG2ryCURaFufDqJExRd4foIz7N8Jg7L3oLw6afU
	 2MnaYV6HUvjzjkZrLHFqNgDzEJzWB8DbEQ13iIKI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yemike Abhilash Chandra <y-abhilashchandra@ti.com>,
	Neha Malcom Francis <n-francis@ti.com>,
	Jai Luthra <jai.luthra@linux.dev>,
	Nishanth Menon <nm@ti.com>
Subject: [PATCH 6.12 18/55] arm64: dts: ti: k3-am62x: Remove clock-names property from IMX219 overlay
Date: Mon,  2 Jun 2025 15:47:35 +0200
Message-ID: <20250602134239.001924704@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134238.271281478@linuxfoundation.org>
References: <20250602134238.271281478@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>

commit c68ab54a89a8c935732589a35ea2596e2329f167 upstream.

The IMX219 sensor device tree bindings do not include a clock-names
property. Remove the incorrectly added clock-names entry to avoid
dtbs_check warnings.

Fixes: 4111db03dc05 ("arm64: dts: ti: k3-am62x: Add overlay for IMX219")
Cc: stable@vger.kernel.org
Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Reviewed-by: Jai Luthra <jai.luthra@linux.dev>
Link: https://lore.kernel.org/r/20250415111328.3847502-6-y-abhilashchandra@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso
@@ -39,7 +39,6 @@
 				reg = <0x10>;
 
 				clocks = <&clk_imx219_fixed>;
-				clock-names = "xclk";
 
 				reset-gpios = <&exp1 13 GPIO_ACTIVE_HIGH>;
 



