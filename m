Return-Path: <stable+bounces-183663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C41BC7A7D
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 09:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D883319E6568
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 07:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A172D0C78;
	Thu,  9 Oct 2025 07:18:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAF724E01D
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 07:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759994282; cv=none; b=rOpACRC4QuHDg6iUnW/jFas4H6N2zHUSr871vW3Zg/i2UxVccXIwF+Bdnf050d37ETD3gk9rcXwIMCVQp/I2MK13QK9s8WtGH/+GvJ3o6+mibDmqZj7yZ74/c7aR2hgYYHZLnm+HPOBRzJqbZQXQ/NEqApOMIuVIwlgDh7DKOdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759994282; c=relaxed/simple;
	bh=vHsLC2ZZf3R3Cazh2jOIeRCeKj5FEq8IfCJ5bB8jxzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dTO1OLCdkM7xWiJ9Req1KIaZ4KHqS5oAs6nDQE3Qvr/1oGe3CoaX1KmVoogXi9WOzgqrJNMCINKxtZx40XQa8SwB0ohvMvHXdr2rKaWhCQJtAF/K6GZorOFrfjk4lUB/5fgAEUMVd5KO0BISDhm22MkyAk8rR2zcEzDLm0nAxls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-7ea50f94045so16208786d6.1
        for <stable@vger.kernel.org>; Thu, 09 Oct 2025 00:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759994280; x=1760599080;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sLfLe9mIdxe47Pj3LvR4pabCTnZl5QqVr+O+If4CSm8=;
        b=ZkXy2aVjWyTjpTlurpbpzlLv8x1i6PxlfN9Ox+vdnkwCDkn9ii4jW9GrSWFMtM/Fd1
         qKt8XHY+3fH+mIaPl4HWgqsMBXdI8qV6/Et2hoxRoSISqNO87X/Wp1rL76+PTViUpUwb
         SUqB1LihdhiSt3GQnEkw+9inUtPZiOrwpDByoxYHfPzISaMy/bVAZDcgNpl7tBI3B7ZU
         m6yl1/09JcR/J9tNC3NcE72oeiy/JRNwaRxQB9+oEGnP0RX9L7d2kMbvaAI2Dam7RfrJ
         jbKkJH8EJ/zF89NJHyFDaVaQ8Oqr5/O2UNVXocM0qDLy6+qYqlOjLDtqgUeqMBYXUIFN
         9pcA==
X-Forwarded-Encrypted: i=1; AJvYcCVIJaAyyvp2kCXU3CwqVgYYAc1EWu9DAF6Xz+Vo3+dIOdT/2rIoOp5QFeuJG+Y6ETrAhYDObN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx02cg2rdLt0RVJQapOj7/Xp1F3yC4G+wRksUEXlP/y1mqaghet
	Bp8jhHQj0SKDW4G3OT8zEP4L97MqVn78WdhahwJUDbbTtAfjlhje2g9Ts8ULIr49
X-Gm-Gg: ASbGncszvzHg5L5uVh/XWlSfHhpE3kynczHGCz1JGutjqxPk7L/mGZUR9SP43VKXj+8
	cxqiStGz1kMeaPAFlK9UoxnFe1Sto9d2OcQFEO+6vPx4j2g+58zS3lQb7Tq1mmBZ5Vsf1TEaZYA
	sidl+Uj65utCGJUlbEUlRRNCqPg+EbauXUX7xX/8s1fBiP5j/eddDLA+aNVyjnsEQaWaf0DDhvf
	fAaY0WNZGXcKap4UnMZdK1SxtnCiOADqBdEXP1MuLJ6QZBPBdnzpsL5Q7dBwi6EH36sO8tVkRw8
	kTVItJYPx6IVdzstjsvpp2xVqS9lLt0zwLAnT4ZW0DIl7v1/zb5RQDqvgNcTXTuYW/3hXKQsVn0
	GEuIPNRNfnZqXvHCNNWSYAOszQLMbelVttzizItu/B8krskuwMepHaCpaMUfhOTTftQSHfajKRy
	9ruC+nwOftybEemrg8PJ8mWjM=
