Return-Path: <stable+bounces-155227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70124AE2829
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 10:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF54A3BCDCE
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 08:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1E81DE4CD;
	Sat, 21 Jun 2025 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6WeohGO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4191940A2
	for <stable@vger.kernel.org>; Sat, 21 Jun 2025 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750495947; cv=none; b=TuDiWhCD7UEvB94wscJ26ul89EJEuDmqSLp/wgPxX4YgwVEjDKaGnxTemXDUBsQg4cruP8R3nhY5AIqte9TZZOCcoJktCety/dpWLTXT1XjlfJDx032P2PIiaCPHr3lFI6jtWQX0Qva7k3a4R4/Tr66R4v6Fx1cjJOYD2j89SXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750495947; c=relaxed/simple;
	bh=x/sRTqZHuzcT//yR6ELkEI+/4VL+JCdznyR2HKm8BGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ofp4q5TDPkFLT8fCAphXWj6yP679zSdAx5LFKJ7RtSD38Tn39rPnbbzz3KwiEbpPtm85y9nUUuolZ6pCpm4qzodGcr3eeJqxPdRdoeUgnKMRWqpqQK2JivvZqFY6iTbMDFjOEBAkSQZ+VnUPzHgeBleAZqpEYK6tSaGullaDK2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6WeohGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CC5C4CEE7;
	Sat, 21 Jun 2025 08:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750495947;
	bh=x/sRTqZHuzcT//yR6ELkEI+/4VL+JCdznyR2HKm8BGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m6WeohGO+w0msvGky5I7Yp65yXjtdBElPq7pTKdvaBYzzuWjC/SXXIGIL3rJXZzBM
	 TY9Nh2gyh0JxVsrfIyKhUasi9IN1Yq5W2ql3YAFmUGMRVYSL32JpfDnXB3AT5CRiIw
	 TacyTtEN8ZfOS+1UQaDvp/lYlaKXNmNh5KwdsYzU0ximhoVileNUa5vSslMcG/h6dW
	 5YWk3mIXuPywc+5qFPQB2DPtwxI9ESGSBRze1cew2vnLA+8+UUvNLIt92ipNrL/tdf
	 VPmDqoWMg30RaIPQLVHrdptVs3v3XXVTYZCcAY+SLOVpDNlDOWBilfgDF+TFUKnuzY
	 7Lys/dsboRAuw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH for 6.6 2/2] ARM: dts: am335x-bone-common: Increase MDIO reset deassert delay to 50ms
Date: Sat, 21 Jun 2025 04:52:25 -0400
Message-Id: <20250621014723-43fcdb24b96ff37e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <1750381796-6607-2-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
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

Note: The patch differs from the upstream commit:
---
1:  929d8490f8790 ! 1:  c4225ee1fae71 ARM: dts: am335x-bone-common: Increase MDIO reset deassert delay to 50ms
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
     
      ## arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi ##
     @@ arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi: ethphy0: ethernet-phy@0 {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

