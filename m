Return-Path: <stable+bounces-46569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D658D08E1
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 18:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307F01C22825
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3181155C8D;
	Mon, 27 May 2024 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzldhrqR"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BF0155C96;
	Mon, 27 May 2024 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716828061; cv=none; b=r0Vn6YVBqVpGqG/rC/8Zbgd/a6jTnFm9JmAuL0NE2e3+P3go12F7Gno7WasfUbVHk+CyccKly4nWuqje3jrT33HG3lMZUk7A+KByeBmE3ho2e16fgYNKncOLGxigklFUnXmfpeuVuWanudv3Q9mVAlsmlGa1YHPZ0dnQf7RQZs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716828061; c=relaxed/simple;
	bh=dfkfDaQUMpGwTtp2bomb4Iu2aKjA9XikV5FqpfBCsSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q3kUf/kz+mNl/MIbRSBqVmjhMaoZmb5KsnvHlRFo/YKsh5gfCZAiAECwTxoa1vngR/1eEoTL1XT3Q5yRsxfaDJ5LxZj4NOj26oCYbTBnFv/9y8EXcagtQr9tNVc17Wdlb+fqwwf3a2/tcx2jeJTZlVwFFRthah+kVPZ+m+SKHYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzldhrqR; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e964acff1aso35515841fa.0;
        Mon, 27 May 2024 09:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716828058; x=1717432858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXhZGnNO1k1I5G/0gxKase3G2b7JBGSEOc1kPGMl+NM=;
        b=dzldhrqRlF2YGq29PgfboobrpPcgJhFZ/nm16yLreVDOdZwXqkm2h21vTuLDBsQQNj
         dHciV2SKF5vFhkzlECH8CxHnTnT6QFAd3AEydnj7YtGGQbLcU/HCTBTJZlTIDZ3jFF8k
         JYkjWwMhH6CKmC+/0r0v/xxbWRGrT2uWvT3W3yMO3Xv9rE9+4bkFZxV5Ha4Y8D2wGdRh
         bHsz1s6JRmcloxtE7/ZrjvWG2xW7ApsYS1Es16FQcZsM7o6ck6YSnnikFB0wpsVy4/o1
         ISNK0TUsyyuQS7BvaTtDyho39Y8MD6ss35akWSLUaLjDEOuGP1Cn4Nbfs0Ku3LBRom/x
         YADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716828058; x=1717432858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXhZGnNO1k1I5G/0gxKase3G2b7JBGSEOc1kPGMl+NM=;
        b=LB8jbZaQRdOdORVaPo52wLx0GZ3byYglJVzTmQJIrkvrb9NfbZClJpWyeDHeJAT61f
         UYDuQe6tKbIYSmCcmv4+czp/TzImtKRatm5MrGpG1RcyJ00GnAOW8KId5vpRvsdNWoeb
         SbVzLGjMZ/l9YWeT24tX0rV88rfi8WSt+9SsR8zpefDXKWGwswa6kbbrfT636PivjWva
         5KPH0zprTgfN9aVgmZrrM94ilb3g61kiFJ0J4J2LUAquF9aJbVlQ2baNHQ+rN8Ff/BrN
         0ETVsZjXaPNrZ/7Io0LQvcHxKaUKJQooszLtFt7vXrm+fqUe805VtNUre/XawGO+/b6S
         o+VA==
X-Forwarded-Encrypted: i=1; AJvYcCU8s1l2nzZ4mVrVxWRsHW0Aey2+yUj3/Bb42HtwnwEaBCPDDYqcNUAmXUJDFORF8Swpd9gW43h3BiH6/kIFi/neJ4CC3y+AKMwxpD7Q4jK7oLynSwWEU1HWyXR/g6f5uSw/hd+j4uZRaj7nsa0hBtVYalQBzlNCH4/fXQ6wCnJJK3tZrQKjOBPV
X-Gm-Message-State: AOJu0YzqBntKNyxV4+uWewl1SWx5huwtxrAI6W2qabAAdtVrs5G0WXR6
	8DaqjAwKZPTSxdZALT5IzezRFtpF1iBCCGjyrE+7TB+lVwyINQumsloirG9AI4L4yS9wuVf2LTs
	9TxCfgtoIFXeOwj0PzQrLyKp1k20EHFDb3X4=
