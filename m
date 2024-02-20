Return-Path: <stable+bounces-20891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE2E85C623
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B2628402E
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 20:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935E11509BC;
	Tue, 20 Feb 2024 20:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jF5gU6Yx"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA1A151CC3
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 20:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708462496; cv=none; b=Ww7p3GZGtKId1f++ERngXbA9XiJCPKN0xoa58mOfxAQw374JCevtbOQb7Bx5gvtUryLtqdpHmaCN5GgQyPaFnCzxUVqtlIRYkFOkjShPegBWcxFSolDlV3n9+mW0PODHs3NpANvHO7IIXNfdNDmMtdhCrAvnwStHlni1rmhDreo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708462496; c=relaxed/simple;
	bh=uMcOcXoHQpGLnK+m9k5Ve/SLPMwthj9MgZ6aLTX81Hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bdpqRymsguTGRLA2UtBftIfwxZVlPGprgWkypfNqfanbOp0cQ+eq23+aqEtKl7HhhHjrChNZUPmvYK9Rhu0nQ6DMRGBDyUARN2kx9RbrYmQIQDoHSM2BqxGftwEoJROExuG3rLlyZdit7MO3S7SXTAIA04ZWvrqDXbXibVvPyUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jF5gU6Yx; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6087396e405so5821867b3.0
        for <stable@vger.kernel.org>; Tue, 20 Feb 2024 12:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708462493; x=1709067293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUztiz7MykDHEIHn7Kx8dlUkzr7CbaSOU150R3F7dC4=;
        b=jF5gU6YxQrIodU3jhtVZnp5uS7VuX4xkNATFYWrkHAf2rCAZ8SfsTDSTFw4oKmTZev
         1St1dyHWqn1s7LniPe1lz2VNDXqES9c/7oYsaRMfrXmsT2jDRdbqkSDVQ78MDk9VqnrQ
         ZNKyw/jAddYthHncA3EWYXXkULBInV2cJg5cEADwE8m1+Qn10D6xB1A6s3knY1jTvR/z
         XVN8B1+0y3wzFYM1pyg8BOomQPWiVA2CGKCZ78Z9WaVIAllKWEXSRvw5fihIEsVzHaJb
         REDgDNWjPG+zcE/J7YyhWF6PMEHXjngKF5PCkUhEuoQ31r5O4KKQqrPv5G+w2hMoecqL
         tmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708462493; x=1709067293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUztiz7MykDHEIHn7Kx8dlUkzr7CbaSOU150R3F7dC4=;
        b=xM5LIlZZbHM9NYCPAu6MR29CbeSP/ra3rJWX7P8YTcdRISMWf3Jlk9i1d9FC9sxaYF
         3RaHrm4SRI0dmV8cwDkN7p2GTeJEtaHPTZ6wUaPw2LViRE+cI7CUhWVLlDOnzjTcCJqn
         xhpW66WFqFA02RCpv33+KV628mnn5VRLKPduLEemvW4tW/oFMk1Vxabr48RQZUWL6qsD
         HTDgmDCrO1SmTghFOXrBBNNAeIWcV+7HNkpsLKoTgXmhKAATipgm/a0g+9Qc/Ib9WiQU
         FOIqBc/tt8AV6cxWMcpbkMPEbVsLKwE8vOk16G2/I5vdCO74XWbjTkx6rBQWE8i8VnpZ
         +Nkg==
X-Gm-Message-State: AOJu0YwxeI9L6MPiegs/ShyoZgeG6HwBeKh5dLfVeMvDo2mp/3hcNSes
	bNIume4eALjVEZPC9WfOryfqowBVU6qcHKqnJEr4hNRu84HUzQs4FcTCJQ/pEZ5hA2OVgryMRDd
	lIOV0M4nlRsx1+uMjcR2rui/IaiVl9spRz9KV
X-Google-Smtp-Source: AGHT+IFzcBxZxQXlKXBpv8OFi3EIqnP8EaA1jCpBn6YiapzW0uiW3G49aGDKkRcP6KkZLP38yZ+hGRxu7DUDtN9I+yA=
X-Received: by 2002:a81:ad03:0:b0:604:99b2:f371 with SMTP id
 l3-20020a81ad03000000b0060499b2f371mr10075403ywh.1.1708462493328; Tue, 20 Feb
 2024 12:54:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024021921-bleak-sputter-5ecf@gregkh> <20240220190351.39815-1-surenb@google.com>
 <2024022058-huskiness-previous-c334@gregkh> <CAJuCfpEzRNG-aZWskphrUFCC6wr8nbsbpCxwG9tyfxA=CyWCoQ@mail.gmail.com>
 <2024022018-bulb-reabsorb-359b@gregkh>
In-Reply-To: <2024022018-bulb-reabsorb-359b@gregkh>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 20 Feb 2024 12:54:42 -0800
Message-ID: <CAJuCfpHeaEWBnBagUCXGmOKLJaYVFHStm=KhweT8JJkZfbaUEA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: 9328/1: mm: try VMA lock-based page fault
 handling first
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Wang Kefeng <wangkefeng.wang@huawei.com>, 
	Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 12:46=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Tue, Feb 20, 2024 at 12:23:01PM -0800, Suren Baghdasaryan wrote:
> > On Tue, Feb 20, 2024 at 12:20=E2=80=AFPM Greg KH <gregkh@linuxfoundatio=
n.org> wrote:
> > >
> > > On Tue, Feb 20, 2024 at 11:03:50AM -0800, Suren Baghdasaryan wrote:
> > > > From: Wang Kefeng <wangkefeng.wang@huawei.com>
> > > >
> > > > Attempt VMA lock-based page fault handling first, and fall back to =
the
> > > > existing mmap_lock-based handling if that fails, the ebizzy benchma=
rk
> > > > shows 25% improvement on qemu with 2 cpus.
> > > >
> > > > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > ---
> > > >  arch/arm/Kconfig    |  1 +
> > > >  arch/arm/mm/fault.c | 30 ++++++++++++++++++++++++++++++
> > > >  2 files changed, 31 insertions(+)
> > >
> > > No git id?
> > >
> > > What kernel branch(s) does this go to?
> > >
> > > confused,
> >
> > Sorry, I used the command from your earlier email about the merge confl=
ict:
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to
> > '2024021921-bleak-sputter-5ecf@gregkh' --subject-prefix 'PATCH 6.7.y'
> > HEAD^..
> > but it didn't send both patches, so I formatted the patches I wanted
> > to send and sent it with the same command replacing "HEAD^.." with
> > "*.patch". What should I have done instead?
>
> You forgot the "git cherry-pick -x " portion of the instructions :(

Ah, I see. Will do next time.

>
>
> And the subject prefix didn't work here, right?

Yes, looks like it. It worked the first time though :/

>
> thanks,
>
> greg k-h

