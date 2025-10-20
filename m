Return-Path: <stable+bounces-188223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E56EBF2C20
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 19:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7367D422C9F
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A423321AB;
	Mon, 20 Oct 2025 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XNVUUYSX"
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04559331A6E
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 17:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981887; cv=none; b=WBdebLBRauFSJP8AgjbyptESfHJv8gWUxJeJzJi6RWxGGDoGzgLq1V5LUOPlzZ9BkrVEgEdzWk+nqtvMDp3EofR2anqodAkh+Cc6zNHhyqBUtHfCrpzu3tufmqiHECX4dCgkD1uNdtj1kg+/AmzR67MuYu6KA+rKVDMleDKU/Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981887; c=relaxed/simple;
	bh=HyONp9SDFUvToD2djEWjeSAjDu5g/rm65NEkKfwa9DI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=deqJPxbcshIBvvfX063nHKZ+TqqT5qK9VjRzfU55U/+WzKCQvwHCRd8GfN+XC1MO8w+vvu+wkhDnnYIHBAei5YuUanoEc7tO2PTx353vQONjSVvqE3dqos5oyF632UoDgrC76h3tQqs2a8I58MNRGzz06J5f6Lk9EsyKpNY2F+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XNVUUYSX; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760981883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e99xTgMttofpW0WaDhiAOUSsPXarnQfS2XRpB+6Ob3o=;
	b=XNVUUYSXz/dK1hDKqslxUlb8vFi30IHGSFFK1G7/a26PcVXiFXiz6cgTjTlxgi+74nSTap
	WfmWpnlZRYxtaG2WtEjOVH6ZOkAp95lEznUEBA41bV2KXO3n7d0Lde3dgHLWfcUke1JWt4
	vk20RYdL8pWozB8qTPh8YuXTTs8X2Bw=
From: Wen Yang <wen.yang@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jon Hunter <jonathanh@nvidia.com>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pierre Gondois <pierre.gondois@arm.com>,
	Thierry Reding <treding@nvidia.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 6.1 10/10] arm64: tegra: Update cache properties
Date: Tue, 21 Oct 2025 01:36:24 +0800
Message-Id: <20251020173624.20228-11-wen.yang@linux.dev>
In-Reply-To: <20251020173624.20228-1-wen.yang@linux.dev>
References: <20251020173624.20228-1-wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Pierre Gondois <pierre.gondois@arm.com>

[ Upstream commit 27f1568b1d5fe35014074f92717b250afbe67031 ]

The DeviceTree Specification v0.3 specifies that the cache node
'compatible' and 'cache-level' properties are 'required'. Cf.
s3.8 Multi-level and Shared Cache Nodes
The 'cache-unified' property should be present if one of the
properties for unified cache is present ('cache-size', ...).

Update the Device Trees accordingly.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 15 +++++++++++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi |  1 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 33 ++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 41f3a7e188d0..ed2a534dcfd6 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -3029,36 +3029,51 @@ core1 {
 		};
 
 		l2c_0: l2-cache0 {
+			compatible = "cache";
+			cache-unified;
 			cache-size = <2097152>;
 			cache-line-size = <64>;
 			cache-sets = <2048>;
+			cache-level = <2>;
 			next-level-cache = <&l3c>;
 		};
 
 		l2c_1: l2-cache1 {
+			compatible = "cache";
+			cache-unified;
 			cache-size = <2097152>;
 			cache-line-size = <64>;
 			cache-sets = <2048>;
+			cache-level = <2>;
 			next-level-cache = <&l3c>;
 		};
 
 		l2c_2: l2-cache2 {
+			compatible = "cache";
+			cache-unified;
 			cache-size = <2097152>;
 			cache-line-size = <64>;
 			cache-sets = <2048>;
+			cache-level = <2>;
 			next-level-cache = <&l3c>;
 		};
 
 		l2c_3: l2-cache3 {
+			compatible = "cache";
+			cache-unified;
 			cache-size = <2097152>;
 			cache-line-size = <64>;
 			cache-sets = <2048>;
+			cache-level = <2>;
 			next-level-cache = <&l3c>;
 		};
 
 		l3c: l3-cache {
+			compatible = "cache";
+			cache-unified;
 			cache-size = <4194304>;
 			cache-line-size = <64>;
+			cache-level = <3>;
 			cache-sets = <4096>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 724e87450605..9474b0da0a3e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -2005,6 +2005,7 @@ CPU_SLEEP: cpu-sleep {
 
 		L2: l2-cache {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 876c73a00a54..e09a4fd8364c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -2907,117 +2907,150 @@ core3 {
 		};
 
 		l2c0_0: l2-cache00 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c0>;
 		};
 
 		l2c0_1: l2-cache01 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c0>;
 		};
 
 		l2c0_2: l2-cache02 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c0>;
 		};
 
 		l2c0_3: l2-cache03 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c0>;
 		};
 
 		l2c1_0: l2-cache10 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c1>;
 		};
 
 		l2c1_1: l2-cache11 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c1>;
 		};
 
 		l2c1_2: l2-cache12 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c1>;
 		};
 
 		l2c1_3: l2-cache13 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c1>;
 		};
 
 		l2c2_0: l2-cache20 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c2>;
 		};
 
 		l2c2_1: l2-cache21 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c2>;
 		};
 
 		l2c2_2: l2-cache22 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c2>;
 		};
 
 		l2c2_3: l2-cache23 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c2>;
 		};
 
 		l3c0: l3-cache0 {
+			compatible = "cache";
+			cache-unified;
 			cache-size = <2097152>;
 			cache-line-size = <64>;
 			cache-sets = <2048>;
+			cache-level = <3>;
 		};
 
 		l3c1: l3-cache1 {
+			compatible = "cache";
+			cache-unified;
 			cache-size = <2097152>;
 			cache-line-size = <64>;
 			cache-sets = <2048>;
+			cache-level = <3>;
 		};
 
 		l3c2: l3-cache2 {
+			compatible = "cache";
+			cache-unified;
 			cache-size = <2097152>;
 			cache-line-size = <64>;
 			cache-sets = <2048>;
+			cache-level = <3>;
 		};
 	};
 
-- 
2.25.1


