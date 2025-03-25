Return-Path: <stable+bounces-126023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 372F6A6F42A
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B653B82CD
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B4D1F0E31;
	Tue, 25 Mar 2025 11:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPkvDqCR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6E61E7C28
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902427; cv=none; b=Ju73y1gJRsK58VyY7r66J/HIDtOT4z0l091oaPN64/YycgfVt2in2aTifHhR3BD8LFQ3jxetUBI743nO/g9ejVKlE502aiTvD1qr98NvvLvDS++WObsKrN9UPY7S1zFromMEKnMAM9g7FrfBBbNTVVV8j/oY4zwvTyDNdB7afas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902427; c=relaxed/simple;
	bh=7jvc4NV8imfZSWaxSoCZNdQ8HG9WBrF6YHur5J2haDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVpo6j2Tnt0MsTBt9Jib+dGj32JdkSj0MDYJuweHFrldVjT9kCr8hiHoD0/wPa3TapTjUA4JAHHcIZetmpYL+ayN/y+eejx0LNTuLCU8djsdHDg2z2iBE1AVDfvkX/kwM/QUxTrzKaCVe8WRXmVPRgoUBwRDRnrrl8Rd3P/c1Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPkvDqCR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF60C4CEE4;
	Tue, 25 Mar 2025 11:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902426;
	bh=7jvc4NV8imfZSWaxSoCZNdQ8HG9WBrF6YHur5J2haDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YPkvDqCRU5IcQFo8zrhri2iFu3rVUKRiZNlQwLRrGngYnS1M7Pl012ptVN5f2HwdW
	 mYw23trl/9Hg10lPMH7Z8tvQfVTPCYy3HIu5DHx/FKs8FqGO7Oyvqvke4jiRAol3WC
	 LnodPRuGfoTXWmWlzUocOn4evgR6Y8DjTMTO2phoAC5pFCy8Fhnq35RlX+xsIBzVq5
	 0lb61dYm+2YDzVJa1PUNLRTFRVvwxIJhn/jhzf0SfSww0G2FQcGi//lx5EdXc6rNd7
	 OY3NU8uw8hqF8Q3D2sZ+lD/LeVzXSEpaNCiHkjI3g9qbDUyjjg2A3qSal9vzzjU87x
	 PdZQZdgdjF7Lw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	justin@tidylabs.net
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] arm64: dts: rockchip: fix u2phy1_host status for NanoPi R4S
Date: Tue, 25 Mar 2025 07:33:45 -0400
Message-Id: <20250324232049-26a6a6a3d6927fa8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250324184137.11437-1-justin@tidylabs.net>
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

Note: The patch differs from the upstream commit:
---
1:  38f4aa34a5f73 ! 1:  cbd4da3045ec2 arm64: dts: rockchip: fix u2phy1_host status for NanoPi R4S
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
| stable/linux-6.1.y        |  Success    |  Success   |

