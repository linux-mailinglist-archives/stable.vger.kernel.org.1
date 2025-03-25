Return-Path: <stable+bounces-126021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019C7A6F429
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69E043B8136
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC08255E55;
	Tue, 25 Mar 2025 11:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KexE4QaU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC99BA36
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902423; cv=none; b=h8ABMkqHFosK9L1l/5tW6sW45ZVuexm3NyIIFbSe6Vw+XA/CuvwehB+sWph+sw9cG+Bx6cDA8Vrv3xEg513rPH9xoyn770WJIJGavmHiidDcudYajVL84tlC1WQ/nuL7xmi7cfo+Pv6rMRulVsp3eS/+SzEvWbYUSQRe5uPAjv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902423; c=relaxed/simple;
	bh=PZYhz0PDlzqrBKOBc1J1XsYpzytHfXdslIYNYH8O27U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FbIN8RVdE59hDoIIdbo56Z6IFz3/q6KRLhSm7gIpxDF6hv9mx/jm0XA5qOjKvTWrBXhNR+MAD5PvT0eWMb8FCO+K7QQweWQpB+nwZ0M6JANUH8b2lRB4R+U1wYR2F9J7LgEvlVIOFzW47Y3vpEM8VVHi+Ce+Iz9V2w6FNLwbfEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KexE4QaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C20EC4CEE8;
	Tue, 25 Mar 2025 11:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902422;
	bh=PZYhz0PDlzqrBKOBc1J1XsYpzytHfXdslIYNYH8O27U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KexE4QaUTVoeAtogh0schbVtvNagpC0C3qCpVOKDhdIgLSb0npV4eVGMSg5eAFlwE
	 JotqvWUed6Jpg3S+IuZX59yJwoANUQJ9DfxULx0ldZGo7UkerzDyMedqktfZ2c8i3X
	 yf+N/7T4s3RaK2aLfJCda7f7kwJdAEYzbVzFlhz/dbZkAOmpyVjlztbBpK8RgeQuK/
	 Cl69PIx+dstIrJ/arA6GZXgd0Vpy6rVsGmrIWcncHOz4mJCnNW5DKuQWWZHIOc57a8
	 BEYuIE9zufl8Dvh6+qdV5N3v8zGp8kWij1nUIo5jCdwOnYhEyJCSwf/8UdxNN+G4kB
	 TeCr0+f2anScg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	justin@tidylabs.net
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] arm64: dts: rockchip: fix u2phy1_host status for NanoPi R4S
Date: Tue, 25 Mar 2025 07:33:41 -0400
Message-Id: <20250324204329-f86301e0975263a6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250324184509.13634-1-justin@tidylabs.net>
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

Note: The patch differs from the upstream commit:
---
1:  38f4aa34a5f73 ! 1:  3cb1d28a1d80f arm64: dts: rockchip: fix u2phy1_host status for NanoPi R4S
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
| stable/linux-6.6.y        |  Success    |  Success   |

