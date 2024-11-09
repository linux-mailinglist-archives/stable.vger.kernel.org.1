Return-Path: <stable+bounces-92018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B3B9C2E39
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 16:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5707B21705
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 15:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DDD54F8C;
	Sat,  9 Nov 2024 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F1ZXM9+t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1777728F7
	for <stable@vger.kernel.org>; Sat,  9 Nov 2024 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731166227; cv=none; b=RJtLyelFHcNa2LuHNYEndVz+idUf7xXYrR0n0sO8HBRIG4KNFIcBiP0DN64n7/4bdOjr9tOlmnk87y93lSf8R+GPB5beXxrqY6aEUkEe0JRN2d8RuEi3usVVFuI434x6TTd8WRJrJCodTW0VBgJGGAP4EGbdOFJtLEUJnVSFvfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731166227; c=relaxed/simple;
	bh=Pul2+Kx7IIGskx0u2lIcnJw8iuE/LHZsQpz2O+3mQo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1wgBwKntHL9yysZZhV/bjda20zEvQoYb9RTyPWBAFAd9cA/6IsMi+qDsepz/H3MaqWGgqeu84BZhl8U31FWA2SoQhdOUMULnGd63A93p3oC2Zm7MuPV8VSUbVcq5x7f6Cj63/DpiMFCOU0wpS/0JDf5tP58Pkk8ukOT0T8ksZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F1ZXM9+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5F2C4CECE;
	Sat,  9 Nov 2024 15:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731166226;
	bh=Pul2+Kx7IIGskx0u2lIcnJw8iuE/LHZsQpz2O+3mQo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F1ZXM9+tzuESW7ZbAcA3MBsOer6YU3RnuzQkeHsZ/ftnzrA3kefpm4K3t6ywsKbvV
	 MfgbY9O3mS3Q4b+Vp5IgPCvrC3ltrA4Vl0+o9iK7wkXfDESqR2PPWWbcwaNuFIWVx4
	 hUPGrT/3BvwL2as5XjB8iuTPKfpGBsd2qvB9vZ3s=
Date: Sat, 9 Nov 2024 16:30:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"Gong, Richard" <Richard.Gong@amd.com>
Subject: Re: AMD PMF on 6.11.y
Message-ID: <2024110903-previous-sequel-5a74@gregkh>
References: <478eac36-fc71-4564-959c-422da304f139@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <478eac36-fc71-4564-959c-422da304f139@kernel.org>

On Wed, Nov 06, 2024 at 11:52:58PM -0600, Mario Limonciello wrote:
> Hi,
> 
> 6.11 already supports most functionality of AMD family 0x1a model 0x60, but
> the amd-pmf driver doesn't load due to a missing device ID.
> 
> The device ID was added in 6.12 with:
> 
> commit 8ca8d07857c69 ("platform/x86/amd/pmf: Add SMU metrics table support
> for 1Ah family 60h model")
> 
> Can this please come back to 6.11.y to enable it more widely?

I would be glad to, but it does not apply cleanly, are you sure you
tried this?

thanks,

greg k-h

