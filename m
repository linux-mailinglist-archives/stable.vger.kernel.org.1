Return-Path: <stable+bounces-177501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D19B4066E
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 16:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 554BA174258
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 14:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1BC2F60C4;
	Tue,  2 Sep 2025 14:14:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9F42F068E;
	Tue,  2 Sep 2025 14:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756822460; cv=none; b=feUAnWWYUZyijGhVD3yNbjJoMhQW3eFx/QhDGIxpEv6mq1VWnC0diboNXojjVHU/TcZ8O8uW5MeMMBARRWsckG2Qa189opmZuFjlg8isXMDlTRgxsxNwEk7RKn882rnv0AWcYDLSsbQP3Pxuy97Q1MZkmc5L00X/8tZlWnRTWdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756822460; c=relaxed/simple;
	bh=zqmHVRVfG5H2JdQZxR3TN93cPyGuhdQLjL2DVyfehZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWnuHLchPa/x1OmlJqUMnNf/J0tf+nWD/Isqiu6M34n8GdIVzYh9T+khctgklBQ2dHP0nioAIyy8+p1usCxItM2FjWrcGJE347p5KNByi5nBTWJwjqrY1EE5kM1g9KAk1hNFbpK/oJn8R+uNEhTK9L/qArL1yCY0ZeHbfNE6StA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-528d8aa2f3bso1789682137.2;
        Tue, 02 Sep 2025 07:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756822457; x=1757427257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mgo2uDMTTEUtNqi1o/66IFpTB7qN2XeEQUc+iUdZ+rs=;
        b=S+dR+VfXqt4Lkge2mjEuDUwtE1cThRgIraerzSTY/5SDwdIWaV3RDgq4f1CcK+TiiI
         TWZChQXZLMMrn++XePpkz/QSKuK0JgmB+sxCaByRrtpssX4+5oeaUrhVzsB2rBqL7yj/
         zWgyYazBcqwGRj2THj3s24/ibuONzVV8sab14KsQB22iBolxLonFOr1qeiPJeBLGMoSI
         QU0lQABZG/1HcOmmCxuUCVOJ7BgiPNybY+N6qjN18AqmBB5mllTlx7p5hYDT1Tfms8/S
         xGbzJeEq5j0ilar+Ho6uiys2degBUcvLOOMDYHA5QJW+QfjIYketdq/idhj5u48iTAaY
         xzhw==
X-Forwarded-Encrypted: i=1; AJvYcCUxipHvi/PYj5w36Acetiw8uvln+2CDJsbcPdSiZIUMjvvGrWEk50jpZz4oaAHN5Mf9OzVkHAy+T+SFX9w=@vger.kernel.org, AJvYcCXdVzeDKxT990Ee4w8qbW50BrDw8vxrRarJP2jdzA1OaN0jdsfwD8Gko5QfdhzJjAzkKY9YoYl1@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzg5FoBKLDmlGAJu/ThaWkr7l++KDah1O4H6flrbWpOtrjbqZT
	/rVZ2INrYiKJIWGaCV8utBpySqkyBfwN8vXxwyphRWpjIpZGZ4okYx3+yEFFCGRq
X-Gm-Gg: ASbGncv9VbMDb2/uAVsS4WauGxEQMkORfMuGudQbuM8yEP5Kj7ttSBnuoalnuz+0Czv
	BeC+G0awFhCwFyR4bSwV2MyAd1e9vJYef5Jiesf7astw5bVjV6jcckT50EN4nxBQ3ycDGI7sO+w
	uT+Sh/yE4LETz9cOIdoGJ/r24/Fbwsw3EO1i5UGEyr6gAx8a9ysoHE+sFTAfpIzxZaIN12QJP05
	w+sXTk4rrlo4YYaWzCZP1Q3zbC9KnKSaVdZizxIjeQ6PDOPzr6J7UEcIzClTYuHtd/zTqBmH+AI
	mlXJl0vl2WQTbT1Hfg7UpUAJ1rtVik82lhwXFLVWi8hP58W/G+0FN6A0CX0u/J8OmhX7pXJ7lkT
	QAdrWFQVdYwzjmMNMejx66XUF2BMQnrVP3ik7XyunoyI5eoOFemPqRsshlrv9qpNibwaCi24=
