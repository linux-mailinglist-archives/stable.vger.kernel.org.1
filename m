Return-Path: <stable+bounces-17638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E102F84644D
	for <lists+stable@lfdr.de>; Fri,  2 Feb 2024 00:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83B9DB24451
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 23:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D64347A73;
	Thu,  1 Feb 2024 23:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gc04doKz"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1522A47A6F
	for <stable@vger.kernel.org>; Thu,  1 Feb 2024 23:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706828934; cv=none; b=kt828e6L5nA9bLiF0oevSVADk0XwChTMW0fmR8CiHukms+5qmVsJ0dd6fX/HQFffIImXZfD4QmxMNnFaVRVU228/cu0wk34Z1PPHMiVREgEj2QWgoPC7dOUOzKS/mt9+Ehmqh+lvygS5+VJnzluU3Qen40j1ynF/x4exjnaYmw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706828934; c=relaxed/simple;
	bh=M9Rbd1TTFJHpw9s+5sNyKj1m810A0YRxxUYpqz9R2Yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=By4vQSnmQhF0IdlR8Jwer1xZ1ytk4oUopi6odZQ2y2ad+8skCbjlkdNpW8g4IGqI9bl/IN27lwlaxartDL8jW0I7aSz5Vo01SEKqVomyZTqZVPI76f0eKY+wjBr3LloU+TXl5QnSVc9cA5m/W2mmimb0qQWNWXOHVIyXaEiV7DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gc04doKz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706828931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lIys8ywl8dUROimT8NQnX8daI13tCkTHScBncJRrjoE=;
	b=gc04doKzUig6ezytRCOGb85WK4E9cpwDuUqdPXYZa/XD8H0Rq4UtCYNZpH/xg+pyusfB25
	XTi9LuiTkzEebV8nhXPMjLMrHNDGcUH2wetWpBIPkqFCEkbz19rZLq8ePXv9GsM2MdkPNc
	TIo8rsHJGIDzCS3gGO0F3grjq3AA4m8=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-S5OvLqwkPPyRCLIvBXXdNA-1; Thu, 01 Feb 2024 18:08:49 -0500
X-MC-Unique: S5OvLqwkPPyRCLIvBXXdNA-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-7d6072ed12eso831263241.3
        for <stable@vger.kernel.org>; Thu, 01 Feb 2024 15:08:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706828929; x=1707433729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIys8ywl8dUROimT8NQnX8daI13tCkTHScBncJRrjoE=;
        b=HmnhLa5UBeMFNsjXAKP74xV9Xg2VeWKLA6mmYgfArI47rDYAsf+Mv+RkQvqpqS2mds
         OejFx6mWV6CLUnKV89inxWmhmgu6XAtookmXDgHfJETggXaxHKvlGMKCWLa6weNrKV9J
         qv/gnolhTsFJ3aozSu85Mluyb1mClIRjPjhyQkCPjc19/l1//hpHO3NSwgegITh0YkFJ
         g7Zz11hm/q23FyjjjveCYVhwB/VDc/IkhjAgetoiMGVZv4tvjFU5uQR+GsbCnmnBIoDu
         3/WZuwILlBbfcj5T3AFcM0gb9hw1RCcKE44oVbh0SCsvdXR9UcCJQttMXqbjRjPDJuez
         bSYQ==
X-Gm-Message-State: AOJu0YylvdiR+WsOJ+S1t7hYvs5E39CG2stIM7CXJuU6fEeL2sp9d1K3
	HawFuQApDUOB3ifwpK+XZLSvPps0rE8WN2Z0ASvbMcVZn+W4u/TMq2Ruzk/00T0Q+AAdLulV1En
	zej0e4D+g5pK5mENYviFSxNmGBkN47BHt0hUQLAoI5n4h/mZIlE8iT5bX1UXpHoh7lT9ol/+bWB
	mR9g9zihpTwW95UPz4Z4RjlaKdkRpc
