Return-Path: <stable+bounces-87599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C529A702F
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 18:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215051C21968
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 16:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6D91E9088;
	Mon, 21 Oct 2024 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4r7T+Al"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1B619939E
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729529827; cv=none; b=YvDmUvqmT/8vrCeJEZ+ROCWqgf7ZF7GR5yjpBb16NzGgtBRL0z0cF+AMY5yECHgOxyqxJacP8rgE5BiPZZeVw9z64mEmTBfGG66Nj5CITIgKUzEcjdnTALecVcB+MQIH+hSU7Pc49yg0ZKhXByUw3/8edR8W23I+jLja0Z1GZY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729529827; c=relaxed/simple;
	bh=5S0TGg8jgrQlW57qIoAG0g2eeDejXK0LPq804MUBGwQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpNGWPDMv/7kr9nqKEEIyByyiMNgEezIly/56bbwVS59LYrn05oKuwt15CRRqkEX6Ka/1squASzVLQxz1qS5/mhU+W1f2t9O+J9uV2y/oQvxsJoaU1l8iOo2dapGQKtmZDwafsQlolQkfmNEKjEvdJKPipIMHS0ELEDjnFrplsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4r7T+Al; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so5342253e87.1
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 09:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729529823; x=1730134623; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M273fnt+DSl6Al76DCKRa+RzcpBVSp9P2WGr087VQgs=;
        b=m4r7T+Al9GtfaKF66RZWH862eP+q4Iohh7KFe5D4oogup9D9NckLnHW/PQXsAALPUY
         4lgfyf5lhb0b1sLzXXLrG7DRP4b9gdPNzFjkqxxfVZipqQguQx5Xi8Zp+hl5wSgzkjyu
         q+mGg+jfOMrbw/g3cA8ly4g/JeS+CyUJ1amUWE5a+4yVABsdONmVcgM7lmZ8crugmmsj
         dOFk859BGirvEs12gr5osoibdBfU72rrlxRZpPILgJRKCrwrbLEODWGAvtjFgdw0YhIh
         cV0CTxK6XfYo6rsr/5wHXNv/Ol2b4SBi6FyJyXiZaqEsTh1T9Ixxvzhn7YAvtWl4EX2O
         Dtrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729529823; x=1730134623;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M273fnt+DSl6Al76DCKRa+RzcpBVSp9P2WGr087VQgs=;
        b=l2sLo3a5d1NuDb9sYWGUnwgOBt1ONAZ3ufnjMjeKBaYjBjQufY4oFtbYnIOpvssNJZ
         N3UQmO/de9pOudMcKAO87j6rApvzjuxXP9I/TD9sRe/Rhc5S6Sua5jTXxyn1ckUR5htX
         EImYHrUc06qnWRJ8M5rAk1Xq2K7musAtznPVq+0LSIm6sO4JQkykM6lGK0DqufEB2m4e
         Hh4LRWZ6ydeQs1luQZLrXbdnH+UjHE+KTL97n9wnt1szjkfUVI3qMr55218UywykMYG3
         og48uJ+bxF/p7mBgpbsAOlQrddqn4rldhDLkwGi8jglPnOizJf0SC4GSH3mdo47+czru
         tASA==
X-Forwarded-Encrypted: i=1; AJvYcCX5BuenrdA5zVOdxOxEpUoFosXsiknGnIHo2A6Rsn4wKnBhxOLF7pYPOk0/QMGV8IBAn/B12eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRpWveuhO6ioVi6u1cNSxaR/4wrJZ8jRigTq7hDHrfIOH3nRin
	GhXqcl0fDHqdwwcf8CndJfZPLpYjLlPJanGvndDrepEQ5ucfQwEp
X-Google-Smtp-Source: AGHT+IFYpm/XNpPUmsU0edtr5Nc8/3sONWWu91dkTXMHsL2/ggGcRxWNKSri284ojmcZ6O875LoDDg==
X-Received: by 2002:a05:6512:ac8:b0:539:ff5a:7ea5 with SMTP id 2adb3069b0e04-53b12bfdabdmr371844e87.15.1729529823031;
        Mon, 21 Oct 2024 09:57:03 -0700 (PDT)
Received: from pc636 (host-90-233-222-236.mobileonline.telia.com. [90.233.222.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a22431548sm517613e87.223.2024.10.21.09.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 09:57:02 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 21 Oct 2024 18:57:00 +0200
To: Suren Baghdasaryan <surenb@google.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Ben Greear <greearb@candelatech.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	Florian Westphal <fw@strlen.de>, Vlastimil Babka <vbabka@suse.cz>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.11 024/135] lib: alloc_tag_module_unload must wait for
 pending kfree_rcu calls
Message-ID: <ZxaH3KsZD8voFtBL@pc636>
References: <20241021102259.324175287@linuxfoundation.org>
 <20241021102300.282974151@linuxfoundation.org>
 <a4163f51-cc1a-0848-d0fd-e9b94dafc306@candelatech.com>
 <ZxZ_uX0e1iEKZMk5@pc636>
 <CAJuCfpGwBixidbi1D-+6b6BrM7Ggob-1NZApo_+dny_T2qNAzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGwBixidbi1D-+6b6BrM7Ggob-1NZApo_+dny_T2qNAzw@mail.gmail.com>

On Mon, Oct 21, 2024 at 09:51:58AM -0700, Suren Baghdasaryan wrote:
> On Mon, Oct 21, 2024 at 9:22 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > On Mon, Oct 21, 2024 at 09:16:43AM -0700, Ben Greear wrote:
> > > On 10/21/24 03:23, Greg Kroah-Hartman wrote:
> > > > 6.11-stable review patch.  If anyone has any objections, please let me know.
> > >
> > > This won't compile in my 6.11 tree (as of last week), I think it needs more
> > > upstream patches and/or a different work-around.
> > >
> > > Possibly that has already been backported into 6.11 stable and I just haven't
> > > seen it yet.
> > >
> > Right. The kvfree_rcu_barrier() will appear starting from 6.12 kernel.
> 
> I have 6.11 backport for this fix which also includes
> kvfree_rcu_barrier() backport. I was waiting for this fix to be merged
> into Linus' tree and now I can post it. Will send it shortly.
> 
This is good, i reacted because i have not see the "other parts" yet.
So, sounds good!

--
Uladzislau Rezki

