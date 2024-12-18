Return-Path: <stable+bounces-105094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 333BD9F5C57
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 02:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B0C166891
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 01:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EE23594D;
	Wed, 18 Dec 2024 01:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Bybp/22n"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85553595B
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 01:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734485970; cv=none; b=diTQAWCg9lKxnw/y7EWYelSP+VwGvT6OmU4mozxjY52TC6WLF2zQWrKRkCQgfLng7T5xBnIyRjt9AQSS125jmoAXtKb7iQ1LxEJigzN0rSZFbuxF/0AkLpND+k8t1C6mGFRANcyl6Sv+cPlS9YOW4ABHDUlQGY8aSmaussS0yXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734485970; c=relaxed/simple;
	bh=NBXngBXuXUS1CuveS8CMCH5HMn+Pd3wVJYjajc/z6d0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G3OLjotfryviLKZwFtJBFOsCz+XXJddyXWdw35J97LRgsj5GnPFZjug+2pLUrJy3WfjRcS9O4F7ubjb9leucXCokeAe1Gb9vSORo/W4jrPNHxNl+qov42mhh7e2v+YvMn+wZZT0TH1ezc+00D3AzSXwV7YVCWus2wq+dXCiNph0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Bybp/22n; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aadb1so8193949a12.0
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 17:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734485967; x=1735090767; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iFUmBfvuCYiisihQ0MMHqMUfI983Sn9UGFbT49q6EUw=;
        b=Bybp/22nA1ULl/PyQjewSQ51MvjF+ksX9CTc0ak6NiVkfu8BLUWJfx76CQuUbJhzox
         qgiBT3QT6HFFJ8ZtQITtIz45+SF3/MzW0mdSiKh3wShZAXfjX0tiol+fftm8lgBed47K
         uZ8lMD3C0FNoIXKGsJgO/92aEJFIQa/cFYUio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734485967; x=1735090767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iFUmBfvuCYiisihQ0MMHqMUfI983Sn9UGFbT49q6EUw=;
        b=qIBPIVoC+GeOypNYUIvogtSGEzc1k56kEqItPzXPMgses39vhG9+f5HeulIpyynF/T
         w05DQK+j3QK1eBaZpokqpc9uN/pmoRgnJbELhy3CzxzAhKkds79zTZTCfdPyeN7Eoq2r
         cOoonvMVdsPLGZb0+XcVZ2BdUVvn60tOE+0D8U3oezeqCesA39nQqxUUfqwmqBBClySs
         3wFMvWq3msc50YqAcIYlglHIXy5RF70D6UngWrRaLq7fA/rlL93XndXIvh5kSNLR2gxh
         nuzhX/JsrepGT39XUrp7c1PcVeiYNCVTTnlSTgSOSCJE1JF7qoHhl1hhpVwAtqVUfnz0
         t+1w==
X-Forwarded-Encrypted: i=1; AJvYcCVLwnkd+Ht2krpMEQOmmdQVUbxZSzMQ62QJ6jo8EyaDB5Svedib28QvG8S2NlGn4Six7kCjCWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2GCWdFLPSlWuu/MJzhF5DtOjIlrVAIbs2RNXiF2zbnizTyyRt
	Vi1KTu1UsfoPF97b9JRIHhqh+vPZY5Igm1tpYjmXGfz1rzsabLlJ5MIBPfqv8yek8Rg6WnlUXsw
	H36I=
X-Gm-Gg: ASbGnctp5InezAsTM/7FfghjagrV8RvZS5b+hLUyZ8R8ZU4ZqyyCDDcdqmQOKNq6PF0
	sMsw3lK3yw2vG4t+GbYnAx5q6LU6BJ/OJvVUr6Lqjuel2JE+JAMWtcA0BWPUdsPdgFkzm4LyWwS
	IT+QaTAwM0THSBEDRGQhhlDl53Inj4nIML+MAZbulnfH57W7FRVtAPhzoWci7T4MYue9zcZGscJ
	6n+h9dQIV1E+RnKevW6ENNfm1/K46J5GHTcft+4N+0c1Rj+ijdKJvzHFhBzDlPQlRTp0yptD2ep
	NHl0mcI346SfVSBleEl0oUDABhBF9nI=
X-Google-Smtp-Source: AGHT+IGcqR2NhN2UkFed5mtlU8VR0xYN0IHDO++dJSWVCzT+jjzXJfVxXNEI25UvbN+FjHtT4GsGpA==
X-Received: by 2002:a05:6402:5203:b0:5d2:723c:a57e with SMTP id 4fb4d7f45d1cf-5d7ee3dfa7bmr1035720a12.16.1734485966877;
        Tue, 17 Dec 2024 17:39:26 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652f25af0sm5059945a12.70.2024.12.17.17.39.23
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 17:39:24 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa6aad76beeso828131666b.2
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 17:39:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVI294MAZKuO3DdfLGe8lYIu+18nXCJrmSgof2lMEa793V4KRqaMCtfSYspw+32KEYUdanPsU0=@vger.kernel.org
X-Received: by 2002:a17:906:3119:b0:aa6:894c:84b7 with SMTP id
 a640c23a62f3a-aabf470d31dmr63561966b.12.1734485963656; Tue, 17 Dec 2024
 17:39:23 -0800 (PST)
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
 <CAADnVQJy65oOubjxM-378O3wDfhuwg8TGa9hc-cTv6NmmUSykQ@mail.gmail.com> <CAHk-=whOM+D1D4wb5M_SGQeiDSQbmUTrpjghy2+ivo6s1aXwFQ@mail.gmail.com>
In-Reply-To: <CAHk-=whOM+D1D4wb5M_SGQeiDSQbmUTrpjghy2+ivo6s1aXwFQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Dec 2024 17:39:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjOr6tJ2TsZg-gZkmNTLrDPcWWb1h-WsAo45AmV5KkJaw@mail.gmail.com>
Message-ID: <CAHk-=wjOr6tJ2TsZg-gZkmNTLrDPcWWb1h-WsAo45AmV5KkJaw@mail.gmail.com>
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

On Tue, 17 Dec 2024 at 17:26, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Let me go separate that part out and maybe people can point out where
> I've done something silly.

Ok, that part I had actually already locally separated out better than
some of my later patches in the series, so I sent it out as

  https://lore.kernel.org/all/20241218013620.1679088-1-torvalds@linux-foundation.org/

but I'm not guaranteeing it's right. Consider it a WIP thing, and only
a first step.

           Linus

