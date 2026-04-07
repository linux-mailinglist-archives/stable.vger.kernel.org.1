Return-Path: <stable+bounces-233569-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOm5Di3q1GkjywcAu9opvQ
	(envelope-from <stable+bounces-233569-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 13:27:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 327E93ADAD1
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 13:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF7FB30091F9
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 11:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938BB3A3E95;
	Tue,  7 Apr 2026 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="drHoTJnR"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197683947B6
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 11:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775561255; cv=none; b=sAk+CTDW/bryjMfxOrcQZpkQrVmbhJpQjui+3Hr4mSPLsyDOIySIV56y1HO4QyPT+onbotsDdyH4HeiO4cOjZjHFm4RjRYN2ikSkQgI68L/zb1pOd58YYn8Br40nF/nZPYmFXn3p0PEclmQNVoKLRJ+rG+ehzWNHS9oPz7mVT90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775561255; c=relaxed/simple;
	bh=m7wojd76kH+JWdkDmFN4R78y4CAglakUEaG5a0Guftc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWlnTbAM5ybxm+WlTRQw0LeBnwC69ZdgiRkbGkiVFHC8jiK3y3IGdw6wzBi4Hb+VojRFmOBC35dhlp5vPoxIMlYk1PLThkoAURqvx2E6uTJfL/xI2Gt4P8WQKPJ/NK4Haaf1UPSXuvQt1VrHzGnYy9tD1VHgCn/rTgfR7dI4ccY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=drHoTJnR; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so2668784f8f.3
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 04:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775561252; x=1776166052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1B8jV9BiU3c4QuVbCZHmuxaJfK0Alye13igtopl4zPg=;
        b=drHoTJnRCPtQF5E/FbiHizyMyqDsJ46snlBLp2/i+m3TihfXkHhGVwcMPI1+v5GXn1
         ul540OxXCIoEdZdi0LvuJf7ESMGhj/C7ouXVVw4R58fzkTShtQXuU29im4a9mdyiYj/0
         1Q8L6PZfQMM8W3/wsKUxViEzdicXxYQz2rTw4SUSO/deDGiPpI9U+B8Cf5l7zxwTSs37
         GBS2eTrz19lpY5q2JpH+NSg6pIIwPXGD1mN0TSe9KSWA4W5vw9duuOqkSk2MfZtJ7eiC
         MFh9o7eGLIRBzZ+0N3pgK61FgyRn/wtfG8y9zXYFRHd3v6OEQZvj5/nep/3jpmEmPwRc
         zsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775561252; x=1776166052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1B8jV9BiU3c4QuVbCZHmuxaJfK0Alye13igtopl4zPg=;
        b=TfqvMTCViohNWjvoxkc7GvIXUmpD58O1fmR0fZNDlwXNf95ynr0WQ7l7FToRHRWgCn
         CO+9O8I5L33mhqA7QIHRGxwvXd3pq1QYpi5gJTRFOpxHbgRu8aDf0pFYvn9RDGTgYXb/
         ckydJ4JtF572U1+4Fwcq7TTJEiGQP1sdCwNhwu3c6tPKkIdv2fuCJMVCCTdJxr1n10Y5
         GUjb9f4AySnJO2L1Xcqjs6iG/OOAV6nMYVUSuQeJH3Bt0swlJVdziKPKAFBXwSXesYhe
         aKSRCEC/Nv9q0zdoVza2WYEAFPAm7hvhPBjObqGjfCUMe+RVvhZIX9XD4nEMVRp9Ae2c
         z+SQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF4Q4EZWM29WIvd/PbDc/IVcsz9Qm/lzd1v+KdOif+P501/HLLTQP2n04ZAHJVftY6wLpv4YI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgtQtZ8krK2BJ6iysDvKcVuYCiWeq+ewKs+HxfWI3UCNu0nEgT
	Bg/SBqIp/sFkWUsMmjy9mR6whAvPiH0Tl0zk7Ddn1u8U/aOGm38zx/F+yKrPuCbUOmM=
X-Gm-Gg: AeBDietqGJsSFwyFEaMdQiQlqyPxPtsdqp/cjkpPWwsGlbZlfA+yzPvZaFI+ZS6uePw
	w3jU+tVAH+LYTexa1v9ZQM+HfzAZdulCTh8c80WWXP7EDtMv8u++ClzOS9Mf3ywgRss9XmMfB3x
	We4IugP4VoSOggoOB/FyppYWRK82rGs9EZe+3s4arPxX5BCZM+blePgHlBxhKFbp8dSk4ZCW0nv
	yNORgEf+vCsECMkpMfoQFS32S+ouJ/TbspCB0/fluPSupqIBKe/5+FY2orzcRq1Jat9uUpcEiWx
	+qmfbsh9A3bQ69BPekcHdKQjlN34HBvVsWQVOz1bjPAYHpvQmUfq+C5wGh0TLGU85FkQ/QBtTuK
	LuXoyDFML4+2abI9z2cSClePzSN1agUhL/Jkc58qsgoKiuvK2+ixLxSwPFFHdyDZo/53PBK5cPl
	BUv8WDsJHOKTli3DYI0ViJyXSt6j90ob4Ue1n0I7gd
X-Received: by 2002:a05:6000:4023:b0:439:c661:3245 with SMTP id ffacd0b85a97d-43d292f12a8mr23837109f8f.34.1775561252422;
        Tue, 07 Apr 2026 04:27:32 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f1a99sm52293050f8f.32.2026.04.07.04.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:27:32 -0700 (PDT)
Date: Tue, 7 Apr 2026 13:27:29 +0200
From: Petr Mladek <pmladek@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tamir Duberstein <tamird@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] printf: mark errptr() noinline
Message-ID: <adTqIepV2W6M_Q2o@pathway.suse.cz>
References: <20260405-printf-test-old-gcc-v1-1-76d24d9bb60e@kernel.org>
 <20260406111531.779571d7@gandalf.local.home>
 <CAJ-ks9n+cX=+97=HN76L=WF6jzfLiHZEvL6zM1-P47XORTBz5A@mail.gmail.com>
 <20260406123232.3dacbe94@gandalf.local.home>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406123232.3dacbe94@gandalf.local.home>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233569-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmladek@suse.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:dkim,pathway.suse.cz:mid]
