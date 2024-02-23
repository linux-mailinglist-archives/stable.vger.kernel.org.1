Return-Path: <stable+bounces-23501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 372EA8616D1
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 17:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69BD71C22952
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 16:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAF6839FB;
	Fri, 23 Feb 2024 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OM5tT8yb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D74181AD3
	for <stable@vger.kernel.org>; Fri, 23 Feb 2024 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704276; cv=none; b=uoUt9lc38ALY2RF+696e3GAFZr6c9ZCmjciYeL3mwMR3nsaTl8A7b2xboVO5iKQ69fAEQXnkRpHIJHKji9Jcpgvgo1gAUIizETlrcJu3T/kinTQ2I7sqUtqi8DlRJa/QMo5PR0oa3qwQnv/6ngqaz13xw0etMnnkSEdqKysh+u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704276; c=relaxed/simple;
	bh=VeV7SPLh/J0ES0wnGBPukf8ZUcw0wxynFh+rr1HnnKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fz2X+HnvnX5vhrj3W2fiit+LRso5FIJvWzzAltgW8nAHOaxEorRG/+rIzrEWh5p8skrxbHC+un8ApIVTq1Hr4BBrV2o74IsDuRKThmYBCq051SwgIzds4oTe127GEuDc6TfSB04FkzcjjNfHxU6h95/4/RfNeOtCmM2eHk46hY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OM5tT8yb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D710C43142;
	Fri, 23 Feb 2024 16:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708704276;
	bh=VeV7SPLh/J0ES0wnGBPukf8ZUcw0wxynFh+rr1HnnKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OM5tT8ybCOgReSwllx10xJk9BJgcvTdH0FmlPOe/iwkArwh8qg+PSB1UFHC0NxDMq
	 xWnfD9Qu4ZQ3iwY0V+fEoDUXEU3Wr4MFeL7mxZ+OkCrMQrqgixfqWtXeF6PL+vIyBo
	 3BqglgGUdhpAsn7B/FsD2/80eFADuMVbbw+ihp38=
Date: Fri, 23 Feb 2024 17:04:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: avagin@google.com, bogomolov@google.com, dave.hansen@linux.intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH linux-5.15.y] x86/fpu: Stop relying on userspace for info
 to fault in xsave
Message-ID: <2024022312-bulginess-contend-ac94@gregkh>
References: <2024021941-reprimand-grudge-7734@gregkh>
 <87msrtftnv.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87msrtftnv.ffs@tglx>

On Wed, Feb 21, 2024 at 09:29:08PM +0100, Thomas Gleixner wrote:
> 
> From: Andrei Vagin <avagin@google.com>
> 
> Before this change, the expected size of the user space buffer was
> taken from fx_sw->xstate_size. fx_sw->xstate_size can be changed
> from user-space, so it is possible construct a sigreturn frame where:
> 
>  * fx_sw->xstate_size is smaller than the size required by valid bits in
>    fx_sw->xfeatures.
>  * user-space unmaps parts of the sigrame fpu buffer so that not all of
>    the buffer required by xrstor is accessible.
> 
> In this case, xrstor tries to restore and accesses the unmapped area
> which results in a fault. But fault_in_readable succeeds because buf +
> fx_sw->xstate_size is within the still mapped area, so it goes back and
> tries xrstor again. It will spin in this loop forever.
> 
> Instead, fault in the maximum size which can be touched by XRSTOR (taken
> from fpstate->user_size).
> 
> [ dhansen: tweak subject / changelog ]
> [ tglx: Backport to 5.15 stable ]
> 
> Fixes: fcb3635f5018 ("x86/fpu/signal: Handle #PF in the direct restore path")
> Reported-by: Konstantin Bogomolov <bogomolov@google.com>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Andrei Vagin <avagin@google.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/all/20240130063603.3392627-1-avagin%40google.com
> ---
>  arch/x86/kernel/fpu/signal.c |   12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

Nit, you forgot to give me a hint what the git id was :(

I figured it out, now queued up, thanks.

greg k-h

