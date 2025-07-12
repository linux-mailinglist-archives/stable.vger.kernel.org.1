Return-Path: <stable+bounces-161743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFD1B02C19
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 19:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 429C27ACDF1
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 17:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA702877CB;
	Sat, 12 Jul 2025 17:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcG4OmAY"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9A426B948;
	Sat, 12 Jul 2025 17:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752340325; cv=none; b=bEQFUHiZwASUNU8ta+L9DsQNiUc9rtIi6+mYcRLwLI/Hvl/yBT1ZfhiGS3xFt8V7Ig39OH0Xsgz4laFAjzZioebVN1HdF+UlW3cxzp0D3O26hBpsJnIcYxDgbiD0eCuyTQoNFVi4CyhaBWB+bcQIBLKB5kGAz6xdQY5yGxEWaCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752340325; c=relaxed/simple;
	bh=8aN8Lggjc+78El6nxcKpMhrfSv8uxqhToi/9AVMmQZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=omsVp5PGPDqUF/fl+NQ+41iryv+q/dfa4qOVpqiYqUXZjJLSSMTHDYodBh1ybF6yw3oxEYep87CSldzauMDn5uH/ZS25R4mqa8L4s0fYl4sUjXPi/S3MHhhFzccCf5od01fz9HAnUs7ta/u59okEPxhMOYh1ZSZ+/tG2NhNmFaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcG4OmAY; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-553b3316160so3253021e87.2;
        Sat, 12 Jul 2025 10:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752340322; x=1752945122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJVhCeS8COyKFGy1fiTAFuCQ8rCKhrZIJE4Iij87klY=;
        b=mcG4OmAYDGSiCcqxGNDZZP3mWtxKzdF6c1MTLzj16jOf5fyHBz5nXzynA468kFhPgx
         P4XbCEp1h6ADy4E4pCGzJHjtEcr4xvXuoIdV7+9lnDpTvtfnoGMFHIkTp+tX5gKKYKj4
         LQGVUK+Tn9YeX/JNWvH1r3Lz6vGEC2eGFJMzSBPJXSWeeUSkec1kzjynVe20HMi8M2WD
         58f4/hwLczuicrMnErcgoNGVNDXBNCd0k+TydZPMtbx3zY+P7UtrWKf7Vts+YrZARmUR
         QcYN+p66GZk1KvSlUTjDKAaM/pnqPkg9QfgQDUzPSGe5ceA/1gIHDjIHzpqg6V26gL0E
         xWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752340322; x=1752945122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJVhCeS8COyKFGy1fiTAFuCQ8rCKhrZIJE4Iij87klY=;
        b=pN8Un7TGtTvxecfYZC4GWYqm7uPIxM3cJRkxfI2vAhNO6EZeq9q+PKgnTa2Ya1oF1E
         K+xKVYQBaSYg/jI5Aq8xmDCKyG4F9ez11a9VnQPLg/OEUeBeW4lwdsM6+lbB3ckA0K3H
         IJz/LTUctRAPWuKvXRw33jwqPo13OALlteKFCtYmQsHDKMFTR7I7o7ISigfZry6prikj
         +W7wimJnyNYgSg7P0thyFegOpewEvxHt3bsSBRS6CYWwWhACNxNh9nyO+2GabT3rac/F
         oLsCCQLJ33iXyTkFlWrd8Ho2dbQneheIQoxpawGU7VaTORPjbuPRVYhFCD6kIh/Z5aOh
         HK1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqGAvuKqyfNptGRsSwOUNaEhLoRrV5rFqtlXHbvHjfbysfPd0q3tBKfgt63HZUJsw5lQTKTiK5@vger.kernel.org, AJvYcCWvteaCrjEzQE4jY6mHMc3I3u+lH/xkdO9nJmeISww2CDD2Xh/u6v3d9je658dSbnts6eAKd30HP48iBFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YysCjrkLpaRzuTxCjGhXgMS6v3ekRdIS5n/bF1jBl1NuZM32mtV
	fYSkFLrbVLEY4uqOjiT5SAOVpbwrdderf5rNOlF7cooGbAqOhFODMlUjZ4ABTSlUj9Vhd9wdW03
	7bzD0mbvqsOWgTIZzbQgYtYHDQhRJQhAnhfp87w3IAQ==
