Return-Path: <stable+bounces-105042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE069F5675
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 19:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321A71891545
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285E71F76B5;
	Tue, 17 Dec 2024 18:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WVGOMTqA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F531161310
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 18:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734460989; cv=none; b=WscgXtbG3PON672k6gwOb/ux+sD2zt9u2asZp5HKqRtCaYPyqrc1lAy0ACSuyz4oxlMxxCSrSVDxYJAxC+o5okpiaLrRlviG1eucr+/AWpUrSqjEv8Qs//iG/iy8Nbbupx8jFdrDj9/OsrlmNq80d20B9t8zknDsj0jANTnljiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734460989; c=relaxed/simple;
	bh=MFBOghCFQxrMYgoC0DhigqYvAwhKz8jTiCtMSSCoSqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNiTAULfwLTBvdP7fftmoc78ZxIsZjkJSvpVDFnVpe8/uWtTpMRe6lIRVnUSFbIbh9FXK+rfaXbJshJtjC8SXiB62ELusIzRqf1Spn3GlZqcBwiqsMr3bukmKI3ZoYckaAlcyrxUJ+4MaQEcf7QxCaAAmygS8yMWnDC0deL1p0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WVGOMTqA; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d7e527becaso941189a12.3
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 10:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734460986; x=1735065786; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3mQXudYgFs4URfCivrY8wmstofKcT17DyeXJ55pVZ80=;
        b=WVGOMTqAqmsIikGyvdcwcELBSLjetSb8gEyUVs5smCmv7cBWrJAFp5FwgwsQOK+zXF
         63FxoTRkGgPnJuYJJcqrXbnw4L86vVPw+cPPZv8xlPxxF4de6vrYVTzbgBsyGGe1aG0S
         ZB26qqglhAndBFMZWkQU5nFM+R2FWqG2tJYzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734460986; x=1735065786;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mQXudYgFs4URfCivrY8wmstofKcT17DyeXJ55pVZ80=;
        b=VtfL4+um3FMwUMIgtRoWRrU/dmAs8rfhvZaNjYUEf+DMJ7RbaPk97Kk1sJNQA8y9ku
         4eZPit09B82R3FVKa995P8cAkbB9PUp4sgf+tuOoS69e3uGwB26mb//uHdnxAPaIBrTu
         VJKa+m+ErLlVVEOAoPfA1X9zOsq6yA6tAdwILcp0cfRGW8mu4cKgpG4C20N6kbCnsJpL
         TQLTh+xg+SGEanyB5n2Y1PnoYIdoYdemXBnO7hOgCrNo8aSzdjAzVUWsPmc6IPbHWG6R
         7i3a5CBSRdBZCFuFQ7dPAE+FRaQVgMOdErWDxw2NtwL/vTcO/6PT9vQoC1m27D9lGIrx
         DRjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2Fh7ncEJLexyvWMB3Azu4V8uTq4fMcDU4/qsAwYbj9uOlD5jXrLs3EBAZoKxQOPHB0ASCaj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI8wPwEVHrrZBYGXkttbStvpGxIlCtSmJNH4g7J+FBvkSpLQ8r
	olpUa908TBcJ35ScKOWcPnqEad7R2+/Chm3TgQg7vOxdxPU+nqavHudl6iP/QfhMpNBKcYR3Tmn
	khFU=
X-Gm-Gg: ASbGnct6+q2eTmW3ychQGRYB41gWeZD5ZwVqMG4JWHJvFrdYapBLKhm2Xz31HoUq3w4
	IhRBCP1kYiTwnpGXlvubf4W57nKerYZfxU3rrzEFZCfMqxLVyhCGNpx35R8bbCeQv6cYKA+GAtz
	7lqA7aJVDs+F4eG/gu1IPRcPIu8rMSqu75TURw48ScLbzDMS49HInxlnEQz0ny++GFP3Sc6SFkH
	wHvIbvCHJtcPUotpZ64XqKKfN3NdZZJqG/lQ2YEqex4UfcZyHODnKHiVeW14ClzXXr6c38t8jQm
	Wu9Fo5XfJALBaiHPnaXT19mxt+EWfxU=
X-Google-Smtp-Source: AGHT+IH0WuUdE8NSUWg0/vD6g22l98HGt8ZXQHzOsk5+hLxdTH8yzwZbBsNJvaeFT1gnrJIBpSGrwg==
X-Received: by 2002:a05:6402:40ca:b0:5d3:cf89:bd3e with SMTP id 4fb4d7f45d1cf-5d7ee3fd177mr298225a12.30.1734460986154;
        Tue, 17 Dec 2024 10:43:06 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9635994csm468511966b.121.2024.12.17.10.43.04
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 10:43:05 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d0d32cd31aso6954733a12.0
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 10:43:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWTU/VDCrO9XoBON9NZ3YPWbzTTRdOi/Vb+weBIVL63YXuXnpcsa7wL1B6aoo5QMO6F/eREPZU=@vger.kernel.org
X-Received: by 2002:a05:6402:40cc:b0:5d4:55e:f99e with SMTP id
 4fb4d7f45d1cf-5d7ee3b57d2mr405372a12.18.1734460984008; Tue, 17 Dec 2024
 10:43:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217173237.836878448@goodmis.org> <20241217173520.314190793@goodmis.org>
 <CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
 <20241217130454.5bb593e8@gandalf.local.home> <CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
 <20241217133318.06f849c9@gandalf.local.home>
In-Reply-To: <20241217133318.06f849c9@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Dec 2024 10:42:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgi1z85Cs4VmxTqFiG75qzoS_h_nszg6qP1ennEpdokkw@mail.gmail.com>
Message-ID: <CAHk-=wgi1z85Cs4VmxTqFiG75qzoS_h_nszg6qP1ennEpdokkw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 10:32, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> How else do I get the function name?

My initial suggestion was to just fix up the boot time array.

I think that's actually wrong. Just print the raw data and analyze it
in user space.

> I can make sure that it only works for core kernel code, and print the raw
> address if it isn't.

Streven, STOP HACKING AROUND GARBAGE.

Your solution to "I had a bad idea that resulted in bad code" seems to
always be "write more bad code".

STOP IT.

Really. This is literally what I started the whole original complaint
about. Go back to my original email, and try to understand the
original issue. Let me quote the really relevant part of that email
again:

  This stuff is full of crazy special cases for things that should never
  be done in the first place.

Note - and really INTERNALIZE - that "for stuff that should never be
done in the first place".

You started with the wrong design. Then you keep hacking it up, and
the hacks just get wilder and crazier as you notice there are more
special cases.

This is now getting to the point where I'm considering just ripping
out the whole boot-time previous kernel buffer crap because you seem
to have turned an interesting idea into just a morass of problems.

Your choice: get rid of the crazy, or have me rip it out.

            Linus

