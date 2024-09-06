Return-Path: <stable+bounces-73797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EFF96F781
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 16:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8FF51F247B1
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 14:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCFE1D1F4E;
	Fri,  6 Sep 2024 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fMc5WDVw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3091B1E4BE
	for <stable@vger.kernel.org>; Fri,  6 Sep 2024 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634521; cv=none; b=sTNs8LzfxKUN+IfoTAvLJ6nRP3o5Lm0tMISeXFBLry36d4HT1nR7vfyHElh6LwKS+5HpFwId250j1kMKaUhLu7Y3q9hBzS1c0Qz5LDlFZHspA8jwlTZ29WkBA+hO8XDHLK70zIp7t70fuSzaU4QYUblW1VOOgbNNaBGi1YVuSBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634521; c=relaxed/simple;
	bh=+26xIV2WluTblsS7CAP5s9zVhv5uK8aK+XWtEjUNnrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqM4I8Snm/9zDPqIW/wDOfMq8bCJtJWOIMcd20V+C9RqIdr65MtfXeHcpHkz0wIp2rN13CR0t8sE9yG6FVLXbO2I5+giSkQcCm/Nd6I8NVAN/x3YBN+5x6dtrHrk7nLsGzRMgbCU/zIV+Z5JVTfbA9HvWQG/1jZHZKncPrUFa50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fMc5WDVw; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-205722ba00cso19642995ad.0
        for <stable@vger.kernel.org>; Fri, 06 Sep 2024 07:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725634519; x=1726239319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REdO8OfWu16SCOaIAz6gs7NfqYweprALAE3omfjztt4=;
        b=fMc5WDVwRHQvlL5b6iU0IKODo9uNWitJP/o8UyyuSmDYN3t9I++AGbrGWmSo6IYkfe
         8+rj7bmahUdtOWsHZsHYaes2kX6/pIP4Lkrsc5E+FEJiCV+pTbedhTCQGcsObUjQJHSp
         4BudgYMZb4KnPusVMDKAvLnWmC5tl0UcLKV6OjPA8nG4Pe6Q15sBeR5+o77KPD5kZ8c3
         EYtU0n8Vv/9d9xPt1vxVg197y4limm62y0UbYpPwwjP22ZUGsHChkpJ8WfQadTwLdOT+
         mNoHQwKCmr60aLZVINQiCJxECUD6tGzK/l+8hFUFvH3r0gLS81fnY3a4IxWECOmf+Cuq
         Selg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725634519; x=1726239319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REdO8OfWu16SCOaIAz6gs7NfqYweprALAE3omfjztt4=;
        b=oh8rYusrOqkSKkS3hAaFOH0FRl+4vr22zyfKDh/EKnhsx0vlpcLEv6a1ZUHE3wGk0f
         ogf9GtcfAX2Gqa/WfPP2Ao6GFZqpOZSIxMRWFjBMbD9CzQtMhBC7x1OdMwKmth+Qk5S4
         5CE8q1zS6F/hCk8lyWWG0HehhCE095hhV63fIO9G1Im2xFtW/bpPjCMr33Lj186eDYsJ
         ecluBi4NHy8NL1fVTb1QISPb7EYzoWBlV1siHQ971ldRvliz1qL9OP6rzcDw7PFKr9RJ
         A0uaehmHoWZIseovlG6Y2h/naiIJlj5oZHFcZ0sU74if/fPO+InG3nqZiEXe2QIJI48x
         UZtg==
X-Forwarded-Encrypted: i=1; AJvYcCXV/TxGmzbNq9JducwiiX182L5F/TV9vgBSS/Dfng/ARL76QX1gxTFeJ3hTv7w/CkKApIJxdoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqx4iyBAJKgOeGD6wkkLkgxCiDXmKyOs5t6DR+mZ9HIJuCTUTn
	mmn1cqbgUik5RmRqe285aZi6z2MUj3ZlhokV231nUcV5MvNNCxNAcgnFLrI4KKb2g6e/65+CEfN
	JR+xprMmBfCn9CziKIHz27DwQ9Ih/NF3UVexE
X-Google-Smtp-Source: AGHT+IFcZBVBqhlyg+liux563XH0Zu6u9+L3JlzXrFrKOuRyZHvlOrUxPxPBvpme4+uyqZWwQ1p1hC29CvEYdQuoNP4=
X-Received: by 2002:a17:902:ea03:b0:205:3450:cdb4 with SMTP id
 d9443c01a7336-206f04c22c6mr30271455ad.4.1725634518974; Fri, 06 Sep 2024
 07:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904102455.911642-1-nogikh@google.com> <2024090546-decorator-sublet-8a26@gregkh>
In-Reply-To: <2024090546-decorator-sublet-8a26@gregkh>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 6 Sep 2024 16:55:07 +0200
Message-ID: <CANp29Y6oy=cHWKpnM1+EBfZV24i3ZFUDWLzxvrD6HSyhnw_8JA@mail.gmail.com>
Subject: Re: Missing fix backports detected by syzbot
To: Greg KH <gregkh@linuxfoundation.org>
Cc: sashal@kernel.org, dvyukov@google.com, stable@vger.kernel.org, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Thank you very much for your comments!

