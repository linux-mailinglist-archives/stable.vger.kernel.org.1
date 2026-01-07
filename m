Return-Path: <stable+bounces-206235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C495D00614
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 00:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CE113017215
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 23:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3685E2E7165;
	Wed,  7 Jan 2026 23:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLHpiCmM"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790732E03F3
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 23:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767828063; cv=none; b=ip+OcN1CNRT/UF42+PaSd/C6MQlPy21XVTDsn06g91BhRLRlVot1ZHWm43LOhLGN3W7nTMe7MGXLYoU+pydENFXH1yWnNj3vnmcdqp1CQTfv3j8J+8lY9lvUoSEXckla8ZSqGl0vfEtGmZ1wLMJuyuSKkwPfSN4MIFLP9qnuugA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767828063; c=relaxed/simple;
	bh=+IiIYk6tyq8dn+kFWd93D1ClEiKTPKlKcVrqsM5QbR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nELZM6dZYxZ2/QsOaXGxVXqJtCJ3mMXB3Ts1WlxR+GuI2YOGIl0keFSd/pV+aR8XTQfGr2iH5K0kCt0FpFibSt1gAQgbRHlSWBgfe+m399JDXEUXqVFOBefEMBvXNx3lnNK3rcWrPSmd17bSzID0F4xKnjaEUpR2tKvlkV4zQhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLHpiCmM; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4eda6a8cc12so28076391cf.0
        for <stable@vger.kernel.org>; Wed, 07 Jan 2026 15:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767828059; x=1768432859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCrjzEZQwv01G+U0WIfJQs+VO9PryBUCb3CgwRj0lP0=;
        b=PLHpiCmMD6n85Yj0HEKJuT7fWVqqEfnp0pqwBnJCS3F/EdmGfjdcPv3AxeqgppxXPx
         Qb43t8sSmr5xtt/K4UJmgAJMbkb5qBvvhdj1ImLDxs2qRnRJ4p7bnwqmg9AXiysx9qIR
         yXsPK3yd71Q3Bkkergyd6dS9eKkHCi6gWD4xHO+LULNHOzp3+ksok8vWqg7/8njbNDjX
         TmYURQCDCQn1m0MO/KOF1VKpS1PMGt9foJcIkJsad26LLC7/zLrTlofQ/feeah7J0fpd
         R/jBgBXnS/LEbFO3G+3+S1Ok6jJ8hT7sLAzjZTQyYyu7OLB5CxnULF/o5Ig1CYIe3ghi
         SiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767828059; x=1768432859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dCrjzEZQwv01G+U0WIfJQs+VO9PryBUCb3CgwRj0lP0=;
        b=gDdbAcooZDSWLinhGpG7wgFdQXVN8ysdlOlB/cp5nnb7iJaWmmhRkiIcNncBUvCLQo
         yXMzHvxn1hs9V855vA4FxKYGiCDVjJqQ86c4HvzIt4K81zl+QqiJGkH/U0O9bW3kRV+Q
         KDna1xVJq5aZfzjCz8B5TalboEG+8QrLNstd5W+fXs4oJHfgla9AYvf6ZJ6Ug404UyAe
         9xe+SL+yWoaPhINWjgu+JjgHVwZBSOjGZ50+cJZ2VLFJQtTYMiZzxw7ZZJNAS7OdDa/1
         HTfV0hOE7Pg3Fm/87bMXFY8ivxXCO2vDvif2O1KFxMke2EKDmx3SVOqDbB7i8k6UJa2R
         sR1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXc+QdurzkeuTm8XdbtjaOTVvmFFtj9/BbkBIdDjGQg2c+g8yCbx9hEQEGWMv94LhMpB4rhRBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWafFnD7eGAMl/d/72sDQRA3t3GLJwOOxonQNHJ/KWiYR1hcSH
	uRX3mKmjBnN28PpmIo/pifo/P9IeGTGBtfNsyTwHgzwGIVKz8bbKF04T5FueqonWOO/zSluu4PI
	vVequRtuoz2/lPRo+QB0aHCbuDO14uDk=
X-Gm-Gg: AY/fxX6axHs/CBOeWV21gYNGHVQPiU3hrZ8XIWuyhvSDKdrClkt3baOXyHv82rvcuVF
	iH77YVuxaDkNNnHOu3A55B+05IL2mmQoUl8C1WfSyNGCjirrZLtc1nz2WE5+JpH8UGfX30IuAgK
	GsiEbLsgjRhb6lBhb26zQxvAHTJfuk5tCTUXt89CSkXQ0mhTSS+bzBXBKGVbTFTpmQ6X396l+4a
	C+dinNJVrX0uPJGQKx8jPUk2KVta0M1LJysZ1lt845WpRKCAbyu7A98GsVGU4pBR0HJwQ==
