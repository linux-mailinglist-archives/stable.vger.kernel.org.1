Return-Path: <stable+bounces-151401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C87BACDE94
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 15:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45B151633DA
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 13:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD069290BBC;
	Wed,  4 Jun 2025 13:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EKuBFW8B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590D1290BB1;
	Wed,  4 Jun 2025 13:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749042457; cv=none; b=Eqg6G9Pl/9K8Fd4R4Bo9kVJjXK+CeWTlx/vsBev2YRroSXRwq1jHy4Z8COTjWAFialRxSLXKSwPltSd6vjfjehVO7Wv+5bFb7WNm1fnuANOqSi8t4NmTq3/OsyVcQGYtxjmheNTNs5AcSg07k8XfEnLWd4wEo+Jx8xhIvar8+LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749042457; c=relaxed/simple;
	bh=43OWA7Qeiq8r1g4FO5Z6ePoi9K1B6Ho251GSgks6Oyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HP/bq2JDvRmc4MIo6UGIfgbX+1OL0rEX1sJz0LOJXV85DLvjdrZoJPutO/Puvur2yXQeRJH5FuG5mDoxYCyttUY4z9YAWW3tpbGqrl/ovaa33ilU9/sSHkJ6ToS9lMqPgM/UAsgKG/DwM4NhztyeCkdJvKrs/RtX+40JBFDCnkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EKuBFW8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7256AC4CEEF;
	Wed,  4 Jun 2025 13:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749042457;
	bh=43OWA7Qeiq8r1g4FO5Z6ePoi9K1B6Ho251GSgks6Oyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EKuBFW8B8PUkCyLPG2q0yLT1b6uHMmmUeobWVcbCBf2im8VIjFd6EIgaQHUlCkIrm
	 cr2U/vpNdVk5foOjzQdlRsFC8Emp+egtX1PSTKFQRT41zvMOzQUVMipDF5NXMDNeP9
	 tbvmnFpauwVpFxwf2ZRltzOYB5Qc2rhwNqjcZ9Fc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.32
Date: Wed,  4 Jun 2025 15:07:28 +0200
Message-ID: <2025060428-daily-hydrant-6faa@gregkh>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025060428-exile-lubricate-e455@gregkh>
References: <2025060428-exile-lubricate-e455@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 18c2a7cf9e91..1e6a6c66403f 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 31
+SUBLEVEL = 32
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 08a82a5cf667..81ccd0600c5a 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -261,6 +261,8 @@ cryptobam: dma-controller@704000 {
 			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
 			qcom,ee = <1>;
+			qcom,num-ees = <4>;
+			num-channels = <16>;
 			qcom,controlled-remotely;
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 8a21448c0fa8..b28fa598cebb 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -4012,15 +4012,7 @@ compute-cb@1 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <1>;
 						iommus = <&apps_smmu 0x2141 0x04a0>,
-							 <&apps_smmu 0x2161 0x04a0>,
-							 <&apps_smmu 0x2181 0x0400>,
-							 <&apps_smmu 0x21c1 0x04a0>,
-							 <&apps_smmu 0x21e1 0x04a0>,
-							 <&apps_smmu 0x2541 0x04a0>,
-							 <&apps_smmu 0x2561 0x04a0>,
-							 <&apps_smmu 0x2581 0x0400>,
-							 <&apps_smmu 0x25c1 0x04a0>,
-							 <&apps_smmu 0x25e1 0x04a0>;
+							 <&apps_smmu 0x2181 0x0400>;
 						dma-coherent;
 					};
 
@@ -4028,15 +4020,7 @@ compute-cb@2 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <2>;
 						iommus = <&apps_smmu 0x2142 0x04a0>,
-							 <&apps_smmu 0x2162 0x04a0>,
-							 <&apps_smmu 0x2182 0x0400>,
-							 <&apps_smmu 0x21c2 0x04a0>,
-							 <&apps_smmu 0x21e2 0x04a0>,
-							 <&apps_smmu 0x2542 0x04a0>,
-							 <&apps_smmu 0x2562 0x04a0>,
-							 <&apps_smmu 0x2582 0x0400>,
-							 <&apps_smmu 0x25c2 0x04a0>,
-							 <&apps_smmu 0x25e2 0x04a0>;
+							 <&apps_smmu 0x2182 0x0400>;
 						dma-coherent;
 					};
 
@@ -4044,15 +4028,7 @@ compute-cb@3 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <3>;
 						iommus = <&apps_smmu 0x2143 0x04a0>,
-							 <&apps_smmu 0x2163 0x04a0>,
-							 <&apps_smmu 0x2183 0x0400>,
-							 <&apps_smmu 0x21c3 0x04a0>,
-							 <&apps_smmu 0x21e3 0x04a0>,
-							 <&apps_smmu 0x2543 0x04a0>,
-							 <&apps_smmu 0x2563 0x04a0>,
-							 <&apps_smmu 0x2583 0x0400>,
-							 <&apps_smmu 0x25c3 0x04a0>,
-							 <&apps_smmu 0x25e3 0x04a0>;
+							 <&apps_smmu 0x2183 0x0400>;
 						dma-coherent;
 					};
 
@@ -4060,15 +4036,7 @@ compute-cb@4 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <4>;
 						iommus = <&apps_smmu 0x2144 0x04a0>,
-							 <&apps_smmu 0x2164 0x04a0>,
-							 <&apps_smmu 0x2184 0x0400>,
-							 <&apps_smmu 0x21c4 0x04a0>,
-							 <&apps_smmu 0x21e4 0x04a0>,
-							 <&apps_smmu 0x2544 0x04a0>,
-							 <&apps_smmu 0x2564 0x04a0>,
-							 <&apps_smmu 0x2584 0x0400>,
-							 <&apps_smmu 0x25c4 0x04a0>,
-							 <&apps_smmu 0x25e4 0x04a0>;
+							 <&apps_smmu 0x2184 0x0400>;
 						dma-coherent;
 					};
 
@@ -4076,15 +4044,7 @@ compute-cb@5 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <5>;
 						iommus = <&apps_smmu 0x2145 0x04a0>,
-							 <&apps_smmu 0x2165 0x04a0>,
-							 <&apps_smmu 0x2185 0x0400>,
-							 <&apps_smmu 0x21c5 0x04a0>,
-							 <&apps_smmu 0x21e5 0x04a0>,
-							 <&apps_smmu 0x2545 0x04a0>,
-							 <&apps_smmu 0x2565 0x04a0>,
-							 <&apps_smmu 0x2585 0x0400>,
-							 <&apps_smmu 0x25c5 0x04a0>,
-							 <&apps_smmu 0x25e5 0x04a0>;
+							 <&apps_smmu 0x2185 0x0400>;
 						dma-coherent;
 					};
 
@@ -4092,15 +4052,7 @@ compute-cb@6 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <6>;
 						iommus = <&apps_smmu 0x2146 0x04a0>,
-							 <&apps_smmu 0x2166 0x04a0>,
-							 <&apps_smmu 0x2186 0x0400>,
-							 <&apps_smmu 0x21c6 0x04a0>,
-							 <&apps_smmu 0x21e6 0x04a0>,
-							 <&apps_smmu 0x2546 0x04a0>,
-							 <&apps_smmu 0x2566 0x04a0>,
-							 <&apps_smmu 0x2586 0x0400>,
-							 <&apps_smmu 0x25c6 0x04a0>,
-							 <&apps_smmu 0x25e6 0x04a0>;
+							 <&apps_smmu 0x2186 0x0400>;
 						dma-coherent;
 					};
 
@@ -4108,15 +4060,7 @@ compute-cb@7 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <7>;
 						iommus = <&apps_smmu 0x2147 0x04a0>,
-							 <&apps_smmu 0x2167 0x04a0>,
-							 <&apps_smmu 0x2187 0x0400>,
-							 <&apps_smmu 0x21c7 0x04a0>,
-							 <&apps_smmu 0x21e7 0x04a0>,
-							 <&apps_smmu 0x2547 0x04a0>,
-							 <&apps_smmu 0x2567 0x04a0>,
-							 <&apps_smmu 0x2587 0x0400>,
-							 <&apps_smmu 0x25c7 0x04a0>,
-							 <&apps_smmu 0x25e7 0x04a0>;
+							 <&apps_smmu 0x2187 0x0400>;
 						dma-coherent;
 					};
 
@@ -4124,15 +4068,7 @@ compute-cb@8 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <8>;
 						iommus = <&apps_smmu 0x2148 0x04a0>,
-							 <&apps_smmu 0x2168 0x04a0>,
-							 <&apps_smmu 0x2188 0x0400>,
-							 <&apps_smmu 0x21c8 0x04a0>,
-							 <&apps_smmu 0x21e8 0x04a0>,
-							 <&apps_smmu 0x2548 0x04a0>,
-							 <&apps_smmu 0x2568 0x04a0>,
-							 <&apps_smmu 0x2588 0x0400>,
-							 <&apps_smmu 0x25c8 0x04a0>,
-							 <&apps_smmu 0x25e8 0x04a0>;
+							 <&apps_smmu 0x2188 0x0400>;
 						dma-coherent;
 					};
 
@@ -4140,31 +4076,7 @@ compute-cb@9 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <9>;
 						iommus = <&apps_smmu 0x2149 0x04a0>,
-							 <&apps_smmu 0x2169 0x04a0>,
-							 <&apps_smmu 0x2189 0x0400>,
-							 <&apps_smmu 0x21c9 0x04a0>,
-							 <&apps_smmu 0x21e9 0x04a0>,
-							 <&apps_smmu 0x2549 0x04a0>,
-							 <&apps_smmu 0x2569 0x04a0>,
-							 <&apps_smmu 0x2589 0x0400>,
-							 <&apps_smmu 0x25c9 0x04a0>,
-							 <&apps_smmu 0x25e9 0x04a0>;
-						dma-coherent;
-					};
-
-					compute-cb@10 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <10>;
-						iommus = <&apps_smmu 0x214a 0x04a0>,
-							 <&apps_smmu 0x216a 0x04a0>,
-							 <&apps_smmu 0x218a 0x0400>,
-							 <&apps_smmu 0x21ca 0x04a0>,
-							 <&apps_smmu 0x21ea 0x04a0>,
-							 <&apps_smmu 0x254a 0x04a0>,
-							 <&apps_smmu 0x256a 0x04a0>,
-							 <&apps_smmu 0x258a 0x0400>,
-							 <&apps_smmu 0x25ca 0x04a0>,
-							 <&apps_smmu 0x25ea 0x04a0>;
+							 <&apps_smmu 0x2189 0x0400>;
 						dma-coherent;
 					};
 
@@ -4172,15 +4084,7 @@ compute-cb@11 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <11>;
 						iommus = <&apps_smmu 0x214b 0x04a0>,
