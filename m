Return-Path: <stable+bounces-92130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 622979C3F07
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 14:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D3811F22B04
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 13:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29201A0AE1;
	Mon, 11 Nov 2024 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bJAalIm7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863681A072A
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731329880; cv=none; b=V7uEia1TIj4ADNhBiJytrQnAriBbe56ctgc0U+dcWbV8jDAvN95JSBVH4S9qfq8vuIO73wn+ZT56NnIjRTyDOpJi2rKUulrpvv0dtJrKege1NmMtIavN3otHQV5r9F4F7lq/I7lOglyGAHq5kOQz5zNLtprazOfiPLUU/W+Uz5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731329880; c=relaxed/simple;
	bh=QnFbhLJNbWM3LMfzzeqjzNvRhNmdWczJLcDWMuyWHFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEmLjm9JZdHHubwUjz1FZXHCT37SunqykAVC9MyU+jSDoCIyOcukXFTIPVdaj2RG4jPvSoZCV78OMV/gql3X8/FO/E/EuCVKPQdncJaR0PxUyloSinVT9EGoh86DRATcM/fLdDi3bbPiJK7hURRilEMq74oss6wUG728GvQbqY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bJAalIm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CBEC4CECF;
	Mon, 11 Nov 2024 12:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731329879;
	bh=QnFbhLJNbWM3LMfzzeqjzNvRhNmdWczJLcDWMuyWHFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bJAalIm7Bjld5wYrADk0ho0xkxYSE4NpOgFqO7Hfjg3va460br597nWfkZuuAnsp2
	 5yn9IPmbwP79n9pHr1iUIvPDmLN9fgkzsz9Iy5fAWOrSGMAAvRc3hxDdIHadvl5p4Y
	 HpZFhykfN1+8WVVzwLA7UuubChVsPS92fk8sUzI0=
Date: Mon, 11 Nov 2024 13:57:56 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: stable@vger.kernel.org, jack@suse.com
Subject: Re: backport "udf: Allocate name buffer in directory iterator on
 heap" to 5.15
Message-ID: <2024111134-empirical-snowcap-8357@gregkh>
References: <8e759d2a-423f-4e26-b4c2-098965c50f9e@hauke-m.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e759d2a-423f-4e26-b4c2-098965c50f9e@hauke-m.de>

On Sun, Nov 10, 2024 at 06:36:08PM +0100, Hauke Mehrtens wrote:
> Hi,
> 
> I am running into this compile error in 5.15.171 in OpenWrt on 32 bit
> systems. This problem was introduced with kernel 5.15.169.
> ```
> fs/udf/namei.c: In function 'udf_rename':
> fs/udf/namei.c:878:1: error: the frame size of 1144 bytes is larger than
> 1024 bytes [-Werror=frame-larger-than=]
>   878 | }
>       | ^
> cc1: all warnings being treated as errors
> make[2]: *** [scripts/Makefile.build:289: fs/udf/namei.o] Error 1
> make[1]: *** [scripts/Makefile.build:552: fs/udf] Error 2
> ```
> 
> This is fixed by this upstream commit:
> commit 0aba4860b0d0216a1a300484ff536171894d49d8
> Author: Jan Kara <jack@suse.cz>
> Date:   Tue Dec 20 12:38:45 2022 +0100
> 
>     udf: Allocate name buffer in directory iterator on heap
> 
> 
> Please backport this patch to 5.15 too.
> It was already backported to kernel 6.1.

I tried to take it as-is, but it broek the build.  Can you please submit
a tested version that actually works?

thanks,

greg k-h

