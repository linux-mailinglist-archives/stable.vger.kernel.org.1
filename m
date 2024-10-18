Return-Path: <stable+bounces-86827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA3A9A402B
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 15:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0682CB21356
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 13:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABACE200C8C;
	Fri, 18 Oct 2024 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ggrTegPA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0E1200C92
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729258721; cv=none; b=Z5ms3N0QYYyPSNy+5in6t+kTEca/1F/gPyH6qgz3tu5SswZTvCp4NydcY+X4eW9Oh5YmX1tWokeycNhprX20pJaam0te2/yjbErwQqE2Ob73G/fSrDPr66PwbDJJfumzKG85MdensNIBxFsuQssXVzGj5KXnH7bHvpZ7X58Z2E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729258721; c=relaxed/simple;
	bh=0PH9ZNuHVfDm1Ir0FY5lORCCqHB0yu/JEIaTFjCE54Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFXkjq5aSJSbUX8iV1/004UnXdMWZFpr4sJyCoj+53iCiDE58WG0ES/jGVHmRrYVzA3ycfFnUnPoamO7+VE7uyliYzzsc8OZ8z+WPo6lA5s4FUof4g+BG5fHx5s9RBt5hXnicwmyb9bcS4LxwA9CSwV2QgwLGOU/OBSvrQi9FH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ggrTegPA; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7181a8af549so348244a34.2
        for <stable@vger.kernel.org>; Fri, 18 Oct 2024 06:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729258718; x=1729863518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nVQC71FpKRWshBPwUAPRSfOi9KhTjaLXAKPeTx4sMCY=;
        b=ggrTegPAkbe6a2KzhqnrCK/9V0goCfbsmIKkAaMo+LLjk2SlvCyDNn7CN/uGYxhBW4
         fOUZCmj3h5Ny/UwXtlNsnhguzBLkcGisIVGmx7VAWhKfEWXu9n1ic92vW7A0Xl2Mb39s
         2pdU4DmH7ycbzfqrDEEuE0XNDXkgyZUXk6GOtZxZBp73YSXU5uzfZ3zSdflY6Q9vNdQ9
         +BE0qEINVqyEZ9hqfqSSfFohtgmztIOnX4rOtfjgDBfdVnU/MHW0Wg2TCB+Cao1PTi/K
         NziZCV3KGmHhVo543q4L1+yXfmrz2YxI9EgOpNP3k0/OJEZB3ackkh2r3ld5Io7YUuSM
         OQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729258718; x=1729863518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVQC71FpKRWshBPwUAPRSfOi9KhTjaLXAKPeTx4sMCY=;
        b=Tf6siTXRIUyflbGS6A8pqyeA1QkQXqlmI2bU1HIFY3oQrzNd09RmranuIcKd+fRW4h
         FyBla7u/iBLWLMh+/qeXSq49Dsa7p/3d5QlUfYV45bJ8Wdv1xBTBoHCoq1I51VFgbYD4
         PKi5Dg5lEp35X2fMr183w7iPdihK7728LxBEWaqF06FLPJwom2ye3cNTjp2itH2mknwJ
         3BklD45L1uERVFOIol4EyaOOXTMdtangVwRKOuKHqW15J+mRHe1f2vNOUCi3Nurfsvdq
         u0ewHTsdPOw4T2aOh+N/E0xSEmRCAZdvW+3a3dEXxSFm93gDpk0RPoeG+CLiqhb0IXUF
         jB5g==
X-Forwarded-Encrypted: i=1; AJvYcCU/27YtfPufB0zFf9UH/ro7Xj6VV2Ac4g/flgc1C4kdz3W+VRBWVJdTw/JLatfDR6bSPHWpa9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKIigxTD1ZmHze74MkzP3LiEV9MBPH8s7EuSbBx09DPo89QgrU
	Rr1Qjq3qAOpmjMk3uQnWkjwLb6hLrtni5zTyAgr29MvcBl7lkkt71amTUNJi95s=
X-Google-Smtp-Source: AGHT+IHhM/hhdws8NWJZR7xLe9RfCiROWNQkWuLLhXb3EaaMsAeiBTYEXM+95+rEIX3njEZZmQYboA==
X-Received: by 2002:a05:6830:6f49:b0:718:a52:e1c7 with SMTP id 46e09a7af769-7181a81d73fmr1358859a34.17.1729258718312;
        Fri, 18 Oct 2024 06:38:38 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde122b017sm6974436d6.78.2024.10.18.06.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 06:38:37 -0700 (PDT)
Date: Fri, 18 Oct 2024 09:38:37 -0400
From: Gregory Price <gourry@gourry.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com, mika.westerberg@linux.intel.com,
	ying.huang@intel.com, bhe@redhat.com, tglx@linutronix.de,
	takahiro.akashi@linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH] resource,kexec: walk_system_ram_res_rev must retain
 resource flags
Message-ID: <ZxJk3RYDTpYkELCa@PC2K9PVX.TheFacebook.com>
References: <20241017190347.5578-1-gourry@gourry.net>
 <ZxJbOinZ0E4Ppmak@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxJbOinZ0E4Ppmak@smile.fi.intel.com>

On Fri, Oct 18, 2024 at 03:57:30PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 17, 2024 at 03:03:47PM -0400, Gregory Price wrote:
> > walk_system_ram_res_rev() erroneously discards resource flags when
> > passing the information to the callback.
> > 
> > This causes systems with IORESOURCE_SYSRAM_DRIVER_MANAGED memory to
> > have these resources selected during kexec to store kexec buffers
> > if that memory happens to be at placed above normal system ram.
> > 
> > This leads to undefined behavior after reboot. If the kexec buffer
> > is never touched, nothing happens. If the kexec buffer is touched,
> > it could lead to a crash (like below) or undefined behavior.
> > 
> > Tested on a system with CXL memory expanders with driver managed
> > memory, TPM enabled, and CONFIG_IMA_KEXEC=y. Adding printk's
> > showed the flags were being discarded and as a result the check
> > for IORESOURCE_SYSRAM_DRIVER_MANAGED passes.
> > 
> > find_next_iomem_res: name(System RAM (kmem))
> > 		     start(10000000000)
> > 		     end(1034fffffff)
> > 		     flags(83000200)
> > 
> > locate_mem_hole_top_down: start(10000000000) end(1034fffffff) flags(0)
> > 
> > [.] BUG: unable to handle page fault for address: ffff89834ffff000
> 
> Please, cut this down to only important ~3-5 lines as suggested in
> the Submitting Patches documentation.
> 
> Yeah, I see that Andrew applied it to hist testing branch, if it's not going to
> be updated there, consider above as a hint for the future contributions with
> backtraces.
>

noted, thank you!
 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

