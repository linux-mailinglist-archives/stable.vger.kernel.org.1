Return-Path: <stable+bounces-160113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F719AF8049
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 20:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 441DC7BAE2F
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 18:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692772F6FA5;
	Thu,  3 Jul 2025 18:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhQTMytl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2997A2F6FA0
	for <stable@vger.kernel.org>; Thu,  3 Jul 2025 18:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751567709; cv=none; b=MNbLpIoUtFN9LPvS7Mmwxwe2ptXn+PIl4K7TedB5iXJ/AzrlCx/Ud0auRXnQ/t6Vk2rHEe2TlEb1/t47f8syaG2VJbD7nARE/DmYR89pJCZr2Brbyygjc5Q0Nt/WhLBwMhyo5FJ9fcHWgbwS6yQljY9jIdtE4alpNne4AfmA7f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751567709; c=relaxed/simple;
	bh=QF5VyTVEsW1DW/uQ60tIfdo5Muz0HnjMN8R7m/igdKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GLwk2pnxm11j4rL6NvC7vzJrwBdSdZlZ1dSR0/pBafbu+Kt68KGkXJWosDtv89xmSd4REwQMI/SmHSLFb/q1J1+i3MpXZ5q5FQnSDBATst+ONUg9126zSPYCaq0apCpkt16+tTv+DPv6EOcGlKoDe0BG1SQ/xVA6zEsv21op6TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhQTMytl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0D6C4CEE3;
	Thu,  3 Jul 2025 18:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751567708;
	bh=QF5VyTVEsW1DW/uQ60tIfdo5Muz0HnjMN8R7m/igdKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AhQTMytljLh6UKXJmLtIXb2OVL/u7nQsKu7jAsRxzhCNtkeZZL0CPyAGMBwrnFUw6
	 4SrQ4gELo2v5oCNK4Sl4+obeXRsaHsbqPLEgW7ctmaco0pfsOByLRBcFasv+Z1wKY3
	 LDleKhV2yr4gEH3zOp1Z/wD3YtbPHzXIjRPDLwTfB+EU6HzhiIhKb7DV+WErk809nO
	 RJnNSo5lg0WDpq8M82C2qRPdXZ7b/HacmPRTQ6euxYY6ErUEQUjbN3UVWFAVXuAaM2
	 SG/605fcDV9ugtyN4M2GtullHUDzQu18n+rzUpjCNZe+A8R0o88r/ELQXA4d0Vah4k
	 845aQ1+Gti+AQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: mathieu.tortuyaux@gmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y v2 3/3] net: phy: realtek: add RTL8125D-internal PHY
Date: Thu,  3 Jul 2025 14:35:07 -0400
Message-Id: <20250703115105-c8cef1df15a6bdd0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250702102807.29282-4-mathieu.tortuyaux@gmail.com>
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

The upstream commit SHA1 provided is correct: 8989bad541133c43550bff2b80edbe37b8fb9659

WARNING: Author mismatch between patch and upstream commit:
Backport author: mathieu.tortuyaux@gmail.com
Commit author: Heiner Kallweit<hkallweit1@gmail.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  8989bad541133 ! 1:  6b77f3ae0a112 net: phy: realtek: add RTL8125D-internal PHY
    @@ Metadata
      ## Commit message ##
         net: phy: realtek: add RTL8125D-internal PHY
     
    +    commit 8989bad541133c43550bff2b80edbe37b8fb9659 upstream.
    +
         The first boards show up with Realtek's RTL8125D. This MAC/PHY chip
         comes with an integrated 2.5Gbps PHY with ID 0x001cc841. It's not
         clear yet whether there's an external version of this PHY and how
    @@ Commit message
         Message-ID: <7d2924de-053b-44d2-a479-870dc3878170@gmail.com>
         Reviewed-by: Andrew Lunn <andrew@lunn.ch>
         Signed-off-by: Andrew Lunn <andrew@lunn.ch>
    +    Signed-off-by: Mathieu Tortuyaux <mtortuyaux@microsoft.com>
     
      ## drivers/net/phy/realtek.c ##
     @@ drivers/net/phy/realtek.c: static int rtl_internal_nbaset_match_phy_device(struct phy_device *phydev)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.15.y       |  Success    |  Success   |

