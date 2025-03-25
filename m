Return-Path: <stable+bounces-126026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80231A6F443
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B545A168A1E
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0AF255E51;
	Tue, 25 Mar 2025 11:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJvhTOD7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CB3255E47
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902433; cv=none; b=a4PpfoMxMvsHPTLtL1Z6vE9N965RS1o82E1wMJ78WS6kWw+p0u1xLQtY+vR7f5y4WJ5Q45SqfAx+KxRgjPBj+gSSbAPmo/i7scsN+zAxdnqrhakcr+R7mHG4L+uvuWdvPfbaJ75BHx3U+R3tBMyOsX3S+WdvwbvfNLEQElg88Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902433; c=relaxed/simple;
	bh=bYIcer3OXeZ9Qw1dXyT2MeB4veIUVLph4ycTyHwyLDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uv+gglE+emraJiYfk8r7NWwDAQyX/8Z5HO4cfg2ZA+J1XIwOByHwYDpzKBOoLdpFeR8pqHAia2fSemsNjRAdjelqVd9OiHhSFeC4HwLSA/fvKkCgfun21iyLEghWlI3nsDoZfALnDWOOV2D2V5dX8QZcGSvxMvbKhNuB5pRT/Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJvhTOD7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D02C4CEE4;
	Tue, 25 Mar 2025 11:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902432;
	bh=bYIcer3OXeZ9Qw1dXyT2MeB4veIUVLph4ycTyHwyLDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TJvhTOD7SYZx1yq8CcH6piflylCk3DOeDbjnMVT5xxtuONFKYYhO1VXOKtImTPgvU
	 mvEG7LizpJdvRMeNWsklYtRkbPcrORqfmWC/ll5xc3ymsW38WXAKEPk3oRVx6g22dr
	 jZgieupfk6k+D2dmirDbE2Zwv6t36AxgnTFrWqDF+9WQC0KpRlYe6FYgUBMMa3s1il
	 TaWSMlRsXvOKm4ltfcXcWa8acKCBOZApSxsy8eX1VvHox2I216+bJyGbdkaNUK9A51
	 jeGoAGOHlgyOpvZP/VSqkOSR9U+pWzROu5oDyzJ0JD8L+viVyTl2IkOasMSHdNyhF2
	 oAgt/EcI5pAKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	justin@tidylabs.net
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] arm64: dts: rockchip: fix u2phy1_host status for NanoPi R4S
Date: Tue, 25 Mar 2025 07:33:51 -0400
Message-Id: <20250324215642-00f0c5205e1c40b1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250324184949.15360-1-justin@tidylabs.net>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 38f4aa34a5f737ea8588dac320d884cc2e762c03

Status in newer kernel trees:
6.13.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  38f4aa34a5f73 ! 1:  48176801077a3 arm64: dts: rockchip: fix u2phy1_host status for NanoPi R4S
    @@ Commit message
         Reviewed-by: Dragan Simic <dsimic@manjaro.org>
         Link: https://lore.kernel.org/r/20250225170420.3898-1-justin@tidylabs.net
         Signed-off-by: Heiko Stuebner <heiko@sntech.de>
    +    (cherry picked from commit 38f4aa34a5f737ea8588dac320d884cc2e762c03)
     
    - ## arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtsi ##
    -@@ arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dtsi: &u2phy0_host {
    + ## arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts ##
    +@@ arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts: &u2phy0_host {
      };
      
      &u2phy1_host {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

