Return-Path: <stable+bounces-241138-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wtywGcom7WnBgAAAu9opvQ
	(envelope-from <stable+bounces-241138-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 22:40:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D496467A64
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 22:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C95FF300B47C
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 20:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2993A30F7E8;
	Sat, 25 Apr 2026 20:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f748ubWh"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10B72EA172
	for <stable@vger.kernel.org>; Sat, 25 Apr 2026 20:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777149636; cv=none; b=urGNDQfnwS7upIZR0fmRIwzSrhVRlLWd+UoYKIxBi4Tm65yWH+DUA1iIRE3gVf6MCLRXiukgj2nRltmxzYwXkII58yuXiGb3/TNvuoeV7i1UhYpFH9A/jkaCsMmvuRMGDwSU3SZByxH1LDFdMIjnK3EjzXh6NgWTcD1wMz4nz5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777149636; c=relaxed/simple;
	bh=eXGKJ1cs1uwpHb74uKwDKSH51r13CWDhacHB3RprwGQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jD9dmXCmhOpJv4nApLOwEzkAdjQoVS64hWkvNjAg+G2Cdg/TRy05FyGgV96jHanQJxEnoKR9sYlzRMFoJIUyF9nX5jyKKoPKcVrkA7WGOT5oZgo7guFsyeO6ofF16rl8nT055IgJlXCWXbpObrY0agQOwQGhcstFnTHZehTS/yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f748ubWh; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so115914895e9.0
        for <stable@vger.kernel.org>; Sat, 25 Apr 2026 13:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777149633; x=1777754433; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yFJdJ7NkrEvPSxW0yIUSUiyvLY54UgTANBDOvschyzw=;
        b=f748ubWhpBDF2YqTDpzXbwVNnZNEIimCqXg+52Y4H15qQ/gCbdN2GOthb6tlA9XEW9
         yw0UIkZDy1N0Jf6lmwuzcrxJXB4ZBWrOj9G42+fsRamRFOQv6jtcVKQCc11Z63CYfip0
         BIh+THIEQHKr+S4zAwW1iVbHO/NX++SBuE3a6oo125HbuLGoCGLQJf8jUR48P0HDilnu
         VGBQMAJ+dm6Bow2JO5ZSIEyaJuAJ1rieJnvMeDj5cHac/a7uTVIOOLGlwJECmlLzWbDG
         sUqSNCJlTfhJn95YS1zOus7eA9UYLtkw0Xm3ZXomjQIKfdeb2cRyuABS8aDhu6uUdPUF
         gSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777149633; x=1777754433;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yFJdJ7NkrEvPSxW0yIUSUiyvLY54UgTANBDOvschyzw=;
        b=D8DRIDpzAJ6VTT285pvALIBOO3tMyfk1Eu1kcqLCGoX1xe1l47Sq/oj3DSvipk6+kj
         ywzzNYQ0dLdOCSXDhlHAgvdBloRldFwRb2vtz0GA5Kse0bmq3MyNMcaOdsWd17QH/t7q
         GTirbNuFTufSVAKX52dapHUJYQdMDyG7WfE2Z6mn5pDnxmXm3TE6OD9v3Ll4nKI5G+G1
         daoUllZu5q+EfjqnZwWqUtXtNU9yNAFBsMrOO273tvOxQhWKmBt+tzD/eT5xQwzJfGci
         O52YBj2i4g/YjztqMCNGFT0Izkw6d8OVTOI/kN52Uus+5lh29QKfYNZP92O4XCBWYkr4
         zS0w==
X-Forwarded-Encrypted: i=1; AFNElJ+nGRnq9ylyVhH/s6bQrgwVr8QlIhFIiRmTbNB8oeIc47O1t87jEDw2ZvVtilZ76UHL9uk4Pps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIZ2bIciveMAEg8Rx4G8x/CuR8tf10Ze+JxDzpJN7OxJ93kXXe
	8ZxN/Oymma5hmNtiB/r4A6R/4KH/+o/KLLTXEHmKx63CPH6yI7r2jCF9
X-Gm-Gg: AeBDiev3LZqhBNtXXA+SZMQOi5RVtR/QHRRHZcEfUNxaCb+AqTm5bx8dXjLDh7gFapH
	ybcY8bpJ5uVYrDZwhWbezbLJoHFnA9NRbEJbEcLfQiYnp86tvWZORVMgy9LtNpc7j1o0gi8c+XL
	SAyrn6ogAWdzHBCv1Ps/DWj+7ke9LqtWwKMy9FQdfxAaU7tAGvJ/xGgpHTgegTNGBZifoxu5QOA
	ugtnRW6JLOmhLysrK7kqAMK9P3ugPV7XPj+0Ts1gfKK18DV4x9bO/ak+YIDEdwtjyasaAwnwpqv
	C6COmH3+6jddJxW5zwZEc3xM6VCPZne0Cz+h6MculKWD5EsZjUdHxK6teHzSXUMQ2IeoF6Z1O/B
	AklifpDZatlNwa/fQ3Yb9TJQPit/GYzEr/KjzyllbUcQeUVGQ/r3J94PCV8glMUf3s6SkK/xq5W
	A9daGoUyJChV3+jGvABp1yy/WOu8U3o3lt
X-Received: by 2002:a05:600c:3546:b0:488:81b1:ae36 with SMTP id 5b1f17b1804b1-488fb7880camr521977565e9.23.1777149632839;
        Sat, 25 Apr 2026 13:40:32 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4daf2sm67028315f8f.33.2026.04.25.13.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 13:40:32 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 25 Apr 2026 22:40:30 +0200
To: Song Liu <song@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, stable@vger.kernel.org,
	bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf 1/2] bpf: Do not release trampoline image in case off
 unregister error
Message-ID: <ae0mvi9yCiGakqdH@krava>
References: <20260424153905.354922-1-jolsa@kernel.org>
 <CAPhsuW5rcXABPeOy7PFkHkO8WNyfqppGpB5ijTvmMbj7GVWfcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5rcXABPeOy7PFkHkO8WNyfqppGpB5ijTvmMbj7GVWfcg@mail.gmail.com>
X-Rspamd-Queue-Id: 8D496467A64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241138-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,vger.kernel.org,fb.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olsajiri@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Fri, Apr 24, 2026 at 08:50:51AM -0700, Song Liu wrote:
> On Fri, Apr 24, 2026 at 8:39 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > If unregister_fentry fails we still have trampoline image attached
> > to a function, so releasing it could trigger crash. Releasing the
> > trampoline image only when the unregister succeeds.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> The fix looks good.
> 
> Acked-by: Song Liu <song@kernel.org>
> 
> Can we add a test case that triggers this crash without the fix?

I don't about valid scenario where unregister_fentry would fail now,
that'd be bug that we'd need to fix. We have WARN_ON_ONCE on tampoline
unlink fail.

The fix is meant for when this happens let's go with un-released
trampoline image rather than kernel crash.

jirka

