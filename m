Return-Path: <stable+bounces-45435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F138C9A39
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 11:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5CF1F213E7
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 09:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6584A1BC4F;
	Mon, 20 May 2024 09:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPaYbHB1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C93219E0;
	Mon, 20 May 2024 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716196788; cv=none; b=ekdK3fqjGS6sssXxVWBnnlbc5afgckXrl4nh4SlCmFMYulxYV4dbBdEs0TjuUCS146oKPCLEygIAKZFjNQp9wHe6jLoRPgl0POcsDknJ2Q7ac9EKbGN/fCyPdga3+vfb80ZgaM07MoQwCZISLso2iejLufKrkOqgSo1Q8910LP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716196788; c=relaxed/simple;
	bh=WNf6P72bcYi1f7Q/YxEur95rQekBz1J8C+FdIR6DQV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4eT+NO3IG0TE5S3bp70Q0vFk3coo275igz+z7GFmMYRbywtOZlUDbQNfKuF6068n+aOr9C0Pp5eykQ4sGjgLXx2yLuAR8jZZNPvXnPg0DsNrBJMQQfpBUuZ0z10cnUmKNmWo39RCNWwrjKCiLwTNbqk3CxTvJIGPZXwW1i8ftw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPaYbHB1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1eca195a7c8so67105275ad.2;
        Mon, 20 May 2024 02:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716196786; x=1716801586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNf6P72bcYi1f7Q/YxEur95rQekBz1J8C+FdIR6DQV4=;
        b=BPaYbHB1tf+D6Q6vq82Hc38sUpiVlgPJQneZNGRwKPyOPbwj1OJIWYE+Rk6D4+kTwp
         Lz5xlIKa/kKjPsyljHrcHYwkx6rOjeHxUy7TefQxqqAWBo2AOt0nmpNj8/LWQU/wHqWq
         yHAdbyCdpBuHklF7gbylOVgStxKuRwPjmK5Kj4QL/xJmXuJyZFuhqzCWtf6zzHF8uS6F
         t+3BNfXxzA91zorz7RdhxtTGgNCcLZVtxpLktKltAkqyn6KD4lfUMY6TmJcCrh7bGLdj
         ReEZOj6MAWZq+aN2l+LNIVkNi+hmHOyaklfZB8dW4z43sq4kne0nrZ/oBKD3Y5B3HArs
         4/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716196786; x=1716801586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNf6P72bcYi1f7Q/YxEur95rQekBz1J8C+FdIR6DQV4=;
        b=t8qsAcuAUe+ZCDiOAwInG976z0tQ32s080k6Bg5GlxTnFFgCmR7XkwMIm36RT2JFK9
         Vpn+KbB9dZzMHfbJOIt5hv+L/3lnBN+V6O+O6kvs+9McnPbVOTsFuf1ZPZ3C6BGWS7XA
         mPlR/+0a0wWuDrl1aul7sRK5/0NGebzuOkOPE3iQSHXqs924KesnTOvfpYjnC2T5ZiLm
         OO6ZhYeWXiYLza59vH7VGDUF7jD8Gr/CcWopos043svFNJf+ysyrXmS35wkVDi4pgwF4
         N4fcuFUy/PSNQC7DmEJVa+72yClBXQsWmb5qKb3eJW2jqk9kiJSOlAyGIjsXgGALJOt/
         8aQA==
X-Forwarded-Encrypted: i=1; AJvYcCWUwBBUmOPe9ovZto2uO2SGfBloTml80YPIt+y+kjEMjKY44+NoeTu7hqaNZeu5JM/DnY3glu2jw2DTmJIEhJkMkGlO+JY3
X-Gm-Message-State: AOJu0Yz1mMHMiQeKkhSjcqCM8rYxn/2Ah5PzNj/7GYAImGCJI0j8lx21
	HBbEnZjl9thQnLyrfFJBLQfZpfgwmt4gjraQHtnx5GSOmjUU4qurypz/30VscJxcUhW5qXkl3oQ
	Wy8rOKyIV/wZrx5CHAdAP+4QytAv20zRZOlg=
X-Google-Smtp-Source: AGHT+IHA5ALO4rDjGdGMuE0iLP0CBzKlLf/Vl3GUmnak99XjEEyqobY19GgnDDHEooirsYv6X0jKdzTSMgl0uYQLXNY=
X-Received: by 2002:a17:90a:a083:b0:2b6:24cf:5c32 with SMTP id
 98e67ed59e1d1-2b6cd0e7f04mr21993872a91.49.1716196785903; Mon, 20 May 2024
 02:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHe5sWavQcUTg2zTYaryRsMywSBgBgETG=R1jRexg4qDqwCfdw@mail.gmail.com>
 <38de0776-3adf-4223-b8e0-cedb5a5ebf4d@leemhuis.info>
In-Reply-To: <38de0776-3adf-4223-b8e0-cedb5a5ebf4d@leemhuis.info>
From: Gia <giacomo.gio@gmail.com>
Date: Mon, 20 May 2024 11:19:34 +0200
Message-ID: <CAHe5sWYnbJAjGp66Q4H0W_yk9uYTcERmW=sPvJSWTsqbFZFCVg@mail.gmail.com>
Subject: Re: [REGRESSION] Thunderbolt Host Reset Change Causes eGPU
 Disconnection from 6.8.7=>6.8.8
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: linux-kernel@vger.kernel.org, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, kernel@micha.zone, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thorsten,

I'll try to provide a kernel log ASAP, it's not that easy because when
I run into this issue my keyboard isn't working. The kernel parameter
that Mario suggested, thunderbolt.host_reset=3Dfalse, fixes the issue!

I can add that without the suggested kernel parameter the issue
persists with the latest Archlinux kernel 6.9.1.

I also found another report of the issue on Archlinux forum:
https://bbs.archlinux.org/viewtopic.php?id=3D295824


On Mon, May 6, 2024 at 2:53=E2=80=AFPM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> [CCing Mario, who asked for the two suspected commits to be backported]
>
> On 06.05.24 14:24, Gia wrote:
> > Hello, from 6.8.7=3D>6.8.8 I run into a similar problem with my Caldigi=
t
> > TS3 Plus Thunderbolt 3 dock.
> >
> > After the update I see this message on boot "xHCI host controller not
> > responding, assume dead" and the dock is not working anymore. Kernel
> > 6.8.7 works great.
>
> Thx for the report. Could you make the kernel log (journalctl -k/dmesg)
> accessible somewhere?
>
> And have you looked into the other stuff that Mario suggested in the
> other thread? See the following mail and the reply to it for details:
>
> https://lore.kernel.org/all/1eb96465-0a81-4187-b8e7-607d85617d5f@gmail.co=
m/T/#u
>
> Ciao, Thorsten
>
> P.S.: To be sure the issue doesn't fall through the cracks unnoticed,
> I'm adding it to regzbot, the Linux kernel regression tracking bot:
>
> #regzbot ^introduced v6.8.7..v6.8.8
> #regzbot title thunderbolt: TB3 dock problems, xHCI host controller not
> responding, assume dead

