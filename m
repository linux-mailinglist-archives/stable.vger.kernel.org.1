Return-Path: <stable+bounces-100447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A88B9EB58F
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 17:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4987D282E6A
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 16:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAE21AA7A3;
	Tue, 10 Dec 2024 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIwxajTf"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1CB23DEBB;
	Tue, 10 Dec 2024 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733846454; cv=none; b=m+Kk6KNsGfoIXxj3XfLHbCrOPMsSbErGWEBR/wHh4+yg/5S8ybN4c51raV+uSncFV80AMTJFpVqj2ph2g0QfbHurAE7DeRmPGgj49DWEb3qSTVa124o4EzodiPfCpphY8AIpHMjoo/HTU74x3nqh05oDR9QYjMhPHxzxUbbqCaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733846454; c=relaxed/simple;
	bh=nry9v/APzQ8HNZFESv7cNuNXnCXZICnLXMGUcFE6zoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p8m/jsTpnBvWtXqXb2StiwSi92/v7UNmEdQLefdz3qzhoU0G6GB1hsuvQkpvvIAx18ozI0sVg6eIiy9JRX1h8zft73W+sPW9Fyt1zMMVjCHa7uojg7P08j0mHUDLhAIRgdvTDsrodIP23LMjezo7ECjZu1TZCh/Sy0M8oR10EeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIwxajTf; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53e3a37ae07so3445679e87.3;
        Tue, 10 Dec 2024 08:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733846451; x=1734451251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U85TzBq+v6cdhGQP0Lo1S6+s51Nr98DWhmpaCGn4rok=;
        b=dIwxajTfBFRgBD9MzsOfuZ8bRIXdVJKeOTfHm4LOAnHu+psA1R7xpL936z9wKE0jhy
         JehG2NCJfh1ot8tTtEtxY4LMJMdlH48jf2PPXYUP1ouBhaMp3BO2qO96TX9RVHi+Q7pS
         NfW6O6qDkoAo7Eif26V3nkzZgOnefNUbSoB17eY0vcqJpEgCST3HQluXE4Ziijv6AT+6
         kqbHn2ln8FDYQIFK9YR6DY7sb6EXJ+q3ZcbVUFRA9IwGFnxB9JTk0zUeFaF/O6s/20P2
         cb8NBSvgidRdnVDT/1hH7d/7zMu8UUmgQwluETcqfWosxo0tdZBtgw/bnotCZ1NT75HO
         P8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733846451; x=1734451251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U85TzBq+v6cdhGQP0Lo1S6+s51Nr98DWhmpaCGn4rok=;
        b=g2aHpQrFtVUPYp6finV9c96BduehOliH2k7ZIMPGVfbH8JvqpXbXy+zzk7Fh2Ln34f
         wANGPYgRAZCf+gTDlAsQ69SsJj+Mx4eKZMY/ujnX/KkLp9abP08wBnwxMh03RBqAigrh
         KAOqIXopEwOJ+zRDWbFHiP5ly/BNM4PWV4lMjeBp+/5ts+qlyBkW8JaRVHHu3qTj3KVC
         5c9NoVwOavOW5LCuLENJpVkZcv/smyVrLpS4HstHWQz11oPA6boQwUthyke8RelmMUHv
         hjX2tgoorf+HlX+dI5DMNQIw3r2ZsY0QXL1dNmsjc0Sa+2LnGtiLS/p9piAosu70WDqt
         4TRw==
X-Forwarded-Encrypted: i=1; AJvYcCVgyS+sPjuNkCjFOm2eJsDMe71fAuJOOI5qh5dJY+6GZgsGsOzkqwnOf+Rh7cG5Ttu4qb4ZUEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcMnvUjoYSYPelVLVr2nv7mxetlFDmWxLb/XhpaiZ0YEBMMsSv
	u+Km4xKOv8WHAlp6Jr+6JnX+SYVeGBHF/dofPGCW6MmKTVMyxFKl68DuLF3A5jSgLzRsXUMWSQ7
	s6RMdyqFJ9MSWnuw5MOsfGuHokg==
X-Gm-Gg: ASbGncuLnVLjdJfuDP5fJMJH29P4frBhHP6+ELR0lwJSGiXmglYjJuBn5ERcfWrrdr0
	GxbppkVUUwobAMpuu41qCATDR+F2VIQcTm7bG9iG9F168te/dYA==
X-Google-Smtp-Source: AGHT+IH0VtSG0nvpobR7kj9dQ8kT+wOrCwDN8N9o4wUmdxiu/SPgYf69oHjk1ALEaeBebMWpL3OXMVaV+3GjW8pH6YQ=
X-Received: by 2002:a05:6512:1391:b0:540:1fc4:f998 with SMTP id
 2adb3069b0e04-5401fc4fa31mr2716612e87.33.1733846449172; Tue, 10 Dec 2024
 08:00:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210144945.2325330-1-arnd@kernel.org> <20241210144945.2325330-2-arnd@kernel.org>
In-Reply-To: <20241210144945.2325330-2-arnd@kernel.org>
From: Brian Gerst <brgerst@gmail.com>
Date: Tue, 10 Dec 2024 11:00:38 -0500
Message-ID: <CAMzpN2g+h0+7-ywjPVc=YTYgRVto=sseVf3k2apCMvypC=fkAg@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] x86/Kconfig: Geode CPU has cmpxchg8b
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 9:50=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> An older cleanup of mine inadvertently removed geode-gx1 and geode-lx
> from the list of CPUs that are known to support a working cmpxchg8b.
>
> Fixes: 88a2b4edda3d ("x86/Kconfig: Rework CONFIG_X86_PAE dependency")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/x86/Kconfig.cpu | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
> index 2a7279d80460..42e6a40876ea 100644
> --- a/arch/x86/Kconfig.cpu
> +++ b/arch/x86/Kconfig.cpu
> @@ -368,7 +368,7 @@ config X86_HAVE_PAE
>
>  config X86_CMPXCHG64
>         def_bool y
> -       depends on X86_HAVE_PAE || M586TSC || M586MMX || MK6 || MK7
> +       depends on X86_HAVE_PAE || M586TSC || M586MMX || MK6 || MK7 || MG=
EODEGX1 || MGEODE_LX
>
>  # this should be set for all -march=3D.. options where the compiler
>  # generates cmov.
> --
> 2.39.5
>
>

An idea for a future cleanup would be to change lists like this to
select statements.  That would make it easier to see what each CPU
option enables.


Brian Gerst