-							 <&apps_smmu 0x216b 0x04a0>,
-							 <&apps_smmu 0x218b 0x0400>,
-							 <&apps_smmu 0x21cb 0x04a0>,
-							 <&apps_smmu 0x21eb 0x04a0>,
-							 <&apps_smmu 0x254b 0x04a0>,
-							 <&apps_smmu 0x256b 0x04a0>,
-							 <&apps_smmu 0x258b 0x0400>,
-							 <&apps_smmu 0x25cb 0x04a0>,
-							 <&apps_smmu 0x25eb 0x04a0>;
+							 <&apps_smmu 0x218b 0x0400>;
 						dma-coherent;
 					};
 				};
@@ -4240,15 +4144,7 @@ compute-cb@1 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <1>;
 						iommus = <&apps_smmu 0x2941 0x04a0>,
-							 <&apps_smmu 0x2961 0x04a0>,
-							 <&apps_smmu 0x2981 0x0400>,
-							 <&apps_smmu 0x29c1 0x04a0>,
-							 <&apps_smmu 0x29e1 0x04a0>,
-							 <&apps_smmu 0x2d41 0x04a0>,
-							 <&apps_smmu 0x2d61 0x04a0>,
-							 <&apps_smmu 0x2d81 0x0400>,
-							 <&apps_smmu 0x2dc1 0x04a0>,
-							 <&apps_smmu 0x2de1 0x04a0>;
+							 <&apps_smmu 0x2981 0x0400>;
 						dma-coherent;
 					};
 
@@ -4256,15 +4152,7 @@ compute-cb@2 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <2>;
 						iommus = <&apps_smmu 0x2942 0x04a0>,
-							 <&apps_smmu 0x2962 0x04a0>,
-							 <&apps_smmu 0x2982 0x0400>,
-							 <&apps_smmu 0x29c2 0x04a0>,
-							 <&apps_smmu 0x29e2 0x04a0>,
-							 <&apps_smmu 0x2d42 0x04a0>,
-							 <&apps_smmu 0x2d62 0x04a0>,
-							 <&apps_smmu 0x2d82 0x0400>,
-							 <&apps_smmu 0x2dc2 0x04a0>,
-							 <&apps_smmu 0x2de2 0x04a0>;
+							 <&apps_smmu 0x2982 0x0400>;
 						dma-coherent;
 					};
 
@@ -4272,15 +4160,7 @@ compute-cb@3 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <3>;
 						iommus = <&apps_smmu 0x2943 0x04a0>,
-							 <&apps_smmu 0x2963 0x04a0>,
-							 <&apps_smmu 0x2983 0x0400>,
-							 <&apps_smmu 0x29c3 0x04a0>,
-							 <&apps_smmu 0x29e3 0x04a0>,
-							 <&apps_smmu 0x2d43 0x04a0>,
-							 <&apps_smmu 0x2d63 0x04a0>,
-							 <&apps_smmu 0x2d83 0x0400>,
-							 <&apps_smmu 0x2dc3 0x04a0>,
-							 <&apps_smmu 0x2de3 0x04a0>;
+							 <&apps_smmu 0x2983 0x0400>;
 						dma-coherent;
 					};
 
@@ -4288,15 +4168,7 @@ compute-cb@4 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <4>;
 						iommus = <&apps_smmu 0x2944 0x04a0>,
-							 <&apps_smmu 0x2964 0x04a0>,
-							 <&apps_smmu 0x2984 0x0400>,
-							 <&apps_smmu 0x29c4 0x04a0>,
-							 <&apps_smmu 0x29e4 0x04a0>,
-							 <&apps_smmu 0x2d44 0x04a0>,
-							 <&apps_smmu 0x2d64 0x04a0>,
-							 <&apps_smmu 0x2d84 0x0400>,
-							 <&apps_smmu 0x2dc4 0x04a0>,
-							 <&apps_smmu 0x2de4 0x04a0>;
+							 <&apps_smmu 0x2984 0x0400>;
 						dma-coherent;
 					};
 
@@ -4304,15 +4176,7 @@ compute-cb@5 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <5>;
 						iommus = <&apps_smmu 0x2945 0x04a0>,
-							 <&apps_smmu 0x2965 0x04a0>,
-							 <&apps_smmu 0x2985 0x0400>,
-							 <&apps_smmu 0x29c5 0x04a0>,
-							 <&apps_smmu 0x29e5 0x04a0>,
-							 <&apps_smmu 0x2d45 0x04a0>,
-							 <&apps_smmu 0x2d65 0x04a0>,
-							 <&apps_smmu 0x2d85 0x0400>,
-							 <&apps_smmu 0x2dc5 0x04a0>,
-							 <&apps_smmu 0x2de5 0x04a0>;
+							 <&apps_smmu 0x2985 0x0400>;
 						dma-coherent;
 					};
 
@@ -4320,15 +4184,7 @@ compute-cb@6 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <6>;
 						iommus = <&apps_smmu 0x2946 0x04a0>,
-							 <&apps_smmu 0x2966 0x04a0>,
-							 <&apps_smmu 0x2986 0x0400>,
-							 <&apps_smmu 0x29c6 0x04a0>,
-							 <&apps_smmu 0x29e6 0x04a0>,
-							 <&apps_smmu 0x2d46 0x04a0>,
-							 <&apps_smmu 0x2d66 0x04a0>,
-							 <&apps_smmu 0x2d86 0x0400>,
-							 <&apps_smmu 0x2dc6 0x04a0>,
-							 <&apps_smmu 0x2de6 0x04a0>;
+							 <&apps_smmu 0x2986 0x0400>;
 						dma-coherent;
 					};
 
@@ -4336,15 +4192,7 @@ compute-cb@7 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <7>;
 						iommus = <&apps_smmu 0x2947 0x04a0>,
-							 <&apps_smmu 0x2967 0x04a0>,
-							 <&apps_smmu 0x2987 0x0400>,
-							 <&apps_smmu 0x29c7 0x04a0>,
-							 <&apps_smmu 0x29e7 0x04a0>,
-							 <&apps_smmu 0x2d47 0x04a0>,
-							 <&apps_smmu 0x2d67 0x04a0>,
-							 <&apps_smmu 0x2d87 0x0400>,
-							 <&apps_smmu 0x2dc7 0x04a0>,
-							 <&apps_smmu 0x2de7 0x04a0>;
+							 <&apps_smmu 0x2987 0x0400>;
 						dma-coherent;
 					};
 
@@ -4352,15 +4200,7 @@ compute-cb@8 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <8>;
 						iommus = <&apps_smmu 0x2948 0x04a0>,
-							 <&apps_smmu 0x2968 0x04a0>,
-							 <&apps_smmu 0x2988 0x0400>,
-							 <&apps_smmu 0x29c8 0x04a0>,
-							 <&apps_smmu 0x29e8 0x04a0>,
-							 <&apps_smmu 0x2d48 0x04a0>,
-							 <&apps_smmu 0x2d68 0x04a0>,
-							 <&apps_smmu 0x2d88 0x0400>,
-							 <&apps_smmu 0x2dc8 0x04a0>,
-							 <&apps_smmu 0x2de8 0x04a0>;
+							 <&apps_smmu 0x2988 0x0400>;
 						dma-coherent;
 					};
 
@@ -4368,15 +4208,7 @@ compute-cb@9 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <9>;
 						iommus = <&apps_smmu 0x2949 0x04a0>,
-							 <&apps_smmu 0x2969 0x04a0>,
-							 <&apps_smmu 0x2989 0x0400>,
-							 <&apps_smmu 0x29c9 0x04a0>,
-							 <&apps_smmu 0x29e9 0x04a0>,
-							 <&apps_smmu 0x2d49 0x04a0>,
-							 <&apps_smmu 0x2d69 0x04a0>,
-							 <&apps_smmu 0x2d89 0x0400>,
-							 <&apps_smmu 0x2dc9 0x04a0>,
-							 <&apps_smmu 0x2de9 0x04a0>;
+							 <&apps_smmu 0x2989 0x0400>;
 						dma-coherent;
 					};
 
@@ -4384,15 +4216,7 @@ compute-cb@10 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <10>;
 						iommus = <&apps_smmu 0x294a 0x04a0>,
-							 <&apps_smmu 0x296a 0x04a0>,
-							 <&apps_smmu 0x298a 0x0400>,
-							 <&apps_smmu 0x29ca 0x04a0>,
-							 <&apps_smmu 0x29ea 0x04a0>,
-							 <&apps_smmu 0x2d4a 0x04a0>,
-							 <&apps_smmu 0x2d6a 0x04a0>,
-							 <&apps_smmu 0x2d8a 0x0400>,
-							 <&apps_smmu 0x2dca 0x04a0>,
-							 <&apps_smmu 0x2dea 0x04a0>;
+							 <&apps_smmu 0x298a 0x0400>;
 						dma-coherent;
 					};
 
@@ -4400,15 +4224,7 @@ compute-cb@11 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <11>;
 						iommus = <&apps_smmu 0x294b 0x04a0>,
-							 <&apps_smmu 0x296b 0x04a0>,
-							 <&apps_smmu 0x298b 0x0400>,
-							 <&apps_smmu 0x29cb 0x04a0>,
-							 <&apps_smmu 0x29eb 0x04a0>,
-							 <&apps_smmu 0x2d4b 0x04a0>,
-							 <&apps_smmu 0x2d6b 0x04a0>,
-							 <&apps_smmu 0x2d8b 0x0400>,
-							 <&apps_smmu 0x2dcb 0x04a0>,
-							 <&apps_smmu 0x2deb 0x04a0>;
+							 <&apps_smmu 0x298b 0x0400>;
 						dma-coherent;
 					};
 
@@ -4416,15 +4232,7 @@ compute-cb@12 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <12>;
 						iommus = <&apps_smmu 0x294c 0x04a0>,
-							 <&apps_smmu 0x296c 0x04a0>,
-							 <&apps_smmu 0x298c 0x0400>,
-							 <&apps_smmu 0x29cc 0x04a0>,
-							 <&apps_smmu 0x29ec 0x04a0>,
-							 <&apps_smmu 0x2d4c 0x04a0>,
-							 <&apps_smmu 0x2d6c 0x04a0>,
-							 <&apps_smmu 0x2d8c 0x0400>,
-							 <&apps_smmu 0x2dcc 0x04a0>,
-							 <&apps_smmu 0x2dec 0x04a0>;
+							 <&apps_smmu 0x298c 0x0400>;
 						dma-coherent;
 					};
 
@@ -4432,15 +4240,7 @@ compute-cb@13 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <13>;
 						iommus = <&apps_smmu 0x294d 0x04a0>,
