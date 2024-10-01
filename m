Return-Path: <stable+bounces-78376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3233298B8CA
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD6571F2231E
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484491A01B5;
	Tue,  1 Oct 2024 10:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9/xtUxh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C1119DFA7;
	Tue,  1 Oct 2024 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727776812; cv=none; b=usYyEAsoG5NeloSbTCbYi6Qni0rnF+YwDfWsSNbT2GLJPH+Okf1kWlugxJBoMZjmu7EveXKqabq4J6qH2p38kZLEMqgV2J6+D8iGQ3I7JXPewZpoTmTgIwUpdJ5VNP5HerXsghdaOpUz9vcwip7v+XCBL9YWSqpiZY8Ba8sXrME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727776812; c=relaxed/simple;
	bh=l58NGvPIoWbt5fLNx1NzMEIxfgtojSltUzbzQojs7ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1z7C5mXE2E7QUh8WL/J3Q8NEBXtZFo/uZSCAfiG47YKC/aeTx11WB1yqMm4NZv8uKO8DVz2BfBZyMAZBK7XpwqzaXVWpTPOVb60xsED9G9c9siqOcx9tGXwJi+q0WueOMMa18vTEJ5XS0e/dcsgww0FKP/XS8cQ6G5ZklzLuoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9/xtUxh; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20bb610be6aso3835025ad.1;
        Tue, 01 Oct 2024 03:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727776808; x=1728381608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lxRKIQDKBSh86VP9rX4CecL+aKXuej7WdEDnJzSz7WU=;
        b=F9/xtUxheEmy8TnZP2ldcnsp+W7IHVwolgueL4cl2B8d3FSsaQctLfX3fsg16ol9Zc
         xLA9o/qdhg75VWhCBxrkhy7d1yu5txoPX2sZgPgITDC2TEwcokDcOnt0o4XdyrSZG+Fp
         Ua+NQxduo4ig9n7Q1C9ydsQh4SeMmpAL8AFi6W/inEnKaXRy9Y1mL3IY3i84wJ4SKpoB
         lpZk9manL3p8FCj3qHmMUaaxs3QjYrqfOZsex0R8isWXmPC4+G1cVpPtV1k+nBrGHKQs
         tuAqyvE7pFRr5VJbNBifNnkzVHXuvgk+Qcxy64GONsQwNh94NtJYJMEpiGeKZaV23gKL
         VhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727776808; x=1728381608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxRKIQDKBSh86VP9rX4CecL+aKXuej7WdEDnJzSz7WU=;
        b=kcjumjhipTKCxk1u+JEH3NHRYD+5M6HmQeldN8ww6reNLN/sYoRnUyiTQHqma7u5Zd
         H2sevYd6foq2UtUcAGI5wT6esC7/j2T8nvcupBL0oHz+Xi7qaA+DYQXtZJkE+7FiizlO
         eo9WnkEj8eGH10JPQeqyNOSMRt4Axq6t+vb+BAtM9AWA86mprAI8W7qC3PixJLyRrzOi
         rh9lnr8Yb3afoO5Xmq5yIAoXB3D3dmAQAjDHxh2oEID8f4StG7o04XcTBn3AUE3V3mls
         s0aghqGyqne+LMA/QdFSmGsa7KH+KhUToCSHiyEB8t+f/P8ntjIWqIkewvrTm8JJ5Gp+
         0J4g==
X-Forwarded-Encrypted: i=1; AJvYcCWsPxNY58rbHzzkrkoMY0FQ7Sh4RXHubLAFTliz9oYZR372iLppw3nDGRgdkQgaw2UTFKPzlRdJyAFQG+Su7A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0fmr+tZk+WkhkVskrK4VrU36qs+KeTgh8yB7ZuB+wWfWYaVPJ
	/O/cs2jJ5iMt8wzuEirLi3dU5sdzn9+4F42tBw9M3BiGQoh2Bq4GzDgnW4OvCfY=
X-Google-Smtp-Source: AGHT+IF8O53uszw7KMAxfCEwTuT9ypzSsMieewzGEtcfUz0hP0ixfBIqsFKrWBOF1kNPp9TRcfzrpw==
X-Received: by 2002:a17:903:1c4:b0:20b:9698:a234 with SMTP id d9443c01a7336-20b9698a5a1mr61970675ad.8.1727776808349;
        Tue, 01 Oct 2024 03:00:08 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:70a4:8eee:1d3f:e71d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e10196sm66415465ad.145.2024.10.01.03.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 03:00:07 -0700 (PDT)
Date: Tue, 1 Oct 2024 03:00:05 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	ruanjinjie@huawei.com
Subject: Re: Patch "Input: ps2-gpio - use IRQF_NO_AUTOEN flag in
 request_irq()" has been added to the 5.15-stable tree
Message-ID: <ZvvIJX1IzHy8DCl7@google.com>
References: <20241001002900.2628013-1-sashal@kernel.org>
 <Zvu8GiY4PxqTQPD0@google.com>
 <2024100134-talcum-angular-6e20@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024100134-talcum-angular-6e20@gregkh>

On Tue, Oct 01, 2024 at 11:32:16AM +0200, Greg KH wrote:
> On Tue, Oct 01, 2024 at 02:08:42AM -0700, Dmitry Torokhov wrote:
> > On Mon, Sep 30, 2024 at 08:28:59PM -0400, Sasha Levin wrote:
> > > This is a note to let you know that I've just added the patch titled
> > > 
> > >     Input: ps2-gpio - use IRQF_NO_AUTOEN flag in request_irq()
> > > 
> > > to the 5.15-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > 
> > > The filename of the patch is:
> > >      input-ps2-gpio-use-irqf_no_autoen-flag-in-request_ir.patch
> > > and it can be found in the queue-5.15 subdirectory.
> > > 
> > > If you, or anyone else, feels it should not be added to the stable tree,
> > > please let <stable@vger.kernel.org> know about it.
> > 
> > For the love of God, why? Why does this pure cleanup type of change
> > needs to be in stable?
> 
> Because someone said:
> 
> > > commit 2d007ddec282076923c4d84d6b12858b9f44594a
> > > Author: Jinjie Ruan <ruanjinjie@huawei.com>
> > > Date:   Thu Sep 12 11:30:13 2024 +0800
> > > 
> > >     Input: ps2-gpio - use IRQF_NO_AUTOEN flag in request_irq()
> > >     
> > >     [ Upstream commit dcd18a3fb1228409dfc24373c5c6868a655810b0 ]
> > >     
> > >     disable_irq() after request_irq() still has a time gap in which
> > >     interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
> > >     disable IRQ auto-enable when request IRQ.
> 
> Looks like a bug fix, and also:
> 
> > >     Fixes: 9ee0a0558819 ("Input: PS/2 gpio bit banging driver for serio bus")
> 
> Someone marked it as such.
> 
> I'll go drop it, but really, don't mark things as fixes if they really
> are not.

They are fixes, they just do not belong to stable and that is why they
are not marked as such.

Thanks.

-- 
Dmitry

