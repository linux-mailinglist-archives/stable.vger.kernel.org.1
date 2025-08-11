Return-Path: <stable+bounces-167045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE48B20C06
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 16:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCABB1887AA4
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 14:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F057C255F2C;
	Mon, 11 Aug 2025 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LEobG1zZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D1F2459EA
	for <stable@vger.kernel.org>; Mon, 11 Aug 2025 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922819; cv=none; b=RcJSK41+Ucx2fmsQit/uHqu91Jx+6FexbW6AQffBTUZbB7h702mWwDBIQ3++Sk6NUW6d9GhTnDQmevnpNcuUcy2A71MFh84ElqPuCZzQZlYdLpel9dfE9srWk161k8p3WeDCQ4PgqJxMrqG+9aVLglo1EHvywFKwlGEuuKwVcS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922819; c=relaxed/simple;
	bh=o+skJLf15lCzmm7XuyVHgI9UTU99H4wOljAnL9vR+Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kv1Li47Rn3vBIcFoGQDkjVaB+zW8atmLkubGwuPGSQ4zn6VutPxFpdhxZZTXpfdoes93lddqwOmlh4RfRb8qwJnNdw6A+NsUOUS64U4dDW9bQ4UsHiyNPAOXdqDooFNOusH69VkAkBGU+hEQaDCYgxfCarxK2DedxlgyzEVPpcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LEobG1zZ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-af95b919093so652507066b.2
        for <stable@vger.kernel.org>; Mon, 11 Aug 2025 07:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754922814; x=1755527614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xzG9dwly6/ybnLqAtX/TNi8ZiyF2hyfrYYfwn4/D8JE=;
        b=LEobG1zZqL5Bbz4RFw9xrNnc1w343nHJ6cMHadK9hcoK6uHSEQfaj+cODuS2YFF7Y1
         EJoEu0wcr1OXefpct9tLLaVYrAdKNCnbeffJIZntFbyLJ1ion7lvlNGAHEPJTyWAC27u
         1S/ykQV96lhg4hERTlZ3lN5L9aUTgGMibP0nFh6vVf8gFjt8h/ePLniiSIRG/KHPCk9b
         L0+Dy86GKY2x1d9D1jeQ5b+lsZPOU6Tja61Jgz4EVIG+kxyF3dSd4YmDFxeOs/NzQ2UQ
         yswhRyI7RhE3K/CRzNlbkchz1msTvOvTGVRhYfu0U2XTvFUdM4/+wIrn88H6F9M/lU2D
         jPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754922814; x=1755527614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzG9dwly6/ybnLqAtX/TNi8ZiyF2hyfrYYfwn4/D8JE=;
        b=wBLNigB11UBagWI8/yH+ov++LxF2VucM3QZG/5RzbZePr6q1tXrY3YfHV1OyJ1Kl3f
         atHZDVoTNITXJUtbBkbjexkbdTXU7OYmzwZhHxg+RUNNxyoQwVls1dhHR6o5ppx9gysP
         gldKNXOw8sNg8vMQSLMvm0Xv1hKWK6SZN9LjEfl1jU8EkFa8qXL5LogdVfkhLTPLuV2u
         z7RO1X1dBSAZ/ZiSG1aZIDqvbIwamzpm88guNE57g3ofe9IwxphUTvHraiIsUvdF7K/r
         A/dLVNYgUYiGm1uBZ5BCdCFws+QaOA3t/0lFteSl/XbH8LogneQQxIhovA+Fk8QHS0xt
         P/pA==
X-Forwarded-Encrypted: i=1; AJvYcCVaG+lrHWsardMtezMfwBEXyOtlRI5iVCn8kYU+eaaTprFQ9oYlW0pG02rcrOqRSptrLDvZSLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcTW/gIZxuctt935tRyM8Sxm81XE09cCkEoh5i4y0knQsilWT7
	o4PifQ61BG/THrvHNSfeRJ/MxnvvxCpIkdDLlx/6Dt1I63e6A0a6Dn5zjm1MvXhAUNA=
