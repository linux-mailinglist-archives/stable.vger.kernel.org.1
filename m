Return-Path: <stable+bounces-196019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01413C79932
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 14:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 893724EB13A
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 13:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2A919E97F;
	Fri, 21 Nov 2025 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YrDA5GMe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760123F9D2;
	Fri, 21 Nov 2025 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763732330; cv=none; b=N6hn6POnjJGt8HaV/ZVBQw6OVgNbeN4/1HZHfy6XReAq5ZL7CjBaK0mNUDUKg7afFKGoyn+RWa0yvhDtIIEBbgdz3TTLOdnnNZqtMmX4TbfTtxGKbaWuzjNw8LwcoIt//66SgRnClOXllaVq77DLvnT3TvCQHt4DzS/6OoxHCos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763732330; c=relaxed/simple;
	bh=a/Gk1NgWzd7v5bA+yE/jEck58tl9UCfYKYO8MZUP7hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QdmvFmEciVl6H0A3ATz0UNQX3Pyh7XFxq2ALHQJUNd3PvXIDlUZde9Uhyt+p2ZaipxxlYX1kxLIrE9D66zGBJnwOqeeCsZeQfVY5tGk+AJ4X+iwKyLp0KMrNIdhkmMIFq83LPX7Xt6EPAGaU2/cciahnSUvHJKKJLh3S3fE6s8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YrDA5GMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FD7C4CEF1;
	Fri, 21 Nov 2025 13:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763732330;
	bh=a/Gk1NgWzd7v5bA+yE/jEck58tl9UCfYKYO8MZUP7hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YrDA5GMeP9ameYWijfD9PCJTzhM1PUxaAXWuGYng//6hHCwktZIUmfguXAumxrbmx
	 YacA3oCSUEnEqUMx2J+X27iuPwYMkxtRZzQW7jatd//wegaL4T0J4FWXV3F2/kAhLC
	 aCZuozQjvAgAbdbYP+x3W/wO6uFaWgSaOy/5ma6w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	Winona Schroeer-Smith <wolfizen@wolfizen.net>,
	Antoni Aloy Torrens <aaloytorrens@gmail.com>
Subject: [PATCH 6.6 083/529] ARM: tegra: transformer-20: add missing magnetometer interrupt
Date: Fri, 21 Nov 2025 14:06:22 +0100
Message-ID: <20251121130233.973735739@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251121130230.985163914@linuxfoundation.org>
References: <20251121130230.985163914@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Svyatoslav Ryhel <clamor95@gmail.com>

[ Upstream commit cca41614d15ce2bbc2c661362d3eafe53c9990af ]

Add missing interrupt to magnetometer node.

Tested-by: Winona Schroeer-Smith <wolfizen@wolfizen.net> # ASUS SL101
Tested-by: Antoni Aloy Torrens <aaloytorrens@gmail.com> # ASUS TF101
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/nvidia/tegra20-asus-tf101.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/nvidia/tegra20-asus-tf101.dts b/arch/arm/boot/dts/nvidia/tegra20-asus-tf101.dts
index a3757b7daeda4..408cec997adb3 100644
--- a/arch/arm/boot/dts/nvidia/tegra20-asus-tf101.dts
+++ b/arch/arm/boot/dts/nvidia/tegra20-asus-tf101.dts
@@ -502,6 +502,9 @@
 			compatible = "asahi-kasei,ak8974";
 			reg = <0xe>;
 
+			interrupt-parent = <&gpio>;
+			interrupts = <TEGRA_GPIO(N, 5) IRQ_TYPE_EDGE_RISING>;
+
 			avdd-supply = <&vdd_3v3_sys>;
 			dvdd-supply = <&vdd_1v8_sys>;
 
-- 
2.51.0




