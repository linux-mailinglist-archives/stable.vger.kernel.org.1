Return-Path: <stable+bounces-172921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7965B356B0
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 10:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73931720EB
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 08:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF5027A11E;
	Tue, 26 Aug 2025 08:23:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1987B2248A4
	for <stable@vger.kernel.org>; Tue, 26 Aug 2025 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196598; cv=none; b=laxVqF7mLvrvCU86vE7QBQiDkkMr0WI0T5yQDCr7AGJSHVsaMPVgsRv8USdSco2EaQBr/9IU35wcPm5AfqO4IUIIkUhC1BCe4XjjAfWC9Q4KjsTy4Yx7qw5jmz8A00nTNSYq2Nyv8J/+c/bhZXNlJFb1Jb/bmMQniTabG/vqAAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196598; c=relaxed/simple;
	bh=Wulrl3nzwYRJMoN3k3QagyfBhQ1NYwxExLOjvKYIlEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cm0ScZGgv61NDa6oeWBhOnwHV+ttZij+y0gOguaYqlrl1OpXrYmNw50wSW+LacVJDBopHpO3J+CuWaORaFVuer3vpf69U5UXFqUjrzDalbTZq+wlUsc9tpxB+WmfhbU5Y8Voh0cq+j3fvVaZ49v7+uvHClFnikDLPj2LcGIIsyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61c5270f981so3409636a12.2
        for <stable@vger.kernel.org>; Tue, 26 Aug 2025 01:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756196594; x=1756801394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoEgUhgTXs7cJfDCjUXiIDAL+Ic7fYFRZOTC/mkCXTI=;
        b=qC0+GeZoI1J3u8IkUO/RPu5uBJmoOcAGBXIndoo3NJc/DDYKmPKkL2WXFWGOUXNtVm
         Oo3x5TVcC4TWlnzVSEZyQ16dLfBnjOlC/fP8hccGWO5igcYeoIPDHHI13jXytt4GLROM
         Vv92Dt70Cona/9T7oHd4xzMa9CjOK9tUrJ52E0fXKDUo6f9HqMCnuCjD91UUt7HPV8tt
         HJY3LLjtRafrOm3FoEptKZO9MMUGM66HVoODMi+Lot4DmAaB2BUWXwgZFGc3/OEdscOu
         hEZkVMSQGgqgWJwbnHoz8Uho20vvcpnwT4+jvNuAnOhB6LPSxOCfOWKWdtA2LnLtetzH
         8zQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNdI/I7Z2aUBDApFafYu+FAY7CL11Eb7U2Q/qQ211V0awMyTJDMYgSclvWQZaXsKXpFWmjZzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWAOJwGMDM1seeXDMazzMNyuv/zZAAS3kNO+rR06TwUzM3BVLL
	cQQML5htzpcjdNEG7j9SJPomB0ZxZ/YI6tMfmqxs9tbxsY+iSYvnMsuV
X-Gm-Gg: ASbGnctntQs3zzkAAAsK3d1CstdlAssjm44piSZRV7KcdzH7HpStvpsqK7bSAE/RHh/
	iJ3Gqm7SEaaxhGuprgUlekaxDPdcUp7P0/jCCaA12cU1UYZIjsJyiPhU5/GTji5uw9+YT1ehdVo
	qBKlUKbYXzf0BS+HD7QoCTyMOfL7wIJXFPHzE3Pbmb6IzbaJlpyWBquhupRuwnrECvPFn8MVsfR
	1W8SZHw6uBiplV/KQaRI1dUO6CgYYbEayDrk5CrnmyXl/55NCJzzdvcBXQ/SHFd/9I97ZOnqAsv
	iYkIukhTfEcgZIXUHNfbg43O1NrRBBHrcFk7i6v4vy++I8VQUc75HC4wbOmis+NMOdDYsN+LeLW
	pXb4dMJYqw23O
X-Google-Smtp-Source: AGHT+IGX5sDuhW+5W6VbsXdfJT3rGtM8X/CzpCSqDXv2mDL8i0YM9mxTFCKQLQee6hpN7FF6DkcmCA==
X-Received: by 2002:a05:6402:4390:b0:618:2fde:8fba with SMTP id 4fb4d7f45d1cf-61c1b45c326mr12436871a12.4.1756196594167;
        Tue, 26 Aug 2025 01:23:14 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c533e96dfsm4883755a12.18.2025.08.26.01.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 01:23:13 -0700 (PDT)
Date: Tue, 26 Aug 2025 01:23:11 -0700
From: Breno Leitao <leitao@debian.org>
To: Gu Bowen <gubowen5@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Waiman Long <llong@redhat.com>, stable@vger.kernel.org, linux-mm@kvack.org, 
	John Ogness <john.ogness@linutronix.de>, Lu Jialin <lujialin4@huawei.com>
Subject: Re: [PATCH v5] mm: Fix possible deadlock in kmemleak
Message-ID: <fv4epzbozkpbyuaqt37zt5th3diwmav73cfzdap5kx23j456im@7u5kw5eip3xd>
References: <20250822073541.1886469-1-gubowen5@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822073541.1886469-1-gubowen5@huawei.com>

On Fri, Aug 22, 2025 at 03:35:41PM +0800, Gu Bowen wrote:
> There are some AA deadlock issues in kmemleak, similar to the situation
> reported by Breno [1]. The deadlock path is as follows:
> 
> mem_pool_alloc()
>   -> raw_spin_lock_irqsave(&kmemleak_lock, flags);
>       -> pr_warn()
>           -> netconsole subsystem
> 	     -> netpoll
> 	         -> __alloc_skb
> 		   -> __create_object
> 		     -> raw_spin_lock_irqsave(&kmemleak_lock, flags);
> 
> To solve this problem, switch to printk_safe mode before printing warning
> message, this will redirect all printk()-s to a special per-CPU buffer,
> which will be flushed later from a safe context (irq work), and this
> deadlock problem can be avoided. The proper API to use should be
> printk_deferred_enter()/printk_deferred_exit() [2]. Another way is to
> place the warn print after kmemleak is released.
> 
> [1]
> https://lore.kernel.org/all/20250731-kmemleak_lock-v1-1-728fd470198f@debian.org/#t
> [2]
> https://lore.kernel.org/all/5ca375cd-4a20-4807-b897-68b289626550@redhat.com/
> ====================
> 
> Signed-off-by: Gu Bowen <gubowen5@huawei.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

