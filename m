Return-Path: <stable+bounces-216906-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OmAFezOlGlGIAIAu9opvQ
	(envelope-from <stable+bounces-216906-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:26:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C1D14FF38
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FCFE301494B
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C64330311;
	Tue, 17 Feb 2026 20:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BImMFGaY"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AB317993
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 20:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771359945; cv=pass; b=LlVXea7NRpDA8cvEV8kE3hShKrj+yR9gVFe0ifIEeyqja+OtvgpwAUKKem5psQWILkivaRoVxEihjBxfteDDeCuXd9k6hcVRJK3nHKfKoGuPWePVSgFokXnxHN68KMgMt/FbWSshOXiIwz9nI4e0C/E9ytxFzUv6pypkpTH65Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771359945; c=relaxed/simple;
	bh=GtDUesrtBPEYQJ391tb6gvhG3srtiHA9wFHnN9DgsNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YF8IGBgZ1GBDUbh8Ju4LetnUgQxJOQrRwOsa2ibFd6fOkBhMf8hbwO2IR1OFSGtdHA+/vBXQpvcFt27pulHw2ZZJDIS5h6kEaNvWKPWbivl4vUhwUF0vEr7DWKuAzAnaaDGSqCeQ03ix33CtvT/wq+ATAHUw0SnoosMFoaeGSg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BImMFGaY; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-652fe3bf65aso397a12.1
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 12:25:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771359943; cv=none;
        d=google.com; s=arc-20240605;
        b=B4NBX3EKA9/tyB3YzyCrf5lj+N9S2FYoM48tMb2X5kD1oqiETFOsNZ2WrvnNtlaYUL
         KNmH7WG+V+2yFeXo9dJz8vAE6dRPpOrAVJeZdlWDHeI6UpRLtO0Y1pcpNDoSlLys1sbq
         VD4MptJhGnTcLz18Ug8UCzNByDPW7dGYelymgSCV91quf7IBZ1P7tHd50u0Cxx5xLJm2
         gwXIQCFCUg3yzT4APEWHwm4Y9EjW5+p+5wzEDcV4jlX9H7lDyLlOALYSurKA0wOnA5/i
         L50lWZnQFNGsYD0pOL1HNtCgFUzpF++niVC/o0YzEBpUs8576kgbtIlhcchKLaiq8FZY
         gwwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GtDUesrtBPEYQJ391tb6gvhG3srtiHA9wFHnN9DgsNU=;
        fh=78NmQXYRQXvTTQ8iu6VgZWwmJzmWoWuKmIZ1UHlF8r8=;
        b=RymiGT/9w2HBmu0xbfLxCpkMgIR5m59jiXd1Vzo7RfFMO00XYrqhXShKH/kAX4c8HL
         q5MBs3XUGqirmpAq+yFR+Wxn5PFD+FwE7u2YP2n4t/LoIswLBV6W+rOIZnEEiAAWHxbz
         9NqKyP+s4ILxafoi4OzBJbn6zCZdeHQs/WvEe/r+QnydkOEgByCAVKgZS+7EhBviU01s
         VVP+vXsawQ4FKQK0RT2zEJ44l1caFe4BcTCT0r/5/ePzPYsQYveM01gDi13/I1Im4601
         nTPkpbadc/BJ0Oo2/Gpq6+j4mzZOUFKIe5R5QtGu8rBLFmJMIYvi/ioyDJf0g9VVwrVI
         Tsng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771359943; x=1771964743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtDUesrtBPEYQJ391tb6gvhG3srtiHA9wFHnN9DgsNU=;
        b=BImMFGaYiGJRcuZ5zAdTRf8+BWfImWjkt4SYBtaDG6afTTcJ8wQjOL5aZMLQ6PaJWP
         kWJO5Mn0VBRFAJLDcTu2z/JBbkCF3y+VcBinw0sJvh7nAlK2ngzOVS4oKn6aIdiyOkiA
         USXO9dg11R4VHwRDZzUHqGcBgb6smRJcufRhoZ1PMu+Q4Y0QhT53wB8hujnDZ8iLrm8Y
         D2iwHa5JpWsVWZqxt7QD5IPG0fJ/qzesj5U6wpjIaBwhyva5oXLPR40dXdGWiQJBxhQx
         NR9TQBvZjz/RSe6B1gxKc1wt8+CXidR5O6XuXNlR4sKjpHl83VjHtxUOr8dDQBrb8ZYS
         GVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771359943; x=1771964743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GtDUesrtBPEYQJ391tb6gvhG3srtiHA9wFHnN9DgsNU=;
        b=EdZOKb5CXELRyGEkziN74ZIU1gRCk5GfWN5QEHpYwVY7GZkA6k+35Dfw2/wODfuIKR
         AYG5kEE28hL5mlf40WepQTqddqXrdFz+ThPvBAunPnkvgadObhOZN3wYYZ+2G+X6slBY
         fUk6yChU23Ghyu7NBcbv8kjURiQIucm7nuskd2e+A/UtGS/xe7CPoK8LX4EQz5JanHZp
         uep2e0Y4Nkt31oRLdAQreoojEwf593PUJpd0YQUv388XutKXTLHkI/X7Vrji4u74u5cr
         Tzh51McX73HthSp4RDbqdJ0fXEGS6QMd+Vt1ySFYkkXLzYWLTYwwXx7GcRfRW+loAFUk
         J51g==
X-Forwarded-Encrypted: i=1; AJvYcCXtU0K1xr1sKu0oIyD8dd3fjYaVnrJnVte3ph7a72WUxjuBSLYVDVUC3OZk5C7Fso7pnvxqJH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNTfoTDEzxmnPpOEAwMAgBvUhsydAH0sFtctzvQiaJtaKgTlRb
	0fKCx16TDC3csjO+Zy6TbqrBfU+i1d0aTQDvk3PYadWKjWJvbQ3niCrQ17ueYiaVBqIX5L7BUBx
	bnlcUS1XgYUp9kascy+dNpvgT0mp1n+7p1Bnko6+T
X-Gm-Gg: AZuq6aIo/zYQvYL5q2+d/6vPH8YOvOTbnyMJKrvCASmcrmMEld4vzTy4mRRWW7z3wti
	68/1AuzwFyry1QK0rbIpL9Y6Sj6SrJE3lbzzPbp6DAHxfZU+wNm6D2s3PWkd7PaAPiVYMWJOhYR
	ktrmRRtO2T9sn1yegpBKgHW8ZTIvI5bixkuGzhmkGBC5GvvnBpqMJI4MZ/Gbe/pcUWq8V3TX2BH
	gB0xyJ5aY7Df33dKMyxyhBYjqLUjXqFTf+UpjOk7jMXtqD349dtpvbFP0xFzJOemrXOQnU3crrw
	v5T8ZrYi/O32rHTqo92HdCiTg4o7UCXyT2x8hw==
X-Received: by 2002:aa7:d783:0:b0:649:8aa1:e524 with SMTP id
 4fb4d7f45d1cf-65c14a4eca3mr72486a12.11.1771359942517; Tue, 17 Feb 2026
 12:25:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217-binder-vma-check-v1-0-1a2b37f7b762@google.com>
 <20260217-binder-vma-check-v1-1-1a2b37f7b762@google.com> <CAG48ez2mUQ-D3jpPbvdZzcOz16LMXRnzcudOZsfdoftBF5yvPA@mail.gmail.com>
 <CAH5fLghCCAvOi+xRtPnD4ToQmyignjkn-PJ6xG6Y1DAUHgBKVA@mail.gmail.com>
In-Reply-To: <CAH5fLghCCAvOi+xRtPnD4ToQmyignjkn-PJ6xG6Y1DAUHgBKVA@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 17 Feb 2026 21:25:05 +0100
X-Gm-Features: AaiRm51ZqfX4kH-xRbv10dGnYSdGZ5HZG-5FCY7NO40gcIrlsCslxHPpR6pvA5c
Message-ID: <CAG48ez1vuJMmVyFw9BLePaMskOJ0ig3LwZw5FL34RFAjqyOW5w@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust_binder: check ownership before using vma
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216906-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[linuxfoundation.org,google.com,kernel.org,garyguo.net,protonmail.com,umich.edu,oracle.com,vger.kernel.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A9C1D14FF38
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 9:15=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
> On Tue, Feb 17, 2026 at 5:55=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> > On Tue, Feb 17, 2026 at 3:22=E2=80=AFPM Alice Ryhl <aliceryhl@google.co=
m> wrote:
> > > When installing missing pages (or zapping them), Rust Binder will loo=
k
> > > up the vma in the mm by address, and then call vm_insert_page (or
> > > zap_page_range_single). However, if the vma is closed and replaced wi=
th
> > > a different vma at the same address, this can lead to Rust Binder
> > > installing pages into the wrong vma.
> > >
> > > By installing the page into a writable vma, it becomes possible to wr=
ite
> > > to your own binder pages, which are normally read-only. Although you'=
re
> > > not supposed to be able to write to those pages, the intent behind th=
e
> > > design of Rust Binder is that even if you get that ability, it should=
 not
> > > lead to anything bad. Unfortunately, due to another bug, that is not =
the
> > > case.
> > >
> > > To fix this, I will store a pointer in vm_private_data and check that
> > > the vma returned by vma_lookup() has the right vm_ops and
> > > vm_private_data before trying to use the vma. This should ensure that
> > > Rust Binder will refuse to interact with any other VMA. I will follow=
 up
> > > this patch with more vma abstractions to avoid this unsafe access to
> > > vm_ops and vm_private_data, but for now I'd like to start with the
> > > simplest possible fix.
> >
> > This sounds good to me.
> > (Userspace could still trick Rust Binder into accessing the VMA at the
> > wrong offset, but nothing will go wrong in that case.)
>
> Vma is tricky stuff.

Well, they try to give userspace a lot of flexibility, and then things
like the rmap are supposed to abstract away this complexity so that
normal drivers don't have to deal with this complexity...

> I think if I add the vm_ops->close callback this one isn't possible anymo=
re?

Yeah. (Or you could explicitly check that vma_pgoff_offset(vma,
virtual_address) returns the expected index. But either way, from a
security perspective it shouldn't really matter.)

