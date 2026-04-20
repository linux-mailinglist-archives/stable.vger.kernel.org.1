Return-Path: <stable+bounces-238703-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMXMDjvI5WlIoAEAu9opvQ
	(envelope-from <stable+bounces-238703-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 08:31:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D713C42739A
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 08:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 594393007E30
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 06:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9D115746F;
	Mon, 20 Apr 2026 06:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LVKASRqA"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68754188713
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 06:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776666676; cv=pass; b=GIo2zi8caWxLl6kw56jplpn/YswZiCgTzjh2PF6i26qiBPdqfsGI48vWABmXpQ1DtNilZdNoJLQ6EXudxd9eDCbXKM/CK8ptrAwqrumGt/fV5l0P2EFnziUT82iN9U9Bogfz/xl2X6DFwgY8s8SC2drXNsx0S/z2oN4au4Xo/Ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776666676; c=relaxed/simple;
	bh=oWdHSX0eVcAgY4PHQuy8lYwoogzXG2T9LHnjRsCPmEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6C7v55b1jJ1AivScak1Ue+AX8ENxuQwn3/lqKM9upvPtefL5tPRLIrRzF5t+K19JUjABkLk99cMow0wIC255UPdNLninHOckGAjaNf/DLEUvenOMtwFWTbDairly9IWNn6oqDed4/2AV6G/Tbuj/gOrjh2RCS876Uuyzu8kwrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LVKASRqA; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50e61648f10so225941cf.1
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 23:31:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776666674; cv=none;
        d=google.com; s=arc-20240605;
        b=WDRN14qNHWw8/ay78nKK7w2u62gFWhc5VHN6He3G7YAtbA0Y9spG/u0nnCDV+ElBE+
         fCUB2Zsyhc5f5vGVK4rmjLXxWED85pSz9TIRLV6cI1ljZBH5TGTn8lMxMttB/6oUFtaI
         pIoKIW4DU7/9sNXFvz9h+utp9hZR6hHpvGlXNOrZshvkbFqeHKZ7VFaNrDLbdtOzN+qG
         Y4emxy+CLpaEwuQviK4dB0poXP/gPYsytK5ok2BW3tcsOogk7oXAFRAYRZaWllHQy1IR
         J8F/N6JX7NzGobKVCMrzaKNxL1xBlHiWHJK/wosd2JpV2Jg2ua/LfU12xqescRuvFeqe
         CPcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oWdHSX0eVcAgY4PHQuy8lYwoogzXG2T9LHnjRsCPmEQ=;
        fh=sWg3O/Qe4wPZrYEodVpllTRhcMomb6gpM3cpVpfGGHc=;
        b=RJ3NY3mHJZK1mKP6eq2lazeE8OgHNUddTXoRuENUEAxBvD5yH/vQARMB93+JjG0cRG
         ZQKpTRMz0DjY1SwIWeYb6DKxnxl98yY0jrkFyJSX0X5VY1Gi7cgCNWBn/GVT4qVJ8Q6y
         QAPhmeCveoq1Cah1b7PjHr50mSBpMNdU7I6HdgTlbDA8vE+FRIz5I0dj4Z6NnqXvr2YO
         lK9s004geVgjzJJVrDzoiFjL5bBkV4QaukJ1Z688b/8ETHvaZK8lL84+eSD1Ig8wKm8I
         14OGLMWEKW2ZrSAluW0rSLQr16FKJpUYi0Mpx1qhq1jWtUEHdwYq6snL+6KYQdxJ9ocI
         WD0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776666674; x=1777271474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWdHSX0eVcAgY4PHQuy8lYwoogzXG2T9LHnjRsCPmEQ=;
        b=LVKASRqAjkmZ993zw7TsQBz66QcHWIrlR+4jLYhyTEapGTgh5o4CUxBvb3Wduss/Mm
         BHWKMV7iWQ9X2Jm86GCMbHwhUSdQy4JrJJkO4jn2GXQHSCHGZ49uk1zbQ0neu9WNS991
         fXsPGT1kWf1PsA4FEdxNe6bMPNiFsCzl3ommh097g8YqDNul+Py7gDsCwq7ZVjBt8rGT
         HhLGRh7afaN95qJW5eANMEBD2nrJnIpnKD8+TWFJO7xk0o2kOfY6eszC8hNN9BAGzRqu
         +TPClF+5+FM3I35S6TMH8SbIz9k342NyQ49/5TVifSaHfe3PghqSxLkpinAzUrFCVu2w
         tJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776666674; x=1777271474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oWdHSX0eVcAgY4PHQuy8lYwoogzXG2T9LHnjRsCPmEQ=;
        b=f9DkAIo8IF2IG8g0Wk4TPSiupaT/LGX2DmtnWVgsXqHDwkgigRkxyhp0wJ+PWsohOR
         bTC/dRlcbwMQWoLpLWXYNTKTpqJMO3CoKT+Hzd8yEAvkQm/c7h6IzjCfZGinjHxa0GI/
         R0BNYKx30BOLxtXSpSneabIyK98YMFi2XLRXXQYQGECxpr9llERi1Gg0VtvAl+LD33Nx
         plLpVwo/9v0+XtzsOHY0zUD/8nSTyS7TG+iz9KNbhLBi3+TMcClTu0FyGAzri8oj7Seq
         vnBMZGqCUEuL3eH1Z2pDYxx96wnjp3kfmJu5cemn3SgbChosYto/O/N7sCC0+ok/vWLj
         AQ3g==
X-Forwarded-Encrypted: i=1; AFNElJ/ciDNoZv+rrhoBuWap0K5U+6/naygfz/QPJYq8P8NsgHwOZD2YVm9C5fWCt/ed9J975z5x3fo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiJ/jTWaq//hfSF9czcNgGofKCslzm6eVb7Qw865dvw0XMMe/a
	wQ7GFn3vxohTRUy0DW6rLWCzX7w4MfUKp8S8/VYsrfleAW6vxWNk/VkJd5tASNPdk34DLEuUamw
	bYdT8cQq6WduBO/dhAVcb4nEogo8sQz34IdY4grzh
X-Gm-Gg: AeBDieurAvNliNNYOrQ7qFdY17bEunOYl/lvaSag8Fv4meUBx+1KNVYiDCxtBtYtmRe
	IL4CHveojylecK/iHNyvEQV7SQT4aCuzFYMQsSBk3x4CYXAaCH4M0tkgyCirkakTtqADUrkYQKe
	U2oLSafk+pwpRADtP9jwgGYU6r01YqhzQXUFJ+ELRMZyddN15cmnCJi/Ey+fAWeJikPftPrReQs
	K9Ay13WzrGTbrCwYhqtOVAFg4qF9OnkxACyEyGtlwxjey+9EpcU7vf4m2L61UfhmlNP6IvCRidY
	vGLNw7XpzuAAhFSu4iVaoxrxKOmW
X-Received: by 2002:a05:622a:4a0b:b0:50e:38f0:ccb2 with SMTP id
 d75a77b69052e-50e441d1391mr22856791cf.15.1776666673848; Sun, 19 Apr 2026
 23:31:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHWLEDHfXZScF5jNDzgOxGXf-MBDcVNtqW0DbNz8Ra8rtcuL+w@mail.gmail.com>
 <CAOdxtTbwipkyAfDakLAB6aVp6YkPWtKpDdVDUTz88WDB-18HXQ@mail.gmail.com> <CAOQ4uxhUn6oCBuVJqZu+FcMx8XeAQHZbXFAGon4Xeg2SPLJW_A@mail.gmail.com>
In-Reply-To: <CAOQ4uxhUn6oCBuVJqZu+FcMx8XeAQHZbXFAGon4Xeg2SPLJW_A@mail.gmail.com>
From: Chenglong Tang <chenglongtang@google.com>
Date: Sun, 19 Apr 2026 23:31:02 -0700
X-Gm-Features: AQROBzDX4AAYXOOslqCZs98JMxceUov0-GNl39rBWIuX_y_Te2pwHmhQJ7fdw3g
Message-ID: <CAOdxtTaWWu_7eJWu68zf28zHQP3Y--vXTfbGFsceO47BpN3qxA@mail.gmail.com>
Subject: Re: [REGRESSION] Return change in 6.12.80+ with volatile mounting
To: Amir Goldstein <amir73il@gmail.com>
Cc: Derek Taylor <ddtaylor@google.com>, stable@vger.kernel.org, 
	regressions@lists.linux.dev, Kevin Berry <kpberry@google.com>, 
	overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-238703-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenglongtang@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: D713C42739A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi, Amir,

Thanks for looking into this! To answer your questions:

1. Production vs. Test Suite Impact

The immediate failure we encountered is in containerd's integration
test suite (TestImageVolumeCheckVolatileOption). The test explicitly
reads /proc/mounts and expects the exact string "volatile".

In default production, containerd passes the legacy "volatile" string
to the mount syscall, which your patch correctly handles under the
hood. So the standard "happy path" is not broken in production.

2. The purpose of WithTempMount() / RemoveVolatileOption

Containerd regularly makes temporary overlay mounts (e.g., for
unpacking layers). Because overlayfs rejects reusing upper/work dirs
from a volatile mount, containerd uses RemoveVolatileOption to strip
the volatile flag before these temporary mounts.

Currently, containerd's RemoveVolatileOption does an exact string
match for "volatile". While it works for the default path, there is a
production edge case: if a user explicitly configures their container
runtime to use the new "fsync=3Dvolatile" option, older containerd
binaries will fail to strip it, and the temporary mounts will be
rejected by the kernel.

Conclusion

While containerd could theoretically patch their code to accept
strings.Contains() or fsync=3Dvolatile going forward, there are many
existing containerd binaries in the wild. Given that this patch breaks
containerd's CI tests and introduces an edge case for
RemoveVolatileOption, it might be safest to fix ovl_show_options in
the kernel to continue outputting the legacy "volatile" string to
strictly guarantee backwards compatibility with userspace.

Thanks,
Chenglong

On Sat, Apr 18, 2026 at 8:40=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Sat, Apr 18, 2026 at 1:33=E2=80=AFAM Chenglong Tang <chenglongtang@goo=
gle.com> wrote:
> >
> > CC Amir,
> >
> > For example, containerd 2.2.0 uses `volatile` instead of `fsync=3Dvolat=
ile`:
> > https://github.com/containerd/containerd/blob/main/core/mount/temp.go#L=
91C1-L92C1
> >
> > On Fri, Apr 17, 2026 at 3:41=E2=80=AFPM Derek Taylor <ddtaylor@google.c=
om> wrote:
> > >
> > > This change seems to have so far affected at least containerd in an
> > > issue reported here
> > > https://github.com/containerd/containerd/issues/13250.
> > >
> > > In stable versions 6.12.80+, commit
> > > 6c0cfbe020c0fcd2a544fcd2931fbc366ee3cd12 with the specific change
> > > being:
> > > [*] The mount option "volatile" is an alias to "fsync=3Dvolatile".
> > > In this scenario, code relying on checking "volatile" will now fail
> > > due to the return being "fsync=3Dvolatile".
> > >
> > > #regzbot introduced:v6.12.80
>
> Hi Chenglong,
>
> Thanks for the report.
>
> Is this problem in production containerd or in a test suite?
> I did not understand the purpose of WithTempMount().
>
> Is it possible to fix this function to use string.Contains() instead of
> exact match to the "volatile" mount option?
>
> If needed I can fix the kernel to show the legacy "volatile" option,
> but I would like to first understand how bad the impact of this regressio=
n
> is on real production workloads.
>
> Thanks,
> Amir.

