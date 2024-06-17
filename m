Return-Path: <stable+bounces-52565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3620090B641
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 18:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF520281AD9
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 16:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9B014D29D;
	Mon, 17 Jun 2024 16:23:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BA3847A
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718641439; cv=none; b=CwXGXCfZmmDh7qa/3wbA037uiFTXVn2d4V/ErM2y5Qv2J3KMD5UxU83dYXPNhMwsP7yxBmsfh2tCOty/GYDDnHRMAbfPCttEQzQzuIDxdsrmYt6Qpc5Iy7HS65LcTqUhfmUccOB8VeviC7cUMnQphj3xD80ZFnDiLT6Or43lHbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718641439; c=relaxed/simple;
	bh=VO2VyECDZVyasJy4pD0ZuR/qIoCMZJ514+0+7m1Ps6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4rgh3KyMAd0sGi0PJL3i9n+BTJHTRksY9ntkncvUw9WD+8yOTK6byh2YLHEnXKwN4qUfd1xcFEhgZgIbizkaXcC+je5bo+wkaynHPEEUbQ1IWnWrTGfvArtTaJ7vMTHk9RYcqvBycwH/C1yrMxaJYDAu2hGxh6QFjeOajgVjSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 45HGLpBU028823;
	Mon, 17 Jun 2024 11:21:51 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 45HGLpUo028822;
	Mon, 17 Jun 2024 11:21:51 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Mon, 17 Jun 2024 11:21:51 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5.10] powerpc/uaccess: Fix build errors seen with GCC 13/14
Message-ID: <20240617162151.GN19790@gate.crashing.org>
References: <20240614112714.3482739-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614112714.3482739-1-mpe@ellerman.id.au>
User-Agent: Mutt/1.4.2.3i

On Fri, Jun 14, 2024 at 09:27:14PM +1000, Michael Ellerman wrote:
> commit 2d43cc701b96f910f50915ac4c2a0cae5deb734c upstream.
> The 'std' instruction requires a 4-byte aligned displacement because
> it is a DS-form instruction, and as the assembler says, 18 is not a
> multiple of 4.

You learn something new every day :-)

> A similar error is seen with GCC 13 and CONFIG_UBSAN_SIGNED_WRAP=y.
> 
> The fix is to change the constraint on the memory operand to put_user(),
> from "m" which is a general memory reference to "YZ".
> 
> The "Z" constraint is documented in the GCC manual PowerPC machine
> constraints, and specifies a "memory operand accessed with indexed or
> indirect addressing". "Y" is not documented in the manual but specifies
> a "memory operand for a DS-form instruction". Using both allows the
> compiler to generate a DS-form "std" or X-form "stdx" as appropriate.

https://gcc.gnu.org/PR115289
It will be documented soon, thanks for the report!

> Although the build error is only seen with GCC 13/14, that appears
> to just be luck. The constraint has been incorrect since it was first
> added.

Yes, "m" allows any memory operand, an unaligned one is just fine.

Acked-by: Segher Boessenkool <segher@kernel.crashing.org>


Segher

