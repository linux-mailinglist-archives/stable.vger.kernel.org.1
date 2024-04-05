Return-Path: <stable+bounces-36106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A64899BE4
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 13:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161391C214C9
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 11:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2554B16C687;
	Fri,  5 Apr 2024 11:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BMuK0Rxr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E191649D9
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 11:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712316887; cv=none; b=F1mWu7pqF7Cbx/OYYDyjMKULcbgO9C6bEoR4tsROijAq7Tobu4SmfhPdPY5PsSaX1ubmB67CTv0OVTC1k3FMGa8Ik2QJZf/mysh4MlEzRV/2v4hrsMmb3a//AheCNJTirkPOXJ67f/2q2bgWNW+A/LJtMUDfSPO5gGSAYhJzs3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712316887; c=relaxed/simple;
	bh=/Ucp5S6bC8IJn0PMdwoQcP7ToEdlhKpiax3jIJz9Y+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfdHiEJSI4FrRIwIgvcNf+jPo2yrfayZDE2HIpB5aDvQa2wTmfVdV8zk0ZKXOoatqE37OXHjJHpfiTClGc6leMaRXBD0KhxITiQxC9s4rpne9UG4kqAIIhHvXifVJ2yuS+fNu2bfAQWqZQ9Ok+GcTTjIuExnJY+fI2w2MLfkHEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BMuK0Rxr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA75C433F1;
	Fri,  5 Apr 2024 11:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712316887;
	bh=/Ucp5S6bC8IJn0PMdwoQcP7ToEdlhKpiax3jIJz9Y+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BMuK0Rxr8Ru012uiSHV8KOmHT2EZLvOt2kDS12nHYmSeafCLS6+HVuxqGNZyS2zs1
	 ckAtqGX4iTJsyhVmSoDYQshaL1Dm/vkcfXGGOy5uNdJImkH8ktbEDhsRy/HYypd0V7
	 5LDPs+bqIJmjmeW2RdNO4jhCD2vnIRUF7JgN/vuM=
Date: Fri, 5 Apr 2024 13:34:44 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Wolfgang Walter <linux@stwm.de>, stable@vger.kernel.org
Subject: Re: stable v6.6.24 regression: boot fails: bisected to "x86/mpparse:
 Register APIC address only once"
Message-ID: <2024040516-spill-uselessly-0a0e@gregkh>
References: <23da7f59519df267035b204622d32770@stwm.de>
 <2024040445-promotion-lumpiness-c6c8@gregkh>
 <899b7c1419a064a2b721b78eade06659@stwm.de>
 <87y19s82ya.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y19s82ya.ffs@tglx>

On Fri, Apr 05, 2024 at 01:27:09PM +0200, Thomas Gleixner wrote:
> On Fri, Apr 05 2024 at 12:35, Wolfgang Walter wrote:
> > Am 2024-04-04 17:57, schrieb Greg Kroah-Hartman:
> >> Is this also an issue in 6.9-rc1 or newer or 6.8.3 or newer?
> >> 
> > It is not an issue with 6.9-rc1. 6.9-rc1 just boots fine.
> 
> Bah. That's my fault.
> 
> So before the topology evaluation rework landed in the 6.9 merge window
> this eventual double registration was harmless and only happening for a
> particular set of AMD machines. The topo rework restructured the whole
> procedure and caused the new warnings to trigger.
> 
> So the Fixes tag I added to that commit was pointing at the wrong place
> and this needs to be reverted from all pre 6.9 stable kernels.

Sure, will be glad to, but what git is is "this"?  The original report
is gone from my thread here, sorry.

greg k-h