X-Google-Smtp-Source: AGHT+IFIQW2J4Y5lFxvmxIUCmwOPTjD/3NWWh3d3GpMYAi3sOS1fOcOeOK3J5Z05JxU1Wrniopt45Q==
X-Received: by 2002:a05:6102:3350:b0:522:255d:4d19 with SMTP id ada2fe7eead31-52b1be31896mr3052717137.23.1756822455314;
        Tue, 02 Sep 2025 07:14:15 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-894e1d08c79sm4494066241.6.2025.09.02.07.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 07:14:14 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-89018fa6f6dso1533173241.1;
        Tue, 02 Sep 2025 07:14:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFYJkxCGrb04M9lTeKQQTCgNqfvZvpF+J5tQhtATe4qtEhD5kpg3+yENZsZEwA5SYUrZbQ1wH1@vger.kernel.org, AJvYcCW+ZlkoX+J8NQJ74/BMHraRwB/z3VuduXnj5MXhqMzPbVXQFq0A0aDMPkNWvUxFkvI+pYaij9ZNJBKAZOc=@vger.kernel.org
X-Received: by 2002:a05:6102:5710:b0:51f:66fc:53b8 with SMTP id
 ada2fe7eead31-52b1be3a542mr3788218137.25.1756822454173; Tue, 02 Sep 2025
 07:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org>
 <20250825032743.80641-1-ioworker0@gmail.com> <c8851682-25f1-f594-e30f-5b62e019d37b@linux-m68k.org>
 <96ae7afc-c882-4c3d-9dea-3e2ae2789caf@linux.dev> <5a44c60b-650a-1f8a-d5cb-abf9f0716817@linux-m68k.org>
 <4e7e7292-338d-4a57-84ec-ae7427f6ad7c@linux.dev> <d07778f8-8990-226b-5171-4a36e6e18f32@linux-m68k.org>
 <d95592ec-f51e-4d80-b633-7440b4e69944@linux.dev> <30a55f56-93c2-4408-b1a5-5574984fb45f@linux.dev>
 <4405ee5a-becc-7375-61a9-01304b3e0b20@linux-m68k.org> <cfb62b9d-9cbd-47dd-a894-3357027e2a50@linux.dev>
 <CAMuHMdV-AtPm-W-QUC1HixJ8Koy_HdESwCCOhRs3Q26=wjWwog@mail.gmail.com> <f6835c03-3c3f-40ee-8000-f53f49d2b4a4@linux.dev>
In-Reply-To: <f6835c03-3c3f-40ee-8000-f53f49d2b4a4@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 2 Sep 2025 16:14:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXWkkofG2M3zqxo6DmiZc7OJ8-2p+kJ1gxan0_nVFoiCA@mail.gmail.com>
X-Gm-Features: Ac12FXzoAJTS6asLcRAF7gXDrJv7Cp9NcWKCJrI8Ef4AzRDbSg57ifH0BPfyuUo
Message-ID: <CAMuHMdXWkkofG2M3zqxo6DmiZc7OJ8-2p+kJ1gxan0_nVFoiCA@mail.gmail.com>
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
To: Lance Yang <lance.yang@linux.dev>
Cc: Finn Thain <fthain@linux-m68k.org>, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, mhiramat@kernel.org, oak@helsinkinet.fi, 
	peterz@infradead.org, stable@vger.kernel.org, will@kernel.org, 
	Lance Yang <ioworker0@gmail.com>, linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"

Hi Lance,

On Tue, 2 Sept 2025 at 15:31, Lance Yang <lance.yang@linux.dev> wrote:
> On 2025/9/1 16:45, Geert Uytterhoeven wrote:
> > On Thu, 28 Aug 2025 at 04:05, Lance Yang <lance.yang@linux.dev> wrote:
> >> This proves the problem can happen in practice (e.g., with packed structs),
> >> so we need to ignore the unaligned pointers on the architectures that don't
> >> trap for now.
> >
> > Putting locks inside a packed struct is definitely a Very Bad Idea
> > and a No Go.  Packed structs are meant to describe memory data and
>
> Right. That's definitely not how packed structs should be used ;)
>
> > MMIO register layouts, and must not contain control data for critical
> > sections.
>
> Unfortunately, this patten was found in an in-tree driver, as reported[1]
> by kernel test robot, and there might be other undiscovered instances ...
>
> [1]
> https://lore.kernel.org/oe-kbuild-all/202508240539.ARmC1Umu-lkp@intel.com

That one is completely bogus, and should be removed.
Currently it would crash on any platform that does not support
unaligned accesses.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

