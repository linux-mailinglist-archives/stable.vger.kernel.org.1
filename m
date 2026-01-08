Return-Path: <stable+bounces-206410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF71CD062B9
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 21:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 803C3300E3DB
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 20:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5243331203;
	Thu,  8 Jan 2026 20:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w+nl6nbR"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428CF330D34
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 20:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767905607; cv=none; b=QEWdoZMtuZ1agHTdh4aUGrTrT0hL1Z50rHPkCQ6Oj0vq9NHKXnby1WyscuZAZ3E34R6Rbhao9ntX+WCS2ZASDnMJnwv3JSPGQXqaqAfhlGSkVX5rDpZ7fvTkmaFG1IPNz6kKanCxZro9TiNQ9GCMG3LHKHYWHeSEnR2YEaEVx0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767905607; c=relaxed/simple;
	bh=fgATqevtP3BM94zxoNaA4simYmqtdH2O6vZFv5ELDsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BoV7oVnxiwRwOp3sJosnxa36eHb6kOWkl/bdCy/QcbikJaom6WOBZ8VnR8hSssbad+etQ+/bJVpJQwpACgwSe1shm2PYA0zKQlUY7h/4eyDl6skUHYR+4nhydUkDJWVpHHNNu8iLDgEZXLN6F3CYTqsGB22l/yhX/OJe6btD4Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w+nl6nbR; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7904a401d5cso40290967b3.3
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 12:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767905605; x=1768510405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9G7wPuVfMUEu+XU77xIHXJuSU5P9IBRqFiZrRft7fD4=;
        b=w+nl6nbRebUTEMJKer3iHAJb6oBB8pRb/ag0oE2ZJjSusxGrqJ2C8CScZLAe9Aa7uG
         vx9XD8RnpA3HNcHC5900TW5vKKcHqeQS04fV+ldhNeiZMFCSeg388tihjlGBBwzx2Qfs
         6TXd1VnIEGvoQ6G5REEuxOqc/PQnK6XmoaWai+3DSZUSIrk/93ujMGYItl7744d1C+Mn
         fcOxXVhhOcFJV5PFfONdtRbMTyQ273P+z7G2xuWuAWtpiI4JypNJ7FqnseS8g5v/041y
         d/L3cYKGV96cIAM2Xt/Ch9bhSzmmOYj2zmQm8QoycVa+USzGORXr2R7m8i+vZAExAoEu
         tCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767905605; x=1768510405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9G7wPuVfMUEu+XU77xIHXJuSU5P9IBRqFiZrRft7fD4=;
        b=fusAV0KqYC5XssC9xJ9H4QawbhfHKpOISqMo4gstFNDvFBkKEfGLuFFFdvEPavK30y
         iLnnPX7lXRTaNPV3/UR7LgX1R4gAgbylvmSM7QSX1KrqxsZDo0fSSxIe5jHp42UF+kQJ
         PbYoLnE7QI7Wj2kJ+E3AvDFOuxWzLXIW7gJgrKV6NV/usqEVoDjp0MDVvw4xtb0ECIAh
         kYnFj7pM4IrYC6NHTszk/xUULQ4QiMlnE8ZLWiAKq257y13sFCAYeR7ZUSJI/c2TWLJe
         ZGst+pL6+Jh33qySWS5OphevpqC8Xy4JkTYKMNMho77UsBUebfWbTOoT+G32YAGWXOqz
         2AuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgdHNMmZKF930sf5Gw3huyTAXyExkKqMSvNGaICiP6E9e1nwInVJAhH6oOsiC008L+MTK7BVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywft4I+gmH/2EX2XNd2/dpiZGuArMrMwGA32p/inzKbuPzkHSRx
	YHVZRwgs/fEMrzniHVErbqVIAH4kB3ugE9y/icaKUC3nILYVfB+5n06cJUYdXZk2zHXiD/PRo8x
	AcO6tKHdPrAAIsgIpJjqrJ4c7B+YOiirXzM5pqkq7
X-Gm-Gg: AY/fxX7Z8wL51TS6AWTkvRYf4lADKAttawqIsEuioyonRFK0t+BtQNeDi8SXdP0lX7A
	QLWnLZ7k6BC/BRVu0YDItU1fNauZpsJjhk7Qepk0ZiJH78BECBVvxv7MJTjBtF5eMt//m0vX7gp
	LunJczIdi2iIFUuFLfl/vFvAMzMsa0qHndwIGNH9ORtpByl2kb1hdbXlC/UKmk7wSCpFHg+H46g
	izy0JGvyLvdzfYOB7XUFnVUNtGPkf8Ili/Wrz8dWzEqOQQWEWdeG+427pbdq7khaLAf/d5XDXYb
	uzLKkOHL
