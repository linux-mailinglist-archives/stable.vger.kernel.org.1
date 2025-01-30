Return-Path: <stable+bounces-111739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B21A234C7
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 20:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28EEF18889AE
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 19:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3032817BB21;
	Thu, 30 Jan 2025 19:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eNseV6t1"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC891F03F2
	for <stable@vger.kernel.org>; Thu, 30 Jan 2025 19:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738266317; cv=none; b=TYbDmBX1TPmwFLNje4sBB80E9r6wkHJb0OqJ9wVZHMmiQwO5d+nEOyfPXChvXUn1GvzrLXLY08Xg8che7/TsAeFTB5GtLYEfMNglZK13q81rSolgRl5hXJFdp3evEni0iTFg+dBaakxD3ynHrB1ctVJFpR5C9JDCZJHVH4VcV+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738266317; c=relaxed/simple;
	bh=9fbyLsH88G6tyoNdu7/EPSxn8u+wW28k1RNwWOmH2mQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n82MfO1SBtFKqxSpdzNDeG8sldP0dvIYHNcNRo1+r+3MV5e88QswRPVmMwnbU/VAUpwXrbym8XdMpnD52xfLXAodOuMRcFtLG+5SrNgJZQV7wpBHEY3vh9kZeZh7+x2cKmawMbGCZN69B/PCENbarvngV8vxBzeXu3RxT06kwRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eNseV6t1; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53e44a42512so1009e87.1
        for <stable@vger.kernel.org>; Thu, 30 Jan 2025 11:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738266313; x=1738871113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPqRKKVz/y2KC5CJ8jv2zxFft8RZ+YOxuhSdEo17vUE=;
        b=eNseV6t1d7W4rXL22Rh5mzaI651WV7rprPcZhpDFjMt82V89FJKynBhH6rvhUruWaY
         DVWulus1vlg7n9O2NMBxLQglZGPo97ebqr9j6pTNJ0Os45TF2xhVSUnwyWRTOSQw/SVE
         KIBNPbY0/1AzMT8zv/26z89U0x4TbugqT7eqZ9XpvHaYfTveL1H1OL3EpmuUz2nQZoAp
         XXugd+ZpYkNcDWq6E6mz9HyUUepahdSedckpmF1K+PaVFG/1bqGJ1YVDuVGE+kTjTJ88
         967sDiuN6OuoJCNy19WLghl/FVF/YmFUXJFUId28hOZwDXoUM+3NMOmg5QVUVNFxvxK0
         CBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738266313; x=1738871113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPqRKKVz/y2KC5CJ8jv2zxFft8RZ+YOxuhSdEo17vUE=;
        b=JuLHWL+NS0awtToL5d/UmTu4m5BM49bB6KBsQzR/HuLTr1yBtKMwB6xdAcm7ua3nYH
         3hhJ8r86tFmUI0VJaLpsxUb+0Xr1NPGWEN3YBvsO2tWxtssy6nk93zVs/92GqlBh9Yiq
         AKizTG3W7hCZmes9u3+6iHgDYDQfhAprdjwZQKcP1akGGo8jjsrlyjTIzI4pYv8j4VyL
         nHVFg5TUyWKknIVHiBzoL7D9tjgAidun3z9fx8JceJJKEFY5q53JZdSl1eGCAhPLU+JJ
         htjfpDM9YjgjkmstQggyc8HvINazGr9vjjoo456qL4zMYxC0UwLPQOF7R9+RvF9k9ZJ1
         vdng==
X-Forwarded-Encrypted: i=1; AJvYcCVOLmeYKZKyvSZyjtPOZwbyrdSLGUE61d+XIR8yF8feCODoYpdSppz5xNO9zf4knbJcatjyRqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YygfkzmeUxh54zB1bUQt+QzVHwMwMeXAF2uxsQAtZVdo18qHyyz
	hNV7lakQoSP9rOnNm3GIRjAwu7797MxWqJCHel7NYnFrq28CNaIfLnRT605LcJSOQ9JKjGhwzAG
	hgFZJYTLwXaWGCSh/PSr3s4LYbjWFmGY6gzIv
