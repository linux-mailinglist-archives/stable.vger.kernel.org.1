Return-Path: <stable+bounces-7887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D784081842A
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 10:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72DCA281993
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 09:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B02012B7D;
	Tue, 19 Dec 2023 09:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X1pFzzzt"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9825F13FED
	for <stable@vger.kernel.org>; Tue, 19 Dec 2023 09:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3365b5d6f0eso2625148f8f.3
        for <stable@vger.kernel.org>; Tue, 19 Dec 2023 01:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702977075; x=1703581875; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b00Z9YbA6rA199UjNKAF7p+NcpYYH9RXLvnxhrRldNs=;
        b=X1pFzzztdUHd8mHSLNiqNr22PmncTgH96U9IX1GIIm9lu2g1qGZ9lfK+O26M71UvRk
         CV0Xt9rHsGklH5GdElwV5PU155Oq8CiPC/f2mmNWnE189AnpOlKbcPuqet0v+Nw+GXxr
         eI4z6PYuoJK2Zf42y63Yt+SG90zvJNoTkeCJTwOzcCeZLAFE7zoXaiHdJfYjG3nOtWpB
         ubvp2v0pm92Ejzx5qwCXVkcomEbezlSOxoev9TPrgbxAu+r6JaaFgKZZnCigXvvX97Ya
         eiARN/GVQXRN8yAS/1LtqhF1xCthWJyxZEqd/dCOU0TmsdSetpp9mfrwKQBrU4xEPiI1
         BJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702977075; x=1703581875;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b00Z9YbA6rA199UjNKAF7p+NcpYYH9RXLvnxhrRldNs=;
        b=aq+eh7VpyOA4fo9C5lQmI1dDt6JYgA05Lppq5jmm1DhvSTGVweoqH+KABffozhtSXD
         YAJB3YgVzURt9KQzQSY9eyQFVYlvgHB2hi5ZS+DTeOB60S6t5ABZdDeyYLGmw+s4n0wb
         HnKUghIA1meWT5yb5/sTcUw0yMQGjaysb1KhpI/xDlxabpO9gMHSsmDwHB1IJTlSF0Fe
         L6uvHeaqC85ZQvqeA+GMdAgCnvHH1cSXbzeumb29mC7svbIst6nABB/MOKFjP4mkpYo7
         pvXJGxiiHWtaXmlvjnkPudkhL8SkjSYtM2R4/FMRMgZ+Jl6SAGQ08yEA+1yNQ1HWmVQl
         6VYQ==
X-Gm-Message-State: AOJu0Yx3sJCpDI5m9O2fIvCC5fy1CSxg6JGrd5ISIj4lLcQ9oOcDwPva
	M4FauRLM6k0B+/f3TkGXiiSW/vIxTOouEsrRvK41Xw==
X-Google-Smtp-Source: AGHT+IHBN+SxeU8QRO6kS1FBHfpO8CEQfmp6QyuSnc615l3P4Ta6UdKOSrjrsDDe4ic5UQrYQTMsVdAjXxR7CTKeNoI=
X-Received: by 2002:adf:ea4c:0:b0:336:6690:6d3 with SMTP id
 j12-20020adfea4c000000b00336669006d3mr1693620wrn.29.1702977074695; Tue, 19
 Dec 2023 01:11:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230906102557.3432236-1-alpic@google.com> <20231219090909.2827497-1-alpic@google.com>
In-Reply-To: <20231219090909.2827497-1-alpic@google.com>
From: Alfred Piccioni <alpic@google.com>
Date: Tue, 19 Dec 2023 10:10:38 +0100
Message-ID: <CALcwBGC9LzzdJeq3SWy9F3g5A32s5uSvJZae4j+rwNQqqLHCKg@mail.gmail.com>
Subject: Re: [PATCH] security: new security_file_ioctl_compat() hook
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Eric Paris <eparis@parisplace.org>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for taking the time to review! Apologies for the number of
small mistakes.

> s/syscal/syscall/
> Might to consider checking using codespell to catch such things
> although it is imperfect.

Fixed, loaded codespell.

> Paul doesn't like C++-style comments so rewrite using kernel coding
> style for multi-line comments or drop.
> I don't think kernel coding style strictly prohibits use for
> single-line comments and it isn't detected by checkpatch.pl but he has
> previously
> raised this on other patches. I actually like the C++-style comments
> for one-liners especially for comments at the end of a line of code
> but Paul is the maintainer so he gets the final word.

Changed to /**/ style comments. No particular preference on my side
for comment structure, just used to C++/Java style.

> Sorry, missed this the first time but cut-and-paste error above:
> s/GETFLAGS/SETFLAGS/

Egads. Fixed.

> Also, IIRC, Paul prefers putting a pair of parentheses after function
> names to distinguish them, so in the subject line
> and description it should be security_file_ioctl_compat() and
> security_file_ioctl(), and you should put a patch version
> in the [PATCH] prefix e.g. [PATCH v3] to make clear that it is a later
> version, and usually one doesn't capitalize SELinux
> or the leading verb in the subject line (just "selinux: introduce").

Changed title to lower-case, prefixed with security, changed slightly
to fit in summary with new parentheses. Added [PATCH V3] to the
subject.

> Actually, since this spans more than just SELinux, the prefix likely
> needs to reflect that (e.g. security: introduce ...)
> and the patch should go to the linux-security-module mailing list too
> and perhaps linux-fsdevel for the ioctl change.

Added cc 'selinux@vger.kernel.org' and cc
'linux-kernel@vger.kernel.org'. Thanks!

> I didn't do an audit but does anything need to be updated for the BPF
> LSM or does it auto-magically pick up new hooks?

I'm unsure. I looked through the BPF LSM and I can't see any way it's
picking up the file_ioctl hook to begin with. It appears to me
skimming through the code that it automagically picks it up, but I'm
not willing to bet the kernel on it.

Do you know who would be a good person to ask about this to make sure?

