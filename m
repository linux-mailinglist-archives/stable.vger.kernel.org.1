Return-Path: <stable+bounces-78449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7251198BA0B
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08919B22178
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1887919D09D;
	Tue,  1 Oct 2024 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AChH07ij"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694E618859F;
	Tue,  1 Oct 2024 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727779625; cv=none; b=KRpIdD4mXLm8duJmMPBTnIpUwtuGurmPz92uhA1I4X9mGU/Rd8zGBg4bi+vGxQDQhleQxka8Oq1Do/Boj7ev1adX8wXA8nShQyTKhjkX8LaDjDUELy4HoBuizARmNzrt1zMqbMNk/qULaP1Qb8md1VOypj/h9i2Tibm1kr9Zp+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727779625; c=relaxed/simple;
	bh=hYZ8WovWrMisIzfTygun07snKwiHmm3zRFGpODyxcIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcKnrZkoQff+Iqc4RKcDVALOUtbc9/SMYMG68vMthGWDd/FVYuF7pNc2yWvMhwqe63m3lll0ilFKpXpc9AqWJVABRPI5wudLdaYtF9GFBQLC81UHg5oYyJIsyOmpFyuWcgNuZ1jGDGOp0ixExi32hzVvPbmgOJWVFsMJsmQN92U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AChH07ij; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20b7eb9e81eso22200075ad.2;
        Tue, 01 Oct 2024 03:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727779624; x=1728384424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R75wIKxDQ7UvY0hWCE9IGQr0sPKLU6hEiN4qFZAyjMU=;
        b=AChH07ijkpPr6lAkb5N2VgqRCI8KlE8VQMlzXHFYvDO8woEnH8HzVApAGnzq5C3D01
         cAJi16FkHFKoZio1W19HMPsGk4eqBIS1zbVtsxPlX1wyf/Zh9UkRowU+LA+bB+yLig+q
         Jsf9hofYeR4iSrX4/F9C+oHKA20E4vXvDYLargJ8EG9AidVc1eHTgJnKmsbc/7PasG9O
         cFAeIIghOZ8NRKF2tNMvkQo5vrK3Qg8SpJGaAsUAy1GW1JkEichSuo+RVwX0eHBguD/j
         K1GeCqdmbhLw54YWnlNmXsNnM7Mm6wryMgTukV3hFBPH/V5CMPB2jHnTxfBPx1MALV03
         GZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727779624; x=1728384424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R75wIKxDQ7UvY0hWCE9IGQr0sPKLU6hEiN4qFZAyjMU=;
        b=oEhb78uZEphT2DsnTX1Qyi5tMsdkaF9bNz2jPp+DRRaITWCZudyqFfcl4JwVVaiwMx
         KNONrasYuOtJ2wzkjcRzEdhmCPggGONF872CAK4GSRKUo1h1EhajwbQ+tOhz6DgYHYOf
         kJD+mEKUi8RjRnkA+HDoEsvSR70drKRrOuhzVhLlJuw5F/wlOvE539SMCEs2foGe5nnC
         PURXru8K1v/EToVr4xkqp8Nkbd8M4/v/RQujcAg1K4ZRXcklt/Xhwuix0qokd/mOgGPV
         M2wHv0Id1Zd3cng5B2JfxhwdJOyHdmd46M5mnL+WIwL2SNonSa4TXM3C7HP0Xn28Av9M
         h7EA==
X-Forwarded-Encrypted: i=1; AJvYcCWQIlNgpBLLo6QiTqijWBcFT7QuoS/5/vpfJldQ1+VJ70jcoB7Q44cM+E4Q9e5SkWMwycRwDnA0x17WQi+SsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJRDuc9wUaEf6lpWxgnFN4mnBivFUxJ5320Q8HCTGzFuMSUAod
	cDEP8i0cGZARMI7GJefCpMRLQukZPi0lrXoJz/KLrZls2ZmG7ChX
