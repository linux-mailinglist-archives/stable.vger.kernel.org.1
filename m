Return-Path: <stable+bounces-109597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9391A17A90
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 10:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2730C3A483F
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 09:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CC11B3950;
	Tue, 21 Jan 2025 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOr3TAZY"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA65A1C1F0F
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 09:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737453253; cv=none; b=dZX0HRs8tBLVxB3fZQDzSB/KMU5Ym++bPUNQK1nMO2rPvEvL9FGOzjdNo1O6SAf+GmSaGY8rhn6zftgv9ipRDZjaJ51MHrU04OurQuzQ6Nkl3OQIOb6j8JZSes5CQQ2RfvwQkX0W5sWjgUEs445UXQXjuUpqRrEik4ZtKf4w3XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737453253; c=relaxed/simple;
	bh=TpJffZQuac9DW2hZt9Juhtwp6++c0H+7a9wV097FLJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBUAsb60XMf4aXAlaSe+IvKIprpVU8xWUGi2azr1LIwdfokidUYDOLDYKMciT2yRdKHOymmdY3r0m7KbHnRg6NQfiV/7bEOxvAuO9Eoh10sFYNUPAxV7F/vmgbhk7LLT2UHFSyNkhw9ge95orrOVaBgQWI7WCZ497Al7DihOnsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FOr3TAZY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737453250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r/0k+9z4JN2ODCDMi+Xos9Bp9IQjHEziyZ9zUX/AkWM=;
	b=FOr3TAZY+7e4iv9t0onFM5F3AH2r0M2Khop/iBcpZiqVpFxpSWHCFG+enGz+kJkRK3ZT05
	850nLOQZ5zhCB3WGNBkC/sRLiPDKrJ9JZk/lNW3kTQapUOVV5e0p55aYswLjP+NEIMsYJW
	P038RZvJN+tSHqOJXa/L5cGqBw5NSZo=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-d2MgRBvoOq276kvcq-LWwg-1; Tue, 21 Jan 2025 04:54:08 -0500
X-MC-Unique: d2MgRBvoOq276kvcq-LWwg-1
X-Mimecast-MFC-AGG-ID: d2MgRBvoOq276kvcq-LWwg
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e02fff66a83so11090760276.0
        for <stable@vger.kernel.org>; Tue, 21 Jan 2025 01:54:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737453248; x=1738058048;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/0k+9z4JN2ODCDMi+Xos9Bp9IQjHEziyZ9zUX/AkWM=;
        b=s6k3z8mSLcaC+Wyfnq6Qjl8vX/PbKBAVTUEAk/pnbO0WyQkKwJmSXeX2osYUsKT3zy
         kXkcG9GbEU3DxknuyicBArcv5W1jC3PwYRaIGDweO3xyV1QiqMgG7j9ztFvlMzGkKsXF
         fAay8DgBJNdX603dwfCHKbAEpF1QP96t1c2Z3pZG7NF9zMG6QOPuxd67GrzYKxLVqgaZ
         bV2NTzGkc/H7shnkHEx6NTTW38pLhE7dPC8w6ZHVMAzeegkSjhy/SJlKt2U3wvcDQkm+
         RC44HeHgtCrnIgJkwL348qYE87wi98ckTIqVgNhHfcd/QtxVnAmfRJLO6Ht2oqbL4G/N
         gWUw==
X-Gm-Message-State: AOJu0YzSfgvhoNBisuyh/AR/WaQibjls84rSrUwgz0W4aOGBXYSxZrj7
	uLqFy+RGeT+qhFtlR84yJO2G3os1IFrQkkmfCdrs0VHQCNXZajm3DsQwwem2iNenrNlN0uJxuf2
	I7q/Uv5v6RxWBjh9y+u4K6Eplhp+k5tLAT4LSgA0AeGHPew3Ka0pMOP199Es7k3LgzDJpfU18an
	QSHJhB1wdtbhPMGs9vfyr0EXTtaWTW
X-Gm-Gg: ASbGncuc/z4IIJ12/oIo3LDHOCfVoPihUME7ew9kIbBtx1TfipfqmBDtOlLLJDEnTwk
	ZxSInB8SxYbSCMgd9bRkrUshtjiLrqA2kOvMCahF+R6ezCRFtN9M=
X-Received: by 2002:a05:690c:7248:b0:6f4:4280:2433 with SMTP id 00721157ae682-6f6eb67072dmr117323367b3.9.1737453248378;
        Tue, 21 Jan 2025 01:54:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9d/EFlpu1M174fWhAr0r5Yc5QQh90el5D1HrGAVT7p2zXcR8P5kxeKd4NAgWJ+uEdZzsvIqu7o/nUtqHwi7Q=
