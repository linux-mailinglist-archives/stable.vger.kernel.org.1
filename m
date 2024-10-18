Return-Path: <stable+bounces-86851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D25F9A42AB
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 17:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1173285406
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 15:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C65202623;
	Fri, 18 Oct 2024 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RG43i1vb"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649E9201267
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729266019; cv=none; b=Lnxwu9D62NFsZlrX5Rh1undVhc1DLLZOK0ml7zUWI4hDL2Ve3lsW1X+iIhkcwc36UITQXPQB7DeeNi82W8SgYPBFEfg7OpKvGvnloUtXwuwB3JQ/lQNwgwLb5rOjw5LmAXeOktBFPcZDzEgbE7KeAogPlBXPu38U+LeC3/vdwrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729266019; c=relaxed/simple;
	bh=JwhDul0KWehdjzF8RUVNvZuD0KzaRzk5sOiMKzR8xWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVXjWsRaSIHpe3fH5wVRQwyMaHqHdqZ7jlOICmsm9GRvm2hRS2FpoY+IF4rYiuNDMhGwDXjxdOYdqlrD7DtaVfuWsV24FOXxvaWUk9myAXWaXKc0ZgG21OSWzdkmLCZOF/PsrnlzKIA1fUWp53NL5S8VPZLsLHZm4xHXu73Ph8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RG43i1vb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729266016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L7sF+ux8tQB6rtv2OQ9q9fbX718Icj+2tzphppaDZ3A=;
	b=RG43i1vbN5Rrrf/oPdzlGp3Y/ELYt0iwHXBj3zaTgUYhTJXn/QMPtr3AM0MHDC22FDxRu3
	ftE7MxG5ckZqRtLGEqjZyN6auDyYNp7cGytpMTt/k14g23F7qsedI8/Eu5o/gWtEM4lI9l
	/S9wr2OfB/6s7Ev0yc23Ii+ZrZXPzHU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-9VZDhXIJN6-ai3qN3pH6Fg-1; Fri,
 18 Oct 2024 11:40:10 -0400
X-MC-Unique: 9VZDhXIJN6-ai3qN3pH6Fg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8B231964CF3;
	Fri, 18 Oct 2024 15:40:06 +0000 (UTC)
Received: from localhost (unknown [10.72.112.28])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39A1F1955D5A;
	Fri, 18 Oct 2024 15:39:10 +0000 (UTC)
Date: Fri, 18 Oct 2024 23:39:00 +0800
From: Baoquan He <bhe@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Gregory Price <gourry@gourry.net>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
	mika.westerberg@linux.intel.com, ying.huang@intel.com,
	tglx@linutronix.de, takahiro.akashi@linaro.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] resource,kexec: walk_system_ram_res_rev must retain
 resource flags
Message-ID: <ZxKBFMAecrL25Fwb@MiWiFi-R3L-srv>
References: <20241017190347.5578-1-gourry@gourry.net>
 <ZxHFgmHPe3Cow2n8@MiWiFi-R3L-srv>
 <ZxJTDq-PxxxIgzfv@smile.fi.intel.com>
 <ZxJoLxyfAHxd18UM@MiWiFi-R3L-srv>
 <ZxJ13aKBqEotI593@smile.fi.intel.com>
 <ZxJ2NxXpqowd73om@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxJ2NxXpqowd73om@smile.fi.intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 10/18/24 at 05:52pm, Andy Shevchenko wrote:
> On Fri, Oct 18, 2024 at 05:51:09PM +0300, Andy Shevchenko wrote:
> > On Fri, Oct 18, 2024 at 09:52:47PM +0800, Baoquan He wrote:
> > > On 10/18/24 at 03:22pm, Andy Shevchenko wrote:
> > > > On Fri, Oct 18, 2024 at 10:18:42AM +0800, Baoquan He wrote:
> > > > > On 10/17/24 at 03:03pm, Gregory Price wrote:
> > > > > > walk_system_ram_res_rev() erroneously discards resource flags when
> > > > > > passing the information to the callback.
> > > > > > 
> > > > > > This causes systems with IORESOURCE_SYSRAM_DRIVER_MANAGED memory to
> > > > > > have these resources selected during kexec to store kexec buffers
> > > > > > if that memory happens to be at placed above normal system ram.
> > > > > 
> > > > > Sorry about that. I haven't checked IORESOURCE_SYSRAM_DRIVER_MANAGED
> > > > > memory carefully, wondering if res could be set as
> > > > > 'IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY' plus
> > > > > IORESOURCE_SYSRAM_DRIVER_MANAGED in iomem_resource tree.
> > > > > 
> > > > > Anyway, the change in this patch is certainly better. Thanks.
> > > > 
> > > > Can we get more test cases in the respective module, please?
> > > 
> > > Do you mean testing CXL memory in kexec/kdump? No, we can't. Kexec/kdump
> > > test cases basically is system testing, not unit test or module test. It
> > > needs run system and then jump to 2nd kernel, vm can be used but it
> > > can't cover many cases existing only on baremetal. Currenly, Redhat's
> > > CKI is heavily relied on to test them, however I am not sure if system
> > > with CXL support is available in our LAB.
> > > 
> > > Not sure if I got you right.
> > 
> > I meant since we touch resource.c, we should really touch resource_kunit.c
> > *in addition to*.
> 
> And to be more clear, there is no best time to add test cases than
> as early as possible. So, can we add the test cases to the (new) APIs,
> so we want have an issue like the one this patch fixes?

I will have a look at kernel/resource_kunit.c to see if I can add
something for walk_system_ram_res_rev(). Thanks.


