Return-Path: <stable+bounces-121424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C77A56EE6
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 18:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 325A43B736D
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 17:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCD023F417;
	Fri,  7 Mar 2025 17:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FIE9QcRS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9EC221D92
	for <stable@vger.kernel.org>; Fri,  7 Mar 2025 17:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741367899; cv=none; b=dGK1XsgGxZBeCK3jW/0vLIwicaTOKQk6iBqQz+5oHVSrmnVwoHgC8CfBfNRnUrt9+oakZOgV9y+u2qGMncObiUgl7O2yGx4DcTZhxGJlbljEDPpXxjSZSjGG209kvLCHy46Z4G2NPjnhpfdvka4rCP7YVrPQkZ6PXrdVSKDVuTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741367899; c=relaxed/simple;
	bh=Exa+LJbtcRhil2Mq0hG1/BWNs/UE6mgwSzeGSV6F5J4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XKbs6gg/AM5xubrIW/JnGMAUcfACk4eNxpN1l1lhQpFtTGvkWPvI2C9cmMmeEVSBoM366IAdYLKU59qFv4lKYk0Po0DaQfIfD1djiT+EWHWPfNgDzTEoi4biiQptJKydsoGCu8SWZwMV6q0o5qMw+G1FlIMdf0n8DyZRRCm6ZrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FIE9QcRS; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2f9b8ef4261so533237a91.1
        for <stable@vger.kernel.org>; Fri, 07 Mar 2025 09:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741367897; x=1741972697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Exa+LJbtcRhil2Mq0hG1/BWNs/UE6mgwSzeGSV6F5J4=;
        b=FIE9QcRSX3czE47b6rsAH1Zwwz32B5bPDVSm6xyk5NQACjPKe07k4mEgtSsrOYtOR5
         GXICiBd9lf4z6UMqkGNGS83oxk8Dfp88K2PL0gvpHzM4yANqrheZBlLfdVWHsRJlkier
         Btn3btH01eNIRk0bSndkc87qdy9at1/9kpMRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741367897; x=1741972697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Exa+LJbtcRhil2Mq0hG1/BWNs/UE6mgwSzeGSV6F5J4=;
        b=KqBSFDj3GtPOdH6HcAvN74l8yUacQQtAg2gRjTqn7ufHgeAcJqpIJFSWMCmy0jyfQd
         Y90jcPwwfod10hJU8pR1XfvA08jbfMybf8sf8s5fM7EINP656EtoeYmTLPOZ1JCdc3uO
         xGFkMGWI4CH63riP5EHt1mob1dSf2ZH8PiIHFb05xTyII3h0jJmUQXzeFfc45jWqOMPK
         7Y428GWD4NQ59AsS2dG0IDOPdfXwln8TJafA3g++Rj8p1R6PjE25+J0mkEcZPB2ZmpSk
         pfc+JgqRXENLgmugn/arNCJPnoexMRhq6bu6xpOliAdnxiVghDkvlUT4cwiZk4aNpW/W
         DsoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvwtoiHMlajUBdFaXvO+FKtew2w141ZChIAY7ubx5pjNxMR6FP/g3QqUB/kB2UI2vRwMgOxC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc6WbFB32C1i2vbzaL2BkMB5nZ/k311biFUjOKXoKclyGfl4sp
	aKEnFVjRdjSVY17CRLriSBc/fDJtoS3dF4cf/Q2S/nHF0h7jh8aDEsqh7neQOfJJOwJswVDqZ2O
	b+oxaWxJGBc5IrKNxdQLYCFvOC1dPmaQY3fQ+
X-Gm-Gg: ASbGncuNMa3XMH3hA2uF12LRTiicFZMt0OabKsI3DsfJ6r2+kv571smdC7YRGkq+BCr
	zkKYSwLXAbbPtZMn/DbBuZY4O8jtwO7B4ZVhzoF2uQ5jy3Vr1tGHx3HWEAlr39vtsM91fSRT9M2
	fhfp7JYjGR7RoAcwuYQJmYAdQpj3apEQYL9XgoUbSwB82hkRNw5ijzGQ==
X-Google-Smtp-Source: AGHT+IFj5m3zt+Gojvekzq1fuZQVeCyz7gnyUq6Vkk5e58fHmXRr37924drMwzNvEPdMxqSim6hQiGW+lLcrdQ24yGY=
X-Received: by 2002:a17:90b:3891:b0:2ee:6d73:7ae6 with SMTP id
 98e67ed59e1d1-2ff8f9100d3mr215985a91.7.1741367896144; Fri, 07 Mar 2025
 09:18:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307131243.2703699-1-revest@chromium.org> <2cf9798f-1a89-46e1-b1a4-7deec9cb7e40@intel.com>
 <CABRcYmLcXosu62EbTMQNGCEa+mmNtRKCQX8oL=WDrgP-UH6B_g@mail.gmail.com>
 <c43a1936-d8a6-42f4-bcfe-d4de56b38f10@intel.com> <20250307164429.GCZ8sibd8HT8R7gfs9@fat_crate.local>
In-Reply-To: <20250307164429.GCZ8sibd8HT8R7gfs9@fat_crate.local>
From: Florent Revest <revest@chromium.org>
Date: Fri, 7 Mar 2025 18:18:05 +0100
X-Gm-Features: AQ5f1JqIuoJsdDgTu7BibzmQNR2gwIlvFpXiSsIrvcT9AYke3jwOXnvwRZLjc5c
Message-ID: <CABRcYmLg3NG3VDDojxhX0sh89CAYksYAcMHmKcobGWrXVihMdQ@mail.gmail.com>
Subject: Re: [PATCH] x86/microcode/AMD: Fix out-of-bounds on systems with
 CPU-less NUMA nodes
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 5:44=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrote=
:
>
> On Fri, Mar 07, 2025 at 08:32:20AM -0800, Dave Hansen wrote:
> > On 3/7/25 07:58, Florent Revest wrote:
> > > One thing I'm not entirely sure about is that
> > > for_each_node_with_cpus() is implemented on top of
> > > for_each_online_node(). This differs from the current code which uses
> > > for_each_node(). I can't tell if iterating over offline nodes is a bu=
g
>
> You better not have offlined nodes when applying microcode. The path you'=
re
> landing in here has already hotplug disabled, tho.
>
> > > or a feature of load_microcode_amd() so this would be an extra change
> > > to the business logic which I can't really explain/justify.
> >
> > Actually, the per-node caches seem to have gone away at some point too.
> > Boris would know the history. This might need a a cleanup like Boris
> > alluded to in 05e91e7211383. This might not even need a nid loop.
>
> Nah, the cache is still there. For now...
>
> for_each_node_with_cpus() should simply work unless I'm missing some othe=
r
> angle...

Awesome - thank you both! I'll send a v2 using
for_each_node_with_cpus() ... On Monday :) Have a good weekend!

