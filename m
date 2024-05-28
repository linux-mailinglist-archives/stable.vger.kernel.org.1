Return-Path: <stable+bounces-47550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 783B68D1389
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 06:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0403D1F23840
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 04:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D9518EB8;
	Tue, 28 May 2024 04:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXxpEynC"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754814400;
	Tue, 28 May 2024 04:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716871930; cv=none; b=PSVyonmkkB8S7ohE3IzmzXKBN9hkotzyu5Qk4u1QJyTKKuHVFPPxxcGgPC7Wne2qkFKaPyxfLokMh2ewbmUdRIXxZTgJi43hWycK0TKhs39xaerTlSbp251JKdI3Idcg1xBWPhzeaId3VIBPtZaan40GVthAKjaWLTdlWHTUCH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716871930; c=relaxed/simple;
	bh=g7yMPL+lshsT2TyhdNE17+VKbTpRnVLb1qhQEeVrl8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAXuQOZ5jLcto+Q8HLSXuvPmgmbJfXJYXFxto+RJRQ3JpPg9ytSK4ogX26USrAPTSnPRVMCsk7fZK4ZShdj9X07aLOaDguJBcOpRPDfQj3KoS8qv2wtn/dxm+N29aG5WsCjnc4wMA9DCMgm0u0j85yLpMww7Rhm1I9gC3DI1dEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXxpEynC; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e95a7545bdso3117781fa.2;
        Mon, 27 May 2024 21:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716871926; x=1717476726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtlJErHFMtX/7aNJSWoJWAzYMBeqsDWDnwMet809dVw=;
        b=TXxpEynCcJxCxO0EpO9wA4aCnf6kpAl/qCV2yO++SR1lHP66Sc9218u5CdgSEQePcW
         gVuihn251EjESm4K3RwbpfDMziD4arH25C7DAcSCN6eLcZ404MKWtOBq3RgJx11D82be
         MDhTrwl2MpZoXSnjZppiMlRLiGW5ruxqiL3rwFf9wjd+QxAmSAF6Q46a2IE0A7M90jig
         Hqmg4VFSmbxJ3PSCCRVI861lA4zEBHlQviuUVF4iVnImdEeIrpNISONhSolbZgmdq5em
         fr6sQG0ajrx0y5DLpHUqyHQwwD7fUx266uuWT3cegetBiH3Gen3V4HRGNxUi0Nt5PwEB
         29zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716871926; x=1717476726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OtlJErHFMtX/7aNJSWoJWAzYMBeqsDWDnwMet809dVw=;
        b=IUF74YWkMRdhHGw7FpzvFBwN3gmLFL1ZVpVY2ozOvX0IF7fcMK/9wsqOA3CzVyevZ7
         BQ2F+PFG5eTrQJn6adef6Ks5drehS1ZeVwTJa/jLpsuDBDtUAWCgUcHRBon1cSsU3S3q
         Nhp9ka0mj9DmOnuOt5pzyyI9Q0eD45Z4UluZwlVQW0uyadtELZCz7s3ayk2C3kGZwr9V
         BS+AgImq1Y6vNE5Q1uM7IbdA7HDODGbQcWHeBdOnmxBqxC1Y2MS2UyWWKb6HCJuGTmE9
         HZcqFwushaSeXm9L5DpflIsT7t1TkwOj6GkX+xhKxtrLMSzqCfEbkqcSodlloTdSuy2k
         b0MQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfosq1meKcMf9l05k7tUPBQJvFRl055mlho5z93M9Nv01uxYoCUBuWkjnYVuuTgBIaJWPmyJn8+8FNRMx5inpm4o7jkVZwC1ONl6bRLTdGcQbssPaTBV4NvfhdWjF2g7YN0BAgamThBcWbQS2jEEBy0yr6MFqb0awa98qTiz2owqRgnqJ0k2Iq
X-Gm-Message-State: AOJu0YzdJYzRWvkpo/z6ESxCee6eZYQxhrZFdbmqGxBCEhU/T35hoB3r
	4cLN9x3+7N0zDZ8M6Hq/JelvspFb12fUl+1q8bw1r+UyHzY6uXeh+RIyFp4JOG1l/0rEYGQrAW6
	QrezQH+Daajeq6/CkYM4BMxX/5Ig=
X-Google-Smtp-Source: AGHT+IGkmdptDYW6j8rM+09xEDEuBMSvKo6CuZyQBAj/62lzzpgALrY5Khj8WVJm0wW7WJcoP8TrcByyuXfvEsxSCc4=
X-Received: by 2002:a2e:a78d:0:b0:2e9:87bb:1ce8 with SMTP id
 38308e7fff4ca-2e987bb1d9amr3617351fa.35.1716871926371; Mon, 27 May 2024
 21:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE4VaREzY+a2PvQJYJbfh8DwB4OP7kucZG-e28H22xyWob1w_A@mail.gmail.com>
 <5b79732b-087c-411f-a477-9b837566673e@leemhuis.info> <20240527183139.42b6123c@rorschach.local.home>
In-Reply-To: <20240527183139.42b6123c@rorschach.local.home>
From: =?UTF-8?B?SWxra2EgTmF1bGFww6TDpA==?= <digirigawa@gmail.com>
Date: Tue, 28 May 2024 07:51:30 +0300
Message-ID: <CAE4VaRHaijpV1CC9Jo_Lg4tNQb_+=LTHwygOp5Bm2z5ErVzeow@mail.gmail.com>
Subject: Re: Bug in Kernel 6.8.x, 6.9.x Causing Trace/Panic During Shutdown/Reboot
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

yeah, the cache_from_obj tracing bug (without panic) has been
displayed quite some time now - maybe even since 6.7.x or so. I could
try checking a few versions back for this and try bisecting it if I
can find when this started.

--Ilkka

On Tue, May 28, 2024 at 1:31=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Fri, 24 May 2024 12:50:08 +0200
> "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.inf=
o> wrote:
>
> > > - Affected Versions: Before kernel version 6.8.10, the bug caused a
> > > quick display of a kernel trace dump before the shutdown/reboot
> > > completed. Starting from version 6.8.10 and continuing into version
> > > 6.9.0 and 6.9.1, this issue has escalated to a kernel panic,
> > > preventing the shutdown or reboot from completing and leaving the
> > > machine stuck.
>
> You state "Before kernel version 6.8.10, the bug caused ...". Does that
> mean that a bug was happening before v6.8.10? But did not cause a panic?
>
> I just noticed your second screen shot from your report, and it has:
>
>  "cache_from_obj: Wrong slab cache, tracefs_inode_cache but object is fro=
m inode_cache"
>
> So somehow an tracefs_inode was allocated from the inode_cache and is
> now being freed by the tracefs_inode logic? Did this happen before
> 6.8.10? If so, this code could just be triggering an issue from an
> unrelated bug.
>
> Thanks,
>
> -- Steve