X-Gm-Gg: ASbGnctgZg0ldk9Gr9oz+USdTBBYpFKwzdKIOqlfrRVqGqM2aqTEQel+YS/fzg6Q+zq
	DihPNtIIwXwD/F6g0uHo738ZAKC9RpgKsi1ZTZUsU2NaP9GQcxMKMvZU/8FA5SBykuH9tnrY4bu
	hcpztbwC3xgLO/ISdHsqiLJVskzSMN5l5LVBtIgDjSQgMEMpvBNyYfaGaz8y963pjmC6/6tlfB2
	YW7Ijk1YtMiMqY21x8u5yD8W+FheDdKAY/OhPo+
X-Google-Smtp-Source: AGHT+IHBHk/tuoG0+PYXGt8N9d8SbJKla5JtPf2KgQeMTDOJSuW+Wn0RJ/uDlkqGD5wilalXrpQm9WXERIEwyIdgFks=
X-Received: by 2002:a05:6512:3094:b0:553:2767:e398 with SMTP id
 2adb3069b0e04-55a04634539mr2270254e87.39.1752340321712; Sat, 12 Jul 2025
 10:12:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630083542.10121-1-pranav.tyagi03@gmail.com> <2025071245-snowsuit-pension-061d@gregkh>
In-Reply-To: <2025071245-snowsuit-pension-061d@gregkh>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Sat, 12 Jul 2025 22:41:50 +0530
X-Gm-Features: Ac12FXyzOTCSfI9zC6vRyqve_tIZJrwhdoSUM_hk5T3Og9T1ORDpCYIUbKwmYcU
Message-ID: <CAH4c4jKMvLhgT_-2z_LH9scGQbT3J2tgH-RUXAUJ-5c30251MA@mail.gmail.com>
Subject: Re: [PATCH 5.15.y] ocfs2: fix deadlock in ocfs2_get_system_file_inode
To: Greg KH <gregkh@linuxfoundation.org>
Cc: ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org, mark@fasheh.com, 
	jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	pvmohammedanees2003@gmail.com, akpm@linux-foundation.org, sashal@kernel.org, 
	skhan@linuxfoundation.org, stable@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, 
	syzbot+e0055ea09f1f5e6fabdd@syzkaller.appspotmail.com, 
	Junxiao Bi <junxiao.bi@oracle.com>, Changwei Ge <gechangwei@live.cn>, Gang He <ghe@suse.com>, 
	Jun Piao <piaojun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 12, 2025 at 7:16=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Jun 30, 2025 at 02:05:42PM +0530, Pranav Tyagi wrote:
> > From: Mohammed Anees <pvmohammedanees2003@gmail.com>
> >
> > [ Upstream commit 7bf1823e010e8db2fb649c790bd1b449a75f52d8 ]
> >
> > syzbot has found a possible deadlock in ocfs2_get_system_file_inode [1]=
.
> >
> > The scenario is depicted here,
> >
> >       CPU0                                    CPU1
> > lock(&ocfs2_file_ip_alloc_sem_key);
> >                                lock(&osb->system_file_mutex);
> >                                lock(&ocfs2_file_ip_alloc_sem_key);
> > lock(&osb->system_file_mutex);
> >
> > The function calls which could lead to this are:
> >
> > CPU0
> > ocfs2_mknod - lock(&ocfs2_file_ip_alloc_sem_key);
> > .
> > .
> > .
> > ocfs2_get_system_file_inode - lock(&osb->system_file_mutex);
> >
> > CPU1 -
> > ocfs2_fill_super - lock(&osb->system_file_mutex);
> > .
> > .
> > .
> > ocfs2_read_virt_blocks - lock(&ocfs2_file_ip_alloc_sem_key);
> >
> > This issue can be resolved by making the down_read -> down_read_try
> > in the ocfs2_read_virt_blocks.
> >
> > [1] https://syzkaller.appspot.com/bug?extid=3De0055ea09f1f5e6fabdd
> >
> > [ Backport to 5.15: context cleanly applied with no semantic changes.
> > Build-tested. ]
>
> We can't take a 5.15.y version, without it being in 6.1.y first, sorry
> :(
>

Hi,

Thanks for pointing that out. I wasn=E2=80=99t aware of the 6.1.y prerequis=
ite
for 5.15.y backports. Learned something new today. I=E2=80=99ll make sure t=
o get
it into 6.1.y first.

Regards
Pranav Tyagi

