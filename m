Return-Path: <stable+bounces-110210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B81A19748
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 18:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5E63AA5EC
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 17:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6495185B62;
	Wed, 22 Jan 2025 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="0VMRU0GP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X3F5A0+4"
X-Original-To: stable@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F89D1684AC;
	Wed, 22 Jan 2025 17:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737566137; cv=none; b=KC+2gh9ivknWHkAm6REQ6nolKZBw7Zac9hNLB+Gf5LRa4E0eWn7+nWGzRQwhaXCOXG4SqdQzy+HwameYqFxXopxMJlwpRrxKSuY82WL7jHETm1btWBHFWAnTbqc0iYAQ+ur0V3gNAECmjTusKJlfl2bxrzZOqzadt9BW/wKlWLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737566137; c=relaxed/simple;
	bh=gY4kcWTwDxiC3dJTHxuzZYyCM8DiPWnyKkPoHw0mdlM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Gpz5UR83u5RLM06dph0mxmESghQ2jtf1/jEAGUmviYrzOuCP55XydiJe5yEQLhDY1p/rQLJ4CcQ5GinZp2+IbQUlcUfd4t+nSevi940Jh0fUhkn0HIgdxAw+Yzwmqt5nmON+C5XpTs/bClqnn5gpMZIL+pxx/p6wNIfOineSQ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=0VMRU0GP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X3F5A0+4; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 11456138084C;
	Wed, 22 Jan 2025 12:15:34 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 22 Jan 2025 12:15:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737566134;
	 x=1737652534; bh=/05Nlb7e705OChugGX4LbV7DHq9PYMXBweBL7PB5riY=; b=
	0VMRU0GPeyduE88lkID4Rq9UqkyJDBzdLSllaLdPWbg76Q5YQBcgBgwPetBqOmPE
	4k27zdoRaBg0ngALV+4iWiGfB2OAnEQBkY8gW/Un4wM1oBSak9GPcHoqe8sNMROh
	cAljC72He5aY0gRxlhQ4QgRDaL+3WgAvSaTrHJQaJGLb2tJntc/kKNflRB9qadUW
	KPzSjzJEuBAT4MXObMQvbD3DGiMXu4sO7OrtSDQ8TWsVRk7qtCJaul+8RVUqnG+T
	zIEZHN4gUPhwYmnAEPvPvHhJ3vm5aWA4Vbu+M3IncBWfp1TmUN1TnFUXih9LyRKE
	yJ2xu02g9NecBXGqzBji4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737566134; x=
	1737652534; bh=/05Nlb7e705OChugGX4LbV7DHq9PYMXBweBL7PB5riY=; b=X
	3F5A0+4sIVo7HSIJMOWNCLc8upwCSBXUbCuAPahXKykcjwWnGrPY7xBc7gcJJgDQ
	e4lmfx8UO+yqOhuF/oqy5y5SL1I8ZiWbrMMfGwcgyJffbPEAlQ6zRuMcLshlBKoD
	zU7OaeqeawgEqwxCbTw9O/fuGIj6xV8foUp6mWkpQcWBaei42f2Ooxc+kXESfl+A
	2fJmb8qBFG4tmyalpzfGUeHpilZ7JHxhWA18UGYRTiUlwWyAcu5VUWmX0FX+7GNA
	0KSiH/QLBxEWCE4vrEU/K0wREXzIMB/o8tg9gWl9VLtyEyffRn8c81hqhhu05qCQ
	NICPae/++h+GYy6mfsTaQ==
X-ME-Sender: <xms:tSeRZ7w7UAion0JdLLbqtkcOPb_HMRnsAZTbMPmT-F6mqn8-rmCmMA>
    <xme:tSeRZzRzGgFqMKY1d8ZqYVGHNh5jHsgEtHZKmfvXyLEcZ300XDIl29RFQI9YkQMkT
    eTd_XnKsclQfvVFumY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgvddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpeekvdeuhfeitdeuieejvedtieeijeefleevffef
    leekieetjeffvdekgfetuefhgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegr
    rhhnuggsrdguvgdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepghho
    rhgtuhhnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhitghhrghruggtohgthh
    hrrghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhhnrgdqmhgr
    rhhirgeslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehtghhlgieslhhinhhuth
    hrohhnihigrdguvgdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdr
    tghh
X-ME-Proxy: <xmx:tSeRZ1UdFH8VWhzze4N92ivKZAKH_kUBykOGzq_E9Lbs5rDOwQRVZA>
    <xmx:tSeRZ1hHKjNLEB5qXEieDskFKrYOHP3QTW83-8v_-TVUjJrfV1h5CA>
    <xmx:tSeRZ9A0fRZI9jgj4AsoogS9W2CSZquff8eCzk6i08Hzt7sBWN-0NA>
    <xmx:tSeRZ-L4aKE_0hCjwZ-kaf18tW9TlAhUUnldgqcARaPoFEjl2F84XQ>
    <xmx:tieRZ1YSb7E5Pbwj80W8eTsldq8WpgI1ZthEa8U27ttIkXDRAD5iGDgv>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6C6B22220072; Wed, 22 Jan 2025 12:15:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 22 Jan 2025 18:15:13 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Richard Cochran" <richardcochran@gmail.com>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>,
 "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
 "Frederic Weisbecker" <frederic@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "John Stultz" <johnstul@us.ibm.com>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Cyrill Gorcunov" <gorcunov@gmail.com>, stable@vger.kernel.org
