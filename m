Return-Path: <stable+bounces-18811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FFE849436
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 08:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 872E4284CA8
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 07:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EB0C147;
	Mon,  5 Feb 2024 07:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEg0wNbj"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9A8D524;
	Mon,  5 Feb 2024 07:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707116971; cv=none; b=d+vcpFN4CNG5XXx7bMrdkh6rhis1MzBeQEzLKD9UOTlFlhX1gg4ODLjDbAFmgVGG8bKWuHaphs0Iir2+hABpICBhcYBMTRlKvbjYL7pJlOuIz/6SoGyUia3DdJMxAeY2tIoWEzo6MIaXWKAZSu1HhRheGq06UZCCZ0GDklbD70A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707116971; c=relaxed/simple;
	bh=0HWTyJnF7cZWV5uhr1xy2sa3Kokjs5AlpLAQuJ5RMns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZkw4vfXO+95dCdGYcqvCoqesoLbtUX2l1XlsB68/koRMQEDwx/9ruM4WPSkHKgR1S7cCvVN/M4tqpoK5Ryd+X+KZp4mQhQHjucIBKpijyNGW/djGMNa3xxCXhmH59t7hvnFDAHuirw1Tmg+VEhRYEuHigJIhO7X/el0w/yY+D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEg0wNbj; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55cca88b6a5so4757239a12.1;
        Sun, 04 Feb 2024 23:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707116968; x=1707721768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHtD0SBsqpOCqsRqynKKiqdaU6jxk/8r+8X131ttTZQ=;
        b=WEg0wNbjilSNXom4P3Q0mnMLv7gia8UH0wLYHjpQOtgSHPZvfcopPQjX9OEdfbTWIj
         LVFC5R/xn7gAJfgfdOOe8q1nAoB+s7riK+xYDYmLV9FhpDWkG+Jy196D4XvaLYO9OpvG
         YrzZJ3KmarcUdttBnzw1VWX8xq7uGc2oE/3P8XWjQwAsK1RGXMJyg+TgZltOWsvSXZE3
         VztMfqrund4RVgu2OEcDaTYreW9DIV4uAm/JpkEo0FmS2SHx9wmI1gancd7j1LqNcMYS
         GTLKW9xfLk04Z+Lk8j3SQMexm4yTNoZuTgb27qHtNJXagQp4VLQhPJq98cU7Q6QVr6PP
         iMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707116968; x=1707721768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHtD0SBsqpOCqsRqynKKiqdaU6jxk/8r+8X131ttTZQ=;
        b=Itp1IrtBw34DDJpbn+EPtUwJq+uvqZAjyyEtmkxe12Ldt9CFscPU/uYjDGuiHai5SG
         87kiV15x04gBJHjH8rpqs2mIoChff68wFJQFNuAB0HgCEiK5V6gvBczId8N0SomJnEJ3
         JC6bZpSnxZNAcUI2yU6ieCz5iqONUTPgu5/mpB33/LwDS/g580QcX+yxLVxKQUdjN7ad
         fgvzguiglPIjETpQspuXivh1mnMEaqDOp/SvZY2zqIPDOrk5kivHZMCzcPiyFQWHph6p
         /Ob+GMJlHNia3Q5vwRMzaMM8HUmGSrr0auMatyC30qk6ZLoqzUeUCgK9HC/Vf91L2hlb
         tOkA==
X-Gm-Message-State: AOJu0YwOE8Chu3KSj7hx8srkwJOuDDzjrQEexXmhngYzTMjo8U5pydqs
	tTOjBWbOX9p4XRG0vPyTOMHUDxegEtYJ9Bfp+X4fX9EdcLfCoC5AqKXdAmFruAS05DtwbFg0KNd
	xIa9yQOmHA2FtPNkhuCMK81vTV2D8bC6AX+c=