X-Received: by 2002:a05:690c:7248:b0:6f4:4280:2433 with SMTP id
 00721157ae682-6f6eb67072dmr117323187b3.9.1737453247954; Tue, 21 Jan 2025
 01:54:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACW2H-7QEMKA+LUAzFJ+srmRCzSuLk2G7shWt0SGR9SfmxwOjA@mail.gmail.com>
 <CAGxU2F4_59X-Fj7vRCoDqM394699uxqLQZ5yCuH+jXUYcYO81g@mail.gmail.com>
In-Reply-To: <CAGxU2F4_59X-Fj7vRCoDqM394699uxqLQZ5yCuH+jXUYcYO81g@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 21 Jan 2025 10:53:56 +0100
X-Gm-Features: AbW1kvYPrjthcGnUooT6VF8N9ZVJ9kek8dA_ICCkySCZF0sYJrh_CQVaeLavmhI
Message-ID: <CAGxU2F40eWaLxS8tsQaFeQ_ndjwdQXMj7VghH3VidcbkcVPrgw@mail.gmail.com>
Subject: Re: [REGRESSION] vsocket timeout with kata containers agent 3.10.1
 and kernel 6.6.70
To: Simon Kaegi <simon.kaegi@gmail.com>, Eric Dumazet <edumazet@google.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Martin KaFai Lau <kafai@fb.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Jan 2025 at 10:26, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> Hi Simon,
>
> On Tue, 21 Jan 2025 at 05:53, Simon Kaegi <simon.kaegi@gmail.com> wrote:
> >
> > #regzbot introduced v6.6.69..v6.6.70
> > #regzbot introduced: ad91a2dacbf8c26a446658cdd55e8324dfeff1e7
> >
> > We hit this regression when updating our guest vm kernel from 6.6.69
> > to 6.6.70 -- bisecting, this problem was introduced in
> > ad91a2dacbf8c26a446658cdd55e8324dfeff1e7 -- net: restrict SO_REUSEPORT
> > to inet sockets
> >
> > We're getting a timeout when trying to connect to the vsocket in the
> > guest VM when launching a kata containers 3.10.1 agent which
> > unsurprisingly ... uses a vsocket to communicate back to the host.
> >
> > We updated this commit and added an additional sk_is_vsock check and
> > recompiled and this works correctly for us.
> > - if (valbool && !sk_is_inet(sk))
> > + if (valbool && !(sk_is_inet(sk) || sk_is_vsock(sk)))
> >
> > My understanding is limited here so I've added Stefano as he is likely
> > to better understand what makes sense here.
>
> Thanks for adding me, do you have a reproducer here?
>
> AFAIK in AF_VSOCK we never supported SO_REUSEPORT, so it seems strange to me.
>
> I understand that the patch you refer to actually changes the behavior
> of setsockopt(..., SO_REUSEPORT, ...) on an AF_VSOCK socket, where it
> used to return successfully before that change, but now returns an
> error, but subsequent binds should have still failed even without this
> patch.
>
> Do you actually use the SO_REUSEPORT feature on AF_VSOCK?
>
> If so, I need to better understand if the core socket does anything,
> but as I recall AF_VSOCK allocates ports internally, so I don't think
> multiple binds on the same port have ever been supported.

I just tried on an old kernel without the patch applied, and I confirm
that SO_REUSEPORT was not supported also if the setsockopt() was
successful.

I run the following snippet on 2 shell, on the first one everything
fine, but on the second the bind() fails in this way:

$ uname -r
6.10.11-200.fc40.x86_64
$ python3
>>> import socket
>>> import os
>>> s = socket.socket(socket.AF_VSOCK, socket.SOCK_STREAM)
>>> s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEPORT, 1)
>>> s.bind((socket.VMADDR_CID_ANY, 4242))
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
OSError: [Errno 98] Address already in use


With the patch applied, the setsockopt() fails immediately, but the
bind() behavior is the same (fails only on the second):

$ uname -r
6.12.9-200.fc41.x86_64
$ python3
>>> import socket
>>> import os
>>> s = socket.socket(socket.AF_VSOCK, socket.SOCK_STREAM)
>>> s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEPORT, 1)
Traceback (most recent call last):
  File "<python-input-3>", line 1, in <module>
    s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEPORT, 1)
    ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
OSError: [Errno 95] Operation not supported

So, IMHO the patch is correct since AF_VSOCK never really supported
SO_REUSEPORT, so better to fail early.

BTW I'm not sure what is happening on your side.
Could it be a problem in your code that uses SO_REUSEPORT
indiscriminately on AF_VSOCK, even though you then never bind on the
same port again?

Thanks,
Stefano


