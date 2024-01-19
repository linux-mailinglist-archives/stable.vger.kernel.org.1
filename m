Return-Path: <stable+bounces-12262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3728328AD
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 12:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A997B229AB
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 11:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A654C633;
	Fri, 19 Jan 2024 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="UR0ictAH"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5396D3C68C
	for <stable@vger.kernel.org>; Fri, 19 Jan 2024 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705663232; cv=none; b=gJzkgxa74TVPoD5xxsRhsVEO/pPM45AjfYCsXbCJYsHZesg/rAuz5VZ3cPX8Njl7pnAnRekeS+hwlMrzkhKHjk8NfsDaXUmmdK50j4hI0H0W0/X53eWm1Q0+xSG2v72dArJfq4owTPQVLhdN6hL4UZnEtt1A94QsETpL4Nx5e6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705663232; c=relaxed/simple;
	bh=Yn3beNcYVdkSQtS6/dBDhptz4UylN9AibkVXgjj+5cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HhixAI304uWoiuXMmPBgkTS0nqDwJ9Mbw0iP9Wy9B1SQ8ErQB6WPiHeZhwX+QPPnPDH1Y8bUl8YC0t+CvlyxtamBQETx+C2Vs6scOlfmttn7HqsqtHf85jIv2ci02Nn3qZeSlHf26vtSzEuPKOkRXped2iGmXkERa7cqyoTPPhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=UR0ictAH; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so63665866b.0
        for <stable@vger.kernel.org>; Fri, 19 Jan 2024 03:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1705663227; x=1706268027; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aBnEhmd7NsyYgMJlScUd0DjTZJ/ci/Yzod3zpcsS7dw=;
        b=UR0ictAHCO+Z+D8beR7f8YY1zuYjVj7ajXMPZaRk3i//F6NRoVfEcQ/+7cZPIyuOZO
         Uxnr8AfpnB4/Hx+ABeWpeu0FCRCSLFCgfMBU5B2JQwKqlLYCjk/v2ARvmfFYgirrmPko
         hLKQU3BkAet+naV9vczKLtkufn04EHZDlEjNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705663227; x=1706268027;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aBnEhmd7NsyYgMJlScUd0DjTZJ/ci/Yzod3zpcsS7dw=;
        b=saWPi4eKJBWkoMN/EE5X3guLW9zCJCCFagHb6QMdBRiaBDBPX/9UWB/3Kkf0BQttl7
         kxb5fQ7QCsg2PRKx2C52sdvYCizKeVdFpUiz/Bie9CrRU4xmEUAvO5UyoBCYQ/kCS7Pv
         g5UZ37ym7HgFFIKqJqDO9ay2+HAMT61ahMOHFV9DpIWwd+gmiYX/t8Ve3GrzwHR7AXY4
         kJVblbYU4rTLUbN3zDun9VFgJd9bue9jWX5SeX6BM8yR+Gu/bw7eySDzrGvrk2y8+vIC
         EpRkS3RkBc6rLZL/pLjyGZGE+peYSWEleeDl2HKQf+zHp87lMAVcXzPDi/w0CdGsDqTv
         Iifg==
X-Gm-Message-State: AOJu0Yz6isDXIbZSh751PKpNVZao2n1QZDYkBbrtpLznZZpCi0JoBFLh
	US1Cb0LiylcAnKzVF1vHo0Yzv3Osx3/wkMvJGPq/kX+/6kTei+OdE5kUtcdwmURhwtVDrb6gpLg
	IlTjvz1sK52mRb86mWnOZpirVfPpGSwfiyLwKrw==
X-Google-Smtp-Source: AGHT+IFCQLaF1tDjz+sXrYQawR2okyMyjiGZHvJkLev2PMKBOhhjOBWThWDhX+/QlA1615Oc/gfaHB7iQZNRSNa3gBQ=
X-Received: by 2002:a17:907:a4c8:b0:a2e:d789:1cd1 with SMTP id
 vq8-20020a170907a4c800b00a2ed7891cd1mr1713739ejc.15.1705663227289; Fri, 19
 Jan 2024 03:20:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119101454.532809-1-mszeredi@redhat.com> <CAOQ4uxiWtdgCQ+kBJemAYbwNR46ogP7DhjD29cqAw0qqLvQn4A@mail.gmail.com>
In-Reply-To: <CAOQ4uxiWtdgCQ+kBJemAYbwNR46ogP7DhjD29cqAw0qqLvQn4A@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 19 Jan 2024 12:20:15 +0100
Message-ID: <CAJfpegteroc6yJAmjh=MaqZOO9Q7ZJfg5BgMJFN3wdHGZK6gGw@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: require xwhiteout feature flag on layer roots
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	Alexander Larsson <alexl@redhat.com>, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Jan 2024 at 12:08, Amir Goldstein <amir73il@gmail.com> wrote:

> > @@ -577,6 +580,8 @@ static int ovl_dir_read_impure(const struct path *path,  struct list_head *list,
> >         INIT_LIST_HEAD(list);
> >         *root = RB_ROOT;
> >         ovl_path_upper(path->dentry, &realpath);
> > +       if (ovl_path_check_xwhiteouts_xattr(ofs, &ofs->layers[0], &realpath))
> > +               rdd.in_xwhiteouts_dir = true;
>
> Not needed since we do not support xwhiteouts on upper.

Right.

> > @@ -1079,6 +1090,8 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
> >                 l->name = NULL;
> >                 ofs->numlayer++;
> >                 ofs->fs[fsid].is_lower = true;
> > +
> > +
>
> extra spaces.

Sorry, missing self review...

> Do you want me to fix/test and send this to Linus?

Yes please, if it's not a problem four you.

Thanks,
Miklos

