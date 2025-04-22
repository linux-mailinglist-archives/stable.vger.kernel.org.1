Return-Path: <stable+bounces-135179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8002A9754A
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 21:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B630F17F634
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 19:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BFA297A64;
	Tue, 22 Apr 2025 19:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gejZ6tfX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9D5B666
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 19:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745349476; cv=none; b=J9B6WNDW37vCReJzmfxGrsStMn+pGe8ZWGInOc+ZaQbjplFO/y6lrrWOYYIkEUeFlDH5HhVFIplLmFoz08BmU35AzTOlPeF+qVZRailcAYq+NHUHmt93upKJfJlKffg7Bn1IRJxV6uLpVH3SrEKDyDqhaVIgAN21pUjdGO9Y7v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745349476; c=relaxed/simple;
	bh=PnwgcYUFQzJ5WXbdXf0WdTzVE8CyvPZofTV+0642Axw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZdz7Mjh2O3+tRoZwUUre4K/nQ9P2AKlk8tQ88R0Beizu5BGsiiIxOV01n0y3OvuDXrU8FT3RgYxQic1JzCe0NDPQCwMuMDSal8c+1B/RgGQ+YCVsI7y/5yJd8b5ogG1IySOPneo7D6T8qCY2UdxS5bIomH5MK0Q2iYmsrQdij0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gejZ6tfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1FA7C4CEE9;
	Tue, 22 Apr 2025 19:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745349475;
	bh=PnwgcYUFQzJ5WXbdXf0WdTzVE8CyvPZofTV+0642Axw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gejZ6tfXLmIylfcb6iwkBN0gqxsicP9ciKmkjrxFysw2obxdA3W0b1VDA3K9npw+d
	 +q7Pufb3rioRS4hzm5BKdxte4+E7n/kEkPPoei3uVKIVckzafbe/fCYal85d/tJmt7
	 xqpUWgRK7RfDJ9e9dNfvNG5N0lO6bfFkiAep2tiLIiGRe/5rLyCnht0us6V+reoHW2
	 FGF2cgjoS57pp85cYw0Dp+NAkOwqZhmLB0i7hySKwp4I5Um9qZSlYqU6TY/W4XlbJ/
	 u7n1tyu5jxvhUGE+zm79X5E83fVNXGNtRk3Qul0CZPENoARwwx64oh2Ag2TnXX53wb
	 oBCWqj33+n4qw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: WangYuli <wangyuli@uniontech.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4+] MIPS: cevt-ds1287: Add missing ds1287.h include
Date: Tue, 22 Apr 2025 15:17:51 -0400
Message-Id: <20250422115637-928ade71320dac29@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <CB3E3A9CEA5227BE+20250422091648.116984-1-wangyuli@uniontech.com>
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

The upstream commit SHA1 provided is correct: f3be225f338a578851a7b607a409f476354a8deb

Status in newer kernel trees:
6.14.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f3be225f338a5 ! 1:  76449fe1f2e7d MIPS: cevt-ds1287: Add missing ds1287.h include
    @@ Metadata
      ## Commit message ##
         MIPS: cevt-ds1287: Add missing ds1287.h include
     
    +    [ Upstream commit f3be225f338a578851a7b607a409f476354a8deb ]
    +
         Address the issue of cevt-ds1287.c not including the ds1287.h header
         file.
     
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