X-Gm-Gg: ASbGncs6g0PMN/0HZmevzA0iRP1emYrgrF+DuMCr6iVIqODH1YTMDu26zeCe3z/gqTE
	v0fr9pgCJZ5/u3yLzbwZIGhxJoH7318cgdgVVKgO1d365m1aHI79ElAaira5sMedgQAnly/sGR/
	msIt9Fx3KfCRh5VN2vIXUxI9tUSK+sTV0wcz0zC8VwlIJ9SgyawKLR8tm231jGlCnKmFaJG79XN
	4sniPAs3boPGpsjygJgIgZ/yX54fz7YtGoUIbIMF/akaPFb2fxwrh2IrEXOG1+WlWuCiKdO7hdl
	+ZBVNfogj76igjUNCl6Fxdrh+S5l7V2L61PaaILhu40bjte2pCosIl8thG89++vX654ZSGh14Ei
	GmoBwGWi3+WnWf38SkqIO24F2
X-Google-Smtp-Source: AGHT+IExNC0c11zH/jGKM9+upItApkmYT9MY+l7zqDj6ODiv5e4/pyThgUPae5xjJdom1CpErhETJA==
X-Received: by 2002:a17:907:980f:b0:ae0:c943:785c with SMTP id a640c23a62f3a-af9c655d858mr1246144366b.35.1754922813819;
        Mon, 11 Aug 2025 07:33:33 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a1bf9sm2037944566b.31.2025.08.11.07.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:33:33 -0700 (PDT)
Date: Mon, 11 Aug 2025 16:33:31 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Gu Bowen <gubowen5@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>, stable@vger.kernel.org,
	linux-mm@kvack.org, Lu Jialin <lujialin4@huawei.com>,
	Waiman Long <longman@redhat.com>, Breno Leitao <leitao@debian.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH] mm: Fix possible deadlock in console_trylock_spinning
Message-ID: <aJn_Oxp3kKUF-fuR@pathway.suse.cz>
References: <20250730094914.566582-1-gubowen5@huawei.com>
 <20250801165228.6c2a009c0fe439ddc438217e@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801165228.6c2a009c0fe439ddc438217e@linux-foundation.org>

On Fri 2025-08-01 16:52:28, Andrew Morton wrote:
> On Wed, 30 Jul 2025 17:49:14 +0800 Gu Bowen <gubowen5@huawei.com> wrote:
> 
> > kmemleak_scan_thread() invokes scan_block() which may invoke a nomal
> > printk() to print warning message. This can cause a deadlock in the
> > scenario reported below:
> > 
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(kmemleak_lock);
> >                                lock(&port->lock);
> >                                lock(kmemleak_lock);
> >   lock(console_owner);
> > 
> > To solve this problem, switch to printk_safe mode before printing warning
> > message, this will redirect all printk()-s to a special per-CPU buffer,
> > which will be flushed later from a safe context (irq work), and this
> > deadlock problem can be avoided.
> > 
> > Our syztester report the following lockdep error:
> > 
> > ======================================================
> > WARNING: possible circular locking dependency detected
> > 5.10.0-22221-gca646a51dd00 #16 Not tainted
> > ------------------------------------------------------
> > 
> > ...
> >
> > Chain exists of:
> >   console_owner --> &port->lock --> kmemleak_lock
> > 
> > Cc: stable@vger.kernel.org # 5.10
> > Signed-off-by: Gu Bowen <gubowen5@huawei.com>
> > ---
> >  mm/kmemleak.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> > index 4801751cb6b6..d322897a1de1 100644
> > --- a/mm/kmemleak.c
> > +++ b/mm/kmemleak.c
> > @@ -390,9 +390,11 @@ static struct kmemleak_object *lookup_object(unsigned long ptr, int alias)
> >  		else if (object->pointer == ptr || alias)
> >  			return object;
> >  		else {
> > +			__printk_safe_enter();
> >  			kmemleak_warn("Found object by alias at 0x%08lx\n",
> >  				      ptr);
> >  			dump_object_info(object);
> > +			__printk_safe_exit();
> >  			break;
> >  		}
> >  	}
> 
> umm,
> 
> --- a/mm/kmemleak.c~a
> +++ a/mm/kmemleak.c
> @@ -103,6 +103,8 @@
>  #include <linux/kmemleak.h>
>  #include <linux/memory_hotplug.h>
>  
> +#include "../kernel/printk/internal.h"		/* __printk_safe_enter */
> +
>  /*
>   * Kmemleak configuration and common defines.
>   */
> 
> 
> I'm not sure we're allowed to do that.  Is there an official way?

The official way is to use printk_deferred_enter()/exit().

Note that the API is using a per-CPU variable. It must be called
with CPU migration disabled. The comment suggests disabling IRQs.
But it should be enough to disable preemption.

Best Regards,
Petr