X-Google-Smtp-Source: AGHT+IFfsXLIOQoowsK4hd0ehUg1Ov8vdpWioepVx3d4dhbTTVXSJg1Tj9/T3e3FGQHetVwrMtOEOfIKvteUHmVMjjg=
X-Received: by 2002:a05:690e:1c1d:b0:646:bb17:1515 with SMTP id
 956f58d0204a3-64716abe6afmr6611764d50.19.1767905604924; Thu, 08 Jan 2026
 12:53:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105232504.3791806-1-joshwash@google.com> <20260106182244.7188a8f6@kernel.org>
 <CAJcM6BGWGLrS=7b5Hq6RVZTD9ZHn7HyFssU6FDW4=-U8HD0+bw@mail.gmail.com> <CANn89iK_=W8JT6WGb17ARnqqSgKkt5=GUaTMB6CbPfYuPNS7vA@mail.gmail.com>
In-Reply-To: <CANn89iK_=W8JT6WGb17ARnqqSgKkt5=GUaTMB6CbPfYuPNS7vA@mail.gmail.com>
From: Ankit Garg <nktgrg@google.com>
Date: Thu, 8 Jan 2026 12:53:09 -0800
X-Gm-Features: AQt7F2paXYKlCmGeTnuQcEGigGANcGPgcSVsAVj8JM63TEpsjULC0t9r9-C1EyU
Message-ID: <CAJcM6BH11e4Cs3=7B3Uu-JxPeq4BAnQ3VDLfCAN_JcfnPLtOaw@mail.gmail.com>
Subject: Re: [PATCH net 0/2] gve: fix crashes on invalid TX queue indices
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Joshua Washington <joshwash@google.com>, netdev@vger.kernel.org, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Catherine Sullivan <csully@google.com>, Luigi Rizzo <lrizzo@google.com>, Jon Olson <jonolson@google.com>, 
	Sagi Shahar <sagis@google.com>, Bailey Forrest <bcf@google.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 8:37=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Thu, Jan 8, 2026 at 4:36=E2=80=AFPM Ankit Garg <nktgrg@google.com> wro=
te:
> >
> > On Tue, Jan 6, 2026 at 6:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > >
> > > On Mon,  5 Jan 2026 15:25:02 -0800 Joshua Washington wrote:
> > > > This series fixes a kernel panic in the GVE driver caused by
> > > > out-of-bounds array access when the network stack provides an inval=
id
> > > > TX queue index.
> > >
> > > Do you know how? I seem to recall we had such issues due to bugs
> > > in the qdisc layer, most of which were fixed.
> > >
> > > Fixing this at the source, if possible, would be far preferable
> > > to sprinkling this condition to all the drivers.
> > That matches our observation=E2=80=94we have encountered this panic on =
older
> > kernels (specifically Rocky Linux 8) but have not been able to
> > reproduce it on recent upstream kernels.
>
> What is the kernel version used in Rocky Linux 8 ?
>
The kernel version where we observed this is 4.18.0 (full version
4.18.0-553.81.1+2.1.el8_10_ciq)

> Note that the test against real_num_tx_queues is done before reaching
> the Qdisc layer.
>
> It might help to give a stack trace of a panic.
>
Crash happens in the sch_direct_xmit path per the trace.

I wonder if sch_direct_xmit is acting as an optimization to bypass the
queueing layer, and if that is somehow bypassing the queue index
checks you mentioned?

I'll try to dig a bit deeper into that specific flow, but here is the
trace in the meantime:

Call Trace:
? __warn+0x94/0xe0
? gve_tx+0xa9f/0xc30 [gve]
? gve_tx+0xa9f/0xc30 [gve]
? report_bug+0xb1/0xe0
? do_error_trap+0x9e/0xd0
? do_invalid_op+0x36/0x40
? gve_tx+0xa9f/0xc30 [gve]
? invalid_op+0x14/0x20
? gve_tx+0xa9f/0xc30 [gve]
? netif_skb_features+0xcf/0x2a0
dev_hard_start_xmit+0xd7/0x240
sch_direct_xmit+0x9f/0x370
__dev_queue_xmit+0xa04/0xc50
ip_finish_output2+0x26d/0x430
? __ip_finish_output+0xdf/0x1d0
ip_output+0x70/0xf0
__ip_queue_xmit+0x165/0x400
__tcp_transmit_skb+0xa6b/0xb90
tcp_connect+0xae3/0xd40
tcp_v4_connect+0x476/0x4f0
__inet_stream_connect+0xda/0x380
> >
> > Could you point us to the specific qdisc fixes you recall? We'd like
> > to verify if the issue we are seeing on the older kernel is indeed one
> > of those known/fixed bugs.
> >
> > If it turns out this is fully resolved in the core network stack
> > upstream, we can drop this patch for the mainline driver. However, if
> > there is ambiguity, do you think there is value in keeping this check
> > to prevent the driver from crashing on invalid input?
>
> We already have many costly checks, and netdev_core_pick_tx() should
> already prevent such panic.
>
> >
> > Thanks,
> > Ankit Garg

