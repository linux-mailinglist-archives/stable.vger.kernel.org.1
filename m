Return-Path: <stable+bounces-111860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7591A246D4
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 03:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B68297A24C0
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 02:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156CB28371;
	Sat,  1 Feb 2025 02:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4H574ytS"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0434819BBC
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 02:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738377139; cv=none; b=aJZX3JN6qubHrrXSNcWGYP/qCfkGEjRMLXxwZm17xGryNtL0p3o1vAX/Nz1LnLFbUuu7d4C4/KrsohecXnknf1Vs7DzlnTzPrfvhyKMPJWgtYegXoj/kxtAfCSEJ3xksgQXQyAeQdWK7KeGNNOtWpCi+2R2RYsgqPdb5uijWOxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738377139; c=relaxed/simple;
	bh=YvUJr1IlpMallDUUXqLZIE2yKMx495vfCWgRkrRQMXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4IO8PeeUt3yj1tl81/zWg/Vhys88htzpQh91b3+bu7kO6B3jbtR+msknhSUhmckr675rcyy6CTo/mor9kOYnMa95VJjsTQ2tjrjAu+pfhWKi3fMvpDLd2m4rz/yk5Jwjkhttd6BwKXINMhm0xda7GR9IAoJvcjUHmoNWmjSdP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4H574ytS; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5401af8544bso1362e87.1
        for <stable@vger.kernel.org>; Fri, 31 Jan 2025 18:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738377136; x=1738981936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pG4VfCSV2vZRH8VFu+tXkb/1AcO1THW/axuTYVw/Lrc=;
        b=4H574ytSsuT3cVotvtpy1/OQWQM25WHhDwfjFjpY0Uznz7wdG0b0/XXqVHs6y556A2
         zxJLHVcGvehKVdAw2nRGnWl0tcsjiYYYLfIIUXQsgaLoP63+Pol4tDUjaZuRlczNZCcT
         vMPumzgbPI33a7sQbCq31gTA6wGF4OAqc51hmjyMzfz3Mg4BKhMZcyZr1/pJfEbWXK/K
         mSt+ZaNT5MKaaaQJAAM0vmA7/DBxbYziu+1XC3Z4bdzBDPb1hat8whW+C8sZigsrLmpL
         QOx3y6/H7oLoilfAx7snKpSxtG2ZtXnqggqooQ1BADtrwLZQd+Q1jsMvf7biY/7WZHL3
         bWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738377136; x=1738981936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pG4VfCSV2vZRH8VFu+tXkb/1AcO1THW/axuTYVw/Lrc=;
        b=YmetYj2Oi5xQThLTAqbg4toaRqJ0MY9s2QOxehKTMRFshpDTxtyOSUdtJtfSzNd+Oy
         2d8O7M1qAKfojrglizR+SsQHj6pwjaZ0gBTDQgGWdtcT1pBGr+JzIeF7WTvgDKk7Bycz
         73Y7EncOwGmfbcOpQdD3XUtaXh0Crd62We3GNI7CZVuckoDLk7mw2ET6T+hBUJ7E++FK
         UT0ocKhr/5JsXKadFbFMwrP2CK8ZbnfFLay1k9LRmbwSgG17V1KdBJokx5EPf9FYKfO4
         kV1ufUrvXK9WJNWP1bEpwmMnNESA5zQdYBrc5WYP8hZSB6Kwd2Amg9Fc6L6wr6Dpv2IM
         72rA==
X-Forwarded-Encrypted: i=1; AJvYcCVyABWmrxclxQBSkclAyp9N/PsGH5APFmJPbpotsRRqbu2+PxE8XPOKWh8AXNmcAv+YpIEcTd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyAKmQ2T6gn3l8RzXyWCTjteKE9Um5r7LDHbjPaMGcJRZ90Al7
	qhE7rUgoiy/06tdiOuCT5M5Ykomx/zSq8nYWK1vqzfZkox9699rSFRmH9Zy5b8z5ikVGnMwPiV+
	INoyxnDR+lGngXlkzS0nGDl0oxm4dlnu6AoeT
X-Gm-Gg: ASbGncuhfLw7KHGx93eJWPNniiYbleKXaD4IKgBYiSGayqOnwNGIJhINmhYJydzOlA3
	nygl3Whpu2evSYDp3+SWoumfBlQI6YRAGJPcqPpzjeipG0OmeTBMo2LLTkN7XeEyc6QcDEdE5Te
	YvAaZgJ8Dyjk/7b692X4cMBQ==
