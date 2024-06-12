Return-Path: <stable+bounces-50238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EACCC905265
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8780AB222CD
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 12:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98F716F83E;
	Wed, 12 Jun 2024 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zr1JKDKk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981A216F0F3
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195255; cv=none; b=YTnm2acd0OBiyTx2LJ70QF3BXU2bxajU8TBuAdx8YtAD7ArNUSNMuLV9AAwZrN4dY4OC2YBXrqK7SHPvQC29oyh7wkN6bOEYj2rGfKoLTQ6v8UImmC6NGl1kV3CXvSpn6Gz1sk6vLYJJYuz8qQuaNIc4Wtydbc+0yEXnPaUO2xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195255; c=relaxed/simple;
	bh=IeColGgMXO0cur7CRoCaXf+4UM1IaeKblR787z1wtPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIfoHTkg+zKVOxnwOIovLvtZW4bTmp2D18EcPMeh92jr6afDVja5xjg1yt0a+lboeUWTqU6TUDsEABeiMfxTc2vSxYackh7gKvXblvwZFQcuT+qv32vJ4Bt2D/1TojQhYcIYxZsx5PHQVy7n1f8WYaIqXYrAA3VDKMUTqGl7MYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zr1JKDKk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43E8C4AF1A;
	Wed, 12 Jun 2024 12:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718195255;
	bh=IeColGgMXO0cur7CRoCaXf+4UM1IaeKblR787z1wtPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zr1JKDKkDU/F8KdTlHXMlbljRZbX0q4d/ZHuqxFhT2NtIF3x9ToC58NzyP1lNAqb/
	 QW1s5rgrOXtSi8zBkvXiMo/9GdJN6sFX03nhcxjhIY2U8YH/2CfnS5mpZaBATSgSTA
	 A+DvW7/bu9aSzdYwlF6ea4Cr8jC68Uw6EPX10Avw=
Date: Wed, 12 Jun 2024 14:27:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: stable@vger.kernel.org,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH 5.10.y] binder: fix max_thread type inconsistency
Message-ID: <2024061223-flap-playpen-bd16@gregkh>
References: <2024052313-runner-spree-04c1@gregkh>
 <20240523184352.1541595-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240523184352.1541595-1-cmllamas@google.com>

On Thu, May 23, 2024 at 06:43:52PM +0000, Carlos Llamas wrote:
> commit 42316941335644a98335f209daafa4c122f28983 upstream.
> 
> The type defined for the BINDER_SET_MAX_THREADS ioctl was changed from
> size_t to __u32 in order to avoid incompatibility issues between 32 and
> 64-bit kernels. However, the internal types used to copy from user and
> store the value were never updated. Use u32 to fix the inconsistency.
> 
> Fixes: a9350fc859ae ("staging: android: binder: fix BINDER_SET_MAX_THREADS declaration")
> Reported-by: Arve Hjønnevåg <arve@android.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://lore.kernel.org/r/20240421173750.3117808-1-cmllamas@google.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [cmllamas: resolve minor conflicts due to missing commit 421518a2740f]
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  drivers/android/binder.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

All now queued up, thanks.

greg k-h

