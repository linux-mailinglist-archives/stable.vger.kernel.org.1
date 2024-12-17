Return-Path: <stable+bounces-105079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A659F5A5D
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 00:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC026168631
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 23:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AA71F9F64;
	Tue, 17 Dec 2024 23:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MJ6UmWcp"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE0E1E2617
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 23:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734478364; cv=none; b=doZybJ9kLKO2PKPSIuYw71zPIlXwjyRr9wHLapFufAczje7qtZGNUC1Eyeo/rgA8eTH0pcwf32MHdtNYoGxm38FZ5aB+W6ei+Bm1XCJYN7wKzyYg9Isdk0s0zs+MXmy+Nnbo1ActN3K0DvlTiGbQtmLabGXdppxxPur0/ilqg0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734478364; c=relaxed/simple;
	bh=Mj7k5dGfa3oPLPtKzMGI12Y2IRONSBuekyU421EVVfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1bRY9d74BhRA6soesJ2lQ8BZQX8IzDDXXy1lRb5AUsBrm7xlp9TgL3Advw2gI6884VycdKdAIx51Mk7AmlD9c7bci9X/kkvq/3ZQ1OlfxAKBv8BWzDJ+79LxOL5XeLoH7zaVLnqs7hdcbS2I/CkfrVgpyNsdkyYWAYhvX3TT+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MJ6UmWcp; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so3365583a12.2
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 15:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734478360; x=1735083160; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8StnlEH6OZ/sVqGukX7lbgEpcDL09QcbZqzfMEHuBU0=;
        b=MJ6UmWcphS1AZyu9rPUJ6Ml/oxO7+Cm+KjPICHgmqYFdHi+LrzvUlVlxjZpkHlruWE
         ansBu+lXY9lrzsDHNx04vvJguKqP1El0X5fyTBYbAx+3fGlrKIoD0XUxL9awNuIy5/Xx
         DwTwjYuqiFcjvnC/yILdnHjEBNyke236fG7vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734478360; x=1735083160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8StnlEH6OZ/sVqGukX7lbgEpcDL09QcbZqzfMEHuBU0=;
        b=fIU9cuaPdySS3vB+8NJimm7Ee8pi/76cbrjU1gVhgfZ9L33aZubVDhxeAz3S9mEJM/
         PqdHJf5G9aBS2KcmfUUi1V/Jt1bwMCq4aImJ/S3b8UvdAVAPraCKjts/VzieYUifsFGz
         tkhzrBLfB7HT7kMz/dzD6calTM+ImNK6qB6sAwOROh7ckkBYeHg1JTMFReGXSsazJhVg
         AeGffbH5ZwHjLOlV8j+EFQPKlKluRLSLw+uA0op4QlGSx+X2FQd2CSLKjtTZKxAXhu0N
         lgBS6aYLhAhst4UN0zZFp0VFvfSrQIrYrQuzckOqgpLKHNbQUgOSsb7s8TkR8VlYyyHL
         Q6nw==
X-Forwarded-Encrypted: i=1; AJvYcCV2QAqO26+Ww+qWkMo1UO5U2LhqfurkajVN9Q0/zgffmrj3gt51OJmzIiSzeO8eT2zqtA2BCWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgYRRP8negdyH0EaCAZvehTzJ/mG8/P0i8crXPvGKSEApNuIk9
	z7uFepMX8rO3cRjeWCcjEy4BBqKCrfggyRk13LjHmWRWWPMIyPuidjhc8EaihgHYmbal/bcCzza
	c2i4=
X-Gm-Gg: ASbGnctfaHY4FiYFeuoblS8kdZX4yUNCLKgVM+L/A1tlQk+U6V9IJcxi177Y0YuH8uZ
	/29Qgy3c23bFWpoNyl6LRimgBmEIZpsXJquIGQMGNNa92FErWWZMXdFIr7ianSajMZJ3mJ1i0cg
	vdhPoNFUMHLdecChQhiQ3FyU5NkGpJp4GfgsUS4rvBRQv0k6uw2eqkPyILy7P7lBJUe1Go+stG3
	F3EXyZJ3viYFid6NR4wTa+yhTOBsmTA1KxJku/aiDdOSk8+gn1/yP7/M6hfGd1dIrHAL7WiYmT5
	Lb9JjD/iFg+lXWgHTo2z2+S/eYBIZWw=
X-Google-Smtp-Source: AGHT+IEPkeO/P7QS6A9iWh5Vea+5GSw0k+sfiAAOFqHgoI2mKvBtUo8DwDOU0c6Qis8qlBUMBaZqOA==
X-Received: by 2002:a17:906:311a:b0:aa6:9372:cac7 with SMTP id a640c23a62f3a-aabf47b6ff8mr46020266b.31.1734478359742;
        Tue, 17 Dec 2024 15:32:39 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963913dfsm489633666b.159.2024.12.17.15.32.38
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 15:32:39 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so3365538a12.2
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 15:32:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXA3uDA+NB6jhdjfLby8nrGNcs+xPmrO+S4gJ+yi2bT7UsAxuJJdbSTdWSmnwrOW7WCXUoj4Ys=@vger.kernel.org
X-Received: by 2002:a17:907:94cf:b0:aab:dee6:a3a2 with SMTP id
 a640c23a62f3a-aabf48f990bmr43732266b.47.1734478358083; Tue, 17 Dec 2024
 15:32:38 -0800 (PST)
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
 <20241217175301.03d25799@gandalf.local.home>
