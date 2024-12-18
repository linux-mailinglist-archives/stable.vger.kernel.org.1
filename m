Return-Path: <stable+bounces-105195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3299F6C6B
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 18:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A326188CC64
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 17:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E291FA8D8;
	Wed, 18 Dec 2024 17:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xiq4WyjA"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80F0175D34
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 17:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734543515; cv=none; b=s2wfZ8dxFezolaKrkEybQBQCv9MvTFSkCp9TNkP9cO2lbVGBkjyB869PbnnwQnIZZd7/Ej1stRKf0rOxLL1ygEP5GEJb5rQsbOPtp0tnkGoEljNEgn1kcqdbpRvs5ieGwpFbhuApvGoajXvNic+F6xH+YWDslwQKH9/MCDNzpDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734543515; c=relaxed/simple;
	bh=2IDarS+z5rWsw5F42NBh3QyLlnxgWWGOnhqA0OOFV3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rNpPmrJYlqFaKo3IuCat4X6dMtwjQvF2jl+61HL6jDGmKzjpr6WsKrtcGJhn1lpfL1278OmmvJsF2cvZeOPsUCA2vIw4QWKcYSa3uul03VEUv37kpU5kQhnA+iaTlzKsBTSud/sFyiDumJrJdtx1Noir8YavMdZO0gFs/YndxSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xiq4WyjA; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-540215984f0so7467240e87.1
        for <stable@vger.kernel.org>; Wed, 18 Dec 2024 09:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734543510; x=1735148310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhIbkShSV59R5JCXz2hrDMjgzzBOjFz+Dlxz+KTcoWQ=;
        b=Xiq4WyjAqVbbZGR9MqtEMLVfxSMB7ede9mXBsFf0Kq/x///XQQz7JDmcD7nIRmnhdp
         7UEIzf3CXHg5CPEEJ0weEUaZqVcCA+mACMoPyd8BTBu199JU6Ls/luS71RZiGMnncOeG
         jSgmg1y3AncJV/VCVSN4GavITKaBaX4+gjjxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734543510; x=1735148310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BhIbkShSV59R5JCXz2hrDMjgzzBOjFz+Dlxz+KTcoWQ=;
        b=foo58AdZTAktW5hYT5EBkfyKcLLGbVHnOADq0tekBN2L4zgOhRl1G3mKSLFIIpF8yE
         ZLHLcvVqZoOeXJEMsoNpp9oqXlpdWS1oqzOmLiN/9i+1ySLb3mKRgowtJ/jDS/L8DhSv
         qsm5wrdENVTgO3LQxQhex4JJ+Iwpy82y9G0/bF4ZfarbriNZ+fdXMO4hyunSSqi1DoDw
         aTozDtGkaJYYpyryOaxDwtklsJL9KNhfPqWzZDnDY86Ie0jbbCJ2JeciP/pQRkDJoPQO
         jwQjp15ultOBtNpys4P1MFjc/jgKx7Q8gPZdFGvn+RlxKL4PX9XM/UJBW6wJwl8lCpvG
         Pl0w==
X-Forwarded-Encrypted: i=1; AJvYcCXDnAWhiC5505gw5kQ9A/xA73fLEjbgOsB/QvKv5K2eEcQrVi6hCbpwR+WomJp70e4aoyZX+iQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDkp233YltbMwpYY/gM+sueBXolJ6864Z3vkTPj+a7ulsBrSxx
	kv30+J3DzlJHR8nXV68fR8E9ZxLsZcONOaJWOs4m3G3GpaCJ3ou8wozMSq1GwqjI9jHVfAFMQJ8
	TcHP/
X-Gm-Gg: ASbGncsHxSTTGH8fhdgmYHPInIPrvcKBnkzQvjW6oj3TcyZINCarPo1T6o5nm9yNlDt
	GJC4hoEX4ckYy9UIgUlNXrFhkz9dxlF3moyOUGDJ8SSIs3pfJrOCk6WFcuPeUvQtR3X5rilExOh
	+nezEuSCHuFdDZM9DJ3eEFiHrXHu3SRqFAZHw+AlWBsQRmT/vm5dLe3XCDs4pBrrjbR4iz1W3Eh
	EzkU9Gnb/H3bu15UFvV6eihmie83Lb40GZAKJL9lmwY8RHhnM9UtyvRNZVgQdIuSTKLr7tx4z1t
	z/hudEbBf/RQ7ngFtjMe
X-Google-Smtp-Source: AGHT+IGsA7JaSMNtY7LPQez+3qdEBLmOoQSsRJi4s1tvTHk/N+ofnUVvV9OZPyvvJiGvc0dM3cwBuw==
X-Received: by 2002:a05:6512:224d:b0:53f:231e:6fa2 with SMTP id 2adb3069b0e04-54220fdcfe0mr161533e87.26.1734543509939;
        Wed, 18 Dec 2024 09:38:29 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c1394esm1518511e87.187.2024.12.18.09.38.27
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 09:38:28 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-540215984f0so7467148e87.1
        for <stable@vger.kernel.org>; Wed, 18 Dec 2024 09:38:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVHDZ2uBcwte8Jc4PoAMfNHPUt3BdZPjdO6P0jKbWaZVWGVeI69prvo1lh0RLiBLE7np/e6jZU=@vger.kernel.org
