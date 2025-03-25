Return-Path: <stable+bounces-126019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 910BFA6F422
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687B91891955
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC63B255E47;
	Tue, 25 Mar 2025 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spKz3BDV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6102C1E7C28
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902419; cv=none; b=BFejIT5cJg2x6e0uY1YTYOJI3aTv1caIz/lTCP/rvDPK/5Y4OBAYhbUehBFTj9n/3gBPcAP79v7KCnb0H3va8ame1l1guh1DwQhFuqEcVntQnIluk7eOPq6EWHKjp8CGIzwW1UzZLqvvv3f/w0YfMrFTvvU//D0SsR/fZN/PpV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902419; c=relaxed/simple;
	bh=wetoO1pfWYFQWdKUZygwrc6aR8ZqLBTUIUZ6aJCDXDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HXDycAoTVFVzpoPzVS1JPSUYnlQBrqXQQsphbjhJ8CpcxRWILegoYC23Gb/09P7fTgTYHI0sa/t7EMMZLx1fKgF/uh56TSUP/LLTdOPCs0YPZBwYqfOLyMIs/yAEhLjaWZ2VA4h8ZhKiDLMzMBEdx/wkU5Y3uSj2rrK0H9zruyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spKz3BDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE70C4CEF4;
	Tue, 25 Mar 2025 11:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902418;
	bh=wetoO1pfWYFQWdKUZygwrc6aR8ZqLBTUIUZ6aJCDXDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=spKz3BDVeLgPXiqI0zGPSAOEnIxOsrmZY2YL3JnpNyOBMj+tcORDT8uFr7DIQ+Tk8
	 qlDs21kAOB+RskrlfpPZVUfGDua6EvCU49qGhuR5WW7rYIWNCi3RJKHOA/KNB/xM94
	 SUJUH+ihVdut/s86VCSgq+VSN21qx9fGKi9eNqB7Ai2SYGrVwMjFeoCmtwvqF3LACR
	 vL3R5kZHpvn4upAJjPyo9Pn3hJFV1a9K6Gh7WCEJlFv6qTh4clKyhfXjgl+hrJkrGs
	 FWF0ODnWUDPE2Z+jZ7cu2of3VSKHBES1xg0/0BuC5OYXaYx+fUf0GgogYJ1MUreduK
	 nQ13yeQaL+XIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	justin@tidylabs.net
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] arm64: dts: rockchip: fix u2phy1_host status for NanoPi R4S
Date: Tue, 25 Mar 2025 07:33:37 -0400
Message-Id: <20250324212536-2d7ea99374a0528d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250324182725.6771-1-justin@tidylabs.net>
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

Note: The patch differs from the upstream commit:
---
1:  38f4aa34a5f73 ! 1:  ea6155299db0c arm64: dts: rockchip: fix u2phy1_host status for NanoPi R4S
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
| stable/linux-6.12.y       |  Success    |  Success   |