X-Google-Smtp-Source: AGHT+IH7HjonA2ukS0sI9/ek9diFeOEMNQO9S7//LhweJEZnO5LK1BMnJDYfh+lTRbjvNn5qJSgqDg==
X-Received: by 2002:a17:902:f705:b0:205:6c15:7b6e with SMTP id d9443c01a7336-20b37c119f4mr219881365ad.60.1727779623464;
        Tue, 01 Oct 2024 03:47:03 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:70a4:8eee:1d3f:e71d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d68a93sm67516115ad.56.2024.10.01.03.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 03:47:03 -0700 (PDT)
Date: Tue, 1 Oct 2024 03:47:00 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	ruanjinjie@huawei.com
Subject: Re: Patch "Input: ps2-gpio - use IRQF_NO_AUTOEN flag in
 request_irq()" has been added to the 5.15-stable tree
Message-ID: <ZvvTJD20aLHgHY7q@google.com>
References: <20241001002900.2628013-1-sashal@kernel.org>
 <Zvu8GiY4PxqTQPD0@google.com>
 <2024100134-talcum-angular-6e20@gregkh>
 <ZvvIJX1IzHy8DCl7@google.com>
 <2024100149-repugnant-unrelated-5974@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024100149-repugnant-unrelated-5974@gregkh>

On Tue, Oct 01, 2024 at 12:05:56PM +0200, Greg KH wrote:
> On Tue, Oct 01, 2024 at 03:00:05AM -0700, Dmitry Torokhov wrote:
> > On Tue, Oct 01, 2024 at 11:32:16AM +0200, Greg KH wrote:
> > > On Tue, Oct 01, 2024 at 02:08:42AM -0700, Dmitry Torokhov wrote:
> > > > On Mon, Sep 30, 2024 at 08:28:59PM -0400, Sasha Levin wrote:
> > > > > This is a note to let you know that I've just added the patch titled
> > > > > 
> > > > >     Input: ps2-gpio - use IRQF_NO_AUTOEN flag in request_irq()
> > > > > 
> > > > > to the 5.15-stable tree which can be found at:
> > > > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > > > 
> > > > > The filename of the patch is:
> > > > >      input-ps2-gpio-use-irqf_no_autoen-flag-in-request_ir.patch
> > > > > and it can be found in the queue-5.15 subdirectory.
> > > > > 
> > > > > If you, or anyone else, feels it should not be added to the stable tree,
> > > > > please let <stable@vger.kernel.org> know about it.
> > > > 
> > > > For the love of God, why? Why does this pure cleanup type of change
> > > > needs to be in stable?
> > > 
> > > Because someone said:
> > > 
> > > > > commit 2d007ddec282076923c4d84d6b12858b9f44594a
> > > > > Author: Jinjie Ruan <ruanjinjie@huawei.com>
> > > > > Date:   Thu Sep 12 11:30:13 2024 +0800
> > > > > 
> > > > >     Input: ps2-gpio - use IRQF_NO_AUTOEN flag in request_irq()
> > > > >     
> > > > >     [ Upstream commit dcd18a3fb1228409dfc24373c5c6868a655810b0 ]
> > > > >     
> > > > >     disable_irq() after request_irq() still has a time gap in which
> > > > >     interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
> > > > >     disable IRQ auto-enable when request IRQ.
> > > 
> > > Looks like a bug fix, and also:
> > > 
> > > > >     Fixes: 9ee0a0558819 ("Input: PS/2 gpio bit banging driver for serio bus")
> > > 
> > > Someone marked it as such.
> > > 
> > > I'll go drop it, but really, don't mark things as fixes if they really
> > > are not.
> > 
> > They are fixes, they just do not belong to stable and that is why they
> > are not marked as such.
> 
> Ok, if your subsystem will always mark this type of thing properly, we
> will be glad to add you to the "don't take any Fixes: only commits" to
> the list that we keep.  Here's the subsystems that we currently do this
> for:
> 	https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/ignore_list
> 
> what regex should we use for this list?

Let's do:

	drivers/input/*

and see how it goes.

Thanks.

-- 
Dmitry

