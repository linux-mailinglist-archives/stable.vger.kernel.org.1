Return-Path: <stable+bounces-110982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0D5A20E50
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 17:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E6587A1344
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 16:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7831A8F79;
	Tue, 28 Jan 2025 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tehSMgB6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7C91917D9
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738081066; cv=none; b=Vp+HV28tqPxGReXM8fUhJiZ03QcPuVxNCJQUKRK8TkyFIkVoNcSLnZbqFo1q3h4zOYhiR2Hey5PPAm2u/hWOJKMXskHQejAKxvO7hdrtZaB0s3soco29BX0ifQyiFAvqspe/QqWKZoPjFz604ifzVN8TwjXANaKooN24BiukgFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738081066; c=relaxed/simple;
	bh=+M8DoEqII/T8gYlCLuhhciHVSWQrv5yZq/OGTwcXKQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m/70AKs6GcnhtMxLWlVZQCsGHzC0mGxuvKwM1f4ROYj34Hz5SeUNOL3gd6pZVBSbXzwA0GVath2+ZLoG619QaWMvExUE6/JA6jHuBO6sfNEGJWFfLx/pOR3jrx9GJM8UwgWhT4/EkSwxOFk/Ew6XJwhL7u+DTJj/dxsLWEnONXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tehSMgB6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B84AC4CED3;
	Tue, 28 Jan 2025 16:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738081066;
	bh=+M8DoEqII/T8gYlCLuhhciHVSWQrv5yZq/OGTwcXKQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tehSMgB6YeuGarLWK6oatJStVQJN1UrwDpP/jpQu+Hb2LPPHj+IQ/F9vG9fjzDvfX
	 l/ZwOf7/E1FdaCzqU2zSjD6Zpy4QxGCWZvyouaddwJAziEljVGsYQZGNuUYIiwpdLL
	 eijrZWqW8Cl9nZrVu2mG7D7e1N6XkUez56cNuz+252n5x8Uy98eTyDAcjzNS/FbhkZ
	 XxK/6zq8NZNWKQ2hgt/qzutTmaJcDhWDJsaiYanaYikdBLA0J6TTPj+7osoPqzy8L5
	 O3HJND9lb1aE/NVISvZlfayTvEYGdNBN0px5F6pwOoTGmZEdas0GcSe2S2ZbFWDJie
	 4PXGwwavMynoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] scsi: storvsc: Ratelimit warning logs to prevent VM denial of service
Date: Tue, 28 Jan 2025 11:17:44 -0500
Message-Id: <20250127160159-907603d824080966@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250127182908.66971-1-eahariha@linux.microsoft.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: d2138eab8cde61e0e6f62d0713e45202e8457d6d


Status in newer kernel trees:
6.13.y | Branch not found
6.12.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  d2138eab8cde6 ! 1:  eff28b745a790 scsi: storvsc: Ratelimit warning logs to prevent VM denial of service
    @@ Metadata
      ## Commit message ##
         scsi: storvsc: Ratelimit warning logs to prevent VM denial of service
     
    +    commit d2138eab8cde61e0e6f62d0713e45202e8457d6d upstream
    +
         If there's a persistent error in the hypervisor, the SCSI warning for
         failed I/O can flood the kernel log and max out CPU utilization,
         preventing troubleshooting from the VM side. Ratelimit the warning so
    @@ Commit message
         Link: https://lore.kernel.org/r/20250107-eahariha-ratelimit-storvsc-v1-1-7fc193d1f2b0@linux.microsoft.com
         Reviewed-by: Michael Kelley <mhklinux@outlook.com>
         Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
    +    Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
     
      ## drivers/scsi/storvsc_drv.c ##
     @@ drivers/scsi/storvsc_drv.c: do {								\
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

