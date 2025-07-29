Return-Path: <stable+bounces-165033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C82B14799
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 07:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6AB175349
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 05:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D246523817C;
	Tue, 29 Jul 2025 05:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JFkBmDmN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906A222D7A5
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 05:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753767250; cv=none; b=L7+jZaBrCREx9JiYP4F5wHuLMpuRN3q/D6RHCbhm999EcBjTTJi53+J4dsz/BYzvPL37OHTDfxwCzbgUBfkRMXwmYNRZlukhXxXUHPaT2MGf54ZxVCu/C3ARqpdbhHjoxYjzTUhly0OM84eokUa5+cQyKASiiwMyVT9905JwpUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753767250; c=relaxed/simple;
	bh=qKAC5DW2JQ8V1S2ikGUaLAAv7w7fEROv695RWUPOfNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aE0QH1/5vsAyHCJzWfsNBY/rn8bcyW9RjUMDjHZ43t03B57y8DVQXXNRqReqo24RipYRuQPCshW1YqdqfveBuOKoTQIxeRmM+jGKR9lsgK5VXbTstgpLRomWptJwoytQlTHKnnabB53E8SyAg4OCWQrJy0eQJDjGo9EE5OI4Ca4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JFkBmDmN; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6154d14d6f6so1926217a12.2
        for <stable@vger.kernel.org>; Mon, 28 Jul 2025 22:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753767247; x=1754372047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D6p1/M8lR2WSDDU9YBd8I/6HRm8nPQPg6ynn7GwgSIk=;
        b=JFkBmDmN8wDAW1UTQYjpbk/uPsiP/vHQdlP4EsQoCsxFTb9jZMTdlnbsEhTh5PFT76
         gomYFGpBeYdCZ7avarjHwcag9NXThnHWhTEWIvuEcvUuu0Zeedt05YzJP1B3DPfPI8Oi
         906koV3nTFxC4a2DWBlB3UEz7YEj9okctvPJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753767247; x=1754372047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6p1/M8lR2WSDDU9YBd8I/6HRm8nPQPg6ynn7GwgSIk=;
        b=bzX6i/042pszD33QwWQABCE3zgZIynXreSggj/4EhA1HifGd4CJSxFtW0x+R7zRzZL
         uzIVQDx9q3VehfG0qtlExuCniyYM7/6U9kd3HtffIivMbnPV7x+APi/bdqZIJ5ALwfhI
         LtLtYHnz82D+gcsNB2Uh959ex0Ec470Iz7EYjsHCvX/bn6T4EAnK+X05GKpypyvKuwFZ
         ghFgcUj4IeO00F0D21hGeXFlPo06TG9oMYQ1ySQwKaNvK8YBcxFJ5UZiut/G39F7AVmp
         8rHNGu2EQnN8vQ/Htd2l1F0Xtn79zuU6KOEjbvf7wNFLlzX/9NWdsadWUXYS+4iqemgf
         KOEg==
X-Forwarded-Encrypted: i=1; AJvYcCUz9mFo7Q1Yb8W3G+qpwVChlsJOGmQKHRZ3QWD+VNau4w++5+xDoxV3Q9CGe7c4FsDYUqIIGMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfDwhuuwxNfWr+LjXmD5VN0/UCjotNvrlbADOgKIZ5zxnYaErU
	PJlZSBIplXzSyl3PQEyMcSEM1CWfuC9SuGLu91Z1ZnnubF572vBcMwND9ozoHZGFxedJoLxebMd
	BcaRFjt8=
X-Gm-Gg: ASbGncvHEhGW+yiquLDijRFdPHJ1/J0sD4vKoyAtzBlBHIwIWr3EXHfQ61p6A9WOnPT
	R/fwLrCPp9eNlFrvJgFZcVQdHaoBgbn540cZIzp31Pwyh2ZvFWfLdy/Xeup9T46AzvC9YNnF262
	wu3Zoagi/XvSSs0X6pItyMCIFFgllREgayIB9Y9aC++qaZ2yzkMDr8JrUL4AUfj+ptq+kuaIXG5
	WCu+m4rTdTLqfDy+dhyyPWiuDuZs8yN8wGMUXjsE6t6CKNT0QI5KP0VRvFoBk+YKgay/GbWxHSI
	ffDqVXNDX5kyfhm2kFKrGhPUyrph9HBgm1TMuGxOUT8iNF9lG4TKJKrjkgajwhV86eyY+I6QjxI
	O87SFv0NbmENaDPlEKv9IZJnHwNAc89o9oFVbWlEs+Mbj4P9Ql0E9anF+Y3vT2rmhOwVf2L2gSY
	cyRdEYizw=
