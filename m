Return-Path: <stable+bounces-240257-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGy/BJYO6Gl/EgIAu9opvQ
	(envelope-from <stable+bounces-240257-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 01:56:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A82DA440C07
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 01:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1720C307B4F1
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 23:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B06C3A63E6;
	Tue, 21 Apr 2026 23:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EXHosAoc"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B843A5E8A
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 23:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776815667; cv=pass; b=CR3ulb4ZnBH46L9WsLs4aLsVGxgF42ONjC3f9RK9dO40dBlO4I9he0ewX5WO2xkHixuPMgI0WUaUpOqmBZYfYmJZgzkPDayB/X6TmtJ/CZMWBAqCRM70PhppBXpEZdiy+0tumSkb5TejLIUKIE8QccTOf+mYma4z87mjOrBwntI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776815667; c=relaxed/simple;
	bh=H1tHV2AxqvpQzt0bU5Pihn0mRHk/4Zw8qlVOIr0xMMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FM8YUwUlVeAj7nSMuRipgjGZbkaXYn/IfvF9U/9FJKJ786WrXN7kM4E6+ag4ACt93pOG04r+0XkNaHQZaqToLVd794tCAkllvpmpjMwtmZUYyUMo7jZXbC9QxUodszkj0SwPVQmr5o1cQMC+T+ToUfIVuh0x3LYz0cSHwD2e6bU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EXHosAoc; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50d6b9bca48so63245901cf.2
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 16:54:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776815665; cv=none;
        d=google.com; s=arc-20240605;
        b=iCfBnhzKHWjvMhzUYyEo/y2utWCX9ijFgOVpVkjdCGsEOsAn/ns3MahgsBMDYn8Fhc
         p9MxIlH2AIKYTZaXbxtaq2t+pTOsC/KfvxuL/uoOPWldDy8aumVDZvsD1z94Y44ZQwn5
         Xti3fvYTvcyOHvB22z8oR/eDWGyMjoSqrn4gFD3n0CMrZs31sE2u3ww/TvA3X9zofIqM
         JuQIzseAem6O/QEcHyuI8n3Hk/iNT8wsrlM9rHaSjg/u9czJlBjCl2IKP/TZE/U5saY/
         ZnPLsmjVRhLmFJ/uotPO/JvvACGYPdnCqTh9q47mdnvmz+TPwz5rGAinFIn0ODE20Kar
         6/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aKcIgoAajVypMfQvXdPWBcTg4avBTwmW4grlivILcXA=;
        fh=qbbM/svWRTvRVde11+dsZLp5Ld21CIG7qUE21AH4his=;
        b=JuTxDF1TpGrhi3uBNlnQUamZLONS2GxFqXaZwDRXpb5sfc1BsoRzuT83H8bNt8/WCv
         zlZYlKbw6704+OiAlf8TaReXJz7h0P+cprxUEtWFqLO3Va92HpijUXyROH3Hom3gMAKh
         BdmYtoTKatB/CL+ByStnEw1dA5bZZ4Cu8CsE9nEzrO47hcw+TvKYuyXTnny4FP91cXJV
         jxj21aE6Qnv19qHhOGdmbHwNfVt4l9FqvpEA7+jz4cy4Jc6PSo+h8LCpZzX6lbwnbCPc
         czqLml8XwjOGBT9PTyUEXDtYSh6+y1o4HuSVSi80SZSRM+aJeTFDWbYzAuqlyZItc8eJ
         oQqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776815665; x=1777420465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKcIgoAajVypMfQvXdPWBcTg4avBTwmW4grlivILcXA=;
        b=EXHosAocc2Bsm+S+TbvXYc058xM+ckplBxlZ+YHzKEeLEj+IhfHUQpqJUIzPTe/W0b
         Cfw/OxO2M0YSIEPllZcTtgNW54+ZjuGJ9RbMLhI7DJerBkGNrHwTbgflKP9Hjk7jliGK
         RDJ/KhMa8UOxq54jhr1JgeXDLdj8nU/QchOHL2fKZ/2Maou0cqfc23c9d4Y3UVTq2giZ
         UTlJOGafiGLSfmgOlBG0WpLERNA+cxdvfAGX4JLfHqsrhaDcb8xhC/1oTtu5s5kl7Tfb
         Cl7vx1xmKKtVXEz9b/0AhgFwplnQPW+nZ3VYxO+Wl0zebFV5WfJGig/JwbGphZDiJunH
         oX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776815665; x=1777420465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aKcIgoAajVypMfQvXdPWBcTg4avBTwmW4grlivILcXA=;
        b=sdTBaSEPEdnM4xqRV/TrrBoNd3V64qiq7A0Ch7NcC/eaR9RVjrhnX05XmAcCiEFQOI
         prsTTmCzs6pvy1bzBqG9WId/49Qvp8qSn3tTU2lIGsQg5WFZ63FPAX4FPEjMNo7nlYhb
         d5ezZnsoLq9tHY317RV3sXmFr/nuvPiF1ClqhtSrc+Fa1fAYr2NTZucn6LYvDzH8grIb
         z9az3N4tGXFpueTT0sjz6ByZ5rSWQkfc8+QLgWN3hBGmyDgfvBV2AJGvfPa5Bd3DJyGq
         F+U5UMV8V90xgu8xAzuki8MWEC2j8RxhMMLzJxkRWy84jX6/52TF3lk7nvG10NgZH5A9
         4SYA==
X-Forwarded-Encrypted: i=1; AFNElJ9GP9G1TuWcqm2IuL2yokqMn5SwHwPbDRLFW+B8Uu4g++Pr/TXcUxoXbJesxe0i5TZWY82VVWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrnd5rgdsqflLCcgseeeg3CxTBUaDkp3wiDmiVdLpQLSMHFilY
	fe1XOKOLUXZO0fxQ2TtBMr8h6MuRzgYebkZixl7eMfjckoQxKNg2sEgu22AFWvln25mIDWA8k9G
	7K+iglFbOvIbBikz3WPSSd14JxDPuVKtbi+uGDsNu
X-Gm-Gg: AeBDietmo7kmOWMQ5tx0bdSvMnu9yxZw414F0Xxlg9NVlf+PlpE6D0h83gcd/aT59Ee
	zOwKnl/XzbaltMSjawKTDcTuJfvEowbnXkQLyUTWuKgQL1HfmauLeW8yxPnARYEMezEsqhrcy2q
	kKd2eS3VVomCZ52JBoRzLa8fJjDEnBXsbrr7DWs7U4PMuNpUDrYr6eAwZjTiKaowUIOPPjRUrsI
	IGHW47O3DSDO/a30vIeCw9iLoMBqJ3/KU0+RuRqasA8tEyzoMwdbcAmhUpn9eGY5nHUBdy9kF7h
	wVkAX29fV5JUZ+Eu/xle08wdWmI=
X-Received: by 2002:a05:622a:4d93:b0:50d:a5e8:39e9 with SMTP id
 d75a77b69052e-50e36b495e9mr297879961cf.20.1776815664530; Tue, 21 Apr 2026
 16:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHWLEDHfXZScF5jNDzgOxGXf-MBDcVNtqW0DbNz8Ra8rtcuL+w@mail.gmail.com>
 <CAOdxtTbwipkyAfDakLAB6aVp6YkPWtKpDdVDUTz88WDB-18HXQ@mail.gmail.com>
 <CAOQ4uxhUn6oCBuVJqZu+FcMx8XeAQHZbXFAGon4Xeg2SPLJW_A@mail.gmail.com>
 <CAOdxtTaWWu_7eJWu68zf28zHQP3Y--vXTfbGFsceO47BpN3qxA@mail.gmail.com>
 <CAOQ4uxhCNhGinePrnkSfT9Mtf4o5FmBX7mTA2m4miCMOt3mJqA@mail.gmail.com> <CAOdxtTZGFxaayJpqsiFQrWBqXvDn7oyxSL3_9TWP919k0FhWTg@mail.gmail.com>
In-Reply-To: <CAOdxtTZGFxaayJpqsiFQrWBqXvDn7oyxSL3_9TWP919k0FhWTg@mail.gmail.com>
From: Samuel Karp <samuelkarp@google.com>
Date: Tue, 21 Apr 2026 16:54:06 -0700
X-Gm-Features: AQROBzAkSzvOaq9x23mj12eG21nTUWOF2akExiQWk4MV82XnI5dSal-M0xoxtz0
Message-ID: <CAE6nXrPes8T9Cn4ihTt43qmtgCCZvmMwYXo-yG_HJgNO7y+vVg@mail.gmail.com>
Subject: Re: [REGRESSION] Return change in 6.12.80+ with volatile mounting
To: Chenglong Tang <chenglongtang@google.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Derek Taylor <ddtaylor@google.com>, stable@vger.kernel.org, 
	regressions@lists.linux.dev, Kevin Berry <kpberry@google.com>, 
	overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-240257-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[samuelkarp@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A82DA440C07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We can fix the test case for the "volatile" option and expect either
"volatile" or "fsync=3Dvolatile". Existing use within containerd beyond
the test code involves us producing the "volatile" option and passing
it to the mount syscall (or _not_ passing it, depending on the
situation). This seems like it should still work if "fsync=3Dvolatile"
is an alias rather than a replacement.  However, containerd is not in
full control of the mount options; as part of snapshot (layer)
management external snapshotter implementations can provide mount
options to containerd which containerd then passes to the kernel.  The
protection in RemoveVolatileOption will break if a newer snapshotter
produces "fsync=3Dvolatile" and provides it to an unpatched version of
containerd.  I think the breakage scenario then becomes new kernel +
new snapshotter (producing the new option) + old containerd.

--=20
Samuel Karp

--=20
Samuel Karp


On Tue, Apr 21, 2026 at 10:20=E2=80=AFAM Chenglong Tang
<chenglongtang@google.com> wrote:
>
> CC: Samnuel from containerd
>
> On Mon, Apr 20, 2026 at 12:59=E2=80=AFAM Amir Goldstein <amir73il@gmail.c=
om> wrote:
> >
> > On Mon, Apr 20, 2026 at 8:31=E2=80=AFAM Chenglong Tang <chenglongtang@g=
oogle.com> wrote:
> > >
> > > Hi, Amir,
> > >
> > > Thanks for looking into this! To answer your questions:
> > >
> > > 1. Production vs. Test Suite Impact
> > >
> > > The immediate failure we encountered is in containerd's integration
> > > test suite (TestImageVolumeCheckVolatileOption). The test explicitly
> > > reads /proc/mounts and expects the exact string "volatile".
> > >
> > > In default production, containerd passes the legacy "volatile" string
> > > to the mount syscall, which your patch correctly handles under the
> > > hood. So the standard "happy path" is not broken in production.
> > >
> > > 2. The purpose of WithTempMount() / RemoveVolatileOption
> > >
> > > Containerd regularly makes temporary overlay mounts (e.g., for
> > > unpacking layers). Because overlayfs rejects reusing upper/work dirs
> > > from a volatile mount, containerd uses RemoveVolatileOption to strip
> > > the volatile flag before these temporary mounts.
> > >
> > > Currently, containerd's RemoveVolatileOption does an exact string
> > > match for "volatile". While it works for the default path, there is a
> > > production edge case: if a user explicitly configures their container
> > > runtime to use the new "fsync=3Dvolatile" option, older containerd
> > > binaries will fail to strip it, and the temporary mounts will be
> > > rejected by the kernel.
> >
> > I need to challenge this specific argument because I do not agree
> > that this edge case could be considered a regression at all.
> >
> > An admin from the past could not have set an explicit
> > "fsync=3Dvolatile" mount option.
> >
> > Though experiment - overlayfs adds a new mode fsync=3Doff
> > which is more loose than "volatile" because "volatile" can actually
> > return error on fsync in some cases.
> >
> > Overlayfs would also not allow to reuse workdir from such
> > a mount.
> >
> > So would you then claim that adding the new mount option
> > "fsync=3Doff" is a regression because of the edge case that an admin
> > decided to explicitly add "fsync=3Doff" and RemoveVolatileOption()
> > does not handle it.
> >
> > I don't buy it.
> >
> > There is a more correct way to handle this situation and it is
> > documented in overlayfs.rst:
> >
> > "When overlay is mounted with "volatile" option, the directory
> > "$workdir/work/incompat/volatile" is created.  During next mount, overl=
ay
> > checks for this directory and refuses to mount if present. This is a st=
rong
> > indicator that the user should discard upper and work directories and c=
reate
> > fresh ones. In very limited cases where the user knows that the system =
has
> > not crashed and contents of upperdir are intact, the "volatile" directo=
ry
> > can be removed."
> >
> > containerd unpacking layers falls under this very limited case.
> > containerd can syncfs() workdir after unpack & unmount of temp
> > overlayfs and remove the "incompat/volatile" directory and then
> > the upperdir/workdir are are free to be remounted.
> >
> > >
> > > Conclusion
> > >
> > > While containerd could theoretically patch their code to accept
> > > strings.Contains() or fsync=3Dvolatile going forward, there are many
> >
> > Following the documentation advise would be better.
> >
> > > existing containerd binaries in the wild. Given that this patch break=
s
> > > containerd's CI tests and introduces an edge case for
> > > RemoveVolatileOption, it might be safest to fix ovl_show_options in
> > > the kernel to continue outputting the legacy "volatile" string to
> > > strictly guarantee backwards compatibility with userspace.
> > >
> >
> > Considering my comments above, I think we have not yet reached
> > the point where the backward compat "volatile" string is called for,
> > but with other reports from production workloads, we could get there.
> >
> > Thanks for the clear and honest explanations of the containerd situatio=
n!
> > Amir.

