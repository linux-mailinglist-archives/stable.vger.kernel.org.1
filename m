Return-Path: <stable+bounces-95779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE4F9DBFA7
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 08:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0432816C8
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 07:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB19156646;
	Fri, 29 Nov 2024 07:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ur5LtPlI"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F7B1537C3
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 07:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732864304; cv=none; b=CKIYJaoIBRU0IKdT8P0a6P8r1ioTaFyzTZ7NR0kxYwsHdZSmHG2yKigJfvaZV+CegEXB26VSnmFBh68UIOJhMaflHC9/sz9GiE0jNdvZgB/WLa1K/bUgP32N6m549+Gi7xftZCHpP4mEdGJxpe5jzHAdHjXFmj2H705f30onGxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732864304; c=relaxed/simple;
	bh=8VcFjYDKaw3Qsc17Njnz6igX6rknkM4yf+dmt/yglcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+dnuCJaV/FjFa0uYE7KzG2HbAGlgCo5J7fL8S9kUILXN7FMuFgPVfyIOWh6Ot+yjJ3+cad9n5qo8rvz0/gcneAcjeEKINTr2kIUpZWGTQkx1V4WH3qGNivraRLwy7zqcHl70oSjwRrCxn5Q/q1yRmFUi4HNitFwvjSh7TwgjGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ur5LtPlI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732864301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FWT0OxMsEzDV+GInq5dR2gW9nX3HUCC+dF6QXlOVL+E=;
	b=Ur5LtPlItrV9wlHqzFlObVfsUJP1Ixx4MvHW+4rdigr/mu59S6PGa1x+j3EHvjb5XIr++4
	MuPEJtMNkN6dxlwUh2s1pEDiyqHMYrQib5wFbBvKI93jyz4ibS9BL7td2cb+sETFSR3ND7
	GBC3l5Swh2r7nuQHmFz9jqNMSYVWcz0=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-YDQbU1wUOrWng0lvinoBjA-1; Fri, 29 Nov 2024 02:11:39 -0500
X-MC-Unique: YDQbU1wUOrWng0lvinoBjA-1
X-Mimecast-MFC-AGG-ID: YDQbU1wUOrWng0lvinoBjA
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83e5dc9f6a4so199775739f.0
        for <stable@vger.kernel.org>; Thu, 28 Nov 2024 23:11:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732864298; x=1733469098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWT0OxMsEzDV+GInq5dR2gW9nX3HUCC+dF6QXlOVL+E=;
        b=U+BGsIRiGYISyTw6vSXvyZeZ7jSjfe2RodN2Rs98st+pxc2lpsCB1/jCjY6Bxoh3vD
         Vyg+tbXzuJqedtAHdkEC8FL1tg8B/ixqenImZF00UY0HalJDkMAI+KUvU2pBSI6vMNUg
         31BCJStj3ZxXOmYtEcaC3Ou41nuBvw51heuWJBD12AvXNfiFD31ciBmNtFQK0Ltot4Tc
         IRxUQDMZXXiN/4smarmJ7W4pRwK5nwF5tp4A6Pe0Mi2exPZKAWkXPZhhSFQw57PdeSW7
         F4QGOmJOSbK1upcoOcXjxFENj3WLvBEM6OoTWAUzbK+TJnCku2sPr2991ffGkLH70Sqr
         7yfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHJI2+eAqUCRxOK6Yf2GrhLq5PCnKKNBBJckFbecAR+LeARfywP9Mqj5FRcefCxEd6Jlrmpyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaVbKAkhvRIGwxAvIKb+y5agkieSPfSeWQx1Tg64lGF8hF1Zw/
	apFM6PqOjxZqXfp/CBkZz188jVwP3m+yf2TfBLIEycGUSSaatjLgq2HL9ak5QkE8QM9nl4tFN6X
	1dHwZ/sez0zrREAO6oa9QggORCEtFk+gKnuIOo7DrRbzQ5DJNA3onKcYXBFA3Y7uSiSTCGjAe3g
	Pa2/xWWBQBLNaaK0klFFgagXd9rUql