X-Google-Smtp-Source: AGHT+IEaiPB/WBdvTY0Xy9HmY2UTVqCSq6/bTFChmLjdYOwg3RgsGcf1VGS6PC79lQ4LEZx1oVfK2TsLN24i19dHJgg=
X-Received: by 2002:a17:907:77d5:b0:a36:cfdd:1fe8 with SMTP id
 kz21-20020a17090777d500b00a36cfdd1fe8mr5139298ejc.50.1707116967614; Sun, 04
 Feb 2024 23:09:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMBK1_QFuLQBp1apHD7=FnJo=RWE532=jMwfo=nkkGFSzJaD-A@mail.gmail.com>
 <2024011723-freeness-caviar-774c@gregkh>
In-Reply-To: <2024011723-freeness-caviar-774c@gregkh>
From: Serge SIMON <serge.simon@gmail.com>
Date: Mon, 5 Feb 2024 08:09:01 +0100
Message-ID: <CAMBK1_S2vwv-8PfFQ4rfChPiW7ut5LXgmUZRtyhN=AoG3g5NEg@mail.gmail.com>
Subject: Re: S/PDIF not detected anymore / regression on recent kernel 6.7 ?
To: linux-sound@vger.kernel.org, regressions@lists.linux.dev
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Any news on this ?
Just to say that i tried the 6.7.3 version and i have the exact same
problem as described below
("linux-headers-6.7.3.arch1-2-x86_64.pkg.tar.zst" for the exact ARCH
package, of course with a system fully up-to-date and rebooted) : no
more S/PDIF device detected after reboot (only the monitors are
detected, but not anymore the S/PDIF output at motherboard level-
which is what i'm using).

Reverting to 6.6.10 does solve the issue, so per what i'm seeing,
something has definitely been broken between 6.6.10 and 6.7.0 on that
topic.

Is this tracked by a bug somewhere ? Does i have to open one (in
addition to these mails) ?

Regards.

--=20
Serge.

--=20
Serge.


On Wed, Jan 17, 2024 at 6:39=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Jan 16, 2024 at 09:49:59PM +0100, Serge SIMON wrote:
> > Dear Kernel maintainers,
> >
> > I think i'm encountering (for the first time in years !) a regression
> > with the "6.7.arch3-1" kernel (whereas no issues with
> > "6.6.10.arch1-1", on which i reverted).
> >
> > I'm running a (up-to-date, and non-LTS) ARCHLINUX desktop, on a ASUS
> > B560-I motherboard, with 3 monitors (attached to a 4-HDMI outputs
> > card), plus an audio S/PDIF optic output at motherboard level.
> >
> > With the latest kernel, the S/PIDF optic output of the motherboard is
> > NOT detected anymore (and i haven't been able to see / find anything
> > in the logs at quick glance, neither journalctl -xe nor dmesg).
> >
> > Once reverted to 6.6.10, everything is fine again.
> >
> > For example, in a working situation (6.6.10), i have :
> >
> > cat /proc/asound/pcm
> > 00-00: ALC1220 Analog : ALC1220 Analog : playback 1 : capture 1
> > 00-01: ALC1220 Digital : ALC1220 Digital : playback 1
> > 00-02: ALC1220 Alt Analog : ALC1220 Alt Analog : capture 1
> > 01-03: HDMI 0 : HDMI 0 : playback 1
> > 01-07: HDMI 1 : HDMI 1 : playback 1
> > 01-08: HDMI 2 : HDMI 2 : playback 1
> > 01-09: HDMI 3 : HDMI 3 : playback 1
> >
> > Whereas while on the latest 6.7 kernel, i only had the 4 HDMI lines
> > (linked to a NVIDIA T600 card, with 4 HDMI outputs) and not the three
> > first ones (attached to the motherboard).
> >
> > (of course i did several tests with 6.7, reboot, ... without any change=
s)
> >
> > Any idea ?
>
> As this is a sound issue, perhaps send this to the
> linux-sound@vger.kernel.org mailing list (now added).
>
> Any chance you can do a 'git bisect' between 6.6 and 6.7 to track down
> the issue?  Or maybe the sound developers have some things to ask about
> as there are loads of debugging knobs in sound...
>
> thanks,
>
> greg k-h

