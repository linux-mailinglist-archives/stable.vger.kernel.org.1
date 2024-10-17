Return-Path: <stable+bounces-86633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC2B9A2482
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 16:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B2D1F22270
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 14:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE211DE3D9;
	Thu, 17 Oct 2024 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o4pO3N10"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291731DE3C4;
	Thu, 17 Oct 2024 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174007; cv=none; b=ZCae5K6ZIsObCm8JcEvMb319qOCEMv52f/3Ciazwr45Mtrvb7APvUvp24244L0ALVQvHL5XvEi1Lg51IEP4DL7ifE/d/pkhLfEkzKJUi2BUNBx4cXKMbGEWeL9yfw+1DdkuALkAgJ6QBqwRrZOyqRSNh6ChvnSUm2zqWVqSt67I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174007; c=relaxed/simple;
	bh=hZCoXQsVjJgdy7BIPN0W3U1cPX3GJPfRlR7ZS+yt2tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoU7fHylWxF7zd94OeL4Kaj9ue3QodoF64k90q+b3olyrLZQmjwsgc+xk23VEQX+4f5bkLzlLTP3HBSzT8JXqA+z3NwjNVPSdeHDH/r7c34odo1GzrIunqmNUljj0IAB/ceOteQcFlhV/cIdgqCrFF3uT0XaWFGR1XuxUCWVmWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o4pO3N10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F02EC4CECD;
	Thu, 17 Oct 2024 14:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729174006;
	bh=hZCoXQsVjJgdy7BIPN0W3U1cPX3GJPfRlR7ZS+yt2tA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o4pO3N10VGpb0DEWrd9vOW3mo6KGSnEuioKaCNXorxJX2pKRxVQaSbQBwBuEVGr8l
	 5Iijk/m/WYoGutti6X3/EOkZpPpl99hYZxcg6meJXKQq5vzofrah2bRFnrPtD1PORY
	 nTa0r5wa3T2ouwab99aBjkGm4hv3+S8nA9aGvktU=
Date: Thu, 17 Oct 2024 16:06:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vimal Agrawal <avimalin@gmail.com>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, quic_jjohnson@quicinc.com,
	dan.carpenter@linaro.org, vimal.agrawal@sophos.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] misc: misc_minor_alloc to use ida for all
 dynamic/misc dynamic minors
Message-ID: <2024101725-opal-quarters-b4b7@gregkh>
References: <2024101722-uncharted-wages-5759@gregkh>
 <20241017133532.94509-1-vimal.agrawal@sophos.com>
 <2024101715-flounder-delusion-8edb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024101715-flounder-delusion-8edb@gregkh>

On Thu, Oct 17, 2024 at 03:39:06PM +0200, Greg KH wrote:
> On Thu, Oct 17, 2024 at 01:35:32PM +0000, Vimal Agrawal wrote:
> > misc_minor_alloc was allocating id using ida for minor only in case of
> > MISC_DYNAMIC_MINOR but misc_minor_free was always freeing ids
> > using ida_free causing a mismatch and following warn:
> > > > WARNING: CPU: 0 PID: 159 at lib/idr.c:525 ida_free+0x3e0/0x41f
> > > > ida_free called for id=127 which is not allocated.
> > > > <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
> > ...
> > > > [<60941eb4>] ida_free+0x3e0/0x41f
> > > > [<605ac993>] misc_minor_free+0x3e/0xbc
> > > > [<605acb82>] misc_deregister+0x171/0x1b3
> > 
> > misc_minor_alloc is changed to allocate id from ida for all minors
> > falling in the range of dynamic/ misc dynamic minors
> > 
> > Fixes: ab760791c0cf ("char: misc: Increase the maximum number of dynamic misc devices to 1048448")
> > Signed-off-by: Vimal Agrawal <avimalin@gmail.com>
> 
> Sorry, but no, do not hide behind a gmail.com address.  Either fix your
> corporate email system to be able to send patches out, or use the other
> method of sending from a different address as documented in the kernel
> documentation.
> 
> As it is, I can't take this, sorry.

Also, only patch 1/2 showed up, what happened to patch 2/2?

thanks,

greg k-h

