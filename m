Return-Path: <stable+bounces-230780-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JBeFGe4x2kQbQUAu9opvQ
	(envelope-from <stable+bounces-230780-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 12:15:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB35234E26C
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 12:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6120B302DFAF
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 11:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D73388378;
	Sat, 28 Mar 2026 11:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLUSLcLA"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1809378833
	for <stable@vger.kernel.org>; Sat, 28 Mar 2026 11:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774696532; cv=pass; b=I0MPusJtgTHbt4nerDDtdcPsItVOEwhlj+kaEzWTCFbsJ9uCFkxqX9yf3hLIMqyTBWbzhFVMgq2bbnFoB8IOLTirjmIK4fqXet5c3Al0SfZKvxU8AX5AlNm9fwD14AHTnW44p0zuO1jaeMDA/ibMRKmGu5XJYoFb8ASLkCEvZP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774696532; c=relaxed/simple;
	bh=GMvNtChBKJjdwyS/+GTl13oTZyqcxPbtMIjyiOqLNgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1rBE+tGUB2yvPSjxu1Zx9bvWu6UMxhiyUlfVMJ0cpc+xgNrvjd7PQptY+gKLAQjlcRtwjg/jC1QtnRGl0/8TX6HgTY5jPi3l2q3+S4MPpP4rb+DHTF4yvkiVSrMK9J8BgoMqOygPmYFNITxEGxFNIRz7MJwsfnqZ2A/C2+zHls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLUSLcLA; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4042905015cso1823027fac.0
        for <stable@vger.kernel.org>; Sat, 28 Mar 2026 04:15:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774696530; cv=none;
        d=google.com; s=arc-20240605;
        b=F4CMmZS2NwALrKMdCmMurUjUSXE3+R9n/926cZEdoAwoYRI+nk/GLjwdEFGxvbe3Yu
         gT4ugZ51zzm/+HDaAvRA/x8CdHsqSGfDVdcLlTrlcaYYQlrSa2eANYbp5PYzpIQQ4HnW
         2Poc+cM/mPFSjvDlooWg0Nm4WWH6vMyA74bpF8xJtQgLeQsqxATIOG2Nzj/4yV3Uzf42
         6AhCa3AVUhjRZ+QiZRzv1OmJEYsEGNf8R5av+nWHtdvXfviKAd9zbO6cHXXgT70HAw4u
         xhdQTBFpDlkRzzRu3GpWeUtkG6jWNbIir4B8bVE7yMqSlezW3KgLecZ/Iclg5BpacXtO
         XiWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cncPSoLfsUFWH5ZGfrEC9emTM1DT6AlrNfIAu40YnfY=;
        fh=LSYrCPrqRMks1MpdRWIa43qAoFnU+BNbCWVMPwW9Evs=;
        b=UF66lakwGBBirtWXgePHDK7Qsqj6COmG8Duz1kCp1VLMME+NzJoDx9Nxm/II7bSOpG
         6nEPJV6abIrCaeFSd0IFEHBpwZTS+CDl1orvZDy+jPKaeqz8PGgeQRyT7iXJKl/d3Y7t
         W6j657mWwXvH3ndEdBBMKZ5oUIF7eD67WerP87ugS1n5QNckbasij2FnZT0dIxrHFEaw
         ZKC1XiW4sVAasHz7MC2Ggtr+wSSOxxzJHcCrTrwGW1QK+w+wkvYpUn7PRN4QE2VYT9z8
         dMIbZur5GQ6imSSZGPymm7jXos6eBXRk5+b/icdMzHSU/X0ZiHbgz3/LgNU4yAN8vwrG
         9oeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774696530; x=1775301330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cncPSoLfsUFWH5ZGfrEC9emTM1DT6AlrNfIAu40YnfY=;
        b=kLUSLcLA4U/K2O0nS0HM/cQnl01PqTYP96CazcXuDqSYUxhN/Hi6udmYHm9OV93NxD
         AKasxCSmS/LI1+A0yvDKxBdRpYU/hPnN1Ovlgol/eeJVfb/eXz9GfZspbF5dBZ4KIUer
         y3zngsYX4plzzQFG1Qpt0qaZ7JMl+V6ZFTPgMxd9ZMw3pr9WMgCpcM4YyQf2Kn9+YlAc
         3LM3lEflmhEk8nHR/juVBlN5FoCeZQkdc3O1DIckjNqXRtNV+oUeT3hAcZR+PloCitfI
         VQcf9sLuIk9kfjPylwMArKVOCTMHgG1ixUBdRaoyitjXTOG7GkaPA+wUSDQUiBCX2+HO
         qDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774696530; x=1775301330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cncPSoLfsUFWH5ZGfrEC9emTM1DT6AlrNfIAu40YnfY=;
        b=Cvi1QZf0JzO8qlo3IdqbtEQI04LdEGLEw5cWMIE5gdNyv5Y2brPB71kCSsU/GYqIbH
         wExJkj3xvMot9xb2TclKI8ZZnGfD3RuWAQaANMhl+sJHYq03JGdY1mWbe2PXIZPA0tbW
         T9xyZaIMDS3wM/ir+0x2gscqoKAXii0yK8uJ1EYh8jcXgEiL/UyYHXOml0CxbdbzkSXM
         /UqubDEHu2tlDNWItcWjsDGg8ZL7Bi5hai6UgRhbqTLvkPaOd4XkIFfGvKgTmJi1Pyxj
         /HlJJ++ZniaxHqMJguea2tFP326GYTqcVKtWA9nTyzF9RPJUVYHwMyJG0FgQ25WgPoaN
         4DyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlboJ7nVtC70n5JuHUYdnDUEmgHDDLrLxqkxQuv8FzVNqr2cym+EnSLDuhGpMdiaSkygyVyKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzry8enBhiqd32pH6QfOCi58koD8nqwCsJDsobQI4fZ7cpFliZJ
	Sfs/w1x0YIrTxm1cfjr4Ikhq9jyTnylW+RZLGFMACXC9GUiqXi5hY8VrAwzNBdl/LtChSSxHUUH
	chne2JV/5G+uFMGw0N1MgcVAFd2hVw/A=
X-Gm-Gg: ATEYQzwMVDH5vcX9WBkFZHpx6C6q0QocOlNPXpfHmA86E1/NsO/WVigDceOXnx98TWN
	FiSKMcNIFDhP7WoxJQCPJydt+Dr7sQXCAbljJL2hFqEok+LMo0T2Nvk5lcZwuWVqzQgS3Mur9Lm
	djJDk8brUoc4hOzdydYyejFM1sqVInqY9MeB2o+blc9tAn1UDMN4kXctjonhyiurARnv0vShTnM
	23XhfJZNoSiBDc0eTYV+DxJQLjHZu0zorFvv0ZDcpOTsvu24utrQ7Vv4KkFOncTb0efPKnckDV+
	0Dn/c6ur3jwhu0e+YPX0eqDiC6MXvjWgD3qngg==
X-Received: by 2002:a05:6871:341b:b0:409:57ae:54e4 with SMTP id
 586e51a60fabf-41cec068104mr2925514fac.9.1774696529587; Sat, 28 Mar 2026
 04:15:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327222711.268132-1-devnexen@gmail.com> <20260328100010.41236-1-devnexen@gmail.com>
 <2026032803-tree-stubbed-1e9b@gregkh>
In-Reply-To: <2026032803-tree-stubbed-1e9b@gregkh>
From: David CARLIER <devnexen@gmail.com>
Date: Sat, 28 Mar 2026 11:15:18 +0000
X-Gm-Features: AQROBzADIpiaAdAsSWDXr_2MGaRWWGqF3eyfR0B6mVPGw_ItYK7BztzM9d0l-jY
Message-ID: <CA+XhMqw+pR3fLGbysq3FnfpH+b2GtmdhSjjgCKhTwfZFrF0_0w@mail.gmail.com>
Subject: Re: [PATCH v2] media: nxp: imx8-isi: fix memory leaks in probe error
 paths and remove
To: Greg KH <greg@kroah.com>
Cc: laurent.pinchart@ideasonboard.com, mchehab@kernel.org, Frank.Li@nxp.com, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	jacopo@jmondi.org, aisheng.dong@nxp.com, guoniu.zhou@nxp.com, 
	linux-media@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230780-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ideasonboard.com,kernel.org,nxp.com,pengutronix.de,gmail.com,jmondi.org,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kroah.com:email]
