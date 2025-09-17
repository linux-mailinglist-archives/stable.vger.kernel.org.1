Return-Path: <stable+bounces-180461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22619B823CA
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 01:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7354626A96
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 23:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC7730DEDD;
	Wed, 17 Sep 2025 23:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3GfjjVD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BEB2FFDF7
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 23:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758150526; cv=none; b=IgJScNchLEslDgwJnZLnwNxVkRUMhFJSOelEu79Tik0/mAge1i1zhxC2qbtWcgzCoyJogGMIaJHRzszcO/xFeOZZwGjTzfbDnmzNcFc+7TAPl9fZkYuCOtPcIW7iJ6wjOTZsQ/ZLAWQ5QY3uw5KEDYoqwQesTENiyVV9dFPQ5sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758150526; c=relaxed/simple;
	bh=fiHidarY3es8NBA+LEW3pv6bjjvuMZYa+mJzlo0B1L4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAWTN5hOQD/tV5w4ZJyB9H0Nkq5oX8wlT0vhKdWy1UrivBmd7cd90fM/45aqWsDDkwmd827zjvBcdWnplObnjlUI1COICxdb1g+CMLYtGmNgqJyR44Zx6MMLYaGacnf/0R5XPwmCJplX66vQRJwfnh4go6/efzmkcx+gXDM0A5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3GfjjVD; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b0473327e70so55966666b.3
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 16:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758150522; x=1758755322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRGj/ILyJWi2Bsgex4Gvbo4N7e1wLDw4WJvnSHlYoZY=;
        b=a3GfjjVDOZloiF3VHg1fDTK/uGAjwoqZxrDmljLKWUYqeFDkG4puWSop+iNpdtY33S
         NdJ/cP+klOKHxsi6s4nCGtkbcYEDAr91Zn8tCT7GSnFwGfC6ggfa2Q5GgWRsLQpgHBpM
         EpHymmtQJ0Lf27fTlyD1EBlsqIOChVPhkRy9Lf+4/l3T5KNkiTqz6hMJeKiwi5b3DZrB
         AYGyHTdN5Je9sN4jCvevyClImXvu8bsCKeLyPITDphDybU3LBlBAkM1rHHfFUagqm+EG
         iIJWJWDWxzZn54aHP90ddn90W5Mz38hCIIC1IFhAfEdK5vwq35TO1TBkGVofSdTYJNs0
         2l7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758150522; x=1758755322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRGj/ILyJWi2Bsgex4Gvbo4N7e1wLDw4WJvnSHlYoZY=;
        b=jB8chA+v6FsDHJTLB0scVuSr/PoTeXJPFxYqRysBMkBSlbFuRRGyhbQlu04ziWCuNa
         dv5jNM0zaVSJGiSDfZX9C37WAe+LYF/NoE9F/kuhldWwTBEkEUD/41ZEJHQMe9rXOOsJ
         4rIyIbECkjsbxVBoO2uJF0K1hbhmCx+Tj7+dDNwrfdbkpEoZmYqFjReQioyNkpKzdmp3
         d6e8H1Bcp/6E4RCXQ8kDbGKUuSplyZL8sT14Fr/us2R45rwuolRJTXidz1XFYnCGSUty
         z47Ga8Bw7z/jE+/nhMv6XUawXvwVo7DHg4f+3k68yFap4MxH+A53qQkkZlLwztV5ebRO
         g83g==
X-Forwarded-Encrypted: i=1; AJvYcCWD95eCB07+usIhMgWooo5fRR5yvaKIm3gAJxB5/6kngAdIZixoWZguRVxYxcrJHQVV0fAkN/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcDyxCiERm7AbW207kLWC4uTkXIyLMwVDMqn00z6tQ5OBteOtY
	dnl/TSPHK+q+DyB5LVwbtIapUMbhj9PWhsoowwW2K/0akoE+jKcoEb+UTEMzkiuOgADKyo/YXpI
	nBkPF2ydyWa5mzr3cNgD4epGWnS9+yT/LVdXd0MM=
X-Gm-Gg: ASbGncs8ZGepzrX34pQcY3ZHndyZ5bFt8PYmhAa+Diu6jrdPkJAti+Qt8q/NCPd8bgA
	mKVjKOTW+u0Yr2ReNQ7D8KXkacvNsXzx733t7BHxxyp4VBhueHdGqBolNOP9YR+gfbKEe6NYRfZ
	FuTo9fYwOGZnaxKQ1g1FZkIC1KoeRqC0UouZh4QZ081V4iEe5KFcR8mjTMPvPWVTt+sIqnbEWlp
	8knKiiz0SBkZ8aoJS2TOn2hteU3FAyjwJ+uG+saWFXh8MJGa+P95J4DZA==
X-Google-Smtp-Source: AGHT+IFTShsh8t7nrREG3sNteTvvDWCztpJ0irdoYHone0kblikor9dVjpl7/+XtSzyEetSqaaCdKn/NmlZEPTV0vhE=
X-Received: by 2002:a17:907:6093:b0:afd:d994:7d1a with SMTP id
 a640c23a62f3a-b1bbc545b99mr380535666b.63.1758150522536; Wed, 17 Sep 2025
 16:08:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917124404.2207918-1-max.kellermann@ionos.com> <aMs7WYubsgGrcSXB@dread.disaster.area>
In-Reply-To: <aMs7WYubsgGrcSXB@dread.disaster.area>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 18 Sep 2025 01:08:29 +0200
X-Gm-Features: AS18NWAPWaGTXxRYRzp3XafBT13uBoehIcp4zLeoIa2AaJjHnaVuMpyaFs-UzhE
Message-ID: <CAGudoHHb38eeqPdwjBpkweEwsa6_DTvdrXr2jYmcJ7h2EpMyQg@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Dave Chinner <david@fromorbit.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, slava.dubeyko@ibm.com, xiubli@redhat.com, 
	idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 12:51=E2=80=AFAM Dave Chinner <david@fromorbit.com>=
 wrote:
> - wait for Josef to finish his inode refcount rework patchset that
>   gets rid of this whole "writeback doesn't hold an inode reference"
>   problem that is the root cause of this the deadlock.
>
> All that adding a whacky async iput work around does right now is
> make it harder for Josef to land the patchset that makes this
> problem go away entirely....
>

Per Max this is a problem present on older kernels as well, something
of this sort is needed to cover it regardless of what happens in
mainline.

As for mainline, I don't believe Josef's patchset addresses the problem.

The newly added refcount now taken by writeback et al only gates the
inode getting freed, it does not gate almost any of iput/evict
processing. As in with the patchset writeback does not hold a real
reference.

So ceph can still iput from writeback and find itself waiting in
inode_wait_for_writeback, unless the filesystem can be converted to
use the weaker refcounts and iobj_put instead (but that's not
something I would be betting on).