X-Google-Smtp-Source: AGHT+IHt8GFyUUHcmWVX7yarPRZP6/gIbZDSCDXFpBiKKVXFPJwQdiC89AKHgIseke24FqnXzcU+qA==
X-Received: by 2002:a05:6402:35cb:b0:615:79b9:28d2 with SMTP id 4fb4d7f45d1cf-61579b938ddmr39838a12.0.1753767246683;
        Mon, 28 Jul 2025 22:34:06 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61544a81df7sm1899628a12.59.2025.07.28.22.34.05
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 22:34:05 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61543f03958so2160184a12.0
        for <stable@vger.kernel.org>; Mon, 28 Jul 2025 22:34:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXLA/0MqbrfAfDsnPPmS79bwNczOimfTfHqXiHqILZzX9BTm7j9oRv4JLv0nqvDCB0sExXW5Tk=@vger.kernel.org
X-Received: by 2002:a05:6402:560f:b0:615:78c6:7b12 with SMTP id
 4fb4d7f45d1cf-61578c67f57mr138067a12.30.1753767244941; Mon, 28 Jul 2025
 22:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wh0kuQE+tWMEPJqCR48F4Tip2EeYQU-mi+2Fx_Oa1Ehbw@mail.gmail.com>
 <871pq06728.fsf@wylie.me.uk> <hla34nepia6wyi2fndx5ynud4dagxd7j75xnkevtxt365ihkjj@4p746zsu6s6z>
In-Reply-To: <hla34nepia6wyi2fndx5ynud4dagxd7j75xnkevtxt365ihkjj@4p746zsu6s6z>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 28 Jul 2025 22:33:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiy=vZu63bfD8uJ6wSK8Pw_vsz-Fe2=WjFLGa_f1JnFWg@mail.gmail.com>
X-Gm-Features: Ac12FXwMXGQ8qR47Of_hZzjFq_Xr2vB0JGiqe4Uq_C-qLobzrwFzNBbnC87IKqQ
Message-ID: <CAHk-=wiy=vZu63bfD8uJ6wSK8Pw_vsz-Fe2=WjFLGa_f1JnFWg@mail.gmail.com>
Subject: Re: "stack state/frame" and "jump dest instruction" errors (was Re:
 Linux 6.16)
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: "Alan J. Wylie" <alan@wylie.me.uk>, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Jul 2025 at 08:42, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> The problem is likely that CONFIG_X86_NATIVE_CPU is using some
> AMD-specific instruction(s) which objtool doesn't know how to decode.

It might be a good idea to add some byte printout in the objtool
'can't decode instruction' error message, to make it easier to
immediately see what code sequence cannot be decoded.

> I don't have time to look at this for at least the next few days, but I
> suspect this one:
>
>      1a3:       8f ea 78 10 c3 0a 06 00 00      bextr  $0x60a,%ebx,%eax

Hmm. We do have BEXTR in our x86-opcode-map.txt file,:

  Table: 3-byte opcode 1 (0x0f 0x38)
  Referrer: 3-byte escape 1
  AVXcode: 2
  # 0x0f 0x38 0x00-0x0f
  ...
  f7: BEXTR Gy,Ey,By (v) | SHLX Gy,Ey,By (66),(v) | SARX Gy,Ey,By
(F3),(v) | SHRX Gy,Ey,By (F2),(v)

but there's apparently two different versions of 'nextr'.

The one we know about is the "BMI encoding", but there's also a TBM
encoding ("Trailing Bit Manipulation") that AMD introduced for
Bulldozer, and it appears that we don't have those in our opcode maps.

And yeah, I think it's bulldozer-specific, which explains why nobody
sees it (because bulldozer was one of the not-very-great AMD uarchs
before they got it right with Zen).

             Linus

