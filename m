Return-Path: <stable+bounces-219847-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIYaDOGgoGlVlAQAu9opvQ
	(envelope-from <stable+bounces-219847-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 20:37:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF451AE70F
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 20:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37EFA30882D9
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 19:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A62E4418F7;
	Thu, 26 Feb 2026 19:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4t7ae9rT"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2857D199FB0
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 19:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772134240; cv=pass; b=ffqU5CzZuadbrl4t+m/04zQFgU6WK1KIURvVDiYBdvRm4dceoBFMKmUq8WVMP31PMOscVmghW7OXeL5eWCGjNIzKkENY4NgGAq5LmjCJL8mVchqw68gFpfodjldIFoEL8sWRPcQcIX7FCf87HoliBSRDABv78vpKupj3idIKbgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772134240; c=relaxed/simple;
	bh=EDiRpk9WXNH2j7W9qEH+/npjk1Bz2Ch2dm65/MgxM0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTYLG7rKI6OySRXe8H1vHghxN8e1dcKE10A/qD8+kzHRiumvX+wYvxiBspExX78XlN1cWyBEF8nRCeqM/8IIhR1y0apjlmUJneEmbjbwSY4ok+JoWB9KNbmkRy5mOEX9Op+Ii/Y9IQ28iU+WCGxlr9XeimnKnYHJa0yxH6AWTn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4t7ae9rT; arc=pass smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-94dd05a4b44so679988241.1
        for <stable@vger.kernel.org>; Thu, 26 Feb 2026 11:30:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772134234; cv=none;
        d=google.com; s=arc-20240605;
        b=hk9f5zeJmM+FObHaPp1f5Y4U7yQ+GOK49FWJvBUvMldIZb49FFGcAyVcQlp9bn6Jvc
         YxE5V9IHUeCfjUJPayoWJ6DqCuUPOUXA5rMYPVvMHzUEhzQr60vEzzZz1eEoBtKQ9/Jb
         v+hC/jn71920U1yc6LpWTSYAicgoRyL3iat6FFT8QG4a60caQ1Nd+3xqkQDL06D0MXW9
         3XMY3JLwboPDPTYbfTHnPekZz6XIzTtaJKLXzlUxVX7B5nGnJPnMOX7wZtpxnxc45Ugt
         00M6JoehMZp/R72LC5xgBs3dWXKE0Yl8sW20asaEFjpfvUIwIBNXIb086FiIbPBG4I7k
         EjUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gppqoUIRkjbPacmUlM2HqLqaZsXsaMRgN3weCaVbsQ4=;
        fh=Pdr1ora3K/3mEwFwW2Eagh2XuUl+/DW+XSwlTLpoiXY=;
        b=CbghG9lERobk/Xn+tblYPMfHybrgh5rAz9KtIl/USxLCiorty6MCfV4k+uQcDIMtg5
         fn1sLXujsZHnp/YHIsyjgRVk8zVwISKtnJ7BQb3FOboZcVFV6oz7lyXwR0SQ3fvH6qoN
         GYBZIMQzegYMmHWOvro1hABpjHgr6wQBspo5MkOFjCyhFik4GezNeG4ob/78PzLGNqtK
         nVi5vUKKsX6H8T9ovNown+849ufL9Bcq5OaugVHfAhmMK+8b63dAqCq5DGS+wmMpjAuK
         kZWi4FWLxArcB4VsSqjM4zLqyYse+IZuoe2CTZ+A7KeeoUTHMcqLR5xXI0uy+N+iDjjz
         0n9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772134234; x=1772739034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gppqoUIRkjbPacmUlM2HqLqaZsXsaMRgN3weCaVbsQ4=;
        b=4t7ae9rTiqtM6GeihiCDkHchBIfhzLmRGbBa+XIzRUs6vXtuFy01j3HeK0JEQ56A6X
         VMaCbrNyeZigmRbCaIaUpWLX7UHB+k8vONF9wUaOP+U92/cRce15ty5UF7UnYYD5bO7+
         xf0msZ7uwu0/DnzUzvGaeZXpWiObSstr76qMFwCBs3aaAZX9CnXE8JMMog3DKZp6ThiY
         hNB+4oV3SVlxJRTqoiRCAWpzfokgGMqsrfnSYg2Es+rzYo5ToQyMWzPpY3L1cW/6pWv8
         fGnPkZcuSstdy/L/nXPsYqIx2XEqaw6nxEz8BzVIXFBUe+EWQLiq0ejmCYwNTc6EOIDc
         jPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134234; x=1772739034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gppqoUIRkjbPacmUlM2HqLqaZsXsaMRgN3weCaVbsQ4=;
        b=jx6ZawFlA7MrTQO2Icl86f2bvhEuKLmg0h177a1AeBvGpzDMyMpjq8ZOIvAW8Ug7I3
         LMIGyWUJH42oqTAr+9hSU5mcQYWf5GtfMbMemCgC+K4AGgBpDEc2eLRJM2lQshNVR/0p
         DQwHB93STT+40tR15BBjsvUtZyqL28VOPHOYtEQ+5Lr8BrcWY2jFizZZwGLLgpgaD9l4
         8Fo6YYa6rF7kmWrTkMKkbyCvnPrbWAVL6oT7NYnSVZTOp7nPOaRB/PN3ClnEvqEixxnM
         peBtJoypitJCO5Ftk4AqXjJn/Rvj3ys3bm/mJBTFSARaXQ1/EbSpWFJj5rXHyzr0OHVX
         J6bQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0DD7FFh/i9+55zE7j+LO6Cvt13hjCM2SNYdZueE6xzYUdlWkM2ss3mVGnxWOcW88/tQBcRHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYLxjCPQjpAVCaOGfUeMAAzcX8Fe1U/lThuk83U78r+H+u7e5J
	ql6iaQUlsZTnkctU74PrhDF5CxBpN8/mT2+jeeSrp6wfx+DKwuOp18zq6vXUjcBhzNBBLU6taLb
	ZMaNuer4xnj//jmPT5Ugmsll2pAwClfWdxiSu7ps1
X-Gm-Gg: ATEYQzxDcsX6oe9mRnVrAj7Dju3pduxjYOlpxwHvHudPjprygc+LNsuAfjZGccy6JXb
	17yBjGj4ERrt/ztAJFxcxL0hPKvsYiRCWkCuR/nsGTRS0wDkm9glUgQV6ehwfYtkYyI2Wqhh9Ch
	0hgIpyViBYosBRMAiSAJ5GOqIwRVd3pW9ITIh8aW8V9tuUAjhq938GgH46JlYpn9NhUrANrdnsQ
	TNwb6d1ULZ/LlalMtI/gKSh8pq1k6tcaHGDBL29cmwS6JORA3Ecl0grQmOTCmRXhXw7TwgE7tpR
	Zfi5PtLG66cCMbWIXjz8XnbUjmaa29cpknHI3Q==
X-Received: by 2002:a05:6102:2923:b0:5fd:ea47:d317 with SMTP id
 ada2fe7eead31-5ff1cf8c55dmr2027641137.15.1772134233403; Thu, 26 Feb 2026
 11:30:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5648b7de5b0a5d0dfef3785f9582b718678c6448.1770217260.git.thomas.lendacky@amd.com>
 <20260226191612.1962381-1-changyuanl@google.com> <19F7B76A-8DC7-4CA9-9646-90931AF78CD7@alien8.de>
In-Reply-To: <19F7B76A-8DC7-4CA9-9646-90931AF78CD7@alien8.de>
From: Changyuan Lyu <changyuanl@google.com>
Date: Thu, 26 Feb 2026 11:29:56 -0800
X-Gm-Features: AaiRm52mbhBk6ZiFqH2K1HPMP6HstuljJ3p25pgUCFlPpd4wymPi3SxbpiojxTg
Message-ID: <CAGzOjsopYTEoNqdtO3w58wyuDcqW4QjJUHH5K0niEfj20bZBMQ@mail.gmail.com>
Subject: Re: [PATCH] x86/boot/sev: Move SEV decompressor variables into the
 .data section
To: Borislav Petkov <bp@alien8.de>
Cc: thomas.lendacky@amd.com, ardb@kernel.org, dave.hansen@linux.intel.com, 
	kevinhui@meta.com, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	stable@vger.kernel.org, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219847-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[changyuanl@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,amd.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,alien8.de:email]
X-Rspamd-Queue-Id: 6BF451AE70F
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 11:22=E2=80=AFAM Borislav Petkov <bp@alien8.de> wro=
te:
>
> On February 26, 2026 7:16:11 PM UTC, Changyuan Lyu <changyuanl@google.com=
> wrote:
> >On Wed, 4 Feb 2026 09:01:00 -0600, Tom Lendacky <thomas.lendacky@amd.com=
> wrote
> >> As part of the work to remove the dependency on calling into the
> >> decompressor code (startup_64()) for a UEFI boot, a call to rmpadjust(=
)
> >> was removed from sev_enable() in favor of checking the value of the
> >> snp_vmpl variable. When booting through a non-UEFI path and calling
> >> startup_64(), the call to sev_enable() is performed before the BSS sec=
tion
> >> is zeroed. With the removal of the rmpadjust() call and the correspond=
ing
> >> check of the return code, the snp_vmpl variable is checked. Since the
> >> kernel is running at VMPL0, the snp_vmpl variable will not have been s=
et
> >> and should be the default value of 0. However, since the call occurs
> >> before the BSS is zeroed, the snp_vmpl variable may not actually be ze=
ro,
> >> which will cause the guest boot to fail.
> >>
> >> Since the decompressor relocates itself, the BSS would need to be clea=
red
> >> both before and after the relocation, but this would, in effect, cause=
 all
> >> of the changes to BSS variables before relocation to be lost after
> >> relocation.
> >>
> >> Instead, move the snp_vmpl variable into the .data section so that it =
is
> >> initialized and the value made safe during relocation. As a pre-cautio=
n
> >> against future changes, move other SEV-related decompressor variables =
into
> >> the .data section, too.
> >>
> >> Fixes: 68a501d7fd82 ("x86/boot: Drop redundant RMPADJUST in SEV SVSM p=
resence check")
> >> Cc: stable@vger.kernel.org
> >> Cc: Ard Biesheuvel <ardb@kernel.org>
> >> Tested-by: Kevin Hui <kevinhui@meta.com>
> >> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> >
> >Reviewed-by: Changyuan Lyu <changyuanl@google.com>
> >
> >>  [...]
>
> Did you test it too to make sure it fixes your issue?

Hi Borislav,

I rebased this patch to e3c81bae4f282a6be56bc22e05e2ce3dd92ae301
and tested with the steps in
https://lore.kernel.org/all/20260226060714.1636773-1-changyuanl@google.com/=
.
This fix works for my use case (direct kernel boot without UEFI).

Tested-by: Changyuan Lyu <changyuanl@google.com>

Best
Changyuan


> Small device. Typos and formatting crap

