Return-Path: <stable+bounces-263739-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LjjNOY1OMWqCgQUAu9opvQ
	(envelope-from <stable+bounces-263739-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:24:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F2568FE4D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:24:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JeS9FKln;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263739-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263739-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 777843034EFA
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 13:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E5432E13B;
	Tue, 16 Jun 2026 13:23:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78210329E7E
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 13:23:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781616219; cv=none; b=Z7oq7IstSIdET2HqjGH5eDVKAzOtglc+hhHsYvxq4fjZt9kNo7lPgTp3bbfJPXVOixK9vK0uAc6K1Bn+Xb0OhVKIee0I4VtsYhAo1qXI4T3rYlhQIHlFYTG76GBanIM/M06UTotfQ2Yp1ULPne8gfuf0B9zTfSgfLYzMDtxTY8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781616219; c=relaxed/simple;
	bh=guMWy7wf98B65PfVClETVri2NzA1ofjmGgJWY8rzEb4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=nuIx5qjSCCsdwdT7r3rQ61ULJOOsVIvDdgsCfg89yRhSWvRprL4DNO1Q/nQoG7ZJ7QaaswYJQKVsPEvbVxEwKxOmbx7is/e3pw5qsouZgpLhHqbDl1ifRI8W5kC0ZTbnNA02AvytNJa/Gucknh1Q/hRxSuisBAiZSURmwO8om9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JeS9FKln; arc=none smtp.client-ip=209.85.216.42
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36dd65b95f2so3259035a91.0
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 06:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781616216; x=1782221016; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i2eQVWR69DVBll8DZTLTpPBD8LsUE2YsnnLAZbM4NLE=;
        b=JeS9FKlnZWX6vOmsRq815yzvCmadjACpNiIdJjmdx2tKQfvPw/Va6P4hYzAaHjj8R8
         VvfZf6LHKKAc0b46wgdxM7yxHn8XijamyY323Jd2aAgZ6HWUsp32pafusdS0ccPqX194
         LD0XcpAFnejk3WEmf7FJKlIku7l6WhDAbM/uYyQ1y+Xu+JNjwcVD6q4diY3xpOeiU9vw
         o3tuCWW5DB7xEcCXejildWIb2Go0ouFB7f5NMF3pxs7cLKjJ7d0Q2U0rBvr/VMtIty1A
         Pv6BAS9DPj5fmEdl3HXr0xWAruVm9wV1xn/Vn9YhEKguGTlzRvHanMJLTeyTuXJqC15E
         I9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781616216; x=1782221016;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i2eQVWR69DVBll8DZTLTpPBD8LsUE2YsnnLAZbM4NLE=;
        b=VAzOLW49hhkOE7YXMzLF1iuH2kiHZ7uNEZqbNXUijM5pOzHVE3pw4YFEKx/EZoKqJl
         VZe1hjiwzu/eGBsDvkUbFGO5/E2FtR0EMx3Bhj0rUY5UmEytaqylchz1CqgT9X4FoLdf
         IaeppXDia/BfLNj2yGvVzRyQpYX8vfiK7qUbXBI41UtiN0619FHoRfGeKOnTGZiALWOa
         xZJUus3VgXxpO7NYn09L1CpbtjVA32LTEW+fa2lQ+OwB1/GkalRYlqp98LvPuet2cLgO
         IEHYwf1KfZMSMpXe/oE8VACD/GwuNGB4jpeRcUpsBndd9Bf9bbybVA8HJPCya7OlhuRC
         oAVg==
X-Forwarded-Encrypted: i=1; AFNElJ/TD+MGOoMgNJYMepWuUZoUKPKh2Av3rUpRPshzizgcx2tErOYmE28GwpPB76u/kSvyQ2IxS+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQmezKn11+J7rQRnkRVWZDS0XYCQllvXGkJMheBUI8M/clJx8G
	d6xbw7c1+5sGnf90SJcyOKRbfXYxiJuzKVXkoDsnat0iBWokirHahkxB
X-Gm-Gg: Acq92OGHcBQPojgvKQlZFzpnOs00qTmAONbKQ0I2uFWOHkBQQ6Mdsd34Vk4FGztA5TF
	Cbp2U8mYhC42+4DWhxbyAOiCyoyI523Hc+zfijVMLjQ8G6IHhR5Qfdtm1zj2DqbvTQJE8cet2k8
	MWpvrJMvOZ57XylwTWk668SfBfxGA/Jq3y0rDe/8y/P9UWAUfYYwUbkLrkl7i251N+kQV5EOHV9
	btNgSuPzqwATQ8Y6dQq6GJ7qsjYEyOlxlDPcTuyZjumqNlvWXTSY8wq4Nt+1aAbtXnVK90WBrs4
	2icOJJfSj9ckC3ZOzD1poBg2E0UGOO6RGHaKIh3hfUU9FBCJ+AIpPyoe0mnjb/6BktW54OMYNRp
	IHwOBy6/URW9f7jkqV1E754q5hKVFluYwM+K8b3ysGqxz3/q6d6gzBsOFmHbOhewvr4dobpsnjn
	W1Yam3tHr+lo+XdJMYdKJa+nOGJg==
X-Received: by 2002:a17:90b:1d51:b0:368:65d1:893 with SMTP id 98e67ed59e1d1-37c5235adeamr3228415a91.5.1781616215829;
        Tue, 16 Jun 2026 06:23:35 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c866518677dsm11704475a12.19.2026.06.16.06.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:23:35 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>, Mukesh Kumar Chaurasiya <mkchauras@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode
In-Reply-To: <20260616182627.2ebf3cfc-3a-amachhiw@linux.ibm.com>
Date: Tue, 16 Jun 2026 18:39:11 +0530
Message-ID: <8q8eeio8.ritesh.list@gmail.com>
References: <20260609053327.61563-1-amachhiw@linux.ibm.com> <cxxqerzk.ritesh.list@gmail.com> <20260616161011.835c90f0-38-amachhiw@linux.ibm.com> <a4suelh6.ritesh.list@gmail.com> <20260616182627.2ebf3cfc-3a-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263739-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.ibm.com,lists.ozlabs.org,gmail.com,ellerman.id.au,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:amachhiw@linux.ibm.com,m:linuxppc-dev@lists.ozlabs.org,m:maddy@linux.ibm.com,m:vaibhav@linux.ibm.com,m:harshpb@linux.ibm.com,m:anushree.mathur@linux.ibm.com,m:gautam@linux.ibm.com,m:mkchauras@gmail.com,m:npiggin@gmail.com,m:mpe@ellerman.id.au,m:chleroy@kernel.org,m:thuth@redhat.com,m:kvm@vger.kernel.org,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[riteshlist@gmail.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riteshlist@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 65F2568FE4D

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> On 2026/06/16 05:38 PM, Ritesh Harjani wrote:
>> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
>> 
>> >> > diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
>> >> > index 3449dd2b577d..7472b9522f71 100644
>> >> > --- a/arch/powerpc/include/asm/reg.h
>> >> > +++ b/arch/powerpc/include/asm/reg.h
>> >> > @@ -1356,6 +1356,7 @@
>> >> >  #define PVR_ARCH_300	0x0f000005
>> >> >  #define PVR_ARCH_31	0x0f000006
>> >> >  #define PVR_ARCH_31_P11	0x0f000007
>> >> > +#define PVR_ARCH_INVALID	0xffffffff
>> >> 
>> >> Logical processor version is defined as part of the PAPR spec. We should
>> >> ensure that this invalid PVR is also documented in the PAPR spec.
>> >> 
>> >> If you have already taken care of that, then please confirm and feel free to add:
>> >
>> > Regarding the PAPR specification documentation: The PAPR spec documents
>> > the valid Processor Version Register (PVR) values for each processor
>> > generation (POWER8, POWER9, POWER10, POWER11, etc.). However, the
>> > PVR_ARCH_INVALID value (0xffffffff) introduced in this patch series is a
>> > KVM implementation detail used internally to mark invalid compatibility
>> > mode requests - it's not an architectural value that would be defined in
>> > PAPR itself.
>> >
>> > The validation logic and the use of PVR_ARCH_INVALID as a sentinel value
>> > are documented in the kernel code and commit message.
>> >
>> 
>> But that still worries me on what if PAPR wants to re-use this value for
>> some other purpose in future. 
>
> This is a valid concern about potential future conflicts with PAPR.
> However, I'd like to point out that PAPR explicitly specifies:
>
>   "The first byte of the logical processor version value shall be 0x0F."
>
> Since PVR_ARCH_INVALID (0xffffffff) has a first byte of 0xFF, it's
> explicitly outside the valid PAPR-defined range for logical PVR values.
> This means there shouldn't be any risk of future conflict with PAPR
> specifications.
>

aah ok.. That make sense. Thanks for confirming that.
Can we please update a small comment in the code and log this info,
maybe something like:

/*
 * PAPR specifies that the first byte of a valid logical PVR value is
 * 0x0f. 0xffffffff therefore lies permanently outside the PAPR-defined
 * range and is safe to repurpose as a kernel-internal sentinel. KVM
 * stores it in vc->arch_compat when userspace requests an unsupported
 * compatibility mode (e.g. Power11 on a Power10 compat host);
 * kvmppc_sanity_check() detects this and prevents the vCPU from running
 * until a valid arch_compat is set.
 */
#define PVR_ARCH_INVALID      0xffffffff


-ritesh


