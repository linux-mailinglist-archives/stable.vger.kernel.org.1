Return-Path: <stable+bounces-105093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A939F5C37
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 02:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 126761893255
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 01:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342513597A;
	Wed, 18 Dec 2024 01:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Sr0nvYj1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCC73594C
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 01:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734485242; cv=none; b=Ce1X22R3b2WVLLh95EKcZaK9EYSVotZ2zAYyu//5p2s1T5kx9J/CbZpuuLRKQMtrICseJS3yMcUsakQtuB5k7soms0x6DumCCENbkniYyzWJkvoGrL1Glj0cXNXE0q91ORsv6HgHhpvXYXDDIEetyd7+GATR438Yj8a32sKzlE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734485242; c=relaxed/simple;
	bh=7dftcd3gpORal5tdW4nSoIicKcvSkaRlFW4x371Uyik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D7Hv8RpgkbXqWBW8F1rrSfNOASymNzgJyMJ8lmGaELO/AI+jWVy9H5eWlVn70vcQ3IlUxuV0ZgDvcOlDzkD2GVHgVZ1KDNXnxab0ILNCpcKsDGan3yIRi95r2ahw3ly2TNSNVvFlhoqdqGipKVQz6UvzsrroT7H9zPekBiKgE00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Sr0nvYj1; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa6a3c42400so47481166b.0
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 17:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734485237; x=1735090037; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wmDTFUak1a2VAaHb5TpBHcRdGXQyEP1xmQEFDjAyPq8=;
        b=Sr0nvYj1euECSxJjv162PBpyBpGnNW3VvpTNDQqbELAcP84xhog+k6nynnvkqluakh
         sDc2kuHhM26GKHY0aqRWOhjCrKzpu/hZvbkzcZHfTxlzwfuSRlOX9ZDPCshKG+1CMk9M
         oq95TTjtIIfJHoSPuRrSK6DHLhgBLaTbi5HzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734485237; x=1735090037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wmDTFUak1a2VAaHb5TpBHcRdGXQyEP1xmQEFDjAyPq8=;
        b=BrVL7U1BjXifnby8WmbtV3kCKjf+GB53aovEYiPWwYtoQEjZ3FGxi/axi5NHLndU/y
         hfUjDUPADHHSTAQSx79CCacxIJVCP3wSRskCpyZGrlEVyNWJZQzF1bfMjL4q6bZkweKa
         rKNXIuyDxlLnQ89fGbpB7/eQUKoT5fMmzeSvUGiNcyFq/cSG0ZUENeW5ni9hGXCp/rHB
         W1ZxRJdbc2BShb3j3ZNOGhreAdxW58tXarqj84iObudNnzoX1yGcKwFBJUq9rZy18CnT
         LcXlA8goBK5ziiRUoBQ+qrrx9ukO6rLeNlPrQ9ej/eshat1skbMwBj/zj5KajoDgPxq8
         3Cjg==
X-Forwarded-Encrypted: i=1; AJvYcCWeshfRDYpHGi8gOh82bFBmFrLSk+Gyo1e3sOZ2e5eE+83ltcQvgNSBxEJBXfbmB3gMLYOfGas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8eSWDPi0dXyhTRt4MTlHBbtKkDndCV7v0BJUfh4CrjGS1cbdi
	7SdrZx55KrwGuA+aAjO0Fa/HzhcxG7ZfUvjnaM01viM3Y1qEh4LnA9rRlWKRd8VlUMix1A7cBKo
	8brE=
X-Gm-Gg: ASbGnctAo36WgGUe03JtGlBTym73N9SaXFl6USGjmnqXO2l57x8atejiZWSu+b0C2GO
	wVwiZKSN/LJvM+p2eJp4O4nmiDoBRlEzJzteUv6my7lwi90WQHVilRlPP98upg/Hz4FY1dUabOq
	C8fIWDjsPa2Rzxpjd6Kzah7QjlWBQsQs5Ztc7IM4ZhIUbUTFnT49mdJ/36uc9yn/dxZNcKPw2Ui
	oTBjH5XKX3Mj1cv4f1PGyCNDzqllT8Dr/oYOh2G4K0Hg7AZ3HWBKPrHRAHQAsyhgx2BPO4H2o1B
	ITUMO4TUavLPvLjZ+C96YjpX+EDkBN0=