X-Rspamd-Queue-Id: AB35234E26C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 28 Mar 2026 at 10:21, Greg KH <greg@kroah.com> wrote:
>
> On Sat, Mar 28, 2026 at 10:00:10AM +0000, David Carlier wrote:
> > mxc_isi_probe() allocates isi->pipes with kzalloc_objs() but never
> > frees it on any probe failure path or in mxc_isi_remove(), leaking the
> > allocation on every failed probe and every normal unbind.
> >
> > Additionally, when mxc_isi_pipe_init() fails partway through the
> > channel loop or when mxc_isi_v4l2_init() fails, the already initialized
> > pipes are not cleaned up =E2=80=94 their media entities and mutexes are=
 leaked.
> >
> > Fix both by adding kfree(isi->pipes) to all probe error paths and to
> > mxc_isi_remove(), and cleaning up already-initialized pipes in the
> > err_xbar error path.
> >
> > Fixes: cf21f328fcaf ("media: nxp: Add i.MX8 ISI driver")
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > ---
>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.ht=
ml
> for how to do this properly.

Apologies for the confusion =E2=80=94 I wasn't submitting this for stable
inclusion directly. The Cc was added based on CI bot feedback since
the Fixes target is in the
  stable tree, but I understand the correct flow is to let it go
through the maintainer tree first and let the Fixes tag handle stable
backporting.

Cheers.

>
> </formletter>

