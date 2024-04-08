Return-Path: <stable+bounces-36395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F294F89BD76
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 12:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E802840A2
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 10:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA3B5F87C;
	Mon,  8 Apr 2024 10:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q/kNRfqR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7725F879
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 10:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712573118; cv=none; b=Qs1n/Dk3wIgOB8RjzUnmoax5YoXM8/RL4IRTNoHLuMnKLoP75jD6GiYhflRlbltSYO7hr2K4saxqJvMJRIwOc0d8ovPAukZsvGYeQjU4pYKatXiWAzgU4aHWbk1XGdpFQE63ajTxrkH3KHnpsndjV9y46FQaPO/tmmc+LVGFb5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712573118; c=relaxed/simple;
	bh=TjK8PkPD005I72YE9SqLPuyy2giIhEzWrl8zJuhO01k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6o56A3OP/H0SttuvHju/E4V6LIUKnPnSSlB1wtnSoUCl8t40tfFqhJIFDseMtRy1AFBxbMmN7zqhNcKM0Ia+Nlwal/VChKCDuL6rlxBmnF1fMu0jt3yVpDt/ClG7d8slOox1isCbJDl8zx4X9JackGp2qPjxx6V9VuMCUOGBuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q/kNRfqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0DEC433C7;
	Mon,  8 Apr 2024 10:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712573117;
	bh=TjK8PkPD005I72YE9SqLPuyy2giIhEzWrl8zJuhO01k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q/kNRfqR214RROZRz745w8zmHhi29yJFWn7I24n64bsUUtcpbFApem93niMFlxPkC
	 WM6Xcq3jTsHUNdhwaS6FVXpd8PjqyPL7wbYDR49i1GfJyV0bi4MC90MVjAUrM4/V8V
	 3lSHGPsZZy4x/lvKEVDsQXywtHJAlG0j5WbYZ2Ck=
Date: Mon, 8 Apr 2024 12:45:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Wolfgang Walter <linux@stwm.de>, stable@vger.kernel.org
Subject: Re: stable v6.6.24 regression: boot fails: bisected to "x86/mpparse:
 Register APIC address only once"
Message-ID: <2024040800-stove-mullets-9090@gregkh>
References: <23da7f59519df267035b204622d32770@stwm.de>
 <2024040445-promotion-lumpiness-c6c8@gregkh>
 <899b7c1419a064a2b721b78eade06659@stwm.de>
 <87y19s82ya.ffs@tglx>
 <2024040516-spill-uselessly-0a0e@gregkh>
 <87r0fj97ve.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0fj97ve.ffs@tglx>

On Fri, Apr 05, 2024 at 04:55:33PM +0200, Thomas Gleixner wrote:
> On Fri, Apr 05 2024 at 13:34, Greg Kroah-Hartman wrote:
> > On Fri, Apr 05, 2024 at 01:27:09PM +0200, Thomas Gleixner wrote:
> >> On Fri, Apr 05 2024 at 12:35, Wolfgang Walter wrote:
> >> > Am 2024-04-04 17:57, schrieb Greg Kroah-Hartman:
> >> >> Is this also an issue in 6.9-rc1 or newer or 6.8.3 or newer?
> >> >> 
> >> > It is not an issue with 6.9-rc1. 6.9-rc1 just boots fine.
> >> 
> >> Bah. That's my fault.
> >> 
> >> So before the topology evaluation rework landed in the 6.9 merge window
> >> this eventual double registration was harmless and only happening for a
> >> particular set of AMD machines. The topo rework restructured the whole
> >> procedure and caused the new warnings to trigger.
> >> 
> >> So the Fixes tag I added to that commit was pointing at the wrong place
> >> and this needs to be reverted from all pre 6.9 stable kernels.
> >
> > Sure, will be glad to, but what git is is "this"?  The original report
> > is gone from my thread here, sorry.
> 
> The upstream commit with the bogus Fixes tag is:
> 
>     f2208aa12c27 ("x86/mpparse: Register APIC address only once")
> 

Thanks, now reverted.

greg k-h

