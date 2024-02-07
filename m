Return-Path: <stable+bounces-19089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A30384D139
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 19:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB51828AB6E
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 18:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3264438D;
	Wed,  7 Feb 2024 18:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eEZqg9bo"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC92E12B75
	for <stable@vger.kernel.org>; Wed,  7 Feb 2024 18:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707330796; cv=none; b=DZRqDIJGMZngIvZajBLN/uAxz3c4gwyxro4ZDvgzsQ9mSA9VmaNzajiMLcqt9QM+PjON9yhgUyHBQp5t6+b5qv3nI1nihbnK9XCHheNHJQv7QI+3uTpg9NonumjYDix6llZ53dfbgAabe6Y9wd+UyM4VrzlYKOzGQ7lAPh0SdaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707330796; c=relaxed/simple;
	bh=vcbjnt5RH4cAV2tJXYgIsVQe1Lf+xy5epqYic0XC5Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QdLS5GW/eCLwTgyWNYyd5XwcYEqaqQSMBEMrjjGMZM8tOJWkxmrpiktLyt0/wC1MVcIB5nG03Pjng+vQtAWhlJVjpQZ/Q7OIE99tiSleb7ajlw7KhGikXdlZZiD9iFVwoVukQCpONNFmrjAZ92OuBWgQcbm00QlY3Ky2UnR+qrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eEZqg9bo; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a370e63835cso124731166b.1
        for <stable@vger.kernel.org>; Wed, 07 Feb 2024 10:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707330793; x=1707935593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPN6YHmWuLd5MWUOmF+xJhqXptNUFEEGocEdREYkoUg=;
        b=eEZqg9boFAF1fBMIbYIqFLv+PK6/HVmjEHdQqmq6DQ00/wzgPrBWdaQcbIICub4rkZ
         PXb0EnU0uRcqfvMDO7GxCkUqSUUSA7CBN6xAU2kgIiJkmS/Ewr19lOeoKah8i9SRUspm
         EF/ZPnCc/ISTQO179vs2Ya/g5zzjXPsSMnqv0Agt02xlddwtu0wbG4pFnMSy+/wIPa/y
         fo9tHZm5JVm5buPxBiDsfScdURYFpVL3LaBxvZj7F4bBpdeprvAKHxhfLgjW8Se5tZYF
         1+uq9K/V2i1fj2Kq0q+MHcS/naHStsrVnhoRihp/+R1G5DYnLFIMMJfORjpoqya312Br
         Uauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707330793; x=1707935593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPN6YHmWuLd5MWUOmF+xJhqXptNUFEEGocEdREYkoUg=;
        b=kYoBywf5+MZGV97GenDf9d4LY0kOOigX4pqcVmlR0ivEnpszEXqDCb/4G54JMs2HZK
         B79mogna76Pln+a68qrDtUeb0VD2w5bgQA8SEDOhIFMbO+eR7MPOrx1+IWcqaAoXBiGs
         kkxV/3Y9kFcHqhAyatZ4hssiMj9FV7aVPYrpJJIfiMprIFXCst5pPuf+coIlUka0y2av
         q1RSSqIrqkIbtwhNDD7JSQxifvZySW8iYCicJHxQWJZXrtedJ/uwvHNJULV2usKRI+es
         HrUGtmcGiTxKZz03tu0Oi7H8XfZKAe0Pt+j9mlkhVL7CYloxRbRJLtcxYVcRBOR7uXu0
         NKTQ==
X-Gm-Message-State: AOJu0YxLl6zE9ieqSZ9hrkxLM9S7PkB7jpYD+vGtOyBfdv/jZD3z7eAI
	0FGr+bYBvYtCudWrbWZHxKV3LU6uNs+1aUVyQ1xrtLBt3cZGJ11Fi0hmhEiTPzu3SKAstXIW/SR
	VhtPlDJjgbQEpUCBshY00T+5i1z8Le1hDQaRa
X-Google-Smtp-Source: AGHT+IEmincd4Fm+vxfFykn5vYT7vHDEMm4sKWDOLRSn5dY2DxhjYcMa066xPr14AMS0mJHD4AbsNPK3mEUonbBdGTM=
X-Received: by 2002:a17:906:4bd2:b0:a37:9c44:c5cf with SMTP id
 x18-20020a1709064bd200b00a379c44c5cfmr4748046ejv.24.1707330792878; Wed, 07
 Feb 2024 10:33:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <38f51dbb-65aa-4ec2-bed2-e914aef27d25@vrvis.at> <ZcNdzZVPD76uSbps@eldamar.lan>
