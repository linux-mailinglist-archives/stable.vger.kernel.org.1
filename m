Return-Path: <stable+bounces-112284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B72F7A285F4
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 09:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51F2016728C
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 08:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE6A2147FE;
	Wed,  5 Feb 2025 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pl3y3MNV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB1520370C;
	Wed,  5 Feb 2025 08:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738745590; cv=none; b=lSdHx4yynczr6knCoVXam2/l29Of0g4wwNFMm1Bc/CJMP7LFjdjKvHJNaDdhGJECVee4etQohiZnn7tKB4lH9W5jrE5lmdGUYf7ELljzUF0xQjd3FrSS1PtLQNLUrovTM8Lq3BoS+YTGbMYwe9wjiitIe1YmYPabWEZY9UKvtsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738745590; c=relaxed/simple;
	bh=LZEIxUhP5Ow+7UH5rHBRl5YR7tPiFdjFrBwS3KKVYvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7jwcDunF3m7mh9SY0mzMuoxo7BU2e/75YoOxtZGf4o0l9/lxpSjbgqsdRe/TSCgOns4QimjffhXqwCjTANUcwNdOc84Vq70Kjw+XtouHkAf1YCFY8qTy2MTVb0zj+jITyWnIMm8HqR0ZSPSYE/p93LV+46GCaG439RcSMhaLes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pl3y3MNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0258DC4CED1;
	Wed,  5 Feb 2025 08:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738745589;
	bh=LZEIxUhP5Ow+7UH5rHBRl5YR7tPiFdjFrBwS3KKVYvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pl3y3MNVOcJVwgL0JKjShMAKYN/xf/dljc0jnugZi3mCmgbX8aKFiftnyZTU8uC53
	 uT9PTKGF0GY/yr7MjCLOf0e8xSBgnZqjrlkSi8TGik6SXSJQRivLy3Hr1xBt6oJKJG
	 T+PW9jEZrBQKRR4TAhE4/4SUH8GWGlNivucVMfBg=
Date: Wed, 5 Feb 2025 09:53:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Patch "hostfs: convert hostfs to use the new mount API" has been
 added to the 6.6-stable tree
Message-ID: <2025020534-family-upgrade-20fb@gregkh>
References: <20250203162734.2179532-1-sashal@kernel.org>
 <e71dbfcd-317e-43b0-8e67-2a7ea3510281@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e71dbfcd-317e-43b0-8e67-2a7ea3510281@huawei.com>

On Wed, Feb 05, 2025 at 09:13:33AM +0800, Hongbo Li wrote:
> 
> 
> On 2025/2/4 0:27, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >      hostfs: convert hostfs to use the new mount API
> > 
> > to the 6.6-stable tree which can be found at:
> >      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> 
> Hi Sasha,
> 
> If this, the fix : ef9ca17ca458 ("hostfs: fix the host directory parse when
> mounting.") also should be added. It fixes the mounting bug when pass the
> host directory.

I've swept the queues and have added the "fixes for the fixes" commits
like this one now, thanks!

greg k-h

