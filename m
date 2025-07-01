Return-Path: <stable+bounces-159102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A612AEEBF4
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 03:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8805D3E08F4
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 01:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E600195808;
	Tue,  1 Jul 2025 01:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHmuTv3L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E04B19007D
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 01:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751332545; cv=none; b=C20y1NccNHlaET8uZ5wzdRBGSpPY7diRHf7vnx9qhluYk0GsVhJiH6GuobtIDnaIWQmXQsA/V7xYki9JFlxugzqBtZxMM49ZiH3Be81dkXwuvdpSNnJNvire9DF3TnjsWPOWr7PhPrJsgqwBrhWi7qZ93CDKzWatU+4vthSwy/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751332545; c=relaxed/simple;
	bh=yMlazPylH8BURpNQKjg8iyEdrxflxLAD5y4SChVQptU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OsdtiPc6QGGmcQMALch2Hy42SENSirTU+wIKkit9lhg8460o69RR3pbzhlX23UIAL2AzY2j42OiM+JUYPeFKK54gYhwRLpGdRJvHkhrquMPsS/QxtAWPLrX8bx8G5+L1FM7ukVt15/AQ2nUOF3HdHVTj3Zim8du7AR3khS8ydyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHmuTv3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403B7C4CEE3;
	Tue,  1 Jul 2025 01:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751332542;
	bh=yMlazPylH8BURpNQKjg8iyEdrxflxLAD5y4SChVQptU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RHmuTv3LZD+aZE7pLSc9CgMPkRRga0uGtaJGxK1OcXOr9gPwV2yT50gCAZCY7u9kn
	 gThTDVH+wlMzky8FW5oBduqiT6yhugbyBHqBJN9TAd2csgAUaCyMinnfek/FfAsI8Z
	 UA9lvO3jGCXFvf5hospYkRFOVWcVHVSAERUAhCbq4OWUeoMq/mrdbSB0JbXGpXKr21
	 dAOf2he7LEKbsdDNJR1Z9Ncx63OaCZQJ0LS5I9ThKSTEsgoYXYX3rtE0nLoF1mOcXV
	 Fuz24n9z78xE5pKwZtW3ngmzllQxGCJGck5K3FMbM3zKvhy7I7OxNgkxJK55jM0IE6
	 zrnOGGh8GQBIw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: mathieu.tortuyaux@gmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y 1/3] r8169: add support for RTL8125D
Date: Mon, 30 Jun 2025 21:15:40 -0400
Message-Id: <20250630190500-dcb442c394cb3d70@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250630142717.70619-2-mathieu.tortuyaux@gmail.com>
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
1:  f75d1fbe7809b ! 1:  2e19ef032703b r8169: add support for RTL8125D
    @@ Metadata
      ## Commit message ##
         r8169: add support for RTL8125D
     
    +    commit f75d1fbe7809bc5ed134204b920fd9e2fc5db1df upstream.
    +
         This adds support for new chip version RTL8125D, which can be found on
         boards like Gigabyte X870E AORUS ELITE WIFI7. Firmware rtl8125d-1.fw
         for this chip version is available in linux-firmware already.
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

