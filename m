Return-Path: <stable+bounces-132066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ADFA83C0A
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 10:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9534A5F7F
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 08:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF76A1E5B9D;
	Thu, 10 Apr 2025 08:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fVTjOMDJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E2F1E5B65;
	Thu, 10 Apr 2025 08:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744272331; cv=none; b=DEoxdqDsovtXtfx5R8m0e6YjSfYx/vGozCgdGMK/mEHWsk1xkMtx1LDuhXXW7AHoqRxGS3qYsx3FfZWLC7xHwWeiaoCeOdfnFJ2OQ5flKJIsoTImS9BmCiImIhCE0Qhz9RHAQ5gt40IDzBCWbT39f7YYsu+WqLqAK5pyIYTL+uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744272331; c=relaxed/simple;
	bh=HACMz5TOu/NPUCoPtSJRRuRpnxSmXN3RFRqhqk0Xhtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcCH99CcjbaQfre/490bv18r0MI03zrylugSyV5Pm/wRuz6NyKhYukYydM0u4aAU2CnTn8WDSOSONJscuuKnGTXM4vEUF4v5RJKWOyngz3ygju5MXnTBBBmX91lB2cXVG4+dYE7DMY1IlsM8DHnb8z6Uf1aZ9I2A8s2lfW5J3Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fVTjOMDJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98006C4AF0B;
	Thu, 10 Apr 2025 08:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744272331;
	bh=HACMz5TOu/NPUCoPtSJRRuRpnxSmXN3RFRqhqk0Xhtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fVTjOMDJ1DumnuYNlupjd14s4hzm5gOyR6L7bkyzHKmockcd/bbmNkZN9G1BpCA6j
	 DWgJq0OX8c3ectu3P+rRUEWPNwvkl6Dl6ea3rCBsCojB5V1I6gE4qQhaYtHq9LrFdC
	 otN3VU75R8lrU+syIePdhCJLcJf5fMmjAEGh1ISg=
Date: Thu, 10 Apr 2025 10:03:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Karol Wachowski <karol.wachowski@intel.com>
Subject: Re: [PATCH] accel/ivpu: Add handling of
 VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW
Message-ID: <2025041011-borrowing-shrug-781e@gregkh>
References: <20250408095711.635185-1-jacek.lawrynowicz@linux.intel.com>
 <8d96c75d-e8fb-446b-a85c-803a2b5212ed@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d96c75d-e8fb-446b-a85c-803a2b5212ed@linux.intel.com>

On Thu, Apr 10, 2025 at 09:49:37AM +0200, Jacek Lawrynowicz wrote:
> Hi,
> 
> This is an important patch for the Intel NPU.
> Is there anything it is missing to be included in stable?

Patience, you only sent this:

> On 4/8/2025 11:57 AM, Jacek Lawrynowicz wrote:

2 days ago, AFTER the latest of -rc releases was sent out for review,
and those kernels have NOT even been released yet!

[rant about how you all know this process works deleted as it was
 just snarky on my side, although quite cathartic, thanks for letting me
 vent...]

Relax, it will get handled when we can get to it.  To help out, please
take the time to review pending stable backported patches that have been
submitted to the mailing list ahead of yours.

greg k-h

