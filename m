Return-Path: <stable+bounces-114220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0655FA2BF32
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 10:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 113997A2A49
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 09:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99CB2343B0;
	Fri,  7 Feb 2025 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="reP7Jvbc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qJt5Iz8U"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D221DE2BF;
	Fri,  7 Feb 2025 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738920320; cv=none; b=LA1xhGaEvYUfEVdQ9zXAyxjIOPq1jpXJGRPdnBiOuFnpFK2KLheF2BkEGuQqB9Q+OGhwTLqKxOTx5fV2q4smQLwjTXEgHhLUqYBq3fiUy8oUqbgAmnKjt5mdBlJshfDz6bLFFPd/fDodkatyrhksVWBky24RFNfJ+1oCcBdmBNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738920320; c=relaxed/simple;
	bh=KBLkEL12Og2x3Pglq0lPKHmlfc+op+vs3fb6Uyx1aJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYKGGsahQul9/We9fhQQuIC3G0o0Mglq/YXWy9Y6YbUXGuO6Y3DvY7OGUl2TMnOiv6AxJGeDSjAh+qGC23qiEq3SlBYFdvC67OZBTBEqm0KjS6+ZkMYXlt0txJ7bFaHNybTclm4u0oSdl6w0puvVWgHwO2M2+eeib6di4cFH7so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=reP7Jvbc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qJt5Iz8U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 7 Feb 2025 10:25:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738920316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VhaHIolMqVaOKYQrrLkqK1G4I/2AK3phIMMuTF3pFWo=;
	b=reP7JvbcU0nfOWcSr3dJZmrxK5PQZGFlsLkEuFFgIPl0MwajUgTqxxSd2w1mapH1lnohce
	Dt+L8IRlNu3GG4Y4SPILVNj/qQ51TByMbchdQI4kOrjL6EPzsm5hA4oHHNWCgM0dwx092g
	1uTItGKhAbjDmnB8dciy/vxknCXn8o0ZTuLzjLERhGSFbYbONep0oJ7EN3HyAQlDLonCpJ
	hHkfcCXWi8Ns5jgBfKcA0Fc7xQ3JyipUAksSeDCLWCVnloijRX5cAwXh1DxWZ9CgghQ74D
	PqWgiz/Blka85Kxai5sWW625S7TUlRc8Fn+M/nZDvohviOy6mdTEwTEcb/po8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738920316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VhaHIolMqVaOKYQrrLkqK1G4I/2AK3phIMMuTF3pFWo=;
	b=qJt5Iz8UgObFD7UP8tWK4AITuhI5urfa9k2BZtjcbS8a/x8wc1tc8plkXpxvBbvmp/93Gi
	W3afGDhGaKSUj7AA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Mateusz Polchlopek <mateusz.polchlopek@intel.com>, 
	Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	"Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>
Subject: Re: [PATCH net-next 0/4] ptp: vmclock: bugfixes and cleanups for
 error handling
Message-ID: <20250207102320-55575f30-68fd-4aa3-93a0-d97173253471@linutronix.de>
References: <20250206-vmclock-probe-v1-0-17a3ea07be34@linutronix.de>
 <e16551dd-3a84-49ba-b875-c11f77239984@intel.com>
 <34d961bf2f40f054dd79cf7d8cf81a3eefd00a59.camel@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34d961bf2f40f054dd79cf7d8cf81a3eefd00a59.camel@infradead.org>

On Fri, Feb 07, 2025 at 09:10:42AM +0000, David Woodhouse wrote:
> On Fri, 2025-02-07 at 08:13 +0100, Mateusz Polchlopek wrote:
> > 
> > 
> > On 2/6/2025 6:45 PM, Thomas Weiﬂschuh wrote:
> > > Some error handling issues I noticed while looking at the code.
> > > 
> > > Only compile-tested.
> > > 
> > > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > > ---
> > > Thomas Weiﬂschuh (4):
> > > †††††† ptp: vmclock: Set driver data before its usage
> > > †††††† ptp: vmclock: Don't unregister misc device if it was not registered
> > > †††††† ptp: vmclock: Clean up miscdev and ptp clock through devres
> > > †††††† ptp: vmclock: Remove goto-based cleanup logic
> > > 
> > > † drivers/ptp/ptp_vmclock.c | 46 ++++++++++++++++++++--------------------------
> > > † 1 file changed, 20 insertions(+), 26 deletions(-)
> > > ---
> > > base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> > > change-id: 20250206-vmclock-probe-57cbcb770925
> > > 
> > > Best regards,
> > 
> > As those all are fixes and cleanups then I think it should be tagged to
> > net not net-next.
> 
> Agreed. Thanks, Thomas. For all four:

Ack.


> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>

Thanks.

> I'm about to post a fifth which adds a .owner to vmclock_miscdev_fops.

I assume you want me to include this in my series.

> Tested with the existing '-device vmclock' support in QEMU, plus this
> hack to actually expose a PTP clock to the guest (which we haven't
> worked out how to do *properly* from the timekeeping subsystem of a
> Linux host yet; qv).
> 
> --- a/hw/acpi/vmclock.c
> +++ b/hw/acpi/vmclock.c
> @@ -151,6 +151,18 @@ static void vmclock_realize(DeviceState *dev,
> Error **errp)
>  
>      qemu_register_reset(vmclock_handle_reset, vms);
>  
> +	vms->clk->time_type = VMCLOCK_TIME_TAI;
> +    vms->clk->flags = VMCLOCK_FLAG_TAI_OFFSET_VALID;
> +    vms->clk->tai_offset_sec = -3600;
> +    vms->clk->clock_status = VMCLOCK_STATUS_SYNCHRONIZED;
> +    vms->clk->counter_value = 0;
> +    vms->clk->counter_id = VMCLOCK_COUNTER_X86_TSC;
> +    vms->clk->time_sec = 1704067200;
> +    vms->clk->time_frac_sec = 0x8000000000000000ULL;
> +    vms->clk->counter_period_frac_sec = 0x1a6e39b3e0ULL;
> +    vms->clk->counter_period_shift = 4;
> +    //vms->clk->counter_period_frac_sec = 0x1934c67f9b2ce6ULL;
> +
>      vmclock_update_guest(vms);
>  }
>  
> 



