Return-Path: <stable+bounces-28132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49F187BAA5
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 10:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EADF285940
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 09:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE9C6CDD1;
	Thu, 14 Mar 2024 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xKArqfGy"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1D16CDCE
	for <stable@vger.kernel.org>; Thu, 14 Mar 2024 09:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710409604; cv=none; b=IT+DjuCsEogn9I+bB7FZ6eQu1MCAUEvmgse7y0D0ZWIoly5im2oYvs7WUbXb30zJX4sqOcKIpPEaHb9xOdXwsXgN2RXuMeqCfUPa9Y/Gcgn1VEYN5V3+LuF7OkkdUFFyYj5IXGwrtDKwOUTkgGrdfkocREuAxEIN8FEdjg382YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710409604; c=relaxed/simple;
	bh=JpkIl1BKIGGNixjpaVbZrY93MdTBPhWCW8x98baClsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0WQ1U0knUybYx1Hsf/dAsWKZRW+ZteYjAZsiZhmLUq/iMhKQRrILg6F4mAsVU/7bFyjIYmZisFw5Pmwusxt9wacU0JsSv72vBdnlCp4ORLzgMLNg+2g+6Oqf0sqzL1Pf6lc88ppftVD3ZMKAlNN9qdPAwlRdEi//wf+bAzsh44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xKArqfGy; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 14 Mar 2024 05:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710409599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vWzqCXedOPkmF4U9w0yKT7h+/OYrXyYp5XQWSsj+4/4=;
	b=xKArqfGyRKuVq9elFQTGJSP9X2sRrVBpXGZUkvkMRMgg3Lg6y0Zo9CuAQ/3/wgtIFR5PMk
	tzBMgEikptytMrxYCcmVsHwYF/rMoyoRO85dceXRxzG4ZDdDoTOjWlnB9Ox0dINyTIdlAp
	pzgf88dwwimCv3QqSb/T+1SngUxJkRU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Helge Deller <deller@kernel.org>
Cc: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: dddd
Message-ID: <vubxxvlsgyzzn64ffdvhhdv75d5fal5jh5xew7mf7354cddykz@45w6b2wvdlie>
References: <ZfLGOK954IRvQIHE@carbonx1>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfLGOK954IRvQIHE@carbonx1>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 14, 2024 at 10:41:12AM +0100, Helge Deller wrote:
> Dear Greg & stable team,
> 
> could you please queue up the patch below for the stable-6.7 kernel?
> This is upstream commit:
> 	eba38cc7578bef94865341c73608bdf49193a51d
> 
> Thanks,
> Helge

I've already sent Greg a pull request with this patch - _twice_.

> 
> 
> From eba38cc7578bef94865341c73608bdf49193a51d Mon Sep 17 00:00:00 2001
> From: Helge Deller <deller@kernel.org>
> Subject: [PATCH] bcachefs: Fix build on parisc by avoiding __multi3()
> 
> The gcc compiler on paric does support the __int128 type, although the
> architecture does not have native 128-bit support.
> 
> The effect is, that the bcachefs u128_square() function will pull in the
> libgcc __multi3() helper, which breaks the kernel build when bcachefs is
> built as module since this function isn't currently exported in
> arch/parisc/kernel/parisc_ksyms.c.
> The build failure can be seen in the latest debian kernel build at:
> https://buildd.debian.org/status/fetch.php?pkg=linux&arch=hppa&ver=6.7.1-1%7Eexp1&stamp=1706132569&raw=0
> 
> We prefer to not export that symbol, so fall back to the optional 64-bit
> implementation provided by bcachefs and thus avoid usage of __multi3().
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> 
> diff --git a/fs/bcachefs/mean_and_variance.h b/fs/bcachefs/mean_and_variance.h
> index b2be565bb8f2..64df11ab422b 100644
> --- a/fs/bcachefs/mean_and_variance.h
> +++ b/fs/bcachefs/mean_and_variance.h
> @@ -17,7 +17,7 @@
>   * Rust and rustc has issues with u128.
>   */
>  
> -#if defined(__SIZEOF_INT128__) && defined(__KERNEL__)
> +#if defined(__SIZEOF_INT128__) && defined(__KERNEL__) && !defined(CONFIG_PARISC)
>  
>  typedef struct {
>  	unsigned __int128 v;

