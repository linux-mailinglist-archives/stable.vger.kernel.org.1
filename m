Return-Path: <stable+bounces-10928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8686D82E05D
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 19:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B702831D3
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 18:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661FD18B15;
	Mon, 15 Jan 2024 18:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hAK/VnFs"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA2718AEE
	for <stable@vger.kernel.org>; Mon, 15 Jan 2024 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705344913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GthAXNtsk/z7gO/RnYZ5f/Z0hY8DxVn6/8xfaoTAglE=;
	b=hAK/VnFsiM9KXLcvb4UF4W7zf27CVpSlIHLedgytb0SZSOv22D8Xui3aYBMuiC3LLvbjX8
	cHJ7Go4XWmlqdaRYJi7XvfLmumz+dZIVdZqw6wFpx7uCrhwsymZhxfF8/lEM7NgTyUDVEA
	27FbqMUoN1EgMmdblznCftk/RDwzDpM=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-nf6NPiELO2S5RTrYM9MGPg-1; Mon, 15 Jan 2024 13:55:12 -0500
X-MC-Unique: nf6NPiELO2S5RTrYM9MGPg-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-dbed0713422so7038130276.0
        for <stable@vger.kernel.org>; Mon, 15 Jan 2024 10:55:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705344911; x=1705949711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GthAXNtsk/z7gO/RnYZ5f/Z0hY8DxVn6/8xfaoTAglE=;
        b=EPZf05MqubhKNV7/oWZC7LdCLSkNh2D99I/mf6lNZ8IhC/6J+OZZ0sxwjJZx4QVjpb
         3hVpij1RG6cpsYlPaT5+lM9igsV+7u+3OdS2LTqevrNApZkpg0N1wYhnstAmjqoRlm3e
         POA49n5Dz9yZTW7jmfawAKQLiwv2aDMEvJlaLoYpuzFPSeeiCZQBJUb1JeMdHicBf1Zu
         TlqZkZeDI55kAMa8NLKdmuaVAARDB1UDwrvTHWepNdO+XurrtTm1xY26orP8+tRQ9vv2
         /ExGZVVFsn00YQJ2slxVd12UWC3HO6uxJdeQR77WNgBvLseJI7huU/wWLDjRCVpws7bD
         9FxQ==
X-Gm-Message-State: AOJu0YzMz+wuc2cHFNEYej5NwDKpO+PD/bKvuJzg/EeJq2uhIkMbGkHb
	XwNftXq2kHRMvOZ/B6+M/3HBu5deIuiNL3UBv2CY+2LGxNbfQHKHg1khD9OsVw31dXySLHtMwZR
	DHfe04mV/8maf9JxbdnLRUm5ilNIsdbPe7R1nz6tz0iWsHj3QVuQ=
X-Received: by 2002:a25:d287:0:b0:dbe:ab15:2ffc with SMTP id j129-20020a25d287000000b00dbeab152ffcmr2223271ybg.108.1705344910972;
        Mon, 15 Jan 2024 10:55:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8/Pr+RHGkHS1w1pJSo1nV+YfK7/PsArpNSUrdCY6hNsPiQe4QgkfgzOOzYdHkj/WNdw6IrZQaM29w1oXEqfY=
X-Received: by 2002:a25:d287:0:b0:dbe:ab15:2ffc with SMTP id
 j129-20020a25d287000000b00dbeab152ffcmr2223261ybg.108.1705344910694; Mon, 15
 Jan 2024 10:55:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115102202.1321115-1-pbonzini@redhat.com> <2024011502-shoptalk-gurgling-61f5@gregkh>
In-Reply-To: <2024011502-shoptalk-gurgling-61f5@gregkh>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 15 Jan 2024 19:54:59 +0100
Message-ID: <CABgObfZ0gpw2-n2d5vyEjuCefOp+3TPyUuMvjScAbae2GKfO0A@mail.gmail.com>
Subject: Re: [PATCH stable] x86/microcode: do not cache microcode if it will
 not be used
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, x86@kernel.org, 
	Borislav Petkov <bp@suse.de>, Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 7:35=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Jan 15, 2024 at 11:22:02AM +0100, Paolo Bonzini wrote:
> > [ Upstream commit a7939f01672034a58ad3fdbce69bb6c665ce0024 ]
>
> This really isn't this commit id, sorry.

True, that's the point of the mainline kernel where the logic most
closely resembles the patch. stable-kernel-rules.rst does not quite
say what to do in this case.

> > Builtin/initrd microcode will not be used the ucode loader is disabled.
> > But currently, save_microcode_in_initrd is always performed and it
> > accesses MSR_IA32_UCODE_REV even if dis_ucode_ldr is true, and in
> > particular even if X86_FEATURE_HYPERVISOR is set; the TDX module does n=
ot
> > implement the MSR and the result is a call trace at boot for TDX guests=
.
> >
> > Mainline Linux fixed this as part of a more complex rework of microcode
> > caching that went into 6.7 (see in particular commits dd5e3e3ca6,
> > "x86/microcode/intel: Simplify early loading"; and a7939f0167203,
> > "x86/microcode/amd: Cache builtin/initrd microcode early").  Do the bar=
e
> > minimum in stable kernels, setting initrd_gone just like mainline Linux
> > does in mark_initrd_gone().
>
> Why can't we take the changes in 6.7?  Doing a one-off almost always
> causes problems :(

The series is
https://lore.kernel.org/all/20231002115506.217091296@linutronix.de/

+ fixes at
https://lore.kernel.org/lkml/20231010150702.495139089@linutronix.de/T/

for a total of 35 patches and 800 lines changed.

There is no individual patch that fixes the bug, because it wasn't
really intentional in those patches; it just came out naturally as a
consequence of cleaning up unnecessary code. It is fixed as of patch
7, so one possibility would be to apply patches 1-7 in the series
above but, especially for older kernels, that would be way more scary
than this three line patch. It literally says "if microcode won't be
loaded in the processor don't keep it in memory either".

Paolo

> What exact commits are needed?
>
> thanks,
>
> greg
>