On Thu, Sep 5, 2024 at 10:04=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> Note, for kvm, and for:
>
> > 4b827b3f305d1fcf837265f1e12acc22ee84327c "xfs: remove WARN when dquot c=
ache insertion fails"
>
> xfs patches, we need explicit approval from the subsystem maintainers to
> take them into stable as they were not marked for such.

Is it specific only to some subsystems (like kvm and xfs), or is it
due to some general rule like "if the commit was not initially marked
as a stable backport candidate, you need an approval from the
subsystem maintainer"?

On Thu, Sep 5, 2024 at 10:12=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Sep 04, 2024 at 12:24:55PM +0200, Aleksandr Nogikh wrote:
> > Hi Greg, Sasha,
> >
> > A number of commits were identified[1] by syzbot as non-backported
> > fixes for the fuzzer-detected findings in various Linux LTS trees.
> >
> > [1] https://syzkaller.appspot.com/upstream/backports
> >
> > Please consider backporting the following commits to LTS v6.1:
> > 9a8ec9e8ebb5a7c0cfbce2d6b4a6b67b2b78e8f3 "Bluetooth: SCO: Fix possible =
circular locking dependency on sco_connect_cfm"
> > (fixes 9a8ec9e) 3dcaa192ac2159193bc6ab57bc5369dcb84edd8e "Bluetooth: SC=
O: fix sco_conn related locking and validity issues"
> > 3f5424790d4377839093b68c12b130077a4e4510 "ext4: fix inode tree inconsis=
tency caused by ENOMEM"
> > 7b0151caf73a656b75b550e361648430233455a0 "KVM: x86: Remove WARN sanity =
check on hypervisor timer vs. UNINITIALIZED vCPU"
> > c2efd13a2ed4f29bf9ef14ac2fbb7474084655f8 "udf: Limit file size to 4TB"
> > 4b827b3f305d1fcf837265f1e12acc22ee84327c "xfs: remove WARN when dquot c=
ache insertion fails"
> >
> > These were verified to apply cleanly on top of v6.1.107 and to
> > build/boot.
> >
> > The following commits to LTS v5.15:
> > 8216776ccff6fcd40e3fdaa109aa4150ebe760b3 "ext4: reject casefold inode f=
lag without casefold feature"
>
> Wait, what about 6.1 for this?  We can't move to a new kernel and have a
> regression.

Indeed!
Syzbot currently constructs missing backports lists independently for
each fuzzed LTS, so the page [1] does have some holes. But in any
case, it's totally reasonable that if we backport a commit to an older
kernel, newer ones should also get it.

>
> > c2efd13a2ed4f29bf9ef14ac2fbb7474084655f8 "udf: Limit file size to 4TB"
> >
> > These were verified to apply cleanly on top of v5.15.165 and to
> > build/boot.
> >
> > The following commits to LTS v5.10:
> > 04e568a3b31cfbd545c04c8bfc35c20e5ccfce0f "ext4: handle redirtying in ex=
t4_bio_write_page()"
>
> Same here, what about 5.15.y?
>
> > 2a1fc7dc36260fbe74b6ca29dc6d9088194a2115 "KVM: x86: Suppress MMIO that =
is triggered during task switch emulation"
> > 2454ad83b90afbc6ed2c22ec1310b624c40bf0d3 "fs: Restrict lock_two_nondire=
ctories() to non-directory inodes"
> > (fixes 2454ad) 33ab231f83cc12d0157711bbf84e180c3be7d7bc "fs: don't assu=
me arguments are non-NULL"
>
> Why are these last two needed?

The last two address the "WARNING: bad unlock balance in
unlock_two_nondirectories" bug on a Linux 5.10-based kernel.
The crash report is very similar to
https://syzkaller.appspot.com/bug?id=3D32c54626e170a6b327ca2c8ae4c1aea666a8=
c20b

>
> Can you provide full lists of what needs to go to what tree, and better
> yet, tested patch series for this type of thing in the future?

Sure!
Could you please clarify a bit what should be the criteria for the
full lists and what exact kinds of tests you mean?

If the list only contains the patches that apply cleanly, it is
unfortunately not very big anyway since the vast majority of the
detected missing backports just cannot be cherry-picked automatically.
I guess, otherwise most of them would have already been backported :)
I plan to try to manually adjust and resend some of them to better
understand how much manual effort it actually requires.

For the commits I listed so far, I checked that they apply without
problems, whether there are fix commits for them and whether the
kernel builds and boots fine. It should be easy to also verify whether
syzbot is able to reproduce the bug after the fix is cherry-picked.
What are some other tests that would be great to have run?

--=20
Aleksandr

>
> thanks,
>
> greg k-h

