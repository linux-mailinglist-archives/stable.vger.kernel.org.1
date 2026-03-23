Return-Path: <stable+bounces-227953-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEA5DuUbwWn5QQQAu9opvQ
	(envelope-from <stable+bounces-227953-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 11:54:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8642F095B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 11:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 66B5F3066D67
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10750391820;
	Mon, 23 Mar 2026 10:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fi+lZNi0"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923433909A2
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 10:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262826; cv=pass; b=gMsHMVH/xZF3rIYfIsHFMwu2ae4OM3B9jZpqvpbSTLqWoIFs6T+12aL2ExOEtmDdlRvf4ALjTT4+Ds1LRpD7GTfbhvlVIwvw6fIjAoWC2mwFxzrYK4z0zOcPBolTrhTkMj15LO9tP+jwRuK3UB0mZ2EbTz/hGPLUt9LV1j2HGms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262826; c=relaxed/simple;
	bh=HGjBs9EzjEBeKYIO3PCVP3mncbPfDlgRYA5LqqNc/+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjUV+dJ8f577AE5OyU6tmo5hwD0zIqOJ9w/JUJprsorxpsQa/CFygR5+23gXtMDJX1SNiLxHYViPUhG2ogXrITdJJDRLixRIf00DukS43kiN1OlBkQcDye4ccQ0WfbLz5NUJzm+ua7i74EdXw1IPJxvs7ZKSwLBOy9dMp0hi7rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fi+lZNi0; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-467e8aaa865so15558b6e.2
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 03:47:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774262824; cv=none;
        d=google.com; s=arc-20240605;
        b=EEZFGPKK4mKgdw4MQvMG1Kt7mGAqrHr6lxUpPWQX17ATXnDpKhpRzbsFwSClbNt1AA
         Kqe0+5wmQ7mGxue7DSHqjyu0IkuOI0QL0WOhXI2BWxvLVJOtN2aHNVcxZLK3MB685XW1
         tggXBTEV3Gv+BVDf92VnNtKcA7n7Fr2lU1S+xQGyd+rTfDXnWSPoGJZ86b2umsmJhaNB
         POT/BnCyTFu4ybz0Gt4QaoUBILJ+s21qo+tLPz1wIkyi470eLiPQHYWBqT5Np6Hs6qJ+
         0hlTB1mfCEtLvNWVAVOlK4cAc2dSzLMTFpufxijKqhsjQf0Enl8o/S0cBJ4dp8m/zyAJ
         cpgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J4sER2GrGUkt7nT+8pQTI5YrRfltUa5SSK35UZE2tZ4=;
        fh=mNvHKG12k46JPOA3zA/rCbjt06JTnFV6sX3PtPHfiYs=;
        b=YDVis+pA7kQf4+7kZoptkGcpml5eKLECX6ukzdfdEHIvrXIU79LwNs4rUH2Ezd4fku
         kRQEPVe6XXG8qbj16WPL1NnqU6DtEefvorKppEd+6cl/R35VDCjjZtvFyLB0cEMGLga0
         QkkBCPD0SQOufq5APXWOOHdoh/keJuLYOCFMpdhBXUcPTZHX4FZF2stuvum3Q+Q8mqXj
         qinJaoYjw6mKXQOy+vrS64smVCdqBE90ARswhTAtgE2kSSPWPVKLKLONpuyKz+fNcQ/1
         zlxCn9/EB7iXJ5lW517Pc6qh+UVZsEFZrn04ONAseZF3+wdltPB9lzNtH75l6utpTpea
         F3iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774262824; x=1774867624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4sER2GrGUkt7nT+8pQTI5YrRfltUa5SSK35UZE2tZ4=;
        b=fi+lZNi0N35yr/96hiINANQNOY8A+l6/cnjmyG37nwmVclW00uEchE2jdzoxsSTwjG
         1QiM3RK7EfD+w7oufCJetCKfEtGuRjRBrlo8WiB93KOrZ37oM9oKcYFEy9MuDEpc7ExN
         E5ylBpkNN4TySSpgiTL3REIXAQOLXrDV2JoRuXSLboxBVBo6ukv8wwbr05Y6G+EPeM3b
         UfVS2zzcZzujmLt+E7lGVaFGH86qJOEYuo94AxJHYpYj9OsYUg+NKiGCd4pd3KhdBwLQ
         UQAuMncSVTzEEMHxyc8rRd0MnUXzQty6iExN6O0OjNiBCT3L2+/4Ydh988NsXyBTnCdF
         TYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774262824; x=1774867624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J4sER2GrGUkt7nT+8pQTI5YrRfltUa5SSK35UZE2tZ4=;
        b=NK5GfrJBbbI4KbFzw9BOWL+YNMGmRKXZSRBCEbjo5BZhdznG6WHYEnu3Ju/17ACgPM
         rekJcu0rRO6BJdkgxs67Xw35e8NwHoiPFqrV15vaGCmxmyemMMBI6FMdJVgTIJ82eD5S
         piZ8RervFs6u431wOgjTcL9Ylmk+kMlawiSEvOkbrlJAw7h44Y/ogtBj1QP0pUrYCFoU
         WOaD0VEwXRGwS3WJxZaJ5FBVQ05t+tyBkKvhQWzDB7iEFMjYmjcm2OWpIJRAHys3OyIg
         o+fYeKHm7BDOCjOvevXxzsW0yZlQ1YitDfx+xlCTg0wiQFmS8oiKN9ICM/J4RpoM7B3m
         bJjA==
X-Forwarded-Encrypted: i=1; AJvYcCV5tPhjDXyjGWC3IJ8kuKfqqh3tjHdeo1C7ASzSX0byz6iTDTrFRs+KNNp6Q8BKimgky/sC1WM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVOhu9XEM8ipx7qx7QLICnpTOBSGyRVBakL6D1wYilO1G+pfB1
	+C7mzdKrnzZGgpNT/CiPv5ToRadkhNz23kxVAMPIrVEN+4eD6QJ1JmeCbg/8VEWIgxiysn6iSji
	HDiKfeVPJj2tCadTBeIqBIsyLqU5qqcWh61Euk8lN
X-Gm-Gg: ATEYQzxKG+kNi/eQZ6U4go9gNEeaGl5HtYSNDytfSLJtnj68Uz354eHwfJcRD0FQzru
	a22QXmNEhutRvgvV9k/D+FfEbmxH9NwUEBCzxx9Fi28RN3ZFDCWXt1ExRdjJ6kAdR03mvznikBz
	hIPMqIlbyZ/1NCvImuJGf50SfNMhsrXFHOBd0tt3xWmYQtDcF6MaQDN0KXLjPsvddAjWHmpYlem
	Vcie8FjbR8khjpgaCEV5n2b19rB5z9RvZkMb9fE8tAAIesjZR/lBYhUYUmYZbXcdQRRSb83HZbp
	pVTGzHkI3xoWpmDHtfNyifVDV6CMemWSDAfWa7WHBk9q/W07hDmIIP3uXEBrAYp9PjmfDA==
X-Received: by 2002:a05:6808:250e:b0:460:f435:2a71 with SMTP id
 5614622812f47-467e5f481acmr6504629b6e.46.1774262824231; Mon, 23 Mar 2026
 03:47:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317220319.788561-1-nogikh@google.com> <20260321170841.179ceada68dc55bb22064fda@linux-foundation.org>
In-Reply-To: <20260321170841.179ceada68dc55bb22064fda@linux-foundation.org>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 23 Mar 2026 11:46:52 +0100
X-Gm-Features: AaiRm52rx499ExyTFO6GE2_kFEksIg4FROgrnFEqj1WrKjemMDutkpP9UTsNmNo
Message-ID: <CANp29Y52fCeN_niOZsk4dWF66UNXt3qyimam1MXyEp8RiehYhA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kexec: Disable KCOV instrumentation after load_segments()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: bp@alien8.de, tglx@kernel.org, mingo@redhat.com, x86@kernel.org, 
	linux-kernel@vger.kernel.org, dvyukov@google.com, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227953-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nogikh@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,linux-foundation.org:email]