X-Rspamd-Queue-Id: 327E93ADAD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon 2026-04-06 12:32:32, Steven Rostedt wrote:
> On Mon, 6 Apr 2026 11:21:39 -0400
> Tamir Duberstein <tamird@kernel.org> wrote:
> 
> > Thanks Steve. IMO that is a very big hammer and not warranted in this
> > case. There's been talk of encouraging distros to enable CONFIG_KUNIT
> > by default [0], which would probably interact poorly with the change
> > you propose.
> > 
> 
> Branch profiling is really just a niche that is enabled specifically for
> seeing all branches taken in the kernel. It hooks to all "if" statements!
> As you can imagine, it causes a rather large overhead in performance.
> 
> This option is only used by developers doing special analysis of their code
> (namely me ;-).
> 
> The only real concern I would have is if the kunit test developers would
> want to use the branch profiling on their code, in which case my suggestion
> would prevent that.

I wonder if it might be possible to disable the branch profiling just
for the printf_kunit.c as a compromise.

Would "#undef if" in printf_kunit.c help?

Or I see that DISABLE_BRANCH_PROFILING is an official
way to disable the feature.

I wonder if the following change would solve the problem.
I am sorry, I could not test it easily.

diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index 05f74edbc62b..45d69769ccdf 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_MIN_HEAP_KUNIT_TEST) += min_heap_kunit.o
 CFLAGS_overflow_kunit.o = $(call cc-disable-warning, tautological-constant-out-of-range-compare)
 obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
 obj-$(CONFIG_PRINTF_KUNIT_TEST) += printf_kunit.o
+CFLAGS_printf_kunit.o += -DDISABLE_BRANCH_PROFILING
 obj-$(CONFIG_RANDSTRUCT_KUNIT_TEST) += randstruct_kunit.o
 obj-$(CONFIG_SCANF_KUNIT_TEST) += scanf_kunit.o
 obj-$(CONFIG_SEQ_BUF_KUNIT_TEST) += seq_buf_kunit.o


Best Regards,
Petr