X-Google-Smtp-Source: AGHT+IEUSP1ncou/c8h+j+X1Lb8tMsf8prnbgrD3RYJ0pVXYEbKjH2dVcuLXjmPpf0CfVX/O7U5iTQ==
X-Received: by 2002:ad4:4ea5:0:b0:813:b162:e3e6 with SMTP id 6a1803df08f44-87b3a7a22aemr100328896d6.11.1759994279833;
        Thu, 09 Oct 2025 00:17:59 -0700 (PDT)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com. [209.85.222.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878be61fc21sm176775626d6.63.2025.10.09.00.17.59
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 00:17:59 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8572d7b2457so83736085a.1
        for <stable@vger.kernel.org>; Thu, 09 Oct 2025 00:17:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWoPFIEeIE0eqiXIxq9oClZnS4BNh+3YJ+gCSYCAkNFDZqg+F/ObiyLKOzeunreSypGQWcmyb4=@vger.kernel.org
X-Received: by 2002:a05:6122:a0e:b0:552:361e:25fd with SMTP id
 71dfb90a1353d-554b9193d05mr2881875e0c.2.1759993878614; Thu, 09 Oct 2025
 00:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909145243.17119-1-lance.yang@linux.dev> <yqjkjxg25gh4bdtftsdngj5suturft2b4hjbfxwe6hehbg4ctq@6i55py3jaiov>
 <99410857-0e72-23e4-c60f-dea96427b85a@linux-m68k.org> <CAMuHMdVYiSLOk-zVopXV8i7OZdO7PAK7stZSJNJDMw=ZEqtktA@mail.gmail.com>
 <inscijwnnydibdwwrkggvgxjtimajr5haixff77dbd7cxvvwc7@2t7l7oegsxcp>
 <20251007135600.6fc4a031c60b1384dffaead1@linux-foundation.org>
 <b43ce4a0-c2b5-53f2-e374-ea195227182d@linux-m68k.org> <56784853-b653-4587-b850-b03359306366@linux.dev>
 <693a62e0-a2b5-113b-d5d9-ffb7f2521d6c@linux-m68k.org> <23b67f9d-20ff-4302-810c-bf2d77c52c63@linux.dev>
 <2bd2c4a8-456e-426a-aece-6d21afe80643@linux.dev> <ba00388c-1d5b-4d95-054d-a6f09af41e7b@linux-m68k.org>
 <3fa8182f-0195-43ee-b163-f908a9e2cba3@linux.dev> <ad7cb710-0d5a-93b1-fa4d-efb236760495@linux-m68k.org>
 <3e0b7551-698f-4ef6-919b-ff4cbe3aa11c@linux.dev> <20251008210453.71ba81a635fc99ce9262be7e@linux-foundation.org>
In-Reply-To: <20251008210453.71ba81a635fc99ce9262be7e@linux-foundation.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Oct 2025 09:11:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV5o0mA50yeEfG9cH-YUZspEd-OVSDJP-q+H+bxbqm-KQ@mail.gmail.com>
X-Gm-Features: AS18NWCQgTe_ntCJBOH_V5jiAjzJoJEeK5wkQ-O8aRmmail08XldJV7y3wHkl-Q
Message-ID: <CAMuHMdV5o0mA50yeEfG9cH-YUZspEd-OVSDJP-q+H+bxbqm-KQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] hung_task: fix warnings caused by unaligned lock pointers
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lance Yang <lance.yang@linux.dev>, Eero Tamminen <oak@helsinkinet.fi>, 
	Kent Overstreet <kent.overstreet@linux.dev>, amaindex@outlook.com, anna.schumaker@oracle.com, 
	boqun.feng@gmail.com, ioworker0@gmail.com, joel.granados@kernel.org, 
	jstultz@google.com, leonylgao@tencent.com, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, longman@redhat.com, mhiramat@kernel.org, 
	mingo@redhat.com, mingzhe.yang@ly.com, peterz@infradead.org, 
	rostedt@goodmis.org, Finn Thain <fthain@linux-m68k.org>, senozhatsky@chromium.org, 
	tfiga@chromium.org, will@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

On Thu, 9 Oct 2025 at 06:04, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Thu, 9 Oct 2025 10:01:18 +0800 Lance Yang <lance.yang@linux.dev> wrote:
> > I think we fundamentally disagree on whether this fix for known
> > false-positive warnings is needed for -stable.
>
> Having the kernel send scary warnings to our users is really bad
> behavior.  And if we don't fix it, people will keep reporting it.

As the issue is present in v6.16 and v6.17, I think that warrants -stable.

> And removing a WARN_ON is a perfectly good way of fixing it.  The
> kernel has 19,000 WARNs, probably seven of which are useful :(

Right. And there is panic_on_warn...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

