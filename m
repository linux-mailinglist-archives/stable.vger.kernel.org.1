Return-Path: <stable+bounces-131817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DDEA81262
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 18:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A89A4885D4D
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 16:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DDC22ACDC;
	Tue,  8 Apr 2025 16:27:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B255C158DD8
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744129648; cv=none; b=dAUgkFsB/gkTM784OHdr7zvpMRHLxoWO4pRN9W5BNqPQ+VcBKxXpK1O4f+y7incVID0UgbyPZZs2ENreogxRt7/xRfWZ8luzojfHWQl8RLhqMh8Or93JIUeRqOCaM7ACAJGRlQPExGJ80uwhhXJqMEKRUfIw8RQW3yXWGAhb1m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744129648; c=relaxed/simple;
	bh=jraddQt3yagLvV8BWrff5xJ1EkB7n97hinVVXFIVI4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2yiA11toWihkoa5Gkj0pbLTkIjd2jEkzp01N42klCLkKychmRl30ZxnGrXP18y9IO+zvmUKkbA8XkijRC22ddVuBcbLUmMG4ywOcgfe8SSflGy6S3t3ejobZxdzYmwx/1gD3+zgre0k2LcjaLOFqg6BWijmMKBFazdmfKEi2kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1789CC4CEE5;
	Tue,  8 Apr 2025 16:27:26 +0000 (UTC)
Date: Tue, 8 Apr 2025 17:27:24 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	will@kernel.org, robh@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH 6.13.y 0/7] arm64/boot: Enable EL2 requirements for
 FEAT_PMUv3p9
Message-ID: <Z_VObETYYOHdym9N@arm.com>
References: <20250408093859.1205615-1-anshuman.khandual@arm.com>
 <2025040816-frequent-unbundle-7415@gregkh>
 <d3a5589f-a231-4d60-9d70-5e0f01dff125@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3a5589f-a231-4d60-9d70-5e0f01dff125@arm.com>

On Tue, Apr 08, 2025 at 03:34:51PM +0530, Anshuman Khandual wrote:
> On 4/8/25 15:23, Greg KH wrote:
> > On Tue, Apr 08, 2025 at 03:08:52PM +0530, Anshuman Khandual wrote:
> >> This series adds fine grained trap control in EL2 required for FEAT_PMUv3p9
> >> registers like PMICNTR_EL0, PMICFILTR_EL0, and PMUACR_EL1 which are already
> >> being used in the kernel. This is required to prevent their EL1 access trap
> >> into EL2.
> >>
> >> The following commits that enabled access into FEAT_PMUv3p9 registers have
> >> already been merged upstream from 6.13 onwards.
> >>
> >> d8226d8cfbaf ("perf: arm_pmuv3: Add support for Armv9.4 PMU instruction counter")
> >> 0bbff9ed8165 ("perf/arm_pmuv3: Add PMUv3.9 per counter EL0 access control")
> >>
> >> The sysreg patches in this series are required for the final patch which
> >> fixes the actual problem.
> > 
> > But you aren't going to fix the 6.14.y tree?  We can't take patches that
> > skip newer stable releases for obvious reasons.
> > 
> > And 6.13.y is only going to be alive for a few more days, is there some
> > specific reason this is needed now for 6.13.y?
> 
> I have also sent same series for 6.14 stable version as well. It will be
> great to have these patches applied both on 6.13 as well 6.14. Thank you.

TBH, 6.13 is end of life soon, so not sure it's worth carrying those
patches. Do you have a reason for this Anshuman?

-- 
Catalin