-							 <&apps_smmu 0x296d 0x04a0>,
-							 <&apps_smmu 0x298d 0x0400>,
-							 <&apps_smmu 0x29Cd 0x04a0>,
-							 <&apps_smmu 0x29ed 0x04a0>,
-							 <&apps_smmu 0x2d4d 0x04a0>,
-							 <&apps_smmu 0x2d6d 0x04a0>,
-							 <&apps_smmu 0x2d8d 0x0400>,
-							 <&apps_smmu 0x2dcd 0x04a0>,
-							 <&apps_smmu 0x2ded 0x04a0>;
+							 <&apps_smmu 0x298d 0x0400>;
 						dma-coherent;
 					};
 				};
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 46adf10e5fe4..404473fa491a 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -455,7 +455,7 @@ cdsp_secure_heap: memory@80c00000 {
 			no-map;
 		};
 
-		pil_camera_mem: mmeory@85200000 {
+		pil_camera_mem: memory@85200000 {
 			reg = <0x0 0x85200000 0x0 0x500000>;
 			no-map;
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index d664a88a018e..58ed68f534e5 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -4553,6 +4553,8 @@ cryptobam: dma-controller@1dc4000 {
 			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
 			qcom,ee = <0>;
+			qcom,num-ees = <4>;
+			num-channels = <16>;
 			qcom,controlled-remotely;
 			iommus = <&apps_smmu 0x584 0x11>,
 				 <&apps_smmu 0x588 0x0>,
diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 9ecf4a7fc328..cfdd30009015 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1952,6 +1952,8 @@ cryptobam: dma-controller@1dc4000 {
 			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
 			qcom,ee = <0>;
+			qcom,num-ees = <4>;
+			num-channels = <20>;
 			qcom,controlled-remotely;
 			iommus = <&apps_smmu 0x480 0x0>,
 				 <&apps_smmu 0x481 0x0>;
diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 416cfb71878a..fddf979de38d 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -2495,6 +2495,8 @@ cryptobam: dma-controller@1dc4000 {
 				 <&apps_smmu 0x481 0>;
 
 			qcom,ee = <0>;
+			qcom,num-ees = <4>;
+			num-channels = <20>;
 			qcom,controlled-remotely;
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
index b2cf080cab56..ce3fa29de7b4 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
@@ -314,8 +314,8 @@ vreg_l1j_0p8: ldo1 {
 
 		vreg_l2j_1p2: ldo2 {
 			regulator-name = "vreg_l2j_1p2";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
+			regulator-min-microvolt = <1256000>;
+			regulator-max-microvolt = <1256000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
index e9ed723f9038..07c2fdfe7ce1 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
@@ -266,6 +266,7 @@ vreg_l12b_1p2: ldo12 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
 		};
 
 		vreg_l14b_3p0: ldo14 {
@@ -280,8 +281,8 @@ vreg_l15b_1p8: ldo15 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
 		};
-
 	};
 
 	regulators-1 {
@@ -484,8 +485,8 @@ vreg_l1j_0p8: ldo1 {
 
 		vreg_l2j_1p2: ldo2 {
 			regulator-name = "vreg_l2j_1p2";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
+			regulator-min-microvolt = <1256000>;
+			regulator-max-microvolt = <1256000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
index af76aa034d0e..9062eb6766f2 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
@@ -356,6 +356,7 @@ vreg_l12b_1p2: ldo12 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
 		};
 
 		vreg_l13b_3p0: ldo13 {
@@ -377,6 +378,7 @@ vreg_l15b_1p8: ldo15 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
 		};
 
 		vreg_l16b_2p9: ldo16 {
@@ -594,8 +596,8 @@ vreg_l1j_0p8: ldo1 {
 
 		vreg_l2j_1p2: ldo2 {
 			regulator-name = "vreg_l2j_1p2";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
+			regulator-min-microvolt = <1256000>;
+			regulator-max-microvolt = <1256000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 91e4fbca19f9..5a5abd5fa658 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -6682,15 +6682,19 @@ mem-critical {
 		};
 
 		video-thermal {
-			polling-delay-passive = <250>;
-
 			thermal-sensors = <&tsens0 12>;
 
 			trips {
 				trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				video-critical {
 					temperature = <125000>;
 					hysteresis = <1000>;
-					type = "passive";
+					type = "critical";
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 60c6814206a1..3f3a31eced97 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -552,8 +552,6 @@ sdhci0: mmc@fa10000 {
 		power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 57 5>, <&k3_clks 57 6>;
 		clock-names = "clk_ahb", "clk_xin";
-		assigned-clocks = <&k3_clks 57 6>;
-		assigned-clock-parents = <&k3_clks 57 8>;
 		bus-width = <8>;
 		mmc-ddr-1_8v;
 		mmc-hs200-1_8v;
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index 56945d29e015..45d68a0d1b59 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -575,8 +575,6 @@ sdhci0: mmc@fa10000 {
 		power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 57 5>, <&k3_clks 57 6>;
 		clock-names = "clk_ahb", "clk_xin";
-		assigned-clocks = <&k3_clks 57 6>;
-		assigned-clock-parents = <&k3_clks 57 8>;
 		bus-width = <8>;
 		mmc-hs200-1_8v;
 		ti,clkbuf-sel = <0x7>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
index 9b6f51379108..77fe2b27cb58 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
@@ -564,8 +564,6 @@ sdhci0: mmc@fa10000 {
 		power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 57 1>, <&k3_clks 57 2>;
 		clock-names = "clk_ahb", "clk_xin";
-		assigned-clocks = <&k3_clks 57 2>;
-		assigned-clock-parents = <&k3_clks 57 4>;
 		bus-width = <8>;
 		mmc-ddr-1_8v;
 		mmc-hs200-1_8v;
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso
index 76ca02127f95..dd090813a32d 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso
@@ -22,7 +22,7 @@ &main_i2c2 {
 	#size-cells = <0>;
 	status = "okay";
 
-	i2c-switch@71 {
+	i2c-mux@71 {
 		compatible = "nxp,pca9543";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -39,7 +39,6 @@ ov5640: camera@10 {
 				reg = <0x10>;
 
 				clocks = <&clk_imx219_fixed>;
-				clock-names = "xclk";
 
 				reset-gpios = <&exp1 13 GPIO_ACTIVE_HIGH>;
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso
index ccc7f5e43184..7fc7c95f5cd5 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso
@@ -22,7 +22,7 @@ &main_i2c2 {
 	#size-cells = <0>;
 	status = "okay";
 
-	i2c-switch@71 {
+	i2c-mux@71 {
 		compatible = "nxp,pca9543";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso
index 4eaf9d757dd0..b6bfdfbbdd98 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso
@@ -22,7 +22,7 @@ &main_i2c2 {
 	#size-cells = <0>;
 	status = "okay";
 
-	i2c-switch@71 {
+	i2c-mux@71 {
 		compatible = "nxp,pca9543";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 1f1af7ea2330..0534b5348347 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -449,6 +449,8 @@ sdhci0: mmc@4f80000 {
 		ti,otap-del-sel-mmc-hs = <0x0>;
 		ti,otap-del-sel-ddr52 = <0x5>;
 		ti,otap-del-sel-hs200 = <0x5>;
+		ti,itap-del-sel-legacy = <0xa>;
+		ti,itap-del-sel-mmc-hs = <0x1>;
 		ti,itap-del-sel-ddr52 = <0x0>;
 		dma-coherent;
 		status = "disabled";
diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
index d5ceab79536c..b40496097f82 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
@@ -44,6 +44,17 @@ vusb_main: regulator-vusb-main5v0 {
 		regulator-boot-on;
 	};
 
+	vsys_5v0: regulator-vsys5v0 {
+		/* Output of LM61460 */
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vusb_main>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	vsys_3v3: regulator-vsys3v3 {
 		/* Output of LM5141 */
 		compatible = "regulator-fixed";
@@ -76,7 +87,7 @@ vdd_sd_dv: regulator-tlv71033 {
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <3300000>;
 		regulator-boot-on;
-		vin-supply = <&vsys_3v3>;
+		vin-supply = <&vsys_5v0>;
 		gpios = <&main_gpio0 49 GPIO_ACTIVE_HIGH>;
 		states = <1800000 0x0>,
 			 <3300000 0x1>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso b/arch/arm64/boot/dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso
index 47bb5480b5b0..4eb3cffab032 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso
@@ -19,6 +19,33 @@ clk_imx219_fixed: imx219-xclk {
 		#clock-cells = <0>;
 		clock-frequency = <24000000>;
 	};
+
+	reg_2p8v: regulator-2p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "2P8V";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		vin-supply = <&vdd_sd_dv>;
+		regulator-always-on;
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "1P8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vdd_sd_dv>;
+		regulator-always-on;
+	};
+
+	reg_1p2v: regulator-1p2v {
+		compatible = "regulator-fixed";
+		regulator-name = "1P2V";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		vin-supply = <&vdd_sd_dv>;
+		regulator-always-on;
+	};
 };
 
 &csi_mux {
@@ -34,7 +61,9 @@ imx219_0: imx219-0@10 {
 		reg = <0x10>;
 
 		clocks = <&clk_imx219_fixed>;
-		clock-names = "xclk";
+		VANA-supply = <&reg_2p8v>;
+		VDIG-supply = <&reg_1p8v>;
+		VDDL-supply = <&reg_1p2v>;
 
 		port {
 			csi2_cam0: endpoint {
@@ -56,7 +85,9 @@ imx219_1: imx219-1@10 {
 		reg = <0x10>;
 
 		clocks = <&clk_imx219_fixed>;
-		clock-names = "xclk";
+		VANA-supply = <&reg_2p8v>;
+		VDIG-supply = <&reg_1p8v>;
+		VDDL-supply = <&reg_1p2v>;
 
 		port {
 			csi2_cam1: endpoint {
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 6285e8d94dde..c8d7eb1814f0 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -184,6 +184,17 @@ vsys_3v3: fixedregulator-vsys3v3 {
 		regulator-boot-on;
 	};
 
+	vsys_5v0: fixedregulator-vsys5v0 {
+		/* Output of LM61460 */
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vusb_main>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	vdd_mmc1: fixedregulator-sd {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -211,6 +222,20 @@ vdd_sd_dv_alt: gpio-regulator-tps659411 {
 			 <3300000 0x1>;
 	};
 
+	vdd_sd_dv: gpio-regulator-TLV71033 {
+		compatible = "regulator-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vdd_sd_dv_pins_default>;
+		regulator-name = "tlv71033";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		vin-supply = <&vsys_5v0>;
+		gpios = <&main_gpio0 118 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x0>,
+			 <3300000 0x1>;
+	};
+
 	transceiver1: can-phy1 {
 		compatible = "ti,tcan1042";
 		#phy-cells = <0>;
@@ -608,6 +633,12 @@ J721E_WKUP_IOPAD(0xd4, PIN_OUTPUT, 7) /* (G26) WKUP_GPIO0_9 */
 		>;
 	};
 
+	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x1dc, PIN_OUTPUT, 7) /* (Y1) SPI1_CLK.GPIO0_118 */
+		>;
+	};
+
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0xa0, PIN_INPUT, 0) /* (J29) WKUP_UART0_RXD */
diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index a00f4a7d20d9..710f80a14b64 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -720,6 +720,10 @@ &serdes_ln_ctrl {
 		      <J722S_SERDES1_LANE0_PCIE0_LANE0>;
 };
 
+&serdes_wiz0 {
+	status = "okay";
+};
+
 &serdes0 {
 	status = "okay";
 	serdes0_usb_link: phy@0 {
@@ -731,6 +735,10 @@ serdes0_usb_link: phy@0 {
 	};
 };
 
+&serdes_wiz1 {
+	status = "okay";
+};
+
 &serdes1 {
 	status = "okay";
 	serdes1_pcie_link: phy@0 {
diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
index ed6f4ba08afc..ec8fcf9d16d6 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -32,6 +32,8 @@ serdes_wiz0: phy@f000000 {
 		assigned-clocks = <&k3_clks 279 1>;
 		assigned-clock-parents = <&k3_clks 279 5>;
 
+		status = "disabled";
+
 		serdes0: serdes@f000000 {
 			compatible = "ti,j721e-serdes-10g";
 			reg = <0x0f000000 0x00010000>;
@@ -70,6 +72,8 @@ serdes_wiz1: phy@f010000 {
 		assigned-clocks = <&k3_clks 280 1>;
 		assigned-clock-parents = <&k3_clks 280 5>;
 
+		status = "disabled";
+
 		serdes1: serdes@f010000 {
 			compatible = "ti,j721e-serdes-10g";
 			reg = <0x0f010000 0x00010000>;
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
index 2bf4547485e1..013c0d25d348 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
@@ -77,7 +77,7 @@ pcie1_ctrl: pcie1-ctrl@4074 {
 
 		serdes_ln_ctrl: mux-controller@4080 {
 			compatible = "reg-mux";
-			reg = <0x00004080 0x30>;
+			reg = <0x00004080 0x50>;
 			#mux-control-cells = <1>;
 			mux-reg-masks = <0x0 0x3>, <0x4 0x3>, /* SERDES0 lane0/1 select */
 					<0x8 0x3>, <0xc 0x3>, /* SERDES0 lane2/3 select */
diff --git a/arch/um/Makefile b/arch/um/Makefile
index 00b63bac5eff..3317d87e2092 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -151,5 +151,6 @@ MRPROPER_FILES += $(HOST_DIR)/include/generated
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
+	$(Q)$(MAKE) -f $(srctree)/Makefile ARCH=$(HEADER_ARCH) clean
 
 export HEADER_ARCH SUBARCH USER_CFLAGS CFLAGS_NO_HARDENING DEV_NULL_PATH
diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index e49a19fea3bd..dc882fc9fa9e 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -201,7 +201,7 @@ static void tpm_buf_read(struct tpm_buf *buf, off_t *offset, size_t count, void
  */
 u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset)
 {
-	u8 value;
+	u8 value = 0;
 
 	tpm_buf_read(buf, offset, sizeof(value), &value);
 
@@ -218,7 +218,7 @@ EXPORT_SYMBOL_GPL(tpm_buf_read_u8);
  */
 u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset)
 {
-	u16 value;
+	u16 value = 0;
 
 	tpm_buf_read(buf, offset, sizeof(value), &value);
 
@@ -235,7 +235,7 @@ EXPORT_SYMBOL_GPL(tpm_buf_read_u16);
  */
 u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset)
 {
-	u32 value;
+	u32 value = 0;
 
 	tpm_buf_read(buf, offset, sizeof(value), &value);
 
diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 22aa2bab3693..19a58c4ecef3 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -225,7 +225,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	struct idxd_wq *wq;
 	struct device *dev, *fdev;
 	int rc = 0;
-	struct iommu_sva *sva;
+	struct iommu_sva *sva = NULL;
 	unsigned int pasid;
 	struct idxd_cdev *idxd_cdev;
 
@@ -322,7 +322,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	if (device_user_pasid_enabled(idxd))
 		idxd_xa_pasid_remove(ctx);
 failed_get_pasid:
-	if (device_user_pasid_enabled(idxd))
+	if (device_user_pasid_enabled(idxd) && !IS_ERR_OR_NULL(sva))
 		iommu_sva_unbind_device(sva);
 failed:
 	mutex_unlock(&wq->wq_lock);
diff --git a/drivers/gpio/gpio-virtuser.c b/drivers/gpio/gpio-virtuser.c
index e89f299f2140..dcecb7a25911 100644
--- a/drivers/gpio/gpio-virtuser.c
+++ b/drivers/gpio/gpio-virtuser.c
@@ -400,10 +400,15 @@ static ssize_t gpio_virtuser_direction_do_write(struct file *file,
 	char buf[32], *trimmed;
 	int ret, dir, val = 0;
 
-	ret = simple_write_to_buffer(buf, sizeof(buf), ppos, user_buf, count);
+	if (count >= sizeof(buf))
+		return -EINVAL;
+
+	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, user_buf, count);
 	if (ret < 0)
 		return ret;
 
+	buf[ret] = '\0';
+
 	trimmed = strim(buf);
 
 	if (strcmp(trimmed, "input") == 0) {
@@ -622,12 +627,15 @@ static ssize_t gpio_virtuser_consumer_write(struct file *file,
 	char buf[GPIO_VIRTUSER_NAME_BUF_LEN + 2];
 	int ret;
 
+	if (count >= sizeof(buf))
+		return -EINVAL;
+
 	ret = simple_write_to_buffer(buf, GPIO_VIRTUSER_NAME_BUF_LEN, ppos,
 				     user_buf, count);
 	if (ret < 0)
 		return ret;
 
-	buf[strlen(buf) - 1] = '\0';
+	buf[ret] = '\0';
 
 	ret = gpiod_set_consumer_name(data->ad.desc, buf);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index 55014c152116..7e3d506bb79b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -887,7 +887,7 @@ static void populate_dml21_plane_config_from_plane_state(struct dml2_context *dm
 }
 
 //TODO : Could be possibly moved to a common helper layer.
-static bool dml21_wrapper_get_plane_id(const struct dc_state *context, const struct dc_plane_state *plane, unsigned int *plane_id)
+static bool dml21_wrapper_get_plane_id(const struct dc_state *context, unsigned int stream_id, const struct dc_plane_state *plane, unsigned int *plane_id)
 {
 	int i, j;
 
@@ -895,10 +895,12 @@ static bool dml21_wrapper_get_plane_id(const struct dc_state *context, const str
 		return false;
 
 	for (i = 0; i < context->stream_count; i++) {
-		for (j = 0; j < context->stream_status[i].plane_count; j++) {
-			if (context->stream_status[i].plane_states[j] == plane) {
-				*plane_id = (i << 16) | j;
-				return true;
+		if (context->streams[i]->stream_id == stream_id) {
+			for (j = 0; j < context->stream_status[i].plane_count; j++) {
+				if (context->stream_status[i].plane_states[j] == plane) {
+					*plane_id = (i << 16) | j;
+					return true;
+				}
 			}
 		}
 	}
@@ -921,14 +923,14 @@ static unsigned int map_stream_to_dml21_display_cfg(const struct dml2_context *d
 	return location;
 }
 
-static unsigned int map_plane_to_dml21_display_cfg(const struct dml2_context *dml_ctx,
+static unsigned int map_plane_to_dml21_display_cfg(const struct dml2_context *dml_ctx, unsigned int stream_id,
 		const struct dc_plane_state *plane, const struct dc_state *context)
 {
 	unsigned int plane_id;
 	int i = 0;
 	int location = -1;
 
-	if (!dml21_wrapper_get_plane_id(context, plane, &plane_id)) {
+	if (!dml21_wrapper_get_plane_id(context, stream_id, plane, &plane_id)) {
 		ASSERT(false);
 		return -1;
 	}
@@ -1013,7 +1015,7 @@ bool dml21_map_dc_state_into_dml_display_cfg(const struct dc *in_dc, struct dc_s
 			dml_dispcfg->plane_descriptors[disp_cfg_plane_location].stream_index = disp_cfg_stream_location;
 		} else {
 			for (plane_index = 0; plane_index < context->stream_status[stream_index].plane_count; plane_index++) {
-				disp_cfg_plane_location = map_plane_to_dml21_display_cfg(dml_ctx, context->stream_status[stream_index].plane_states[plane_index], context);
+				disp_cfg_plane_location = map_plane_to_dml21_display_cfg(dml_ctx, context->streams[stream_index]->stream_id, context->stream_status[stream_index].plane_states[plane_index], context);
 
 				if (disp_cfg_plane_location < 0)
 					disp_cfg_plane_location = dml_dispcfg->num_planes++;
@@ -1024,7 +1026,7 @@ bool dml21_map_dc_state_into_dml_display_cfg(const struct dc *in_dc, struct dc_s
 				populate_dml21_plane_config_from_plane_state(dml_ctx, &dml_dispcfg->plane_descriptors[disp_cfg_plane_location], context->stream_status[stream_index].plane_states[plane_index], context, stream_index);
 				dml_dispcfg->plane_descriptors[disp_cfg_plane_location].stream_index = disp_cfg_stream_location;
 
-				if (dml21_wrapper_get_plane_id(context, context->stream_status[stream_index].plane_states[plane_index], &dml_ctx->v21.dml_to_dc_pipe_mapping.disp_cfg_to_plane_id[disp_cfg_plane_location]))
+				if (dml21_wrapper_get_plane_id(context, context->streams[stream_index]->stream_id, context->stream_status[stream_index].plane_states[plane_index], &dml_ctx->v21.dml_to_dc_pipe_mapping.disp_cfg_to_plane_id[disp_cfg_plane_location]))
 					dml_ctx->v21.dml_to_dc_pipe_mapping.disp_cfg_to_plane_id_valid[disp_cfg_plane_location] = true;
 
 				/* apply forced pstate policy */
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index c4e03482ba9a..aa2800129767 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -148,6 +148,7 @@ void link_blank_dp_stream(struct dc_link *link, bool hw_init)
 void link_set_all_streams_dpms_off_for_link(struct dc_link *link)
 {
 	struct pipe_ctx *pipes[MAX_PIPES];
+	struct dc_stream_state *streams[MAX_PIPES];
 	struct dc_state *state = link->dc->current_state;
 	uint8_t count;
 	int i;
@@ -160,10 +161,18 @@ void link_set_all_streams_dpms_off_for_link(struct dc_link *link)
 
 	link_get_master_pipes_with_dpms_on(link, state, &count, pipes);
 
+	/* The subsequent call to dc_commit_updates_for_stream for a full update
+	 * will release the current state and swap to a new state. Releasing the
+	 * current state results in the stream pointers in the pipe_ctx structs
+	 * to be zero'd. Hence, cache all streams prior to dc_commit_updates_for_stream.
+	 */
+	for (i = 0; i < count; i++)
+		streams[i] = pipes[i]->stream;
+
 	for (i = 0; i < count; i++) {
-		stream_update.stream = pipes[i]->stream;
+		stream_update.stream = streams[i];
 		dc_commit_updates_for_stream(link->ctx->dc, NULL, 0,
-				pipes[i]->stream, &stream_update,
+				streams[i], &stream_update,
 				state);
 	}
 
diff --git a/drivers/gpu/drm/xe/regs/xe_gt_regs.h b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
index 5404de2aea54..c160b015d178 100644
--- a/drivers/gpu/drm/xe/regs/xe_gt_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
@@ -157,6 +157,7 @@
 #define XEHPG_SC_INSTDONE_EXTRA2		XE_REG_MCR(0x7108)
 
 #define COMMON_SLICE_CHICKEN4			XE_REG(0x7300, XE_REG_OPTION_MASKED)
+#define   SBE_PUSH_CONSTANT_BEHIND_FIX_ENABLE	REG_BIT(12)
 #define   DISABLE_TDC_LOAD_BALANCING_CALC	REG_BIT(6)
 
 #define COMMON_SLICE_CHICKEN3				XE_REG(0x7304, XE_REG_OPTION_MASKED)
diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
index 2d4e38b3bab1..ce6d2167b94a 100644
--- a/drivers/gpu/drm/xe/xe_lrc.c
+++ b/drivers/gpu/drm/xe/xe_lrc.c
@@ -874,7 +874,7 @@ static void *empty_lrc_data(struct xe_hw_engine *hwe)
 
 static void xe_lrc_set_ppgtt(struct xe_lrc *lrc, struct xe_vm *vm)
 {
-	u64 desc = xe_vm_pdp4_descriptor(vm, lrc->tile);
+	u64 desc = xe_vm_pdp4_descriptor(vm, gt_to_tile(lrc->gt));
 
 	xe_lrc_write_ctx_reg(lrc, CTX_PDP0_UDW, upper_32_bits(desc));
 	xe_lrc_write_ctx_reg(lrc, CTX_PDP0_LDW, lower_32_bits(desc));
@@ -905,6 +905,7 @@ static int xe_lrc_init(struct xe_lrc *lrc, struct xe_hw_engine *hwe,
 	int err;
 
 	kref_init(&lrc->refcount);
+	lrc->gt = gt;
 	lrc->flags = 0;
 	lrc_size = ring_size + xe_gt_lrc_size(gt, hwe->class);
 	if (xe_gt_has_indirect_ring_state(gt))
@@ -923,7 +924,6 @@ static int xe_lrc_init(struct xe_lrc *lrc, struct xe_hw_engine *hwe,
 		return PTR_ERR(lrc->bo);
 
 	lrc->size = lrc_size;
-	lrc->tile = gt_to_tile(hwe->gt);
 	lrc->ring.size = ring_size;
 	lrc->ring.tail = 0;
 	lrc->ctx_timestamp = 0;
diff --git a/drivers/gpu/drm/xe/xe_lrc_types.h b/drivers/gpu/drm/xe/xe_lrc_types.h
index 71ecb453f811..cd38586ae989 100644
--- a/drivers/gpu/drm/xe/xe_lrc_types.h
+++ b/drivers/gpu/drm/xe/xe_lrc_types.h
@@ -25,8 +25,8 @@ struct xe_lrc {
 	/** @size: size of lrc including any indirect ring state page */
 	u32 size;
 
-	/** @tile: tile which this LRC belongs to */
-	struct xe_tile *tile;
+	/** @gt: gt which this LRC belongs to */
+	struct xe_gt *gt;
 
 	/** @flags: LRC flags */
 #define XE_LRC_FLAG_INDIRECT_RING_STATE		0x1
diff --git a/drivers/gpu/drm/xe/xe_wa.c b/drivers/gpu/drm/xe/xe_wa.c
index 0a1905f8d380..aea6034a8107 100644
--- a/drivers/gpu/drm/xe/xe_wa.c
+++ b/drivers/gpu/drm/xe/xe_wa.c
@@ -783,6 +783,10 @@ static const struct xe_rtp_entry_sr lrc_was[] = {
 	  XE_RTP_RULES(GRAPHICS_VERSION(2001), ENGINE_CLASS(RENDER)),
 	  XE_RTP_ACTIONS(SET(CHICKEN_RASTER_1, DIS_CLIP_NEGATIVE_BOUNDING_BOX))
 	},
+	{ XE_RTP_NAME("22021007897"),
+	  XE_RTP_RULES(GRAPHICS_VERSION(2001), ENGINE_CLASS(RENDER)),
+	  XE_RTP_ACTIONS(SET(COMMON_SLICE_CHICKEN4, SBE_PUSH_CONSTANT_BEHIND_FIX_ENABLE))
+	},
 
 	/* Xe3_LPG */
 	{ XE_RTP_NAME("14021490052"),
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 92baa34f42f2..c6424f625948 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -41,6 +41,10 @@
 #define USB_VENDOR_ID_ACTIONSTAR	0x2101
 #define USB_DEVICE_ID_ACTIONSTAR_1011	0x1011
 
+#define USB_VENDOR_ID_ADATA_XPG 0x125f
+#define USB_VENDOR_ID_ADATA_XPG_WL_GAMING_MOUSE 0x7505
+#define USB_VENDOR_ID_ADATA_XPG_WL_GAMING_MOUSE_DONGLE 0x7506
+
 #define USB_VENDOR_ID_ADS_TECH		0x06e1
 #define USB_DEVICE_ID_ADS_TECH_RADIO_SI470X	0xa155
 
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 5d7a418ccdbe..73979643315b 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -27,6 +27,8 @@
 static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_GAMEPAD), HID_QUIRK_BADPAD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_PREDATOR), HID_QUIRK_BADPAD },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ADATA_XPG, USB_VENDOR_ID_ADATA_XPG_WL_GAMING_MOUSE), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ADATA_XPG, USB_VENDOR_ID_ADATA_XPG_WL_GAMING_MOUSE_DONGLE), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AFATECH, USB_DEVICE_ID_AFATECH_AF9016), HID_QUIRK_FULLSPEED_INTERVAL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AIREN, USB_DEVICE_ID_AIREN_SLIMPLUS), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AKAI_09E8, USB_DEVICE_ID_AKAI_09E8_MIDIMIX), HID_QUIRK_NO_INIT_REPORTS },
diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 020e5897812f..3cf100780599 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1670,24 +1670,28 @@ static int kvaser_pciefd_read_buffer(struct kvaser_pciefd *pcie, int dma_buf)
 	return res;
 }
 
-static u32 kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
+static void kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
 {
+	void __iomem *srb_cmd_reg = KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG;
 	u32 irq = ioread32(KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IRQ_REG);
 
-	if (irq & KVASER_PCIEFD_SRB_IRQ_DPD0)
+	iowrite32(irq, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IRQ_REG);
+
+	if (irq & KVASER_PCIEFD_SRB_IRQ_DPD0) {
 		kvaser_pciefd_read_buffer(pcie, 0);
+		iowrite32(KVASER_PCIEFD_SRB_CMD_RDB0, srb_cmd_reg); /* Rearm buffer */
+	}
 
-	if (irq & KVASER_PCIEFD_SRB_IRQ_DPD1)
+	if (irq & KVASER_PCIEFD_SRB_IRQ_DPD1) {
 		kvaser_pciefd_read_buffer(pcie, 1);
+		iowrite32(KVASER_PCIEFD_SRB_CMD_RDB1, srb_cmd_reg); /* Rearm buffer */
+	}
 
 	if (unlikely(irq & KVASER_PCIEFD_SRB_IRQ_DOF0 ||
 		     irq & KVASER_PCIEFD_SRB_IRQ_DOF1 ||
 		     irq & KVASER_PCIEFD_SRB_IRQ_DUF0 ||
 		     irq & KVASER_PCIEFD_SRB_IRQ_DUF1))
 		dev_err(&pcie->pci->dev, "DMA IRQ error 0x%08X\n", irq);
-
-	iowrite32(irq, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IRQ_REG);
-	return irq;
 }
 
 static void kvaser_pciefd_transmit_irq(struct kvaser_pciefd_can *can)
@@ -1715,29 +1719,22 @@ static irqreturn_t kvaser_pciefd_irq_handler(int irq, void *dev)
 	struct kvaser_pciefd *pcie = (struct kvaser_pciefd *)dev;
 	const struct kvaser_pciefd_irq_mask *irq_mask = pcie->driver_data->irq_mask;
 	u32 pci_irq = ioread32(KVASER_PCIEFD_PCI_IRQ_ADDR(pcie));
-	u32 srb_irq = 0;
-	u32 srb_release = 0;
 	int i;
 
 	if (!(pci_irq & irq_mask->all))
 		return IRQ_NONE;
 
+	iowrite32(0, KVASER_PCIEFD_PCI_IEN_ADDR(pcie));
+
 	if (pci_irq & irq_mask->kcan_rx0)
-		srb_irq = kvaser_pciefd_receive_irq(pcie);
+		kvaser_pciefd_receive_irq(pcie);
 
 	for (i = 0; i < pcie->nr_channels; i++) {
 		if (pci_irq & irq_mask->kcan_tx[i])
 			kvaser_pciefd_transmit_irq(pcie->can[i]);
 	}
 
-	if (srb_irq & KVASER_PCIEFD_SRB_IRQ_DPD0)
-		srb_release |= KVASER_PCIEFD_SRB_CMD_RDB0;
-
-	if (srb_irq & KVASER_PCIEFD_SRB_IRQ_DPD1)
-		srb_release |= KVASER_PCIEFD_SRB_CMD_RDB1;
-
-	if (srb_release)
-		iowrite32(srb_release, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG);
+	iowrite32(irq_mask->all, KVASER_PCIEFD_PCI_IEN_ADDR(pcie));
 
 	return IRQ_HANDLED;
 }
@@ -1757,13 +1754,22 @@ static void kvaser_pciefd_teardown_can_ctrls(struct kvaser_pciefd *pcie)
 	}
 }
 
+static void kvaser_pciefd_disable_irq_srcs(struct kvaser_pciefd *pcie)
+{
+	unsigned int i;
+
+	/* Masking PCI_IRQ is insufficient as running ISR will unmask it */
+	iowrite32(0, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IEN_REG);
+	for (i = 0; i < pcie->nr_channels; ++i)
+		iowrite32(0, pcie->can[i]->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
+}
+
 static int kvaser_pciefd_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *id)
 {
 	int ret;
 	struct kvaser_pciefd *pcie;
 	const struct kvaser_pciefd_irq_mask *irq_mask;
-	void __iomem *irq_en_base;
 
 	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
@@ -1829,8 +1835,7 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 		  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IEN_REG);
 
 	/* Enable PCI interrupts */
-	irq_en_base = KVASER_PCIEFD_PCI_IEN_ADDR(pcie);
-	iowrite32(irq_mask->all, irq_en_base);
+	iowrite32(irq_mask->all, KVASER_PCIEFD_PCI_IEN_ADDR(pcie));
 	/* Ready the DMA buffers */
 	iowrite32(KVASER_PCIEFD_SRB_CMD_RDB0,
 		  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG);
@@ -1844,8 +1849,7 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	return 0;
 
 err_free_irq:
-	/* Disable PCI interrupts */
-	iowrite32(0, irq_en_base);
+	kvaser_pciefd_disable_irq_srcs(pcie);
 	free_irq(pcie->pci->irq, pcie);
 
 err_pci_free_irq_vectors:
@@ -1868,35 +1872,26 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	return ret;
 }
 
-static void kvaser_pciefd_remove_all_ctrls(struct kvaser_pciefd *pcie)
-{
-	int i;
-
-	for (i = 0; i < pcie->nr_channels; i++) {
-		struct kvaser_pciefd_can *can = pcie->can[i];
-
-		if (can) {
-			iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
-			unregister_candev(can->can.dev);
-			del_timer(&can->bec_poll_timer);
-			kvaser_pciefd_pwm_stop(can);
-			free_candev(can->can.dev);
-		}
-	}
-}
-
 static void kvaser_pciefd_remove(struct pci_dev *pdev)
 {
 	struct kvaser_pciefd *pcie = pci_get_drvdata(pdev);
+	unsigned int i;
 
-	kvaser_pciefd_remove_all_ctrls(pcie);
+	for (i = 0; i < pcie->nr_channels; ++i) {
+		struct kvaser_pciefd_can *can = pcie->can[i];
 
-	/* Disable interrupts */
-	iowrite32(0, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CTRL_REG);
-	iowrite32(0, KVASER_PCIEFD_PCI_IEN_ADDR(pcie));
+		unregister_candev(can->can.dev);
+		del_timer(&can->bec_poll_timer);
+		kvaser_pciefd_pwm_stop(can);
+	}
 
+	kvaser_pciefd_disable_irq_srcs(pcie);
 	free_irq(pcie->pci->irq, pcie);
 	pci_free_irq_vectors(pcie->pci);
+
+	for (i = 0; i < pcie->nr_channels; ++i)
+		free_candev(pcie->can[i]->can.dev);
+
 	pci_iounmap(pdev, pcie->reg_base);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index a21e7c0afbfd..61788a43cb86 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2699,7 +2699,7 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
 							port->slave.mac_addr);
 			if (!is_valid_ether_addr(port->slave.mac_addr)) {
 				eth_random_addr(port->slave.mac_addr);
-				dev_err(dev, "Use random MAC address\n");
+				dev_info(dev, "Use random MAC address\n");
 			}
 		}
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index cd8a10f6accf..37fd1a8ace12 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3701,6 +3701,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x1e49, 0x0041),   /* ZHITAI TiPro7000 NVMe SSD */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
+	{ PCI_DEVICE(0x025e, 0xf1ac),   /* SOLIDIGM  P44 pro SSDPFKKW020X7  */
+		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0xc0a9, 0x540a),   /* Crucial P2 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1d97, 0x2263), /* Lexar NM610 */
diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 30506c43776f..ff17e0f95fbb 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -727,8 +727,8 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
 
 		if ((chan == 5 && cmn->rsp_vc_num < 2) ||
 		    (chan == 6 && cmn->dat_vc_num < 2) ||
-		    (chan == 7 && cmn->snp_vc_num < 2) ||
-		    (chan == 8 && cmn->req_vc_num < 2))
+		    (chan == 7 && cmn->req_vc_num < 2) ||
+		    (chan == 8 && cmn->snp_vc_num < 2))
 			return 0;
 	}
 
@@ -884,8 +884,8 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
 	_CMN_EVENT_XP(pub_##_name, (_event) | (4 << 5)),	\
 	_CMN_EVENT_XP(rsp2_##_name, (_event) | (5 << 5)),	\
 	_CMN_EVENT_XP(dat2_##_name, (_event) | (6 << 5)),	\
-	_CMN_EVENT_XP(snp2_##_name, (_event) | (7 << 5)),	\
-	_CMN_EVENT_XP(req2_##_name, (_event) | (8 << 5))
+	_CMN_EVENT_XP(req2_##_name, (_event) | (7 << 5)),	\
+	_CMN_EVENT_XP(snp2_##_name, (_event) | (8 << 5))
 
 #define CMN_EVENT_XP_DAT(_name, _event)				\
 	_CMN_EVENT_XP_PORT(dat_##_name, (_event) | (3 << 5)),	\
@@ -2557,6 +2557,7 @@ static int arm_cmn_probe(struct platform_device *pdev)
 
 	cmn->dev = &pdev->dev;
 	cmn->part = (unsigned long)device_get_match_data(cmn->dev);
+	cmn->cpu = cpumask_local_spread(0, dev_to_node(cmn->dev));
 	platform_set_drvdata(pdev, cmn);
 
 	if (cmn->part == PART_CMN600 && has_acpi_companion(cmn->dev)) {
@@ -2584,7 +2585,6 @@ static int arm_cmn_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	cmn->cpu = cpumask_local_spread(0, dev_to_node(cmn->dev));
 	cmn->pmu = (struct pmu) {
 		.module = THIS_MODULE,
 		.parent = cmn->dev,
@@ -2650,6 +2650,7 @@ static const struct acpi_device_id arm_cmn_acpi_match[] = {
 	{ "ARMHC600", PART_CMN600 },
 	{ "ARMHC650" },
 	{ "ARMHC700" },
+	{ "ARMHC003" },
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, arm_cmn_acpi_match);
diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index dc6e01dff5c7..9b99fdd43f5f 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -328,6 +328,8 @@ static const struct ropll_config ropll_tmds_cfg[] = {
 	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
 	{ 650000, 162, 162, 1, 1, 11, 1, 1, 1, 1, 1, 1, 1, 54, 0, 16, 4, 1,
 	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
+	{ 502500, 84, 84, 1, 1, 7, 1, 1, 1, 1, 1, 1, 1, 11, 1, 4, 5,
+	  4, 11, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
 	{ 337500, 0x70, 0x70, 1, 1, 0xf, 1, 1, 1, 1, 1, 1, 1, 0x2, 0, 0x01, 5,
 	  1, 1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
 	{ 400000, 100, 100, 1, 1, 11, 1, 1, 0, 1, 0, 1, 1, 0x9, 0, 0x05, 0,
diff --git a/drivers/phy/starfive/phy-jh7110-usb.c b/drivers/phy/starfive/phy-jh7110-usb.c
index cb5454fbe2c8..b505d89860b4 100644
--- a/drivers/phy/starfive/phy-jh7110-usb.c
+++ b/drivers/phy/starfive/phy-jh7110-usb.c
@@ -18,6 +18,8 @@
 #include <linux/usb/of.h>
 
 #define USB_125M_CLK_RATE		125000000
+#define USB_CLK_MODE_OFF		0x0
+#define USB_CLK_MODE_RX_NORMAL_PWR	BIT(1)
 #define USB_LS_KEEPALIVE_OFF		0x4
 #define USB_LS_KEEPALIVE_ENABLE		BIT(4)
 
@@ -78,6 +80,7 @@ static int jh7110_usb2_phy_init(struct phy *_phy)
 {
 	struct jh7110_usb2_phy *phy = phy_get_drvdata(_phy);
 	int ret;
+	unsigned int val;
 
 	ret = clk_set_rate(phy->usb_125m_clk, USB_125M_CLK_RATE);
 	if (ret)
@@ -87,6 +90,10 @@ static int jh7110_usb2_phy_init(struct phy *_phy)
 	if (ret)
 		return ret;
 
+	val = readl(phy->regs + USB_CLK_MODE_OFF);
+	val |= USB_CLK_MODE_RX_NORMAL_PWR;
+	writel(val, phy->regs + USB_CLK_MODE_OFF);
+
 	return 0;
 }
 
diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index ae992ac1ab4a..6d5300c54a42 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -17,13 +17,13 @@
 /*
  * fujitsu-laptop.c - Fujitsu laptop support, providing access to additional
  * features made available on a range of Fujitsu laptops including the
- * P2xxx/P5xxx/S6xxx/S7xxx series.
+ * P2xxx/P5xxx/S2xxx/S6xxx/S7xxx series.
  *
  * This driver implements a vendor-specific backlight control interface for
  * Fujitsu laptops and provides support for hotkeys present on certain Fujitsu
  * laptops.
  *
- * This driver has been tested on a Fujitsu Lifebook S6410, S7020 and
+ * This driver has been tested on a Fujitsu Lifebook S2110, S6410, S7020 and
  * P8010.  It should work on most P-series and S-series Lifebooks, but
  * YMMV.
  *
@@ -107,7 +107,11 @@
 #define KEY2_CODE			0x411
 #define KEY3_CODE			0x412
 #define KEY4_CODE			0x413
-#define KEY5_CODE			0x420
+#define KEY5_CODE			0x414
+#define KEY6_CODE			0x415
+#define KEY7_CODE			0x416
+#define KEY8_CODE			0x417
+#define KEY9_CODE			0x420
 
 /* Hotkey ringbuffer limits */
 #define MAX_HOTKEY_RINGBUFFER_SIZE	100
@@ -560,7 +564,7 @@ static const struct key_entry keymap_default[] = {
 	{ KE_KEY, KEY2_CODE,            { KEY_PROG2 } },
 	{ KE_KEY, KEY3_CODE,            { KEY_PROG3 } },
 	{ KE_KEY, KEY4_CODE,            { KEY_PROG4 } },
-	{ KE_KEY, KEY5_CODE,            { KEY_RFKILL } },
+	{ KE_KEY, KEY9_CODE,            { KEY_RFKILL } },
 	/* Soft keys read from status flags */
 	{ KE_KEY, FLAG_RFKILL,          { KEY_RFKILL } },
 	{ KE_KEY, FLAG_TOUCHPAD_TOGGLE, { KEY_TOUCHPAD_TOGGLE } },
@@ -584,6 +588,18 @@ static const struct key_entry keymap_p8010[] = {
 	{ KE_END, 0 }
 };
 
+static const struct key_entry keymap_s2110[] = {
+	{ KE_KEY, KEY1_CODE, { KEY_PROG1 } }, /* "A" */
+	{ KE_KEY, KEY2_CODE, { KEY_PROG2 } }, /* "B" */
+	{ KE_KEY, KEY3_CODE, { KEY_WWW } },   /* "Internet" */
+	{ KE_KEY, KEY4_CODE, { KEY_EMAIL } }, /* "E-mail" */
+	{ KE_KEY, KEY5_CODE, { KEY_STOPCD } },
+	{ KE_KEY, KEY6_CODE, { KEY_PLAYPAUSE } },
+	{ KE_KEY, KEY7_CODE, { KEY_PREVIOUSSONG } },
+	{ KE_KEY, KEY8_CODE, { KEY_NEXTSONG } },
+	{ KE_END, 0 }
+};
+
 static const struct key_entry *keymap = keymap_default;
 
 static int fujitsu_laptop_dmi_keymap_override(const struct dmi_system_id *id)
@@ -621,6 +637,15 @@ static const struct dmi_system_id fujitsu_laptop_dmi_table[] = {
 		},
 		.driver_data = (void *)keymap_p8010
 	},
+	{
+		.callback = fujitsu_laptop_dmi_keymap_override,
+		.ident = "Fujitsu LifeBook S2110",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK S2110"),
+		},
+		.driver_data = (void *)keymap_s2110
+	},
 	{}
 };
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index dea40da86755..0528af4ed8d6 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -232,6 +232,7 @@ enum tpacpi_hkey_event_t {
 	/* Thermal events */
 	TP_HKEY_EV_ALARM_BAT_HOT	= 0x6011, /* battery too hot */
 	TP_HKEY_EV_ALARM_BAT_XHOT	= 0x6012, /* battery critically hot */
+	TP_HKEY_EV_ALARM_BAT_LIM_CHANGE	= 0x6013, /* battery charge limit changed*/
 	TP_HKEY_EV_ALARM_SENSOR_HOT	= 0x6021, /* sensor too hot */
 	TP_HKEY_EV_ALARM_SENSOR_XHOT	= 0x6022, /* sensor critically hot */
 	TP_HKEY_EV_THM_TABLE_CHANGED	= 0x6030, /* windows; thermal table changed */
@@ -3778,6 +3779,10 @@ static bool hotkey_notify_6xxx(const u32 hkey, bool *send_acpi_ev)
 		pr_alert("THERMAL EMERGENCY: battery is extremely hot!\n");
 		/* recommended action: immediate sleep/hibernate */
 		break;
+	case TP_HKEY_EV_ALARM_BAT_LIM_CHANGE:
+		pr_debug("Battery Info: battery charge threshold changed\n");
+		/* User changed charging threshold. No action needed */
+		return true;
 	case TP_HKEY_EV_ALARM_SENSOR_HOT:
 		pr_crit("THERMAL ALARM: a sensor reports something is too hot!\n");
 		/* recommended action: warn user through gui, that */
@@ -11472,6 +11477,8 @@ static int __must_check __init get_thinkpad_model_data(
 		tp->vendor = PCI_VENDOR_ID_IBM;
 	else if (dmi_name_in_vendors("LENOVO"))
 		tp->vendor = PCI_VENDOR_ID_LENOVO;
+	else if (dmi_name_in_vendors("NEC"))
+		tp->vendor = PCI_VENDOR_ID_LENOVO;
 	else
 		return 0;
 
diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 2ee6755b43f5..3019f57e6584 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -264,6 +264,9 @@ static int sun4i_spi_transfer_one(struct spi_controller *host,
 	else
 		reg |= SUN4I_CTL_DHB;
 
+	/* Now that the settings are correct, enable the interface */
+	reg |= SUN4I_CTL_ENABLE;
+
 	sun4i_spi_write(sspi, SUN4I_CTL_REG, reg);
 
 	/* Ensure that we have a parent clock fast enough */
@@ -404,7 +407,7 @@ static int sun4i_spi_runtime_resume(struct device *dev)
 	}
 
 	sun4i_spi_write(sspi, SUN4I_CTL_REG,
-			SUN4I_CTL_ENABLE | SUN4I_CTL_MASTER | SUN4I_CTL_TP);
+			SUN4I_CTL_MASTER | SUN4I_CTL_TP);
 
 	return 0;
 
diff --git a/fs/coredump.c b/fs/coredump.c
index 2b8c36c9660c..64894ba6efca 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -43,6 +43,8 @@
 #include <linux/timekeeping.h>
 #include <linux/sysctl.h>
 #include <linux/elf.h>
+#include <linux/pidfs.h>
+#include <uapi/linux/pidfd.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -60,6 +62,12 @@ static void free_vma_snapshot(struct coredump_params *cprm);
 #define CORE_FILE_NOTE_SIZE_DEFAULT (4*1024*1024)
 /* Define a reasonable max cap */
 #define CORE_FILE_NOTE_SIZE_MAX (16*1024*1024)
+/*
+ * File descriptor number for the pidfd for the thread-group leader of
+ * the coredumping task installed into the usermode helper's file
+ * descriptor table.
+ */
+#define COREDUMP_PIDFD_NUMBER 3
 
 static int core_uses_pid;
 static unsigned int core_pipe_limit;
@@ -339,6 +347,27 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
 			case 'C':
 				err = cn_printf(cn, "%d", cprm->cpu);
 				break;
+			/* pidfd number */
+			case 'F': {
+				/*
+				 * Installing a pidfd only makes sense if
+				 * we actually spawn a usermode helper.
+				 */
+				if (!ispipe)
+					break;
+
+				/*
+				 * Note that we'll install a pidfd for the
+				 * thread-group leader. We know that task
+				 * linkage hasn't been removed yet and even if
+				 * this @current isn't the actual thread-group
+				 * leader we know that the thread-group leader
+				 * cannot be reaped until @current has exited.
+				 */
+				cprm->pid = task_tgid(current);
+				err = cn_printf(cn, "%d", COREDUMP_PIDFD_NUMBER);
+				break;
+			}
 			default:
 				break;
 			}
@@ -493,7 +522,7 @@ static void wait_for_dump_helpers(struct file *file)
 }
 
 /*
- * umh_pipe_setup
+ * umh_coredump_setup
  * helper function to customize the process used
  * to collect the core in userspace.  Specifically
  * it sets up a pipe and installs it as fd 0 (stdin)
@@ -503,11 +532,32 @@ static void wait_for_dump_helpers(struct file *file)
  * is a special value that we use to trap recursive
  * core dumps
  */
-static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
+static int umh_coredump_setup(struct subprocess_info *info, struct cred *new)
 {
 	struct file *files[2];
 	struct coredump_params *cp = (struct coredump_params *)info->data;
-	int err = create_pipe_files(files, 0);
+	int err;
+
+	if (cp->pid) {
+		struct file *pidfs_file __free(fput) = NULL;
+
+		pidfs_file = pidfs_alloc_file(cp->pid, O_RDWR);
+		if (IS_ERR(pidfs_file))
+			return PTR_ERR(pidfs_file);
+
+		/*
+		 * Usermode helpers are childen of either
+		 * system_unbound_wq or of kthreadd. So we know that
+		 * we're starting off with a clean file descriptor
+		 * table. So we should always be able to use
+		 * COREDUMP_PIDFD_NUMBER as our file descriptor value.
+		 */
+		err = replace_fd(COREDUMP_PIDFD_NUMBER, pidfs_file, 0);
+		if (err < 0)
+			return err;
+	}
+
+	err = create_pipe_files(files, 0);
 	if (err)
 		return err;
 
@@ -515,10 +565,13 @@ static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
 
 	err = replace_fd(0, files[0], 0);
 	fput(files[0]);
+	if (err < 0)
+		return err;
+
 	/* and disallow core files too */
 	current->signal->rlim[RLIMIT_CORE] = (struct rlimit){1, 1};
 
-	return err;
+	return 0;
 }
 
 void do_coredump(const kernel_siginfo_t *siginfo)
@@ -593,7 +646,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		}
 
 		if (cprm.limit == 1) {
-			/* See umh_pipe_setup() which sets RLIMIT_CORE = 1.
+			/* See umh_coredump_setup() which sets RLIMIT_CORE = 1.
 			 *
 			 * Normally core limits are irrelevant to pipes, since
 			 * we're not writing to the file system, but we use
@@ -632,7 +685,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		retval = -ENOMEM;
 		sub_info = call_usermodehelper_setup(helper_argv[0],
 						helper_argv, NULL, GFP_KERNEL,
-						umh_pipe_setup, NULL, &cprm);
+						umh_coredump_setup, NULL, &cprm);
 		if (sub_info)
 			retval = call_usermodehelper_exec(sub_info,
 							  UMH_WAIT_EXEC);
diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 03ecc7765615..4503758e9594 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -1096,6 +1096,8 @@ struct nfs_server *nfs_create_server(struct fs_context *fc)
 		if (server->namelen == 0 || server->namelen > NFS2_MAXNAMLEN)
 			server->namelen = NFS2_MAXNAMLEN;
 	}
+	/* Linux 'subtree_check' borkenness mandates this setting */
+	server->fh_expire_type = NFS_FH_VOL_RENAME;
 
 	if (!(fattr->valid & NFS_ATTR_FATTR)) {
 		error = ctx->nfs_mod->rpc_ops->getattr(server, ctx->mntfh,
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 492cffd9d3d8..f9f4a92f63e9 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2690,6 +2690,18 @@ nfs_unblock_rename(struct rpc_task *task, struct nfs_renamedata *data)
 	unblock_revalidate(new_dentry);
 }
 
+static bool nfs_rename_is_unsafe_cross_dir(struct dentry *old_dentry,
+					   struct dentry *new_dentry)
+{
+	struct nfs_server *server = NFS_SB(old_dentry->d_sb);
+
+	if (old_dentry->d_parent != new_dentry->d_parent)
+		return false;
+	if (server->fh_expire_type & NFS_FH_RENAME_UNSAFE)
+		return !(server->fh_expire_type & NFS_FH_NOEXPIRE_WITH_OPEN);
+	return true;
+}
+
 /*
  * RENAME
  * FIXME: Some nfsds, like the Linux user space nfsd, may generate a
@@ -2777,7 +2789,8 @@ int nfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 	}
 
-	if (S_ISREG(old_inode->i_mode))
+	if (S_ISREG(old_inode->i_mode) &&
+	    nfs_rename_is_unsafe_cross_dir(old_dentry, new_dentry))
 		nfs_sync_inode(old_inode);
 	task = nfs_async_rename(old_dir, new_dir, old_dentry, new_dentry,
 				must_unblock ? nfs_unblock_rename : NULL);
diff --git a/fs/nfs/filelayout/filelayoutdev.c b/fs/nfs/filelayout/filelayoutdev.c
index 4fa304fa5bc4..29d9234d5c08 100644
--- a/fs/nfs/filelayout/filelayoutdev.c
+++ b/fs/nfs/filelayout/filelayoutdev.c
@@ -76,6 +76,7 @@ nfs4_fl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 	struct page *scratch;
 	struct list_head dsaddrs;
 	struct nfs4_pnfs_ds_addr *da;
+	struct net *net = server->nfs_client->cl_net;
 
 	/* set up xdr stream */
 	scratch = alloc_page(gfp_flags);
@@ -159,8 +160,7 @@ nfs4_fl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 
 		mp_count = be32_to_cpup(p); /* multipath count */
 		for (j = 0; j < mp_count; j++) {
-			da = nfs4_decode_mp_ds_addr(server->nfs_client->cl_net,
-						    &stream, gfp_flags);
+			da = nfs4_decode_mp_ds_addr(net, &stream, gfp_flags);
 			if (da)
 				list_add_tail(&da->da_node, &dsaddrs);
 		}
@@ -170,7 +170,7 @@ nfs4_fl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 			goto out_err_free_deviceid;
 		}
 
-		dsaddr->ds_list[i] = nfs4_pnfs_ds_add(&dsaddrs, gfp_flags);
+		dsaddr->ds_list[i] = nfs4_pnfs_ds_add(net, &dsaddrs, gfp_flags);
 		if (!dsaddr->ds_list[i])
 			goto out_err_drain_dsaddrs;
 		trace_fl_getdevinfo(server, &pdev->dev_id, dsaddr->ds_list[i]->ds_remotestr);
diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index e58bedfb1dcc..4a304cf17c4b 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -49,6 +49,7 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 	struct nfs4_pnfs_ds_addr *da;
 	struct nfs4_ff_layout_ds *new_ds = NULL;
 	struct nfs4_ff_ds_version *ds_versions = NULL;
+	struct net *net = server->nfs_client->cl_net;
 	u32 mp_count;
 	u32 version_count;
 	__be32 *p;
@@ -80,8 +81,7 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 
 	for (i = 0; i < mp_count; i++) {
 		/* multipath ds */
-		da = nfs4_decode_mp_ds_addr(server->nfs_client->cl_net,
-					    &stream, gfp_flags);
+		da = nfs4_decode_mp_ds_addr(net, &stream, gfp_flags);
 		if (da)
 			list_add_tail(&da->da_node, &dsaddrs);
 	}
@@ -149,7 +149,7 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 	new_ds->ds_versions = ds_versions;
 	new_ds->ds_versions_cnt = version_count;
 
-	new_ds->ds = nfs4_pnfs_ds_add(&dsaddrs, gfp_flags);
+	new_ds->ds = nfs4_pnfs_ds_add(net, &dsaddrs, gfp_flags);
 	if (!new_ds->ds)
 		goto out_err_drain_dsaddrs;
 
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index 30d2613e912b..91ff877185c8 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -60,6 +60,7 @@ struct nfs4_pnfs_ds {
 	struct list_head	ds_node;  /* nfs4_pnfs_dev_hlist dev_dslist */
 	char			*ds_remotestr;	/* comma sep list of addrs */
 	struct list_head	ds_addrs;
+	const struct net	*ds_net;
 	struct nfs_client	*ds_clp;
 	refcount_t		ds_count;
 	unsigned long		ds_state;
@@ -415,7 +416,8 @@ int pnfs_generic_commit_pagelist(struct inode *inode,
 int pnfs_generic_scan_commit_lists(struct nfs_commit_info *cinfo, int max);
 void pnfs_generic_write_commit_done(struct rpc_task *task, void *data);
 void nfs4_pnfs_ds_put(struct nfs4_pnfs_ds *ds);
-struct nfs4_pnfs_ds *nfs4_pnfs_ds_add(struct list_head *dsaddrs,
+struct nfs4_pnfs_ds *nfs4_pnfs_ds_add(const struct net *net,
+				      struct list_head *dsaddrs,
 				      gfp_t gfp_flags);
 void nfs4_pnfs_v3_ds_connect_unload(void);
 int nfs4_pnfs_ds_connect(struct nfs_server *mds_srv, struct nfs4_pnfs_ds *ds,
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index dbef837e871a..2ee20a0f0b36 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -604,12 +604,12 @@ _same_data_server_addrs_locked(const struct list_head *dsaddrs1,
  * Lookup DS by addresses.  nfs4_ds_cache_lock is held
  */
 static struct nfs4_pnfs_ds *
-_data_server_lookup_locked(const struct list_head *dsaddrs)
+_data_server_lookup_locked(const struct net *net, const struct list_head *dsaddrs)
 {
 	struct nfs4_pnfs_ds *ds;
 
 	list_for_each_entry(ds, &nfs4_data_server_cache, ds_node)
-		if (_same_data_server_addrs_locked(&ds->ds_addrs, dsaddrs))
+		if (ds->ds_net == net && _same_data_server_addrs_locked(&ds->ds_addrs, dsaddrs))
 			return ds;
 	return NULL;
 }
@@ -716,7 +716,7 @@ nfs4_pnfs_remotestr(struct list_head *dsaddrs, gfp_t gfp_flags)
  * uncached and return cached struct nfs4_pnfs_ds.
  */
 struct nfs4_pnfs_ds *
-nfs4_pnfs_ds_add(struct list_head *dsaddrs, gfp_t gfp_flags)
+nfs4_pnfs_ds_add(const struct net *net, struct list_head *dsaddrs, gfp_t gfp_flags)
 {
 	struct nfs4_pnfs_ds *tmp_ds, *ds = NULL;
 	char *remotestr;
@@ -734,13 +734,14 @@ nfs4_pnfs_ds_add(struct list_head *dsaddrs, gfp_t gfp_flags)
 	remotestr = nfs4_pnfs_remotestr(dsaddrs, gfp_flags);
 
 	spin_lock(&nfs4_ds_cache_lock);
-	tmp_ds = _data_server_lookup_locked(dsaddrs);
+	tmp_ds = _data_server_lookup_locked(net, dsaddrs);
 	if (tmp_ds == NULL) {
 		INIT_LIST_HEAD(&ds->ds_addrs);
 		list_splice_init(dsaddrs, &ds->ds_addrs);
 		ds->ds_remotestr = remotestr;
 		refcount_set(&ds->ds_count, 1);
 		INIT_LIST_HEAD(&ds->ds_node);
+		ds->ds_net = net;
 		ds->ds_clp = NULL;
 		list_add(&ds->ds_node, &nfs4_data_server_cache);
 		dprintk("%s add new data server %s\n", __func__,
diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 03f606afad93..d7a8a580d013 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -146,12 +146,9 @@ static struct oplock_info *opinfo_get_list(struct ksmbd_inode *ci)
 {
 	struct oplock_info *opinfo;
 
-	if (list_empty(&ci->m_op_list))
-		return NULL;
-
 	down_read(&ci->m_lock);
-	opinfo = list_first_entry(&ci->m_op_list, struct oplock_info,
-					op_entry);
+	opinfo = list_first_entry_or_null(&ci->m_op_list, struct oplock_info,
+					  op_entry);
 	if (opinfo) {
 		if (opinfo->conn == NULL ||
 		    !atomic_inc_not_zero(&opinfo->refcount))
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 77e6e195d1d6..76e41805b92d 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -28,6 +28,7 @@ struct coredump_params {
 	int vma_count;
 	size_t vma_data_size;
 	struct core_vma_metadata *vma_meta;
+	struct pid *pid;
 };
 
 extern unsigned int core_file_note_size_limit;
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 81ab18658d72..2cff5cafbaa7 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -211,6 +211,15 @@ struct nfs_server {
 	char			*fscache_uniq;	/* Uniquifier (or NULL) */
 #endif
 
+	/* The following #defines numerically match the NFSv4 equivalents */
+#define NFS_FH_NOEXPIRE_WITH_OPEN (0x1)
+#define NFS_FH_VOLATILE_ANY (0x2)
+#define NFS_FH_VOL_MIGRATION (0x4)
+#define NFS_FH_VOL_RENAME (0x8)
+#define NFS_FH_RENAME_UNSAFE (NFS_FH_VOLATILE_ANY | NFS_FH_VOL_RENAME)
+	u32			fh_expire_type;	/* V4 bitmask representing file
+						   handle volatility type for
+						   this filesystem */
 	u32			pnfs_blksize;	/* layout_blksize attr */
 #if IS_ENABLED(CONFIG_NFS_V4)
 	u32			attr_bitmask[3];/* V4 bitmask representing the set
@@ -234,9 +243,6 @@ struct nfs_server {
 	u32			acl_bitmask;	/* V4 bitmask representing the ACEs
 						   that are supported on this
 						   filesystem */
-	u32			fh_expire_type;	/* V4 bitmask representing file
-						   handle volatility type for
-						   this filesystem */
 	struct pnfs_layoutdriver_type  *pnfs_curr_ld; /* Active layout driver */
 	struct rpc_wait_queue	roc_rpcwaitq;
 	void			*pnfs_ld_data;	/* per mount point data */
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 7986145a527c..5a7745170e84 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -175,6 +175,11 @@ struct hfsc_sched {
 
 #define	HT_INFINITY	0xffffffffffffffffULL	/* infinite time value */
 
+static bool cl_in_el_or_vttree(struct hfsc_class *cl)
+{
+	return ((cl->cl_flags & HFSC_FSC) && cl->cl_nactive) ||
+		((cl->cl_flags & HFSC_RSC) && !RB_EMPTY_NODE(&cl->el_node));
+}
 
 /*
  * eligible tree holds backlogged classes being sorted by their eligible times.
@@ -1040,6 +1045,8 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	if (cl == NULL)
 		return -ENOBUFS;
 
+	RB_CLEAR_NODE(&cl->el_node);
+
 	err = tcf_block_get(&cl->block, &cl->filter_list, sch, extack);
 	if (err) {
 		kfree(cl);
@@ -1572,7 +1579,7 @@ hfsc_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 	sch->qstats.backlog += len;
 	sch->q.qlen++;
 
-	if (first && !cl->cl_nactive) {
+	if (first && !cl_in_el_or_vttree(cl)) {
 		if (cl->cl_flags & HFSC_RSC)
 			init_ed(cl, len);
 		if (cl->cl_flags & HFSC_FSC)
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 13ffc9a6555f..dce568091200 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6813,7 +6813,10 @@ static void alc256_fixup_chromebook(struct hda_codec *codec,
 
 	switch (action) {
 	case HDA_FIXUP_ACT_PRE_PROBE:
-		spec->gen.suppress_auto_mute = 1;
+		if (codec->core.subsystem_id == 0x10280d76)
+			spec->gen.suppress_auto_mute = 0;
+		else
+			spec->gen.suppress_auto_mute = 1;
 		spec->gen.suppress_auto_mic = 1;
 		spec->en_3kpull_low = false;
 		break;