X-Google-Smtp-Source: AGHT+IEsccTJyokgadctxD4gUbLFqcCCT0IkiQsUawd8VegpGiS5XsBpVEQl3nAm3VoXKG7/pPR0CRO43bwFcNIF1xc=
X-Received: by 2002:a2e:bc08:0:b0:2e9:570e:1cf with SMTP id
 38308e7fff4ca-2e95b3089d9mr71753261fa.52.1716828057942; Mon, 27 May 2024
 09:40:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE4VaREzY+a2PvQJYJbfh8DwB4OP7kucZG-e28H22xyWob1w_A@mail.gmail.com>
 <5b79732b-087c-411f-a477-9b837566673e@leemhuis.info> <20240524132008.6b6f69f6@gandalf.local.home>
 <CAE4VaRF80OhnaiqeP9STfLa5pORB31YSorgoJ92fQ8tsRovxqQ@mail.gmail.com>
In-Reply-To: <CAE4VaRF80OhnaiqeP9STfLa5pORB31YSorgoJ92fQ8tsRovxqQ@mail.gmail.com>
From: =?UTF-8?B?SWxra2EgTmF1bGFww6TDpA==?= <digirigawa@gmail.com>
Date: Mon, 27 May 2024 19:40:21 +0300
Message-ID: <CAE4VaRGaNJSdo474joOtKEkxkfmyJ-zsrr8asb7ojP2JexFt-A@mail.gmail.com>
Subject: Re: Bug in Kernel 6.8.x, 6.9.x Causing Trace/Panic During Shutdown/Reboot
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steven,

I took some time and bisected the 6.8.9 - 6.8.10 and git gave the
panic inducing commit:

414fb08628143 (tracefs: Reset permissions on remount if permissions are opt=
ions)

I reverted that commit to 6.9.2 and now it only serves the trace but
the panic is gone. But I can live with it.

--Ilkka

On Sun, May 26, 2024 at 8:42=E2=80=AFPM Ilkka Naulap=C3=A4=C3=A4 <digirigaw=
a@gmail.com> wrote:
>
> hi,
>
> I took 6.9.2 and applied that 0bcfd9aa4dafa to it. Now the kernel is
> serving me both problems; the trace and the panic as the pic shows.
>
> > To understand this, did you do anything with tracing? Before shutting d=
own,
> > is there anything in /sys/kernel/tracing/instances directory?
> > Were any of the files/directories permissions in /sys/kernel/tracing ch=
anged?
>
> And to answer your question, I did not do any tracing or so and the
> /sys/kernel/tracing is empty.
> Just plain boot-up, no matter if in full desktop or in bare rescue
> mode, ends up the same way.
>
> --Ilkka
>
> On Fri, May 24, 2024 at 8:19=E2=80=AFPM Steven Rostedt <rostedt@goodmis.o=
rg> wrote:
> >
> > On Fri, 24 May 2024 12:50:08 +0200
> > "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.i=
nfo> wrote:
> >
> > > > - Affected Versions: Before kernel version 6.8.10, the bug caused a
> > > > quick display of a kernel trace dump before the shutdown/reboot
> > > > completed. Starting from version 6.8.10 and continuing into version
> > > > 6.9.0 and 6.9.1, this issue has escalated to a kernel panic,
> > > > preventing the shutdown or reboot from completing and leaving the
> > > > machine stuck.
> >
> > Ah, I bet it was this commit: baa23a8d4360d ("tracefs: Reset permission=
s on
> > remount if permissions are options"), which added a "iput" callback to =
the
> > dentry without calling iput, leaving stale inodes around.
> >
> > This is fixed with:
> >
> >   0bcfd9aa4dafa ("tracefs: Clear EVENT_INODE flag in tracefs_drop_inode=
()")
> >
> > Try adding just that patch. It will at least make it go back to what wa=
s
> > happening before 6.8.10 (I hope!).
> >
> > -- Steve