X-Received: by 2002:a05:6102:3bc7:b0:46b:2aa2:a979 with SMTP id a7-20020a0561023bc700b0046b2aa2a979mr5287966vsv.20.1706828929146;
        Thu, 01 Feb 2024 15:08:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5PMIvH8mlOxCH1g5Ms06GYARDVSWb3KEdt+hQjQ4g1UroC8JkAVJu8a/+TAM7qVlOYKk+QUPlKtsT5+8lyxw=
X-Received: by 2002:a05:6102:3bc7:b0:46b:2aa2:a979 with SMTP id
 a7-20020a0561023bc700b0046b2aa2a979mr5287948vsv.20.1706828928875; Thu, 01 Feb
 2024 15:08:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131230902.1867092-1-pbonzini@redhat.com> <2b5e6d68-007e-48bd-be61-9a354be2ccbf@intel.com>
In-Reply-To: <2b5e6d68-007e-48bd-be61-9a354be2ccbf@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 2 Feb 2024 00:08:36 +0100
Message-ID: <CABgObfa_7ZAq1Kb9G=ehkzHfc5if3wnFi-kj3MZLE3oYLrArdQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] x86/cpu: fix invalid MTRR mask values for SEV or TME
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Zixi Chen <zixchen@redhat.com>, Adam Dunlap <acdunlap@google.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Kai Huang <kai.huang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 7:29=E2=80=AFPM Dave Hansen <dave.hansen@intel.com> =
wrote:
> I really wanted get_cpu_address_sizes() to be the one and only spot
> where c->x86_phys_bits is established.  That way, we don't get a bunch
> of code all of the place tweaking it and fighting for who "wins".
> We're not there yet, but the approach in this patch moves it back in the
> wrong direction because it permits the random tweaking of c->x86_phys_bit=
s.

I see your point; one of my earlier attempts added a
->c_detect_mem_encrypt() callback that basically amounted to either
amd_detect_mem_encrypt() or detect_tme(). I bailed out of it mostly
because these functions do more than adjusting phys_bits, and it
seemed arbitrary to call them from get_cpu_address_sizes(). The two
approaches share the idea of centralizing the computation of
x86_phys_bits in get_cpu_address_sizes().

There is unfortunately an important hurdle for your patch, in that
currently the BSP and AP flows are completely different. For the BSP
the flow is ->c_early_init(), then get_cpu_address_sizes(), then again
->c_early_init() called by ->c_init(), then ->c_init(). For APs it is
get_cpu_address_sizes(), then ->c_early_init() called by ->c_init(),
then the rest of ->c_init(). And let's not even look at
->c_identify().

This difference is bad for your patch, because get_cpu_address_sizes()
is called too early to see enc_phys_bits on APs. But it was also
something that fbf6449f84bf didn't take into account, because it left
behind the tentative initialization of x86_*_bits in identify_cpu(),
while removing it from early_identify_cpu().  And

TBH my first reaction after Kirill pointed me to fbf6449f84bf was to
revert it. It's not like the code before was much less of a dumpster
fire, but that commit made the BSP vs. AP mess even worse. But it
fixed a real-world bug and it did remove most of the "first set then
adjust" logic, at least for the BSP, so a revert wasn't on the table
and patch 1 was what came out of it.

I know that in general in Linux we prefer to fix things for good.
Dancing one step behind and two ahead comes with the the risk that you
only do the step behind. But in the end something like this patch 1
would have to be posted for stable branches (and Greg doesn't like
one-off patches), and I am not even sure it's a step behind because it
removes _some_ of the BSP vs. AP differences introduced by
fbf6449f84bf.

In a nutshell: I don't dislike the idea behind your patch, but the
code is just not ready for it.

I can look into cleaning up cpu/common.c though. I'm a natural
procrastinator, it's my kind of thing to embark on a series of 30
patches to clean up 20 years old code...

Paolo

> Could we instead do something more like the (completely untested)
> attached patch?
>
> BTW, I'm pretty sure the WARN_ON() in the patch won't actually work, but
> it'd be nice to work toward a point when it does.
>


