Return-Path: <stable+bounces-192965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29710C47594
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 15:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14641891105
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 14:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B263101DC;
	Mon, 10 Nov 2025 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekcVxPa4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700C930F7FE;
	Mon, 10 Nov 2025 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786273; cv=none; b=JSEkHACkVEuSwOcD6nOi+T5gfsD8RJMCsueSOPh87eB8vPAwj0fjqCOkOM3TGfK3jwcAfZ3mxF1xKRqT27EcVvGvtyCK9FhOJFy/r4ePM7nwbvl2ac2KtLZiUYUdHnGVK9hAoBQxR/m/UL3V88o7r0XKvQPCvvf3KKfR6faoSd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786273; c=relaxed/simple;
	bh=iy9M5bi9LnHKrEDzCp3+pahks1xh5T1G+df/WkdGulQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEo3gW/vabp8LBQnmd1aX9GXZf+Rer7PRRwKmR8/FvLMk1JavQcW+SX9pmiQCIhvItzayjwvTR1bsUhhzT1CvjLk1CJ+kjbeOioE7ei1wljKyAPkZGRRUVhunWSfFmmF2RVzma7pOAVCcBN6dGiCTyzuijcBEMi3VnzZY0/4Or0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekcVxPa4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6DFC19422;
	Mon, 10 Nov 2025 14:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762786273;
	bh=iy9M5bi9LnHKrEDzCp3+pahks1xh5T1G+df/WkdGulQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ekcVxPa4WKSDY5nkkdT6Z1L9JkXrS0GeqRGRQyQGaADUJSIySRrFKgXopcHptZ0CW
	 idrdGJyTtjFSqm0FwWiNEIV8CL3wQDQRhSPbq+2xSu3ncV6Gr7Rnuq5hVaPj0xshzY
	 0ajfh9yV4V0GEGqnTvPiPBDRnqhN4uIclSppQcvZnKs9461StxjaofbtllxoFibJwt
	 qalnULA88Cg//a9kdsRWU9F5cj5ik+RMF7GwLbQLLBRtjiEa7S8bP5vT4uAkrBRUu3
	 yXNerXsSO+2nFAi1LMwJMCC4n/rY+LUYE9+tlKhoXlTwWxrsAx0GvLbN81sEXSOFqw
	 sxFEBRmKXGvlw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vITEf-000000005KC-0dai;
	Mon, 10 Nov 2025 15:51:13 +0100
Date: Mon, 10 Nov 2025 15:51:13 +0100
From: Johan Hovold <johan@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] clocksource/drivers/stm: Fix section mismatches
Message-ID: <aRH74auttb6UgnjP@hovoldconsulting.com>
References: <20251017054943.7195-1-johan@kernel.org>
 <7ad2b976-3b0d-4823-a145-ceedf071450d@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ad2b976-3b0d-4823-a145-ceedf071450d@linaro.org>

Hi Daniel,

On Wed, Nov 05, 2025 at 02:32:18PM +0100, Daniel Lezcano wrote:

> You should replace __init by __init_or_module

That's not sufficient as the driver can still be rebound through sysfs
currently (the driver would probably crash anyway, but that's a separate
issue).

Also note that no drivers use __init_or_module these days, likely as
everyone uses modules and it's not worth the added complexity in trying
to get the section markers right for a build configuration that few
people care about.

I can send a follow-on patch to suppress the unbind attribute, or
include it in a v2 if you insist on using __init_or_module. 

What do you prefer?

> On 10/17/25 07:49, Johan Hovold wrote:
> > Platform drivers can be probed after their init sections have been
> > discarded (e.g. on probe deferral or manual rebind through sysfs) so the
> > probe function must not live in init. Device managed resource actions
> > similarly cannot be discarded.

Johan

