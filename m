Return-Path: <stable+bounces-247259-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGkeLuIIBmpOeQIAu9opvQ
	(envelope-from <stable+bounces-247259-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 19:39:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5C554569A
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 19:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6917B30948A6
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 17:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695D13932DB;
	Thu, 14 May 2026 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BPM+8YNi"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8091433438F
	for <stable@vger.kernel.org>; Thu, 14 May 2026 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778780252; cv=pass; b=b+FOGv8bhivmFq3sPNSJyxJDKyJDNWoCqfrkZlibdUS9+tZa/dzo0s+VEvPIlUR2+8UrRQ77OhvWIsO5/f3xqmrl35g9i9O7Nhfn9o1NvfsL7NGnfsk6e5xQMnsEH7AxagwIKyFhglM4MPmS0itxHDUCBU4WdYc6ITh76epeq/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778780252; c=relaxed/simple;
	bh=Vse/+ZdVAP3JLjTJrQOypdpCOuZ74Ygw+49Q04bTh7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tByV+Ourz2riuAmhQcEklS5yVT65XlpkTxNi+eHDzquNC00/7RL1sUGYActSx0EwwyJFtbY+/wbfy+Pu8CVNm6V/LOEZITOfwp7ns6Q7Ea5s5CDtohdcSdIpZ5AMP1YqL5qlezSUyaeEuMy6S4GjjNk8Dx+9AqRupBKbUn41aZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BPM+8YNi; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50d864c23bdso5541cf.1
        for <stable@vger.kernel.org>; Thu, 14 May 2026 10:37:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778780248; cv=none;
        d=google.com; s=arc-20240605;
        b=a2nndHFXgz8c3cs27L9tqDhsue32YpT9xfn2yETvwpRxsx+Z8ND/SZk5Ht4GR+l0V/
         S11DUbnHMc7AEUheVOWJmqDx9K5gIKS8ZfjPe4rsXk9CMQFrNSgJN7heKV+Uqc1vde8E
         wQtwCK81EaoOG4lLm9L9jd6oGknFBFAl26lPkAGItK6ur2WXQTPxolx5BNh63Svy42V0
         xwy1oY22PDWNe7rwae9VYRpgVchdbNSETUb/zxuWQcZ7Ic72MW7p+nkgNBdr2gixi8C5
         8h0RNca/qHY9yDXykMjvbiYWPPeyaUUJa3uXLcztWqd3RoB+34t2uyRnFC+VdO1vVSxg
         DGjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FmreA23cwcFZxYn98K9SrDczn/2oXXYgf5RnrI0M3NI=;
        fh=x45/lGEXLXmxpEqfyi2deIOK/QKSVk6hB36hoALm4ho=;
        b=ijklVb2yTa3+v4ZPyTvFs1FrE9wtsHfkK8femRtwnmO8f3lnfvvSo/w/L7/yaaLouE
         UmKDa073GN3iXfCDxwNH/sRU4c3taVfy/14IwlkseZss5UQlME837NFuhcSdPN2H/JOp
         yBbr99Aa3ioqxp8HsHy9177M0S2uaz/7zCGq3gwWAPsfrUCZXlQmk7EuKwhQyzai2AJR
         E6S9ksAfRDjuTOti8Y8oMULRp0ja2xqfSroFITfwpH6rJ1/U3P4H/SAjVtDJwsAOkhUa
         RewfWSNatFzXyBE+RzUKDvcJ1ignUFuABE6fWa3yzdCvDtUbGCgHoqUT4i2VuT1XUpMJ
         +lhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778780248; x=1779385048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmreA23cwcFZxYn98K9SrDczn/2oXXYgf5RnrI0M3NI=;
        b=BPM+8YNicDUdgJxTQhQQibN69qGofIOLfCFyoYIE5aSpd0TYlte42tPTmR6v9nAydF
         FN9j/T0yVLwcrsjuM3SmNA+2Tmp31J93Swm76pI1FiayZlFBK7LsapjhesRe6MnRAQRg
         rwEbCg0CZB2meg/NFqtHra7o5IQnU0eEwI+RhUSXplcjKFSX+NvvMGpeiNVVO2IXaBR/
         Aec80sCNytpap71V+2UvWcjx9l9L70dO6MY3Tfi08o0GxOOlfKqty3mdWSq7xkqPL366
         I4IUVd+owxYdX1tJsPqeMNjE3pHIHvqvjFaBGFtZM6GVk4vvyrL21gbK6oVOXzvkCB34
         +4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778780248; x=1779385048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FmreA23cwcFZxYn98K9SrDczn/2oXXYgf5RnrI0M3NI=;
        b=SxS8vsn0Kr4119DTdTWnnAWYxmaFAMra/7hXJsRNUUXaD2DP+EB2oMePY9Sr1vBTQ2
         jL4utx3kvL7l7Sksd60uHMxbqjoVv+NoCef628lMnU9M/7nTsvVtIKZuiYoxLYv1H8Ow
         jdMhqWEb04PHYKtlCRIL/elxb8FGQSYXajHck6JB3QrNCtJol7J4d15FSo4r7uAAii8g
         MCT4OxuniFFVd+d2G0Fxv/3K1q+eTfg0WZZffmzJjiZZMqvYY9QcxBH/yPv+PAmG/zi/
         diTJ3K4O/N34xPBfajW1I81Xo5iKsau5qaQYh0qk6U4vQhB6NOfYhcsModA3spA7OahC
         iWWw==
X-Forwarded-Encrypted: i=1; AFNElJ+fZ/4SuLzy9ZsVgq/9mjTtw72/CJfenLpnwHfmhUvnJwr7Ss22VAu6fVtIBl52Ox06pEAONXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpNx/7PAKXnWzVfqo7U5pUzb06cRc8ZWPUmlZuKhcmPIzbmmJB
	Zx/ZYRbsKSX+dyM3CL6mem4o8tH0b/OHZVOR9tfrLNKlPsijhhC1l+6kyEJ1E3S01kR7/9EyHcD
	8lrMJWB+8gB7JVVwKHg1j1SpaE4yqa8mkB7Ez+kmC
X-Gm-Gg: Acq92OFB3843l71JSt0Q9Le8w4CQIDQUgN8smiOJotRd+gNHY+LozQizTZAF4D+tFMO
	4NslHhfetnYu9tsCNCL/YM24KkobGauJJaFo4tueJPyNSrNWsGZk02hp6sDGOlzEL5HidQV634A
	IQmyoNYmGBfRN7TXacE52hR31q6FMlUzsurhjw7FGUh09xSWJneaMl7FnaC8WzTEcHsL/b3fxub
	KcesCrIgYQijAUkexaS6wpeeB0zPdllAquiDxyNDd6BWluuc7iLpiJqrifY1y2mQ0n9VOtqS1eg
	FcujLirSL/GvnzpmlA==
X-Received: by 2002:a05:622a:8f0b:b0:50e:5eba:cadd with SMTP id
 d75a77b69052e-5165a3be35fmr434751cf.2.1778780248098; Thu, 14 May 2026
 10:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504224142.1041477-1-rananta@google.com> <20260507150925.11e9681e@shazbot.org>
In-Reply-To: <20260507150925.11e9681e@shazbot.org>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Thu, 14 May 2026 10:37:15 -0700
X-Gm-Features: AVHnY4L3_suYXUMuFI-gc4DyBTvFzkaApDG0hk3249nk2DtaN3QwnMlqQUOHEoo
Message-ID: <CAJHc60xK+tGz8rAhO_cNPCRR=A50pMD=sPwNeJWJ-BcLFABQWQ@mail.gmail.com>
Subject: Re: [PATCH] vfio/pci: Use a private flag to prevent power state
 change with VFs
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, David Matlack <dmatlack@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1D5C554569A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247259-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rananta@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,shazbot.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Alex,

On Thu, May 7, 2026 at 2:09=E2=80=AFPM Alex Williamson <alex@shazbot.org> w=
rote:
>
> On Mon,  4 May 2026 22:41:42 +0000
> Raghavendra Rao Ananta <rananta@google.com> wrote:
>
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_p=
ci_core.c
> > index 3f8d093aacf8a..0e4a73e541d3a 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -271,7 +271,7 @@ int vfio_pci_set_power_state(struct vfio_pci_core_d=
evice *vdev, pci_power_t stat
> >       int ret;
> >
> >       /* Prevent changing power state for PFs with VFs enabled */
> > -     if (pci_num_vf(pdev) && state > PCI_D0)
> > +     if (vdev->sriov_pwr_active && state > PCI_D0)
> >               return -EBUSY;
>
> AIUI, clearing the flag in the out_del: below can be lockless because
> at worst we'll deny a low power transition, but I think the test here
> for any state >PCI_D0 does expect memory_lock, right?  Maybe this
> should be something like:
>
>         if (state > PCI_D0) {
>                 lockdep_assert_held_write(&vdev->memory_lock);
>                 if (vdev->sriov_pwr_active)
>                         return -EBUSY;
>         }
>
Yeah, that makes sense. I've applied this and other suggestions and
sent out a v2: https://lore.kernel.org/all/20260514173449.3282188-1-rananta=
@google.com/

Thank you.
Raghavendra

