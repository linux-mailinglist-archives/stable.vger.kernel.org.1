Return-Path: <stable+bounces-165185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 329B8B1582C
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 06:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696AE56059E
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 04:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6048B1DE2BC;
	Wed, 30 Jul 2025 04:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VHjZKqGU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0701317BED0;
	Wed, 30 Jul 2025 04:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753851166; cv=none; b=oMGYE7upM30/3bIXXDK/t88rA5XvAci093IzPy7tz4uTU6r46LTqtsszlW8rs0MP8hl0sutV+MXeOphkn0uOfLxC2rBw2Q31RvyROaBuZI5kWgpiZtu5lMJUwQ3q1GP1N8QVPgzneo0a8uakyJc/5wwrRCBeqMMDnu+PKr4VyVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753851166; c=relaxed/simple;
	bh=KE1IvAHnGLKYo1PVlsOC6mI/DKgTOQOw7nMVSTzSUr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIcRGZlhUiJ920xBlo+cCV6qHlD+gPS1UvEqkHy4oX9zgEKQRtQcbusNGd+PWE9Yyr5c5gicRWRuyddaK/QjdXm+kSm+DkjNZwqFZZ5I7fZoBTCRU51yAty9pIdJA4mG6lmbcPcwpgnpvbc4RbOOzJfMdZo9RwKlgVThzJKI7js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VHjZKqGU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AA7C4CEE7;
	Wed, 30 Jul 2025 04:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753851165;
	bh=KE1IvAHnGLKYo1PVlsOC6mI/DKgTOQOw7nMVSTzSUr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VHjZKqGUipkwQhYniSveTwdNE6IaFgq6FnsdfvH1+jhezL7nj3rXnUKSHKv8Lksoj
	 Hg/ZAVRzTnnZof+1iCaOxC5L31jfWqHjPchkpaKX1ziBJodmgwYD9uIbATjTfXlrtB
	 SAIGIRfcFJCdkAQoWAyIH0Bki8lSciBY5YLQMuDE=
Date: Wed, 30 Jul 2025 06:52:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, darwi@linutronix.de,
	sohil.mehta@intel.com, peterz@infradead.org, ravi.bangoria@amd.com,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] x86/cpu/intel: Fix the constant_tsc model check for
 Pentium 4s
Message-ID: <2025073013-stimulus-snowdrift-d28c@gregkh>
References: <20250730042617.5620-1-suchitkarunakaran@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730042617.5620-1-suchitkarunakaran@gmail.com>

On Wed, Jul 30, 2025 at 09:56:17AM +0530, Suchit Karunakaran wrote:
> The logic to synthesize constant_tsc for Pentium 4s (Family 15) is
> wrong. Since INTEL_P4_PRESCOTT is numerically greater than
> INTEL_P4_WILLAMETTE, the logic always results in false and never sets
> X86_FEATURE_CONSTANT_TSC for any Pentium 4 model.
> The error was introduced while replacing the x86_model check with a VFM
> one. The original check was as follows:
>         if ((c->x86 == 0xf && c->x86_model >= 0x03) ||
>                 (c->x86 == 0x6 && c->x86_model >= 0x0e))
>                 set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);

What do you mean by "original check"?  Before the change that caused
this, or what it should be?

> Fix the logic to cover all Pentium 4 models from Prescott (model 3) to
> Cedarmill (model 6) which is the last model released in Family 15.
> 
> Fixes: fadb6f569b10 ("x86/cpu/intel: Limit the non-architectural constant_tsc model checks")
> 
> Cc: <stable@vger.kernel.org> # v6.15
> 
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>

Nit, no blank lines beween all of those last lines.  Hint, look at all
of the patches on the mailing lists AND in the tree already, you have
hundreds of thousands of examples here of how to format things :)

thanks,

greg k-h