X-Google-Smtp-Source: AGHT+IFzs+XOqrFsk6hy/MoM8kLlgIkWQztpdSLA/VBkP9s/DiNJO9jlgKN+onBF+Rjb/6jESDkkbA==
X-Received: by 2002:a17:906:31cd:b0:aa6:6ee6:1b83 with SMTP id a640c23a62f3a-aabf44bbbc1mr67392866b.20.1734485237011;
        Tue, 17 Dec 2024 17:27:17 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9638ac61sm503568866b.142.2024.12.17.17.27.14
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 17:27:15 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa679ad4265so46711466b.0
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 17:27:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXgfH58SGbjBWr7qWF+S/xWaq8HhnXpkve2z+CuPtmso5Gf4RcuieKisftRLhisfjNYt8HGwzQ=@vger.kernel.org
X-Received: by 2002:a17:907:2cc5:b0:a9a:662f:ff4a with SMTP id
 a640c23a62f3a-aabdc67c3bamr505528766b.0.1734485234499; Tue, 17 Dec 2024
 17:27:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217173237.836878448@goodmis.org> <20241217173520.314190793@goodmis.org>
 <CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
 <20241217130454.5bb593e8@gandalf.local.home> <CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
 <20241217133318.06f849c9@gandalf.local.home> <CAHk-=wgi1z85Cs4VmxTqFiG75qzoS_h_nszg6qP1ennEpdokkw@mail.gmail.com>
 <20241217140153.22ac28b0@gandalf.local.home> <CAHk-=wgpjLhSv9_rnAGS1adekEHMHbjVFvmZEuEmVftuo2sJBw@mail.gmail.com>
 <20241217144411.2165f73b@gandalf.local.home> <CAHk-=whWfmZbwRmySSpOyYEZJgcKG3d-qheYidnwu+b+rk6THg@mail.gmail.com>
 <20241217175301.03d25799@gandalf.local.home> <CAHk-=wg9x1Xt2cmiBbCz5XTppDQ=RNkjkmegwaF6=QghG6kBtA@mail.gmail.com>
 <CAADnVQJy65oOubjxM-378O3wDfhuwg8TGa9hc-cTv6NmmUSykQ@mail.gmail.com>
In-Reply-To: <CAADnVQJy65oOubjxM-378O3wDfhuwg8TGa9hc-cTv6NmmUSykQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Dec 2024 17:26:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=whOM+D1D4wb5M_SGQeiDSQbmUTrpjghy2+ivo6s1aXwFQ@mail.gmail.com>
Message-ID: <CAHk-=whOM+D1D4wb5M_SGQeiDSQbmUTrpjghy2+ivo6s1aXwFQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Florent Revest <revest@google.com>, Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 16:47, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Since we're on this topic, Daniel is looking to reuse format_decode()
> in bpf_bprintf_prepare() to get rid of our manual format validation.

That was literally why I started looking into this - the many separate
type formats actually end up causing format_decode() (and the callers)
to have to generate multiple different cases, which then in turn
either cause a jump table, or - more commonly due to the CPU indirect
branch mitigations - a chain of conditionals that are fairly ugly.

Compressing the state table for the types from 11 down to 4 types
helps a bit, but then also dealing with the "smaller than int" things
as just 'int' (with the formatting flags that are separate) also ends
up avoiding some unnecessary and extra cases.

Because in the end, 'size_t' and 'long' are the same thing, even on
architectures like 32-bit x86 where 'size_t' really is 'unsigned int'
- simply because the only thing that matters for fetching the value is
the size, which is 32-bit.

(The whole "is it signed" and the truncation to smaller-than-int etc
is then something we have to handle anyway in by the 'printf_spec'
thing).

So I have a patch series to clean some of this up and avoid the extra
states. I'm not entirely happy with it, though, and I've been going
back and forth on some of the code, so I'm not ready to post it or
have anybody use it as a basis for some "real" cleanups.

I guess I could at least post the "turn 11 different types into 4"
part. I have other things in there, but that part seems fairly
unambiguously good.

Let me go separate that part out and maybe people can point out where
I've done something silly.

               Linus