In-Reply-To: <ZcNdzZVPD76uSbps@eldamar.lan>
From: Jordan Rife <jrife@google.com>
Date: Wed, 7 Feb 2024 10:33:00 -0800
Message-ID: <CADKFtnRfqi-A_Ak_S-YC52jPn604+ekcmCmNoTA_yEpAcW4JJg@mail.gmail.com>
Subject: Re: [regression 6.1.67] dlm: cannot start dlm midcomms -97 after
 backport of e9cdebbe23f1 ("dlm: use kernel_connect() and kernel_bind()")
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Valentin Kleibel <valentin@vrvis.at>, David Teigland <teigland@redhat.com>, 
	Alexander Aring <aahringo@redhat.com>, 1063338@bugs.debian.org, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	gregkh@linuxfoundation.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 2:39=E2=80=AFAM Salvatore Bonaccorso <carnil@debian.=
org> wrote:
>
> Hi Valentin, hi all
>
> [This is about a regression reported in Debian for 6.1.67]
>
> On Tue, Feb 06, 2024 at 01:00:11PM +0100, Valentin Kleibel wrote:
> > Package: linux-image-amd64
> > Version: 6.1.76+1
> > Source: linux
> > Source-Version: 6.1.76+1
> > Severity: important
> > Control: notfound -1 6.6.15-2
> >
> > Dear Maintainers,
> >
> > We discovered a bug affecting dlm that prevents any tcp communications =
by
> > dlm when booted with debian kernel 6.1.76-1.
> >
> > Dlm startup works (corosync-cpgtool shows the dlm:controld group with a=
ll
> > expected nodes) but as soon as we try to add a lockspace dmesg shows:
> > ```
> > dlm: Using TCP for communications
> > dlm: cannot start dlm midcomms -97
> > ```
> >
> > It seems that commit "dlm: use kernel_connect() and kernel_bind()"
> > (e9cdebbe) was merged to 6.1.
> >
> > Checking the code it seems that the changed function dlm_tcp_listen_bin=
d()
> > fails with exit code 97 (EAFNOSUPPORT)
> > It is called from
> >
> > dlm/lockspace.c: threads_start() -> dlm_midcomms_start()
> > dlm/midcomms.c: dlm_midcomms_start() -> dlm_lowcomms_start()
> > dlm/lowcomms.c: dlm_lowcomms_start() -> dlm_listen_for_all() ->
> > dlm_proto_ops->listen_bind() =3D dlm_tcp_listen_bind()
> >
> > The error code is returned all the way to threads_start() where the err=
or
> > message is emmitted.
> >
> > Booting with the unsigned kernel from testing (6.6.15-2), which also
> > contains this commit, works without issues.
> >
> > I'm not sure what additional changes are required to get this working o=
r if
> > rolling back this change is an option.
> >
> > We'd be happy to test patches that might fix this issue.
>
> Thanks for your report. So we have a 6.1.76 specific regression for
> the backport of e9cdebbe23f1 ("dlm: use kernel_connect() and
> kernel_bind()") .
>
> Let's loop in the upstream regression list for tracking and people
> involved for the subsystem to see if the issue can be identified. As
> it is working for 6.6.15 which includes the commit backport as well it
> might be very well that a prerequisite is missing.
>
> # annotate regression with 6.1.y specific commit
> #regzbot ^introduced e11dea8f503341507018b60906c4a9e7332f3663
> #regzbot link: https://bugs.debian.org/1063338
>
> Any ideas?
>
> Regards,
> Salvatore


Just a quick look comparing dlm_tcp_listen_bind between the latest 6.1
and 6.6 stable branches,
it looks like there is a mismatch here with the dlm_local_addr[0] parameter=
.

6.1
----

static int dlm_tcp_listen_bind(struct socket *sock)
{
int addr_len;

/* Bind to our port */
make_sockaddr(dlm_local_addr[0], dlm_config.ci_tcp_port, &addr_len);
return kernel_bind(sock, (struct sockaddr *)&dlm_local_addr[0],
   addr_len);
}

6.6
----
static int dlm_tcp_listen_bind(struct socket *sock)
{
int addr_len;

/* Bind to our port */
make_sockaddr(&dlm_local_addr[0], dlm_config.ci_tcp_port, &addr_len);
return kernel_bind(sock, (struct sockaddr *)&dlm_local_addr[0],
   addr_len);
}

6.6 contains commit c51c9cd8 (fs: dlm: don't put dlm_local_addrs on heap) w=
hich
changed

static struct sockaddr_storage *dlm_local_addr[DLM_MAX_ADDR_COUNT];

to

static struct sockaddr_storage dlm_local_addr[DLM_MAX_ADDR_COUNT];

It looks like kernel_bind() in 6.1 needs to be modified to match.


-Jordan