Message-Id: <0ecf1a72-d6ae-46ab-ad20-c088c6888747@app.fastmail.com>
In-Reply-To: <Z5Ebh4pbOUGh64BS@hoboy.vegasvil.org>
References: 
 <20250121-posix-clock-compat_ioctl-v1-1-c70d5433a825@weissschuh.net>
 <603100b4-3895-4b7c-a70e-f207dd961550@app.fastmail.com>
 <Z5Ebh4pbOUGh64BS@hoboy.vegasvil.org>
Subject: Re: [PATCH] posix-clock: Explicitly handle compat ioctls
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025, at 17:23, Richard Cochran wrote:
> On Wed, Jan 22, 2025 at 08:30:51AM +0100, Arnd Bergmann wrote:
>> On Tue, Jan 21, 2025, at 23:41, Thomas Wei=C3=9Fschuh wrote:
>> > Pointer arguments passed to ioctls need to pass through compat_ptr(=
) to
>> > work correctly on s390; as explained in Documentation/driver-api/io=
ctl.rst.
>> > Plumb the compat_ioctl callback through 'struct posix_clock_operati=
ons'
>> > and handle the different ioctls cmds in the new ptp_compat_ioctl().
>> >
>> > Using compat_ptr_ioctl is not possible.
>> > For the commands PTP_ENABLE_PPS/PTP_ENABLE_PPS2 on s390
>> > it would corrupt the argument 0x80000000, aka BIT(31) to zero.
>> >
>> > Fixes: 0606f422b453 ("posix clocks: Introduce dynamic clocks")
>> > Fixes: d94ba80ebbea ("ptp: Added a brand new class driver for ptp c=
locks.")
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>>=20
>> This looks correct to me,
>
> I'm not familiar with s390, but I can remember that the compat ioctl
> was nixed during review.
>
>    https://lore.kernel.org/lkml/201012161716.42520.arnd@arndb.de/
>
>   =20
> https://lore.kernel.org/lkml/alpine.LFD.2.00.1012161939340.12146@local=
host6.localdomain6/
>
> Can you explain what changed or what was missed?

The original review comment was about the complex argument
transformation that is needed on architectures other than
s390, which thankfully still works fine.

A lot of times we can ignore the s390 problem, and there are
many drivers that still do, mainly because s390 has a very
limited set of device drivers it actually uses, and also
because 32-bit userspace is getting very rare on that
architecture.

To do things correctly on all architectures, it's usually
sufficient to just use compat_ptr_ioctl(), as in:

diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 1af0bb2cc45c..e64d37f221b5 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -90,26 +90,6 @@ static long posix_clock_ioctl(struct file *fp,
        return err;
 }
=20
-#ifdef CONFIG_COMPAT
-static long posix_clock_compat_ioctl(struct file *fp,
-                                    unsigned int cmd, unsigned long arg)
-{
-       struct posix_clock_context *pccontext =3D fp->private_data;
-       struct posix_clock *clk =3D get_posix_clock(fp);
-       int err =3D -ENOTTY;
-
-       if (!clk)
-               return -ENODEV;
-
-       if (clk->ops.ioctl)
-               err =3D clk->ops.ioctl(pccontext, cmd, arg);
-
-       put_posix_clock(clk);
-
-       return err;
-}
-#endif
-
 static int posix_clock_open(struct inode *inode, struct file *fp)
 {
        int err;
@@ -173,9 +153,7 @@ static const struct file_operations posix_clock_file=
_operations =3D {
        .unlocked_ioctl =3D posix_clock_ioctl,
        .open           =3D posix_clock_open,
        .release        =3D posix_clock_release,
-#ifdef CONFIG_COMPAT
-       .compat_ioctl   =3D posix_clock_compat_ioctl,
-#endif
+       .compat_ioctl   =3D compat_ptr_ioctl,
 };
=20
 int posix_clock_register(struct posix_clock *clk, struct device *dev)

but this was only added in 2018 and was not available in your
original version. Unfortunately this only works if 'arg' is
always a pointer or a nonnegative integer less than 2^31. If
the argument can be a negative integer, it's actually broken
on all architectures because the current code performs a
zero-extension when it should be doing a sign-extension.

A simpler variant of the patch would move the switch/case logic
into posix_clock_compat_ioctl() and avoid the extra function
pointer, simply calling posix_clock_ioctl() with the modified
argument.

      Arnd

