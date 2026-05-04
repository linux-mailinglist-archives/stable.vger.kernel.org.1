Return-Path: <stable+bounces-242995-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HzfLIh/+GmXwAIAu9opvQ
	(envelope-from <stable+bounces-242995-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 13:14:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB61F4BC436
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 13:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14C363019B9C
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 11:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF6939B97F;
	Mon,  4 May 2026 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nigauri-org.20251104.gappssmtp.com header.i=@nigauri-org.20251104.gappssmtp.com header.b="unrxAR9z"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CABC3A7851
	for <stable@vger.kernel.org>; Mon,  4 May 2026 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777893253; cv=pass; b=qMGTHthe2DYI5XdBHtHmtbxCjlKCLlkkxeR3TlPjq7dV8JMEZwUGzS3PtEXZjIkx2IFt3fCsQuHk9VTN05XH0XsL+sWxyZ53FDbvZh8bgEuHzynHN1eRmMrhSK52qg+2EiuIct2z4OZYBY420xftCsyhrT6KLXat3UveRzXkLQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777893253; c=relaxed/simple;
	bh=YleWRHns2NrWUz6rlpeh53kFy4Y3GDVyiq1lWVkejp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hq2zFoBM5Lk13DVTb7RWJD9YuwoE6xZZufoLcsOS1Lq6SAlD1BxIADvQYUTr0uIr8Lj3q8Jyif06Pgs0CKpLPSMSiS6ddrsAYwwy1hA7ogFsBO6dpkr8cl8lCADbX4vBPF6ASyn/zbxke2yA5Il7icItCO77fSDoBXkwsu0cywM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=nigauri-org.20251104.gappssmtp.com header.i=@nigauri-org.20251104.gappssmtp.com header.b=unrxAR9z; arc=pass smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8ea8563c693so448972585a.2
        for <stable@vger.kernel.org>; Mon, 04 May 2026 04:14:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777893250; cv=none;
        d=google.com; s=arc-20240605;
        b=NrFmZGVu2yxz49eWFHHQGsNldRO1y4qnoQmBA7zWo+EMQalUj8cTDEF8eyPmtv3B35
         f75fm5dtgG6ltscDlRp71D0CzQ0OKGH93mPGCAN6oaXxS0hrGZK/g0pLQrpQbCpT5euF
         Rv21sjHp+IdTD+qcHR1F+sNwYiPTMmWpcGfKUtHFRJ0lfnk9DG2iNtHYq0W2ZvimKjQU
         w11vzANnXhDdWOlHFgKiBdvCan/3OiBs+KRZnet52Lb12susHF2kqaeyfB5JkD2hihs7
         UlNy2QUshryaWtWISctQY3HpcO4+vyaOqL3owxQhdq7Tu3TKWHPSBKYQeBPG/jLjVHtV
         dJrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ch/J5k7eHtNCuStFnhOwYjBEOIVihKBTekMZCotq1H0=;
        fh=O+QKTU6OSCaMcBzqhBQGanhdvYVUga15GP1ZOT0lj8w=;
        b=I5u85EHvrfWeqe0I4Y1HvHalMUH06PtKJRcG9NSPdBQs9lIhZJut1sNhdm05Ih+xln
         zO5l8gzGSTLCK2nGrTyETfnBsGm8BmYgeVcArgCN2jgv/X+y4DRb4jkqqW+J/kEX2GlC
         S60SEJ9GaxZ0tVDstaSVmjPKhy1/6fI4w+0tN3ukVti4+8q2GCBRQdqjmVsvoe48VU+p
         jl0HPBmymPw32K+K4LgT2s48mn6WARRgWkBa+ftsNGKVbU81vniWB0m5XqQRSVLa0rNi
         P9arhdHZ3W+3C4uDmMxI9bWjxZ9ij8zdFhiMkXXDr4gh4bE+luSArYJr8dGIX+fXwzT2
         8w3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20251104.gappssmtp.com; s=20251104; t=1777893250; x=1778498050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ch/J5k7eHtNCuStFnhOwYjBEOIVihKBTekMZCotq1H0=;
        b=unrxAR9zxEsJKqzpmJ8ad1gVjaOQnK+Fi8on8cZfUrAsR590rLAxwhHBBxjiUOWPiz
         I6VLZLMa/6jbAOGqbFBx/GGdJBgCQrwQHEzdzWrIOSU1EpCbaz55fR2+NspHxSSfz3LS
         HQQcnqwSzhsD9SGJ1R4+SAJW8VMx4Zl4uPgfuHcKqq8vypEb3QSzbJ5yqXuObBcgLktm
         YcCpOME1yHlzhmt8tPh9hxOL4ohhAZqoRAT85nkBjX2zM7GFWYuYZ4Vx+ArJVl6RwinA
         afzvnLCwV/r0ONG23hPMJ6xwwF0cyHxwrcQ3yIc7n0mv76GDkjIrw672EunjvjuRcUR/
         IKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777893250; x=1778498050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ch/J5k7eHtNCuStFnhOwYjBEOIVihKBTekMZCotq1H0=;
        b=iPxKn4syt3zodqy/xFTx+lDMzqPlyAic/A40Yga8ISYSClnaJl7mUaRPV2GMypeyYk
         +vKAad4Z1iHWpRRrOKQbXgoLUX9Z+BYElXvuo1vSUHhN8M/cBJzZ0SWfA7yyVSW2xbX1
         lIEkDwKJbD9ilok5X7yA9Oo0vAzo9znxO6sHwm7VmcsR5J9WaguUEnyvrewTlAZNbVt6
         vKfCXE9sTvqoKe+6rkhSobngCtMjdz8aP23XZvXJlR0ClK7r0lBTxng/jrSvBrqGL1bG
         q1xcAbdga+etS6rhRYKwybYQVtR1tBTrFTSihON4KldIHp5PbLi9UWh0Z9TXW4gny2ct
         d6dw==
X-Gm-Message-State: AOJu0Yw2Iy/eKIQx51nPnx490pB7D2Mw8MYg0w8ZB1WYZc9ffQ8svrK4
	cNdeN7ngBvYh0Wfikqt3MQspbDwnO55i0mRCnupS/bNjDbtOpQLvTQeawe8aO6C2Uh/V09V2z53
	Sd2/aEyktAbZYlNfoE/pHE/vWgLgp1YM=
X-Gm-Gg: AeBDiet8GEm5b52h2sib86clgiDmzXtQM/J8kk9XnQBUpkP8BVnA+opM4y4IXz42tYq
	5VDdzQP431QIvch73gg89X5jNSipKWtGnevMjZ4aohbQln3xdFdwY6fkLBaEpX4z2LcbfFgWo8g
	UJXWH4NTP990pi1g//f+KnruBAgfAMM6I0S+jPWTyeue9xJW2mQ5vGrXSDkjojQm4Cct4eSCeYl
	okyfTIfn2xJvmANvlljRDD7tqGiylG9r2qx8pJNddzDpZpZN5vlhhWXpFW2MpTHiLtfUexhDgwJ
	vZnjW5ZbKwVxR9I=
X-Received: by 2002:a05:6214:3d85:b0:89c:d424:aceb with SMTP id
 6a1803df08f44-8b66882df04mr149742986d6.31.1777893250288; Mon, 04 May 2026
 04:14:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501225859.504868-1-nobuhiro.iwamatsu.x90@mail.toshiba> <afhkX2Ys2BG1gnqy@duo.ucw.cz>
In-Reply-To: <afhkX2Ys2BG1gnqy@duo.ucw.cz>
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Mon, 4 May 2026 20:13:58 +0900
X-Gm-Features: AVHnY4LqxiCDUo8FVMP_7ti3ORbzUPkHt5mSScKq2VJijp6pPFIiVuxRCG4svIE
Message-ID: <CACe6DC5BJzWxi8xXP2akE4ffTfLiHXrj=W=4OxFnPA-8UOdhaQ@mail.gmail.com>
Subject: Re: [cip-dev] [PATCH for 5.10.y] phy: renesas: rcar-gen3-usb2: Fix
 the use of msleep during spinlock
To: pavel@nabladev.com
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, 
	cip-dev@lists.cip-project.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: AB61F4BC436
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[nigauri-org.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[nigauri.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-242995-lists,stable=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[iwamatsu@nigauri.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nigauri-org.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

Hi Pavel,

2026=E5=B9=B45=E6=9C=884=E6=97=A5(=E6=9C=88) 18:18 Pavel Machek via lists.c=
ip-project.org
<pavel=3Dnabladev.com@lists.cip-project.org>:
>
> Hi!
>
> > From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> >
> > This fixes an issue caused by the use of msleep during spinlock.
> > In the original commit, msleep was changed to mdelay, but this fix was =
not
> > carried over during the backport to 5.10.y tree.
>
> Doing this as a quick fix is probably okay, but this should not be
> final version.
>
> You are right that msleep inside spinlock will blow up immediately:
>
> > ```
> > [   62.677594] BUG: scheduling while atomic: kworker/1:2/126/0x00000002
> > [   62.683957] Modules linked in:
>
> But mdelay for 20 msec inside irqsave spinlock is borderline
> unacceptable, too.

Thanks for pointing that out.
You=E2=80=99re absolutely right.
I had completely forgotten about that....

>
> I believe we'll need Renesas to analyze/fix this properly after the
> CVE emergency is done.
>
> This fix is good for now, but better fix is needed.
>
> Claudiu, are you right person for this, or should we cc someone else?
>
> Best regards,
>                                                                 Pavel

Best regards,
  Nouhiro
--=20
Nobuhiro Iwamatsu

