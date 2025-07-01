Return-Path: <stable+bounces-159099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE0EAEEBF7
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 03:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E27A3A9D19
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 01:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2581991B2;
	Tue,  1 Jul 2025 01:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3NW/bmI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0DD198A11
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 01:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751332534; cv=none; b=mRwGtrzfuf7l6s5uveYD3Xvv7GBgNTQyQuPx6mCm8uaB8kg39o7OETlel8wJfIDLLvGb72MDCbQTy/F0M0hma+QKgSwbl+G0YqslCnHTcW+sEoRut+vtXfrqUG5AT+tvbV/8bmYmit9pMJhUibOZPnXgf1NRxqw+Agk49lzAuxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751332534; c=relaxed/simple;
	bh=e9BISKT4PJAhQfLNgXagGJ+cCuGvIDn1Yvh+acve8yc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AY8ySWHh94K1GY+PTPnHNR1T+Ms3JwWnHQy3twdzOL7A4pZnrvUpqZqwnwXb3ai5S4THTo4uhZAZ734EhC4DMEdMXfjuehoUzJttV8AxADfgeqtcV1D8WKpeELiPeaLng6EY98a7dDd5e9UIkiNRDL3xK+aHa8Tkl3cS29wHNRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3NW/bmI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDD5C4CEE3;
	Tue,  1 Jul 2025 01:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751332533;
	bh=e9BISKT4PJAhQfLNgXagGJ+cCuGvIDn1Yvh+acve8yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3NW/bmIJ2QSKUUFxpeFiDopuxIbwhq4R/mS3X5srnqSQFtkiOPWRkVUBb08L8buD
	 XrEqgMA4GMTgjn+lIvhpM9EKORM7RwKr7LuWJsYMbznbHq9cRzfHlWU0js6Etu0gwh
	 kGtwr6PSnXj77oBHAOGVM4d58rCWJPpUbjFpoA19VCS3afcmhBnmF6E+KrFfTyG8Im
	 cPBCxsTwHqF51iUde7rz7J8IM1iX9ZPzHFxdpDYnGGC34aLYeEUhHNycyTYVIsnPw2
	 jdPMFjYvAorNDGmBIHSyWjs/Xi+ubLrJ6QsgC6/BMUYMPViRyBHqxyoioemUSfktPi
	 HAqsYEFLjc4MA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: mathieu.tortuyaux@gmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y 3/3] net: phy: realtek: add RTL8125D-internal PHY
Date: Mon, 30 Jun 2025 21:15:31 -0400
Message-Id: <20250630191241-9fe84aa9e4eecbe8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250630142717.70619-4-mathieu.tortuyaux@gmail.com>
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
1:  8989bad541133 ! 1:  4de3b40cf2625 net: phy: realtek: add RTL8125D-internal PHY
    @@ Metadata
      ## Commit message ##
         net: phy: realtek: add RTL8125D-internal PHY
     
    +    commit 8989bad541133c43550bff2b80edbe37b8fb9659 upstream.
    +
         The first boards show up with Realtek's RTL8125D. This MAC/PHY chip
         comes with an integrated 2.5Gbps PHY with ID 0x001cc841. It's not
         clear yet whether there's an external version of this PHY and how
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.15.y       |  Success    |  Success   |

