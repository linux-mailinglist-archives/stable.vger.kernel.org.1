Return-Path: <stable+bounces-155219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687B7AE2825
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 10:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1718E3B0293
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 08:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647361E5711;
	Sat, 21 Jun 2025 08:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBzFWRJQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2533A1CD208
	for <stable@vger.kernel.org>; Sat, 21 Jun 2025 08:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750495924; cv=none; b=ggYBTn6H2/R/KOU3qHNwrGO0DtussO6D12FlEPhfXRcU7MrLQHLjXym3ChfA3tmBa7jdmQuzb6M3x0TQeMZlOFnHRzZU5Gjjzr+1ZLu0nQMDEPoOld+tC7drZNo38LRVjRUN5GzkJMciBzsxoNP+EIDqN1UD5FLxN+pZgRfGiTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750495924; c=relaxed/simple;
	bh=2SL0DSQwrrDru8Q6g/zMVYYCiw7wJGmpNj2kbUHhYfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I5K9y649rmt/EzIDFpOgrkwtgOk3l9S4sNu62AA3hTYtGZol+jVlp8mt1fyYgBRl+tSxwps9x6on7FFlNFy3KGIcjo1QaO8iWIserwC6WTNr+s6ucUgjjZYWYtJ6q4KXFidaCqCbmEK5ydyu6Oe6XopzincZmiYpEY9WqmAtMbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBzFWRJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345F9C4CEE7;
	Sat, 21 Jun 2025 08:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750495923;
	bh=2SL0DSQwrrDru8Q6g/zMVYYCiw7wJGmpNj2kbUHhYfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TBzFWRJQWoeDYnJn5L4aw9CyRFP4g6+KqLo6T5ziPJBQkoFHxMJ2qLYwmelKc4IXl
	 7VwWevFoChYAynjccDsisyrjE+OAZsXOPQCOowL491raeQS3UVHGSSUsX649+4j830
	 h9NjvkS6AKHT1HtFc7colVLbfDob/Tk1u0RnXfsRRRlyJoVYOD6DGDsPBpR/DyAMhr
	 DvkfwFO92dC4MQwHk7q6Pjys6MYn9z5J4/EqGZRgmitSxUYtN6A8O4GYuJlcSX+hro
	 onX86aJRiszC9bVX+qkPS2Waqn0vbgU5R+RARchhpOCjpMcUVvkUFQ1XUW32A1GTzQ
	 C0I7WsKP6vNMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH for 5.4 - 6.1 2/3] ARM: dts: am335x-bone-common: Increase MDIO reset deassert time
Date: Sat, 21 Jun 2025 04:52:01 -0400
Message-Id: <20250621043352-d0d76b4e54dc34b2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <1750381987-6825-2-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
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
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  b9bf5612610aa ! 1:  7fd9ee5fc5ba5 ARM: dts: am335x-bone-common: Increase MDIO reset deassert time
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

