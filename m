Return-Path: <stable+bounces-83244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA56997028
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 17:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5129CB21881
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 15:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC091EF921;
	Wed,  9 Oct 2024 15:30:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5071E1A0B;
	Wed,  9 Oct 2024 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487803; cv=none; b=JsNziedH6edDfcAO2okszuY0JujmHk3PXiGvzUYnUPga8HNXUPu0iiW4J8QSx6VeYGE0mfzT1t4/1sy24olNzw/yElnPSJwUXt8Oy0V3GHINhtVNA/wUwCNPWF7TB3TCFEiIBpFMU8K7MwHXYDk0ltASz4OvK7nNus3qpOBUZgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487803; c=relaxed/simple;
	bh=uzj/YTHLAYdtVJLjnUfGGOptx5plAB5ldi0vsg3/9UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/SFLOA2aTJ7/eXl18w7HAraufbXNImYw0wi6gpaEJ/5feZ3CGQxLRiUki3Lxpgu8VI7OXr1gndeoDsCVYwqS5/7Kr43LRf0qlRYbNy3f4Ai9juHKNWjlKYZPjeVDwBOb4kNV7aGsgBonz/GEpLpCLHbXneKZmA/INq0Dk96TqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25058FEC;
	Wed,  9 Oct 2024 08:30:30 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C04373F64C;
	Wed,  9 Oct 2024 08:29:58 -0700 (PDT)
Date: Wed, 9 Oct 2024 16:29:52 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	kernel test robot <lkp@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware/psci: fix missing '%u' format literal in
 kthread_create_on_cpu()
Message-ID: <ZwahcJu_K7bbeICS@J2N7QTR9R3>
References: <20240930154433.521715-1-aleksander.lobakin@intel.com>
 <40f59adc-9d1e-4466-917a-69f3c8d77b5f@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40f59adc-9d1e-4466-917a-69f3c8d77b5f@intel.com>

On Wed, Oct 09, 2024 at 05:26:18PM +0200, Alexander Lobakin wrote:
> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> Date: Mon, 30 Sep 2024 17:44:33 +0200
> 
> > kthread_create_on_cpu() always requires format string to contain one
> > '%u' at the end, as it automatically adds the CPU ID when passing it
> > to kthread_create_on_node(). The former isn't marked as __printf()
> > as it's not printf-like itself, which effectively hides this from
> > the compiler.
> > If you convert this function to printf-like, you'll see the following:
> > 
> > In file included from drivers/firmware/psci/psci_checker.c:15:
> > drivers/firmware/psci/psci_checker.c: In function 'suspend_tests':
> > drivers/firmware/psci/psci_checker.c:401:48: warning: too many arguments for format [-Wformat-extra-args]
> >      401 |                                                "psci_suspend_test");
> >          |                                                ^~~~~~~~~~~~~~~~~~~
> > drivers/firmware/psci/psci_checker.c:400:32: warning: data argument not used by format string [-Wformat-extra-args]
> >      400 |                                                (void *)(long)cpu, cpu,
> >          |                                                                   ^
> >      401 |                                                "psci_suspend_test");
> >          |                                                ~~~~~~~~~~~~~~~~~~~
> > 
> > Add the missing format literal to fix this. Now the corresponding
> > kthread will be named as "psci_suspend_test-<cpuid>", as it's meant by
> > kthread_create_on_cpu().
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202408141012.KhvKaxoh-lkp@intel.com
> > Closes: https://lore.kernel.org/oe-kbuild-all/202408141243.eQiEOQQe-lkp@intel.com
> > Fixes: ea8b1c4a6019 ("drivers: psci: PSCI checker module")
> > Cc: stable@vger.kernel.org # 4.10+
> > Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> Ping? Who's taking this?

I would expect this to go through the soc tree.

Arnd, are you happy to pick this up?

FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> 
> > ---
> >  drivers/firmware/psci/psci_checker.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/firmware/psci/psci_checker.c b/drivers/firmware/psci/psci_checker.c
> > index 116eb465cdb4..ecc511c745ce 100644
> > --- a/drivers/firmware/psci/psci_checker.c
> > +++ b/drivers/firmware/psci/psci_checker.c
> > @@ -398,7 +398,7 @@ static int suspend_tests(void)
> >  
> >  		thread = kthread_create_on_cpu(suspend_test_thread,
> >  					       (void *)(long)cpu, cpu,
> > -					       "psci_suspend_test");
> > +					       "psci_suspend_test-%u");
> >  		if (IS_ERR(thread))
> >  			pr_err("Failed to create kthread on CPU %d\n", cpu);
> >  		else
> 
> Thanks,
> Olek

