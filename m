Return-Path: <stable+bounces-105083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6415A9F5B09
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 01:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C45188D4BA
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 00:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785B53596A;
	Wed, 18 Dec 2024 00:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hXpqhgBf"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6389B35949
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 00:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734480186; cv=none; b=oC/CKSVayqy2UgKjAr6ceawtWNoSP7D2IdSt3infImSBdgd9FNam6sqcOCuCxS2LxBDhjBcecjPeon2BDfIfV9cja+wBEKde9IIZyndsi5nu4sdFR29wMsAp5zmFoWnS+ZBpiUPq+Wb0lKTc9gkPPaMefIXD6fmsrPFmnQsYdqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734480186; c=relaxed/simple;
	bh=TzqYrtdHi6eNGmGGNshxzQLbW6aEixLNXnqSldxiIL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kf89Y8CTognpTG9DQyLdQeWDl+D2AzjM6HVcBbpt9+4UgbiZrYVyKF1HyDfgEZaS+Gu1e5NYfgAPhaSQttIcjxivfEFLVzLtTu4iF9TzFFnvUNGm6Ca1LMZa3JvXDz4y3Qr8gtO+tHnmpy0oumSk7itbWqgD9sOGFYWunjOwF3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hXpqhgBf; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8dd1so9887422a12.2
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 16:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734480182; x=1735084982; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JV+w9s52Xx8eRNhj+xW1leokp3ZTDX6dKUvSrTDSBw8=;
        b=hXpqhgBf/JJoeGeu7NHw5A/7+Gn+ZQgJjWhNbcU/RV7mrHdIkKA3SCZekgbXfJGpUT
         axDFz74V2XXTyI1fmZ3Jme5KCoNB+FI6PmPJ1sWzBQEYO1WBpFsf+j6Iqnw69RvGxBVL
         4AYuuHxLyIZCKpdbFPCtXEFJ/6G+/EpiKthq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734480182; x=1735084982;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JV+w9s52Xx8eRNhj+xW1leokp3ZTDX6dKUvSrTDSBw8=;
        b=o86a/blNtsh2a6/kJWMe4eWBJ2D/KcLlsRK2mNlsK4Fd0hmpg8ctc0w6K2E7fX2SEi
         MbG+KwrApnKv55uba59y+mw6HgVv0mK3kY3Upkfxl1cicV0x4JCfAesVrI5nmrkajVfd
         Ur2ZmYEipwKxlMHO8ZDtkEc9wbPcHgQwiK8P0/Pgp8rKLjPk2uMdRyvjfNgwx4ogbPRn
         CQQqtopqa2Yj33ORTelSWQOjrmaFGwXvakLQVBZEMkKkYlKb517gxnBrck37M5Bm0Ru0
         +KYEuds73wvcFVoQT0WjqSeKlJ00/A6ardk1DzlijhZo0FeW+nJISiZW3CUxeEHu83Ig
         XcvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOxeRQ4mmfTrBWBE6ZnBZ93WmTKhZvyOWUg5Bpwz3nEl9wa77rTHYWEspwhi6YwCAFdZDIYOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZhiCwNfeADnpTGcSCVLUtAQQvAOL2W0j7OQcpZu53LXC0LBXJ
	vpNkEBhT9DoMnbzUwvtFVcXayhUBj2ww1etZfBqUSImDhv/vgcpNMIjhPWGGGqMSvkbeDmhCght
	RvIU=
X-Gm-Gg: ASbGncsNb2uHAZy8C9I52beUFjXrXbXXxMZyLEdfvqh1QLAN+E/hkTsls4RMQQAgkki
	OVpeFhyrWOueA4nZ7fHICBKdP1V//Zj2HzVHioyygLicVbpypHMZniCYhe9RqfTH20vA1IF+GBT
	Dky6+yj+5T2breZE9ybZsR707TI4ddLlmS6y5ZoW/S8qQZxtpRQD1eHJZzO1e9SQ4XBusOvJ2rJ
	iSg9wcM8+xfrXq48MwwTRJlJZWRGFnv9wSANkoCx96WwVmZT/i2BpMzKolqiaBqHv1mtNlOWK4d
	/xGDFViXeQFDP47KN/bsfpLDLH0bWbY=
X-Google-Smtp-Source: AGHT+IH9j5qaAsW9elzamJbuPQOs9nvK1pi59+dadiRtvU9nQMfb1jqjOPnqnPcmhSQohDqKR7/KiA==
X-Received: by 2002:a17:907:d01:b0:aa6:a501:9b3b with SMTP id a640c23a62f3a-aabf475906bmr49789866b.19.1734480182389;
        Tue, 17 Dec 2024 16:03:02 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96069d06sm494994066b.77.2024.12.17.16.03.01
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 16:03:01 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3d2a30afcso10228137a12.3
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 16:03:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWRKcCc3PjP6Sk5Z8d558ac207s+P2paQ2neP5LHb/FHexsFfM6sV+LUCdTlr2W9784MIcUW0k=@vger.kernel.org
X-Received: by 2002:a17:907:3e8c:b0:aa6:650f:cf35 with SMTP id
 a640c23a62f3a-aabf48d50ecmr51073266b.47.1734480171482; Tue, 17 Dec 2024
 16:02:51 -0800 (PST)
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
In-Reply-To: <CAHk-=wg9x1Xt2cmiBbCz5XTppDQ=RNkjkmegwaF6=QghG6kBtA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Dec 2024 16:02:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgdFnwBD9odfSBz2zjedw1oWKKO3F46YAC_puE4b9J6JQ@mail.gmail.com>
Message-ID: <CAHk-=wgdFnwBD9odfSBz2zjedw1oWKKO3F46YAC_puE4b9J6JQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
To: Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 15:32, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But if you look more closely, you'll see that the way the buffer is
> managed is actually not as a word array at all, but using
>
>         char *str, *end;
>
> instead of word pointers.

Oh, and in addition to the smaller-than-int types ('%c' and '%hd'
etc), pointers that get dereferenced also get written as a byte string
to that word array. There might be other cases too.

So it's really a fairly odd kind of "sometimes words, sometimes not"
array, with the size of the array given in words.

That binary printf is very strange.

               Linus