X-Gm-Gg: ASbGncujg/jHm03q3yi4gSzibdzeOVU6wbCPcvYzZ83pvfz8LEDG2eoJfXuYFbRNBYE
	J4pAMjzqY3AaNUmGcsyxH/iLj676xVc98k6hB1EapY8pV6lFgDB7tFb0CjQ7cFL0HFIsp+PYS7l
	NeaCa+oJ3PPUy9gDMKZj/qLm8=
X-Google-Smtp-Source: AGHT+IGBvwWSv1IiLAFKoJbSGBLJk+W5yCPPaqTr3SntN2b5XHQRP2haPQPs+ZrJJmWM2zhJ+gtyW2WGNQ4WHrBS1Pg=
X-Received: by 2002:a05:6512:33d6:b0:543:e496:81d2 with SMTP id
 2adb3069b0e04-543f1c0ce53mr24953e87.4.1738266312941; Thu, 30 Jan 2025
 11:45:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129232525.3519586-1-vannapurve@google.com>
 <p6sbwtdmvwcbr55a4fmiirabkvp3f542nawdgxoyq22cdhnu33@ffbmyh2zuj2z>
 <CAGtprH8pJ3Zj_umygzxp8=4sJTdwY5v2bFDhoBdX=-3KQaDnCw@mail.gmail.com> <wmdg54v56uizuifhaufllnjtecmvhllv35jyrvdilf4ty4pfs5@y4zppjm2sthr>
In-Reply-To: <wmdg54v56uizuifhaufllnjtecmvhllv35jyrvdilf4ty4pfs5@y4zppjm2sthr>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 30 Jan 2025 11:45:01 -0800
X-Gm-Features: AWEUYZmdkF4eXD8cW9j3g94r1RQgW0GcoVRfXjOD-b2Tcyejz6I5I8r9tUSmJdw
Message-ID: <CAGtprH82OjizyORJ91d6f6VAn_E9LY7WptN-DsoxwLT4VwOccg@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] x86/tdx: Route safe halt execution via tdx_safe_halt()
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, erdemaktas@google.com, ackerleytng@google.com, 
	jxgao@google.com, sagis@google.com, oupton@google.com, pgonda@google.com, 
	dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 10:48=E2=80=AFAM Kirill A. Shutemov
<kirill@shutemov.name> wrote:
> ...
> > >
> > > I think it is worth to putting this into a separate patch and not
> > > backport. The rest of the patch is bugfix and this doesn't belong.
> > >
> > > Otherwise, looks good to me:
> > >
> > > Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>@lin=
ux.intel.com>
> > >
> > > --
> > >   Kiryl Shutsemau / Kirill A. Shutemov
> >
> > Thanks Kirill for the review.
> >
> > Thinking more about this fix, now I am wondering why the efforts [1]
> > to move halt/safe_halt under CONFIG_PARAVIRT were abandoned. Currently
> > proposed fix is incomplete as it would not handle scenarios where
> > CONFIG_PARAVIRT_XXL is disabled. I am tilting towards reviving [1] and
> > requiring CONFIG_PARAVIRT for TDX VMs. WDYT?
> >
> > [1] https://lore.kernel.org/lkml/20210517235008.257241-1-sathyanarayana=
n.kuppuswamy@linux.intel.com/
>
> Many people dislike paravirt callbacks. We tried to avoid relying on them
> for core TDX enabling.
>
> Can you explain the issue you see with CONFIG_PARAVIRT_XXL being disabled=
?
> I don't think I follow.

Relevant callers of *_safe_halt() are:
1) kvm_wait() -> safe_halt() -> raw_safe_halt() -> arch_safe_halt()
2) acpi_safe_halt() -> safe_halt() -> raw_safe_halt() -> arch_safe_halt()

arch_safe_halt() can get routed to native_safe_halt if
CONFIG_PARAVIRT_XXL is disabled and will use "sti; hlt" combination
which is unsafe for TDX VMs as of now.

Either patch suggested by Sean [1] earlier or the implementation [2]
to implement safe_halt always for TDX VMs seem functionally more
correct to me. [2] being better where it avoids #VEs altogether. I
haven't come across configurations where CONFIG_PARAVIRT_XXL is
disabled but I don't see any guarantees around keeping it enabled for
TDX VMs.

[1] https://lore.kernel.org/lkml/Z5l6L3Hen9_Y3SGC@google.com/
[2] https://lore.kernel.org/lkml/20210517235008.257241-1-sathyanarayanan.ku=
ppuswamy@linux.intel.com/

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

