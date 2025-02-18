Return-Path: <stable+bounces-116674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A791DA393B6
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 08:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CBAB1886AE0
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 07:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8C31B0F26;
	Tue, 18 Feb 2025 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H7/FmDnv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794507E1
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739863076; cv=none; b=LwGE4/nspVwdocfC44V+DU8bHcEO7Sm1wAMqDw0k9JpxiSCNfDwxMX1ah17TM+DwJrdDjJFEYMYdtSL/NxORSwqLxaWzwbI1FnjKUZ4XM0rB1BEZsw+zczRQ22kxwZoQR0A0KnyVXeNr+x57e1ceZbWu8KZia7NzmbV5KmY0Yjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739863076; c=relaxed/simple;
	bh=c2VJWHtRN9ayuAeDyuuBIvrBlgIriITvFGFikGhvfCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrFkBlq2/H+jsiEigzIktBw109aL9I7R0bcb/TydCVZRzUH+D5XBNIlC/OYuxTC435MfmdGlB5XZIEDMNgorlDeMFfkaIkRBoCETm2Eq3rO4hbzGTCQqLILW4hjXHDKqAzR2NtqKkNouYrm6PLqPBL2JKyJ4ogbLhN88cWzpPs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H7/FmDnv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CB1C4CEE2;
	Tue, 18 Feb 2025 07:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739863075;
	bh=c2VJWHtRN9ayuAeDyuuBIvrBlgIriITvFGFikGhvfCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H7/FmDnvVFkbSRTgVglDug+oc0S100r3l7Wb9rtDyv43gc4bdBNP2mAADsVMGJfDQ
	 R0lQZaWCD3amW0mLCPyUA8wscAM7sUbOO6zfHFKycglV1XPBdL90wLR0QETSdRqXZQ
	 0h/zsU2qvvTwlz5bNT7JdM0t1vPuo8oaPuaN65xo=
Date: Tue, 18 Feb 2025 08:17:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: jaywang-amazon <wanjay@amazon.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.1 1/1] x86/i8253: Disable PIT timer 0 when not in use
Message-ID: <2025021834-overdrawn-rely-d929@gregkh>
References: <20250217225353.21795-2-wanjay@amazon.com>
 <20250217225353.21795-4-wanjay@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217225353.21795-4-wanjay@amazon.com>

On Mon, Feb 17, 2025 at 10:53:55PM +0000, jaywang-amazon wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Leaving the PIT interrupt running can cause noticeable steal time for
> virtual guests. The VMM generally has a timer which toggles the IRQ input
> to the PIC and I/O APIC, which takes CPU time away from the guest. Even
> on real hardware, running the counter may use power needlessly (albeit
> not much).
> 
> Make sure it's turned off if it isn't going to be used.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Michael Kelley <mhkelley@outlook.com>
> Link: https://lore.kernel.org/all/20240802135555.564941-1-dwmw2@infradead.org
> 
> (cherry picked from commit 70e6b7d9ae3c63df90a7bba7700e8d5c300c3c60)
> Cc: stable@vger.kernel.org #v6.1
> Signed-off-by: jaywang-amazon <wanjay@amazon.com>

We need a real name, not a fake-company name please.

thanks,

greg k-h

