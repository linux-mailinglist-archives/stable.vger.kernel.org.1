Return-Path: <stable+bounces-200280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7410ACAAFD4
	for <lists+stable@lfdr.de>; Sun, 07 Dec 2025 01:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ADCF630093A7
	for <lists+stable@lfdr.de>; Sun,  7 Dec 2025 00:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3331DF246;
	Sun,  7 Dec 2025 00:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7ngEJ45"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264AF1D130E
	for <stable@vger.kernel.org>; Sun,  7 Dec 2025 00:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765067878; cv=none; b=kLT7fBolMgwTpzVVHtmMNZnnOomS75DTtgXgOZ3dBuFdvBcYR8onVPLFlZeDV0ln9n1qCaR7I/wdH8u9mF8EdlmJndZ2XeQylP5i2OTAWZi9OklZdYHtaYyAmASYnK7v8mvXIEo1CBJBZ72/fDi/ORI7cVJ77+lDn458/1OJQyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765067878; c=relaxed/simple;
	bh=lkfmwv7bjDBKFQgW2WUnqJdUlq2yXVeM3ri/uSUpAUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZrcmy83OAEMGVGnA/ck31QxTxKI8jYApCDMFXyboacVZn0os7DNr3zjeyciB1bX+sw93tHL++Q+sRdQdE6fxbrUtvC/XbvmaYwUFvnLzaKD2yQJ+iQ30MbFcTqFh+TolUew/B/3M81WkTHFb57O2kR/ut+nWQVrDIjmm8VhcvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7ngEJ45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B906AC4CEF5;
	Sun,  7 Dec 2025 00:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765067878;
	bh=lkfmwv7bjDBKFQgW2WUnqJdUlq2yXVeM3ri/uSUpAUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T7ngEJ45t30yyPTbPxk2lUJmQGOrI6owZl4y0Xeqm/7ZlfWM0bdD0nLkCGGwiuHTg
	 efaKqghaw4fUM0ZKbaDmjPW01+MBBVu/gLk6BYM/1555QVgN+wJIpAvRGa6Obi3UjA
	 M290DtJYb/kDrY5NfMeNV2L2Go6zPDXWVa5Ze8PMQAPCx/W/qf7xEH0yJlp5cqDltx
	 cqFViX4/n7XRdOg8MyvZhqNf5ZmE2LvHImj/krEq3fEqDJWlkmg3/KGu92zKC6KsR7
	 mwBjRC83WoGU4wRLxnxb+npZvD32wPEoeeYVLQUAP/poMJCSCnD72P2khEezolOquT
	 a5yr5+rDDs4Sw==
Date: Sat, 6 Dec 2025 19:37:55 -0500
From: Sasha Levin <sashal@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	intel-gfx@lists.freedesktop.org
Subject: Re: Apply fc7bf4c0d65a342b29fe38c332db3fe900b481b9 to 5.15
Message-ID: <aTTMYz_n-9ck-tSo@laps>
References: <20251204001352.GB468348@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251204001352.GB468348@ax162>

On Wed, Dec 03, 2025 at 05:13:52PM -0700, Nathan Chancellor wrote:
>Hi stable folks,
>
>Please apply commit fc7bf4c0d65a ("drm/i915/selftests: Fix inconsistent
>IS_ERR and PTR_ERR") to 5.15, where it resolves a couple of instances of
>-Wuninitialized with clang-21 or newer that were introduced by commit
>cdb35d1ed6d2 ("drm/i915/gem: Migrate to system at dma-buf attach time
>(v7)") in 5.15.
>
>  In file included from drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c:329:
>  drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c:105:18: error: variable 'dmabuf' is uninitialized when used here [-Werror,-Wuninitialized]
>    105 |                        PTR_ERR(dmabuf));
>        |                                ^~~~~~
>  drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c:94:24: note: initialize the variable 'dmabuf' to silence this warning
>     94 |         struct dma_buf *dmabuf;
>        |                               ^
>        |                                = NULL
>  drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c:161:18: error: variable 'dmabuf' is uninitialized when used here [-Werror,-Wuninitialized]
>    161 |                        PTR_ERR(dmabuf));
>        |                                ^~~~~~
>  drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c:149:24: note: initialize the variable 'dmabuf' to silence this warning
>    149 |         struct dma_buf *dmabuf;
>        |                               ^
>        |                                = NULL
>
>It applies and builds cleanly for me. If there are any issues, please
>let me know.

Queued up, thanks.

-- 
Thanks,
Sasha