X-Google-Smtp-Source: AGHT+IGDm9JPvGLHbtjFN5gsiaTc6QnwCtkwno/1ZV6/IPpxaNeuuM5xrnBDIsxDQcK/xH+cQ2IfrP7ilTJxIVl7kD8=
X-Received: by 2002:a05:6512:220a:b0:53d:dcde:395a with SMTP id
 2adb3069b0e04-543f6160274mr132911e87.2.1738377135702; Fri, 31 Jan 2025
 18:32:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129232525.3519586-1-vannapurve@google.com>
 <p6sbwtdmvwcbr55a4fmiirabkvp3f542nawdgxoyq22cdhnu33@ffbmyh2zuj2z>
 <CAGtprH8pJ3Zj_umygzxp8=4sJTdwY5v2bFDhoBdX=-3KQaDnCw@mail.gmail.com>
 <wmdg54v56uizuifhaufllnjtecmvhllv35jyrvdilf4ty4pfs5@y4zppjm2sthr>
 <CAGtprH82OjizyORJ91d6f6VAn_E9LY7WptN-DsoxwLT4VwOccg@mail.gmail.com> <2wooixyr7ekw3ebi4oytuolk5wtyi2gqhsiveshfcfixlz3kuq@d5h6gniewqzk>
In-Reply-To: <2wooixyr7ekw3ebi4oytuolk5wtyi2gqhsiveshfcfixlz3kuq@d5h6gniewqzk>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 31 Jan 2025 18:32:04 -0800
X-Gm-Features: AWEUYZmeERapyJbLH5q17LnS9dbTKeBXAlIs3Ezuwk-Df4kRvcx2vhlD0t9pkOs
Message-ID: <CAGtprH-n=cfH_BJAmiNMoRbqq0XdGCf3RE67TYW8z7RARnsCiQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] x86/tdx: Route safe halt execution via tdx_safe_halt()
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, erdemaktas@google.com, ackerleytng@google.com, 
	jxgao@google.com, sagis@google.com, oupton@google.com, pgonda@google.com, 
	dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 12:13=E2=80=AFAM Kirill A. Shutemov
<kirill@shutemov.name> wrote:
>
> On Thu, Jan 30, 2025 at 11:45:01AM -0800, Vishal Annapurve wrote:
> > On Thu, Jan 30, 2025 at 10:48=E2=80=AFAM Kirill A. Shutemov
> > <kirill@shutemov.name> wrote:
> > > ...
> > > > >
> > > > > I think it is worth to putting this into a separate patch and not
> > > > > backport. The rest of the patch is bugfix and this doesn't belong=
.
> > > > >
> > > > > Otherwise, looks good to me:
> > > > >
> > > > > Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>=
@linux.intel.com>
> > > > >
> > > > > --
> > > > >   Kiryl Shutsemau / Kirill A. Shutemov
> > > >
> > > > Thanks Kirill for the review.
> > > >
> > > > Thinking more about this fix, now I am wondering why the efforts [1=
]
> > > > to move halt/safe_halt under CONFIG_PARAVIRT were abandoned. Curren=
tly
> > > > proposed fix is incomplete as it would not handle scenarios where
> > > > CONFIG_PARAVIRT_XXL is disabled. I am tilting towards reviving [1] =
and
> > > > requiring CONFIG_PARAVIRT for TDX VMs. WDYT?
> > > >
> > > > [1] https://lore.kernel.org/lkml/20210517235008.257241-1-sathyanara=
yanan.kuppuswamy@linux.intel.com/
> > >
> > > Many people dislike paravirt callbacks. We tried to avoid relying on =
them
> > > for core TDX enabling.
> > >
> > > Can you explain the issue you see with CONFIG_PARAVIRT_XXL being disa=
bled?
> > > I don't think I follow.
> >
> > Relevant callers of *_safe_halt() are:
> > 1) kvm_wait() -> safe_halt() -> raw_safe_halt() -> arch_safe_halt()
>
> Okay, I didn't realized that CONFIG_PARAVIRT_SPINLOCKS doesn't depend on
> CONFIG_PARAVIRT_XXL.
>
> It would be interesting to check if paravirtualized spinlocks make sense
> for TDX given the cost of TD exit.
>
> Maybe we should avoid advertising KVM_FEATURE_PV_UNHALT to the TDX guests=
?
>

Are you hinting towards a model where TDX guest prohibits such call
sites from being configured? I am not sure if it's a sustainable model
if we just rely on the host not advertising these features as the
guest kernel can still add new paths that are not controlled by the
host that lead to *_safe_halt().

> > 2) acpi_safe_halt() -> safe_halt() -> raw_safe_halt() -> arch_safe_halt=
()
>
> Have you checked why you get there? I don't see a reason for TDX guest to
> get into ACPI idle stuff. We don't have C-states to manage.

Apparently userspace VMM is advertising pblock_address through SSDT
tables in my configuration which causes guests to enable ACPI cpuidle
drivers. Do you know if future generations of TDX hardware will not
support different c-states for TDX VMs?

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

