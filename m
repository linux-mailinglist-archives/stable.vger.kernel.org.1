Return-Path: <stable+bounces-145037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 177F2ABD24C
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 10:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB51162168
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 08:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5402E25DB0C;
	Tue, 20 May 2025 08:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fv6v/mTN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08B825D91D
	for <stable@vger.kernel.org>; Tue, 20 May 2025 08:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747730924; cv=none; b=i2+ftpVBPa8rFyAxTIZDQcKEnurZu8zed4qP+9U4/Ij4CWWmMkq6FV7X8f7hx81N+WeTyLYWKhFoBNMLSVGGNZ+GjtXWP74s2qtayJ5sfwAEnwABSxAuV2aPVu+Krej3L/kUp8CQGJdROXbkDRl9/g2HItfdgWmyEekhhpdIT1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747730924; c=relaxed/simple;
	bh=3+QrHJBHF8R+YSGX23QGZF6yQMjgjcscgRaZepOutdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDt2YvUX64EzSpdkl8ZWGcM8m5TPaV/j2Xfag5sIz2l7vjnlmVPoRsMvuTrzeDEW6UUknWNzkjf9hNPVC2KUlR3Wf8TOl63K/RC7c/t2r1hozyzvvUurnT871TYiNC934HXVh8msrfMLI8JJ7PH7yg3/RYkSaxRelXhhpRDPlkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fv6v/mTN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC46C4CEE9;
	Tue, 20 May 2025 08:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747730923;
	bh=3+QrHJBHF8R+YSGX23QGZF6yQMjgjcscgRaZepOutdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fv6v/mTNfbG9t25yhv2vGtJxHtb82+Ea3GRtkgSBv6jdFObcuGdFsWkV/+1uQy9+X
	 NFQszH69KM8s0fJlC6Ml6sCGam7kC21Kkisda+cf+6v4hB0YssnbzQ05E6ipeaTDB+
	 5aQIDevYr/ObwAnIyRdg/BtuT6dIUJ11BsfwZxLg=
Date: Tue, 20 May 2025 10:48:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	Natanael Copa <ncopa@alpinelinux.org>
Subject: Re: [PATCH 6.6] x86/its: Fix build error for its_static_thunk()
Message-ID: <2025052057-prognosis-hush-bf23@gregkh>
References: <20250519195021.mgldcftlu5k4u5sw@desk>
 <20250519-its-build-fix-6-6-v1-1-225ac41eb447@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519-its-build-fix-6-6-v1-1-225ac41eb447@linux.intel.com>

On Mon, May 19, 2025 at 01:43:42PM -0700, Pawan Gupta wrote:
> Due to a likely merge resolution error of backport commit 772934d9062a
> ("x86/its: FineIBT-paranoid vs ITS"), the function its_static_thunk() was
> placed in the wrong ifdef block, causing a build error when
> CONFIG_MITIGATION_ITS and CONFIG_FINEIBT are both disabled:
> 
>   /linux-6.6/arch/x86/kernel/alternative.c:1452:5: error: redefinition of 'its_static_thunk'
>    1452 | u8 *its_static_thunk(int reg)
>         |     ^~~~~~~~~~~~~~~~
> 
> Fix it by moving its_static_thunk() under CONFIG_MITIGATION_ITS.
> 
> Reported-by: Natanael Copa <ncopa@alpinelinux.org>
> Link: https://lore.kernel.org/all/20250519164717.18738b4e@ncopa-desktop/
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
> commit ("x86/its: FineIBT-paranoid vs ITS") was resolved correctly in
> v6.12:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.12.29&id=7e78061be78b8593df9b0cd0f21b1fee425035de
> 
> Fix is required in v6.6 and v6.1

Thanks for this, now queued up for 6.6.y, but I think 6.1.y is ok, as
this didn't apply there, nor did I get any build reports of problems for
it yet.  So I'll leave that be for now.

greg k-h