In-Reply-To: <20241217175301.03d25799@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Dec 2024 15:32:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg9x1Xt2cmiBbCz5XTppDQ=RNkjkmegwaF6=QghG6kBtA@mail.gmail.com>
Message-ID: <CAHk-=wg9x1Xt2cmiBbCz5XTppDQ=RNkjkmegwaF6=QghG6kBtA@mail.gmail.com>
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
To: Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 14:52, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Where the buf value holds the binary storage from vbin_printf() and written
> in trace_vbprintk(). Yeah, it looks like it does depend on the arguments
> being word aligned.

So the thing is, they actually aren't word-aligned at all.

Yes, the buffer is ostensibly individual words, and the buffer size is
given in words, and 64-bit data is saved/fetched as two separate
words.

But if you look more closely, you'll see that the way the buffer is
managed is actually not as a word array at all, but using

        char *str, *end;

instead of word pointers. And the reason is because it does

        str = PTR_ALIGN(str, sizeof(type));
        ...
        str += sizeof(type);

so byte-sized data is *not* given a word, it's only given a single
char, and then if it's followed by an "int", the pointer will be
aligned at that point.

It does mean that the binary buffers are a bit denser, but since %c
and %hhd etc are VERY unusual (and often will be mixed with int-sized
data), that denser format isn't commonly an actual advantage.

And the reason I noticed this? When I was trying to clean up and
simplify the vsnprintf() code to not have so many different cases, the
*regular* number handling for char/short/int-sized cases ends up being
just one case that looks like this:

        num = get_num(va_arg(args, int), fmt.state, spec);

because char/short/int are all just "va_arg(args, int)" values.

Then the actual printout depends on that printf_spec thing (and, in my
experimental branch, that "fmt.state", but that's a local trial thing
where I split the printf_spec differently for better code generation).

So basically the core vfsprintf case doesn't need to care about
fetching char/short/int, because va_args always just formats those
kinds of arguments as int, as per the usual C implicit type expansion
rules.

But the binary printf thing then has to have three different cases,
because unlike the normal calling convention, it actually packs
char/short/int differently.  So with all those nice cleanups I tried
still look like this:

                case FORMAT_STATE_2BYTE:
                        num = get_num(get_arg(short), fmt.state, spec);
                        break;
                case FORMAT_STATE_1BYTE:
                        num = get_num(get_arg(char), fmt.state, spec);
                        break;
                default:
                        num = get_num(get_arg(int), fmt.state, spec);
                        break;

which is admittedly still a lot better than the current situation in
top-of-tree, which has separate versions for a *lot* more types.

So right now top-of-tree has 11 different enumerated cases for number printing:

        FORMAT_TYPE_LONG_LONG,
        FORMAT_TYPE_ULONG,
        FORMAT_TYPE_LONG,
        FORMAT_TYPE_UBYTE,
        FORMAT_TYPE_BYTE,
        FORMAT_TYPE_USHORT,
        FORMAT_TYPE_SHORT,
        FORMAT_TYPE_UINT,
        FORMAT_TYPE_INT,
        FORMAT_TYPE_SIZE_T,
        FORMAT_TYPE_PTRDIFF

and in my test cleanup, I've cut this down to just four cases:
FORMAT_STATE_xBYTE (x = 1, 2, 4, 8).

And the actual argument fetch for the *normal* case is actually just
two cases (because the 8-byte and the "4 bytes or less" cases are
different for va_list, but 1/2/4 bytes are just that single case).

But the binary printf argument save/fetch is not able to be cut down
to just two cases because of how it does that odd "ostensibly a word
array, but packed byte/short fields" thing.

Oh well. It's not a big deal. But I was doing this to see if I could
regularize the vsnprintf() logic and make sharing better - and then
just the binary version already causes unnecessary duplication.

If the *only* thing that accesses that word array is vbin_printf and
bstr_printf, then I could just change the packing to act like va_list
does (ie the word array would *actually* be a word array, and char and
short values would get individual words).

But at least the bpf cde seems to know about the crazy packing, and
also does that

        tmp_buf = PTR_ALIGN(tmp_buf, sizeof(u32));

in bpf_bprintf_prepare() because it knows that it's not *actually* an
array of words despite it being documented as such.

Of course, the bpf code only does the packed access thing for '%c',
and doesn't seem to know that the same is true of '%hd' and '%hhd',
presumably because nobody actually uses that.

Let's add Alexei to the participants. I think bpf too would actually
prefer that the odd char/short packing *not* be done, if only because
it clearly does the wrong thing as-is for non-%c argument (ie those
%hd/%hhd cases).

Who else accesses that odd "binary printed pseudo-word array"?

          Linus