X-Google-Smtp-Source: AGHT+IEiFeqiqTBVau2o0UwF1CseRs5J2I2K15YUqe72E1rmIA/k0t28m+0gQwUsMjLpxytNmWX8UDtYFxSJ2+hi2Ac=
X-Received: by 2002:a05:622a:64a:b0:4ee:1f5b:73bc with SMTP id
 d75a77b69052e-4ffb4a76ceemr59244041cf.66.1767828059316; Wed, 07 Jan 2026
 15:20:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215030043.1431306-1-joannelkoong@gmail.com>
 <20251215030043.1431306-2-joannelkoong@gmail.com> <ypyumqgv5p7dnxmq34q33keb6kzqnp66r33gtbm4pglgdmhma6@3oleltql2qgp>
 <CAJnrk1aYpcDpm8MpN5Emb8qNOn34-qEiARLH0RudySKFtEZVpA@mail.gmail.com> <ucnvcqbmxsiszobzzkjrgekle2nabf3w5omnfbitmotgujas4e@4f5ct4ot4mup>
In-Reply-To: <ucnvcqbmxsiszobzzkjrgekle2nabf3w5omnfbitmotgujas4e@4f5ct4ot4mup>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 7 Jan 2026 15:20:48 -0800
X-Gm-Features: AQt7F2rD2bYE74fC-BJPB9hchw_T0Hhn5OrF8uZDPNCgSz0wuN8d7B-9zslHZs4
Message-ID: <CAJnrk1b-77uK2JuQaHz8KUCBnZfnQZ6M_nQQqFNWLvPDDdy4+Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
 in wait_sb_inodes()
To: Jan Kara <jack@suse.cz>
Cc: akpm@linux-foundation.org, david@redhat.com, miklos@szeredi.hu, 
	linux-mm@kvack.org, athul.krishna.kr@protonmail.com, j.neuschaefer@gmx.net, 
	carnil@debian.org, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 2:12=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 06-01-26 15:30:05, Joanne Koong wrote:
> > On Tue, Jan 6, 2026 at 1:34=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> > > [Thanks to Andrew for CCing me on patch commit]
> >
> > Sorry, I didn't mean to exclude you. I hadn't realized the
> > fs-writeback.c file had maintainers/reviewers listed for it. I'll make
> > sure to cc you next time.
>
> No problem, I don't think it's formally spelled out anywhere. It's just
> that for changes in fs/*.c people tend to CC VFS maintainers / reviewers.
>
> Thanks for the historical perspective, it does put some more peace into m=
y
> mind that things were considered :)
>
> > For the fsync() and truncate() examples you mentioned, I don't think
> > it's an issue that these now wait for the server to finish the I/O and
> > hang if the server doesn't. I think it's actually more correct
> > behavior than what we had with temp pages, eg imo these actually ought
> > to wait for the writeback to have been completed by the server. If the
> > server is malicious / buggy and fsync/truncate hangs, I think that's
> > fine given that fsync/truncate is initiated by the user on a specific
> > file descriptor (as opposed to the generic sync()) (and imo it should
> > hang if it can't actually be executed correctly because the server is
> > malfunctioning).
>
> Here, I have a comment. The hang in truncate is not as innocent as you
> might think. It will happen in truncate_inode_pages() and as such it will
> also end up hanging inode reclaim. Thus kswapd (or other arbitrary proces=
s
> entering direct reclaim) may hang in inode reclaim waiting for
> truncate_inode_pages() to finish. And at that point you are between a roc=
k
> and a hard place - truncate_inode_pages() cannot fail because the inode i=
s
> at the point of no return. You cannot just detach the folio under writeba=
ck
> from the mapping because if the writeback ever completes, the IO end
> handlers will get seriously confused - at least in the generic case, mayb=
e
> specifically for FUSE there would be some solution possible - like a
> special handler in fuse_evict_inode() walking all the pages under writeba=
ck
> and tearing them down in a clean way (properly synchronizing with IO
> completion) before truncate_inode_pages() is called.

Hmm... I looked into this path a bit when I was investigating a
deadlock that was unrelated to this. The ->evict_inode() callback gets
invoked only if the ref count on an inode has dropped to zero. In
fuse, in the .release() callback (fuse_release()), if writeback
caching is enabled, write_inode_now() is called on the inode with
sync=3D1 (WB_SYNC_ALL). This does synchronous writeback and returns (and
drops the inode ref) only after all the dirty pages have been written
out. When ->evict_inode() -> fuse_evict_inode() is called, I don't
think there can be any lingering dirty pages to write out in
trunate_inode_pages().

Thanks,
Joanne

>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

