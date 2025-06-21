Return-Path: <stable+bounces-155226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E17DAE2828
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 10:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E18A3BC9EC
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 08:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C8B1DE4CD;
	Sat, 21 Jun 2025 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Va9ukvFS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425C61CD208
	for <stable@vger.kernel.org>; Sat, 21 Jun 2025 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750495945; cv=none; b=QQQEbwHdwh4FBLUNBK2kmXDips4TJKp8MQ0ZWwcrxeurat0M/hImCqLWh8js16cAJ9+WKxn7996N7kV4NhRs/gMuTBwMgGq+NY/CODkEIEbjxAdjq4k34tqUSM60riLN1WyeMdVARyNsQ86nrMbdLTcG8bvkIDCFPIYrkSmwX14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750495945; c=relaxed/simple;
	bh=IUl0JBpInk3JQguk2tK1OVd6HHI0FLw0+sHTMd+h13s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mv9NMvybdId8ygJPBHcbydWmZJv9m3KoW8gcNougp5lFs6YQoiN4KMrCD+x90bjNyBMxay/NvyQBG7lCgO6ET8BF2f7K64DHprPe37jYiMJiq300urQ4a6oGVIyvX2Itr2Dim+FA70BeQd/2PT3gq2oveAi1m9Qiyk07wFaAVqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Va9ukvFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1C2C4CEE7;
	Sat, 21 Jun 2025 08:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750495945;
	bh=IUl0JBpInk3JQguk2tK1OVd6HHI0FLw0+sHTMd+h13s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Va9ukvFSw9B9Hxi/lSaTImKH1T5/iQD575tFA9HsUn9Q82cOaZxLXdGy9yHMJve9v
	 fAwO4gGM4v0gNpHPW15StVBDcqLDhjSm5Trm4nIY6VlAtZDuNNcsIjl10IG6UqO464
	 L5OcOBzctwNqL7jGUDAh4VcslY3obrCOWWutmlxv/0K5e4vvKYYnJgvfWNNSqe0D7l
	 Y3tIg6HmO57o959jrKzQjIttXWihkwjo0OECwnoCh+nfwBrQaecGFVVJjpZFTN76Vi
	 fUn+hdWcV/ERykLsGzj54gzhBsCazZdgEHRk21rYs8zuUOIlZTvDczYu/NWpVn8/vC
	 RDoTbvuMVE4SQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH for 5.4 - 6.1 3/3] ARM: dts: am335x-bone-common: Increase MDIO reset deassert delay to 50ms
Date: Sat, 21 Jun 2025 04:52:23 -0400
Message-Id: <20250621044640-27f28dfdf8238bd0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <1750381987-6825-3-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
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

The upstream commit SHA1 provided is correct: 929d8490f8790164f5f63671c1c58d6c50411cb2

WARNING: Author mismatch between patch and upstream commit:
Backport author: Nobuhiro Iwamatsu<nobuhiro1.iwamatsu@toshiba.co.jp>
Commit author: Geert Uytterhoeven<geert+renesas@glider.be>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  929d8490f8790 ! 1:  2eb5c6492555c ARM: dts: am335x-bone-common: Increase MDIO reset deassert delay to 50ms
    @@ Metadata
      ## Commit message ##
         ARM: dts: am335x-bone-common: Increase MDIO reset deassert delay to 50ms
     
    +    commit 929d8490f8790164f5f63671c1c58d6c50411cb2 upstream.
    +
         Commit b9bf5612610aa7e3 ("ARM: dts: am335x-bone-common: Increase MDIO
         reset deassert time") already increased the MDIO reset deassert delay
         from 6.5 to 13 ms, but this may still cause Ethernet PHY probe failures:
    @@ Commit message
         Reviewed-by: Roger Quadros <rogerq@kernel.org>
         Link: https://lore.kernel.org/r/9002a58daa1b2983f39815b748ee9d2f8dcc4829.1730366936.git.geert+renesas@glider.be
         Signed-off-by: Kevin Hilman <khilman@baylibre.com>
    +    Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro1.iwamatsu@toshiba.co.jp>
     
    - ## arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi ##
    + ## arch/arm/boot/dts/am335x-bone-common.dtsi ##
     @@
      		/* Support GPIO reset on revision C3 boards */
      		reset-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