X-Rspamd-Queue-Id: 1D8642F095B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 22, 2026 at 1:08=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 17 Mar 2026 23:03:19 +0100 Aleksandr Nogikh <nogikh@google.com> w=
rote:
>
> > The load_segments() function changes segment registers, invalidating
> > GS base (which KCOV relies on for per-cpu data). When CONFIG_KCOV is
> > enabled, any subsequent instrumented C code call (e.g.
> > native_gdt_invalidate()) begins crashing the kernel in an endless
> > loop.
> >
> > ...
> >
> > Disabling instrumentation for the individual functions would be too
> > fragile, so let's fix the bug by disabling KCOV instrumentation for
> > the entire machine_kexec_64.c and physaddr.c. If coverage-guided
> > fuzzing ever needs these components in the future, we should consider
> > other approaches.
> >
>
> AI review has questions:
>         https://sashiko.dev/#/patchset/20260317220319.788561-1-nogikh@goo=
gle.com

Regarding the comments:

> Does this fix cover the CONFIG_KEXEC_JUMP path where execution returns to=
 a KCOV-instrumented kernel?

It doesn't. The fix only covers the main kexec functionality because
that's where the problem manifested: on syzbot we only use `kexec -p`,
not CONFIG_KEXEC_JUMP.

For CONFIG_KEXEC_JUMP, it should be (hopefully) enough to disable the
KCOV instrumentation for `arch/x86/power/cpu.c`, but I am not sure if
we want to also cover it here.

> Is disabling KCOV for all of physaddr.c an overly broad fix that causes
unnecessary loss of coverage for core memory primitives like __phys_addr()?

Disabling the instrumentation at a more granular level would be more
fragile (this was discussed in the v1 series and mentioned in the v2
commit message). When preparing the patch, I tried annotating
individual functions to resolve the problem, it was quite a
whack-a-mole..

Regarding the __phys_addr coverage: so far, it hasn't been super
important during kernel fuzzing. If necessary, we can easily
reconsider the approach later - for now it's just a few lines in
Makefiles.

--=20
Aleksandr

