Return-Path: <stable+bounces-155214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73781AE281A
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 10:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A86917C646
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 08:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874DE1C8629;
	Sat, 21 Jun 2025 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1MtnT/x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4836E149C41
	for <stable@vger.kernel.org>; Sat, 21 Jun 2025 08:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750495900; cv=none; b=suAn1YDPghwsv2ahTuNGX7IyIcH4ycsc+SRAyn16N6Xc/rLcDv8ODvoVXMZeDmSuMjA490VxIrcB7WrkMHbSCKxEPG9WPoA/OjN1LQ6uJgF4kmFKjSef2nsQ3vBTFsWMfm3ak/hx7tF2C6bETGcTcLwAAn7WPYAXNx+yC09Zz4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750495900; c=relaxed/simple;
	bh=vGITNdve9Ir3rAcpuXIZ9QM71vp2b5k1Xf+WjS2DR1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PxwNdkO8k0kHthc9D8i2QUrOl9Du0Dd3BIGJBNxouqLKpZU5iUMs660NHUlkEmFwB4Ncdxscv9NhWnn7EguRSKLRD1B2crCc6oNPlrbcevdO/sdk9Ky3ssOaa9XZi1p5qoWdlgXtpfmDZGfarw9ppUjkbDKOVntWZ9EODhuWDR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1MtnT/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53AC7C4CEE7;
	Sat, 21 Jun 2025 08:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750495899;
	bh=vGITNdve9Ir3rAcpuXIZ9QM71vp2b5k1Xf+WjS2DR1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K1MtnT/xKfGAj+LiIfxfO/jJCLGK3wgaLfPdoVpfhRsZb5mxqccdA9MYwU7h2KgMw
	 uryOc7TC04VHneOYUjEb+Uim/vQdRddaxWGk4WZOLwfVe2m6IIfqYDD/sXzZYabU3B
	 tpqr+dC9b34jSp8TIJbDLf3rKRT/3O88fOg1sMi9tt62gYxWdGsRTVEgZAH3lYYel/
	 ZN4tNJNGQ8M4Ue+sNWMprPqHAWl8HDjAzED8n+FEXXe7GL39MP8qCI9EaYBUkgWHi7
	 DkwJg6U4n1dhfvjFNorl+q5zhO/E4cESTTpQ/uH0oMu7NX3K3B2dbWcxfLi0Rfnx2R
	 5ActNlk8sQjLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH for 6.6 1/2] ARM: dts: am335x-bone-common: Increase MDIO reset deassert time
Date: Sat, 21 Jun 2025 04:51:38 -0400
Message-Id: <20250621013633-5bbfe838ce707cf3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <1750381796-6607-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: b9bf5612610aa7e38d58fee16f489814db251c01

WARNING: Author mismatch between patch and upstream commit:
Backport author: Nobuhiro Iwamatsu<nobuhiro1.iwamatsu@toshiba.co.jp>
Commit author: Colin Foster<colin.foster@in-advantage.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  b9bf5612610aa ! 1:  b61bb04ce6bad ARM: dts: am335x-bone-common: Increase MDIO reset deassert time
    @@ Metadata
      ## Commit message ##
         ARM: dts: am335x-bone-common: Increase MDIO reset deassert time
     
    +    commit b9bf5612610aa7e38d58fee16f489814db251c01 upstream.
    +
         Prior to commit df16c1c51d81 ("net: phy: mdio_device: Reset device only
         when necessary") MDIO reset deasserts were performed twice during boot.
         Now that the second deassert is no longer performed, device probe
    @@ Commit message
         Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
         Link: https://lore.kernel.org/r/20240531183817.2698445-1-colin.foster@in-advantage.com
         Signed-off-by: Kevin Hilman <khilman@baylibre.com>
    +    Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro1.iwamatsu@toshiba.co.jp>
     
      ## arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi ##
     @@ arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi: ethphy0: ethernet-phy@0 {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

