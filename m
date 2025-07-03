Return-Path: <stable+bounces-160104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35541AF8035
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 20:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978BD584180
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 18:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113802F2726;
	Thu,  3 Jul 2025 18:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qqkvnzyr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69A92F272C
	for <stable@vger.kernel.org>; Thu,  3 Jul 2025 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751567686; cv=none; b=Pz+prgtnSVOEWf/WbO86ylxS6SesVzxckPGYDltHYsRmZ1yGNg0t6sKlQWhHob7Qkw+fkIZ5z6eWHrc84clYelHON2kS7+f0NKILOiksQ0EeXPiQtpHX/GRJ10qSL2jKyGuj14meZ90mXdanRTZSLXnt3ES/L+BM7RCxHfo04TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751567686; c=relaxed/simple;
	bh=V5+dObnmeh1LIkck8geWwcVvuw1HDeRHLKrVLTYI/j4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ArD9PG+qSz7lY9wVEuJyF0hWPebifsu2BPVA7TltOl4XapT/cgH4xmfSmGwlQ06mMSqYDOJJueumqbspQHKGjrkS9yY0czf4wuCaEYdJ0/WOEoEOTnHblmIlFMwTl2uKYYCkfktZt8/znSK7rwiLMcZQB6sRXkdR/CqDJW0QjPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qqkvnzyr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9D9C4CEE3;
	Thu,  3 Jul 2025 18:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751567686;
	bh=V5+dObnmeh1LIkck8geWwcVvuw1HDeRHLKrVLTYI/j4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QqkvnzyrQnRu5L1gcFeO7fyY0ze2EnLnqRBHpYY5be+/Fjm0tIYwzeKGF7GD4mt2f
	 eEfv8j3UUKzbh0RdL5ki0wne+FRanO9wDiQs6tzvDM7tqGR2tXjEeLOxo10xacqb1E
	 IwQgeK3FvXooyHNQ1tBvkbZ/Qd1XM+iLwqCXuHBaInwUKfzQB7nr+WajBODt/1bttd
	 ky0UIbKAhk8Nmsy8Ab3Do7eaUbZJgUnZtcIRA0zqbABVU+JSWz35nX9I5yhZ8YbDxS
	 5gXuQ/EgyYCoQF6w5Ocz9epeonCQGdB6CcVGCxvCNbbhki7DRLhs5B2eI+9XxNLKiT
	 3jMKm3Q5myGhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: mathieu.tortuyaux@gmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y v2 1/3] r8169: add support for RTL8125D
Date: Thu,  3 Jul 2025 14:34:45 -0400
Message-Id: <20250703114005-f7e405804919c955@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250702102807.29282-2-mathieu.tortuyaux@gmail.com>
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

The upstream commit SHA1 provided is correct: f75d1fbe7809bc5ed134204b920fd9e2fc5db1df

WARNING: Author mismatch between patch and upstream commit:
Backport author: mathieu.tortuyaux@gmail.com
Commit author: Heiner Kallweit<hkallweit1@gmail.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  f75d1fbe7809b ! 1:  ad11b51351b91 r8169: add support for RTL8125D
    @@ Metadata
      ## Commit message ##
         r8169: add support for RTL8125D
     
    +    commit f75d1fbe7809bc5ed134204b920fd9e2fc5db1df upstream.
    +
         This adds support for new chip version RTL8125D, which can be found on
         boards like Gigabyte X870E AORUS ELITE WIFI7. Firmware rtl8125d-1.fw
         for this chip version is available in linux-firmware already.
    @@ Commit message
         Reviewed-by: Simon Horman <horms@kernel.org>
         Link: https://patch.msgid.link/d0306912-e88e-4c25-8b5d-545ae8834c0c@gmail.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    Signed-off-by: Mathieu Tortuyaux <mtortuyaux@microsoft.com>
     
      ## drivers/net/ethernet/realtek/r8169.h ##
     @@ drivers/net/ethernet/realtek/r8169.h: enum mac_version {
    @@ drivers/net/ethernet/realtek/r8169_main.c: static void rtl_hw_start_8125b(struct
     +
      static void rtl_hw_start_8126a(struct rtl8169_private *tp)
      {
    - 	rtl_set_def_aspm_entry_latency(tp);
    + 	rtl_disable_zrxdc_timeout(tp);
     @@ drivers/net/ethernet/realtek/r8169_main.c: static void rtl_hw_config(struct rtl8169_private *tp)
      		[RTL_GIGA_MAC_VER_53] = rtl_hw_start_8117,
      		[RTL_GIGA_MAC_VER_61] = rtl_hw_start_8125a_2,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

