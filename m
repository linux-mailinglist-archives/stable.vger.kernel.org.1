Return-Path: <stable+bounces-155213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6681BAE2818
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 10:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D5EE17C8AF
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 08:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB4B1DE4CD;
	Sat, 21 Jun 2025 08:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6t5I0YM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEAF149C41
	for <stable@vger.kernel.org>; Sat, 21 Jun 2025 08:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750495860; cv=none; b=TV6/pwaACD2d+yAGNHGWS4C8xlUn0zST0WkoUQ7eGTB0hDescov5zcEX/Ty4UoFvXZyHf6BrXrnhGer6Haytuje7w5Ye0ELCaFKBt86J2F+vxWWgqfWr+7qOZRZUAXVU895wXv3SNL1UCD1XR8E5lMe7HUY3JHHUyIKZYTzw8lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750495860; c=relaxed/simple;
	bh=5NUFk/zymHJXCx4Y4Al1V5mX9IndT/Ve/MIZiqi1/1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PIBXAtw2MIjNQFVp9Hzo6af1sXhljZ+Z0BCXeJ4oa9GZd/SOCuKxAo0SqBQ9Qio+Lze2WmAEDXnAmGN7X4DDHdvzlQXbsPFcFTzWRjhK3wTNzUQRSZGDopNSocOkg+Y/eairin7wDwqiInHZcoiDuq4NiRWsCy72VuGdJotJn40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6t5I0YM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391B6C4CEE7;
	Sat, 21 Jun 2025 08:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750495859;
	bh=5NUFk/zymHJXCx4Y4Al1V5mX9IndT/Ve/MIZiqi1/1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X6t5I0YM1z6bxkkPMRSwaIyYy/qfMHVQpKE2qF8f6CWNqACZ5zY+X4rnD84y9KWf+
	 AOq3y6N7jB/4tJkvZI+13/vGsrbcWyI7dlPM//HxA9g79oiRbuZxVuQyinKnhOcLBG
	 a9EcX/p2Py2BdkQq3GtgkW3cMIJXfVgdkwXtDleb3CgkzNs3POlHy9uPQAaJKES/hL
	 +m4YudUfgvaAjcMd9q1IaimiOfCGbhivwpPhjWhkfJ9k4fmSEBZ6sxZ+g4k9k0sYyU
	 IkdiY5Vf777HG5SZ3R8KOYCBhIbwdNJuMasHBQbmhM/SCv+LKUM+w2glIH/I5g5FZm
	 xWrI/L5YGKLhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH for 5.4 - 6.1 1/3] ARM: dts: am335x-bone-common: Add GPIO PHY reset on revision C3 board
Date: Sat, 21 Jun 2025 04:50:58 -0400
Message-Id: <20250621042012-6f3bb7a44693cded@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <1750381987-6825-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
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

The upstream commit SHA1 provided is correct: 623cef652768860bd5f205fb7b741be278585fba

WARNING: Author mismatch between patch and upstream commit:
Backport author: Nobuhiro Iwamatsu<nobuhiro1.iwamatsu@toshiba.co.jp>
Commit author: Shengyu Qu<wiagn233@outlook.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  623cef6527688 ! 1:  01338e4054b9b ARM: dts: am335x-bone-common: Add GPIO PHY reset on revision C3 board
    @@ Metadata
      ## Commit message ##
         ARM: dts: am335x-bone-common: Add GPIO PHY reset on revision C3 board
     
    +    commit 623cef652768860bd5f205fb7b741be278585fba upstream.
    +
         This patch adds ethernet PHY reset GPIO config for Beaglebone Black
         series boards with revision C3. This fixes a random phy startup failure
         bug discussed at [1]. The GPIO pin used for reset is not used on older
    @@ Commit message
         Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
         Message-ID: <TY3P286MB26113797A3B2EC7E0348BBB2980FA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
         Signed-off-by: Tony Lindgren <tony@atomide.com>
    +    Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro1.iwamatsu@toshiba.co.jp>
     
    - ## arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi ##
    + ## arch/arm/boot/dts/am335x-bone-common.dtsi ##
     @@
      			/* MDIO */
      			AM33XX_PADCONF(AM335X_PIN_MDIO, PIN_INPUT_PULLUP | SLEWCTRL_FAST, MUX_MODE0)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