X-Gm-Gg: ASbGncubEzMsNEWjWVkRogNZxIctXmK+8P8cu2RLXLZe3ghNDUJ9/6k5PBgK6BUhQqb
	FwYMfai0uiyzqWlF9OjtJ6Y/u5GsgsYIS
X-Received: by 2002:a05:6e02:1b01:b0:3a7:9b16:7b6c with SMTP id e9e14a558f8ab-3a7cbd45e72mr58232305ab.9.1732864298351;
        Thu, 28 Nov 2024 23:11:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaJIDjEubmCy0aOLU9g/LdsGvxQayrOWZjhM4HHxnHxAtqspZGb5f7pNvetVWe16XLz7C0JNOwniYKeQx8YGA=
X-Received: by 2002:a05:6e02:1b01:b0:3a7:9b16:7b6c with SMTP id
 e9e14a558f8ab-3a7cbd45e72mr58232215ab.9.1732864298121; Thu, 28 Nov 2024
 23:11:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112185217.48792-1-nsaenz@amazon.com> <20241112185217.48792-2-nsaenz@amazon.com>
 <CALu+AoTnrPPFkRZpYDpYxt1gAoQuo_O7YZeLvTZO4qztxgSXHw@mail.gmail.com> <D5XXP2PU3PUK.3HN27QB1GEW09@amazon.com>
In-Reply-To: <D5XXP2PU3PUK.3HN27QB1GEW09@amazon.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 29 Nov 2024 15:11:33 +0800
Message-ID: <CALu+AoSDY6tmD-1nzqBoUh53-9C+Yr1dOktc0eaeSx+uYYEnzw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/efi: Apply EFI Memory Attributes after kexec
To: Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Matt Fleming <matt@codeblueprint.co.uk>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stanspas@amazon.de, nh-open-source@amazon.com, 
	stable@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Nicolas,

On Thu, 28 Nov 2024 at 23:58, Nicolas Saenz Julienne <nsaenz@amazon.com> wrote:
>
> Hi Dave,
>
> On Fri Nov 22, 2024 at 1:03 PM UTC, Dave Young wrote:
> > On Wed, 13 Nov 2024 at 02:53, Nicolas Saenz Julienne <nsaenz@amazon.com> wrote:
> >>
> >> Kexec bypasses EFI's switch to virtual mode. In exchange, it has its own
> >> routine, kexec_enter_virtual_mode(), which replays the mappings made by
> >> the original kernel. Unfortunately, that function fails to reinstate
> >> EFI's memory attributes, which would've otherwise been set after
> >> entering virtual mode. Remediate this by calling
> >> efi_runtime_update_mappings() within kexec's routine.
> >
> > In the function __map_region(), there are playing with the flags
> > similar to the efi_runtime_update_mappings though it looks a little
> > different.  Is this extra callback really necessary?
>
> EFI Memory attributes aren't tracked through
> `/sys/firmware/efi/runtime-map`, and as such, whatever happens in
> `__map_region()` after kexec will not honor them.

From the comment below the reason to do the mappings update is that
firmware could perform some fixups.  But for kexec case I think doing
the mapping correctly in the mapping code would be good enough.

        /*
         * Apply more restrictive page table mapping attributes now that
         * SVAM() has been called and the firmware has performed all
         * necessary relocation fixups for the new virtual addresses.
         */
        efi_runtime_update_mappings();

Otherwise /sys/firmware/efi/runtime-map is a copy for kexec-tools to
create the virtual efi memmap,  but I think the __map_region is called
after kexecing into the 2nd kernel, so I feel that at that time the
mem attr table should be usable.

Anyway thanks for explaining about this.  It is indeed something to
improve.  I have no strong opinion as your code will also work.


>
> > Have you seen a real bug happened?
>
> If lowered security posture after kexec counts as a bug, yes. The system
> remains stable otherwise.
>
> Nicolas
>

Thanks
Dave


