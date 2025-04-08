Return-Path: <stable+bounces-128876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF55A7FAE3
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25CDD7A59F5
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59332266EF4;
	Tue,  8 Apr 2025 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O/LIZ4WX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AB7215066
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 09:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744106089; cv=none; b=swQAyY7wJS6bQyl4LYncNcdCUcWJaYMkvs3vI3pDz/mx7Vwljpy84SONv3P2TutMHAnQp8FjZmCDD3/4t8dNAL761OblrMkeV9Z+oNyZcT4CzmnXU404+UFJI6xgrY0W0UCg0kIbUtFFhK/+n4dV2Se5/HTc0oxCvHPbg8FTopk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744106089; c=relaxed/simple;
	bh=L7S/h3Q7eEUMkAq6mjIrsrkM3s2/mg/10BzmHEDPO+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biTfFjrr7va3Fr2WyNHrc0pXWcC3PREIXXpvEhKyXFa7s0lL4To+4oGt6meEc3z2bfD5gaSfnq8rd9KK9NXpaMhRBLFtXrGo9HTlujM/r7VUWTB1x1O5zzzWt6ogvPWJdO4BNecvLwBw0fFfb8No97GQNlc0mRt1ou03BnXfVMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O/LIZ4WX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192E7C4CEEA;
	Tue,  8 Apr 2025 09:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744106088;
	bh=L7S/h3Q7eEUMkAq6mjIrsrkM3s2/mg/10BzmHEDPO+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O/LIZ4WX0j1mDv1QLwhon2ERlPoX1V8k85YOIwiiZp0cHq6nLySnUZEvuNK0G6YS3
	 4V4GfHfNYCy6T3dBl9wTc7ryUXG+FFaDf1j9r2UGsz9Pl/bIT07sK9CC9fDZoWXVSE
	 9dXBdFumSq+IMki7TvAt1+QzUkowuwyppbGthXMk=
Date: Tue, 8 Apr 2025 11:53:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: stable@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
	robh@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH 6.13.y 0/7] arm64/boot: Enable EL2 requirements for
 FEAT_PMUv3p9
Message-ID: <2025040816-frequent-unbundle-7415@gregkh>
References: <20250408093859.1205615-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408093859.1205615-1-anshuman.khandual@arm.com>

On Tue, Apr 08, 2025 at 03:08:52PM +0530, Anshuman Khandual wrote:
> This series adds fine grained trap control in EL2 required for FEAT_PMUv3p9
> registers like PMICNTR_EL0, PMICFILTR_EL0, and PMUACR_EL1 which are already
> being used in the kernel. This is required to prevent their EL1 access trap
> into EL2.
> 
> The following commits that enabled access into FEAT_PMUv3p9 registers have
> already been merged upstream from 6.13 onwards.
> 
> d8226d8cfbaf ("perf: arm_pmuv3: Add support for Armv9.4 PMU instruction counter")
> 0bbff9ed8165 ("perf/arm_pmuv3: Add PMUv3.9 per counter EL0 access control")
> 
> The sysreg patches in this series are required for the final patch which
> fixes the actual problem.

But you aren't going to fix the 6.14.y tree?  We can't take patches that
skip newer stable releases for obvious reasons.

And 6.13.y is only going to be alive for a few more days, is there some
specific reason this is needed now for 6.13.y?

thanks,

greg k-h