X-Received: by 2002:a05:6512:2313:b0:53e:2fdb:4de3 with SMTP id
 2adb3069b0e04-542210256b4mr179533e87.44.1734543507103; Wed, 18 Dec 2024
 09:38:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214005248.198803-1-dianders@chromium.org>
 <20241213165201.v2.1.I2040fa004dafe196243f67ebcc647cbedbb516e6@changeid>
 <CAODwPW_c+Ycu_zhiDOKN-fH2FEWf2pxr+FcugpqEjLX-nVjQrg@mail.gmail.com>
 <CAD=FV=UHBA7zXZEw3K6TRpZEN-ApOkmymhRCOkz7h+yrAkR_Dw@mail.gmail.com>
 <CAODwPW8s4GhWGuZMUbWVNLYw_EVJe=EeMDacy1hxDLmnthwoFg@mail.gmail.com>
 <CAD=FV=X61y+RmbWCiZut_HHVS4jPdv_ZB8F+_Hs0R-1aKHdK4w@mail.gmail.com> <CAODwPW_UNVkyXKxyhZv830bhzsy5idu6GiuR9mut+-qGOtv1pw@mail.gmail.com>
In-Reply-To: <CAODwPW_UNVkyXKxyhZv830bhzsy5idu6GiuR9mut+-qGOtv1pw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 18 Dec 2024 09:38:15 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VtTsUsOmW+SxiUXuUZoXSFYXY4ApzmMm_ZzxWKAvTMBA@mail.gmail.com>
X-Gm-Features: AbW1kvb6h8dQi0-AL6QfO49fCuboqPkZd7iKe9aC5hYSbnNdq3yQxBbEFEWpW7s
Message-ID: <CAD=FV=VtTsUsOmW+SxiUXuUZoXSFYXY4ApzmMm_ZzxWKAvTMBA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] arm64: errata: Assume that unknown CPUs _are_
 vulnerable to Spectre BHB
To: Julius Werner <jwerner@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-arm-msm@vger.kernel.org, 
	Jeffrey Hugo <quic_jhugo@quicinc.com>, linux-arm-kernel@lists.infradead.org, 
	Roxana Bradescu <roxabee@google.com>, Trilok Soni <quic_tsoni@quicinc.com>, 
	bjorn.andersson@oss.qualcomm.com, stable@vger.kernel.org, 
	James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 18, 2024 at 8:36=E2=80=AFAM Julius Werner <jwerner@chromium.org=
> wrote:
>
> > Given that I'm not going to change the way the existing predicates
> > work, if I move the "fallback" setting `max_bhb_k` to 32 to
> > spectre_bhb_enable_mitigation() then when we set `max_bhb_k` becomes
> > inconsistent between recognized and unrecognized CPUs.
>
> A clean way to fix that could be to change spectre_bhb_loop_affected()
> to just return the K-value (rather than change max_bhb_k directly),
> and then set max_bhb_k to the max() of that return value and the
> existing value when it is called from spectre_bhb_enable_mitigation().
> That way, max_bhb_k would only be updated from
> spectre_bhb_enable_mitigation().

Sure, you could do that. ...but in my patch series I need to add
_another_ static boolean that's updated in is_spectre_bhb_affected()
anyway. I need to add one to the new is_spectre_bhb_safe() function
that you requested. Specifically, the moment I detect any CPU ID
that's not in the "safe" list then I need to note that down. If I
don't do that then later calls to
is_spectre_bhb_affected(SCOPE_SYSTEM) will return the wrong value. So
while all the other "static" caches in is_spectre_bhb_affected() could
be removed because we changed the default return to "true", the one in
is_spectre_bhb_safe() (which causes the function to return "false")
can't be removed.

In any case, the predicates updating the static caches predates my
series and IMO my series doesn't make it worse. If you want to post a
followup series changing how the predicates work and can convince
others that it's worth doing then great, but I don't think it should
block forward progress here.


> > I would also say that having `max_bhb_k` get set in an inconsistent
> > place opens us up for bugs in the future. Even if it works today, I
> > imagine someone could change things in the future such that
> > spectre_bhb_enable_mitigation() reads `max_bhb_k` and essentially
> > caches it (maybe it constructs an instruction based on it). If that
> > happened things could be subtly broken for the "unrecognized CPU" case
> > because the first CPU would "cache" the value without it having been
> > called on all CPUs.
>
> This would likely already be a problem with the current code, since
> spectre_bhb_enable_mitigations() is called one at a time for each CPU
> and the max_bhb_k value is only valid once it has been called on all
> CPUs. If someone tried to just immediately use the value inside the
> function that would just be a bug either way. (Right now this should
> not be a problem because max_bhb_k is only used by
> spectre_bhb_patch_loop_iter() which ends up being called through
> apply_alternatives_all(), which should only run after all those CPU
> errata cpu_enable callbacks have been called.)

Actually, today is_spectre_bhb_affected() is called much earlier I
believe. It's installed (via cpu_errata.c) and called like this:

  is_spectre_bhb_affected+0x124/0x2d8
  update_cpu_capabilities+0xa0/0x158
  setup_boot_cpu_capabilities+0x20/0x40
  setup_boot_cpu_features+0x38/0x50
  smp_prepare_boot_cpu+0x38/0x60
  start_kernel+0x90/0x438

...but then spectre_bhb_enable_mitigations() is called later and by
that time is_spectre_bhb_affected() should have been called for each
of the CPUs:

  spectre_bhb_enable_mitigation+0xbc/0x340
  cpu_enable_non_boot_scope_capabilities+0x74/0xc8
  multi_cpu_stop+0xf0/0x1b8
  cpu_stopper_thread+0xac/0x148
  smpboot_thread_fn+0xb0/0x238

I agree that it doesn't seem to be a problem today, though.

-Doug

