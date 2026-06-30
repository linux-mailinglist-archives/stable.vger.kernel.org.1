Return-Path: <stable+bounces-269933-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GjoaHHuUQ2qLcgoAu9opvQ
	(envelope-from <stable+bounces-269933-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 12:03:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F22676E2955
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 12:03:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CPaL+u7t;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269933-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-269933-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9577A30054E9
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 10:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711473EB10C;
	Tue, 30 Jun 2026 10:01:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AB43EA942
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 10:01:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782813677; cv=pass; b=TX5WMqcbPH++Ez/fd4hsjhXv1HenvdaqTiuhoPDHk/NCn4A1+UnYS/ITYb4F5SiAs9VfbTr2Eg1s0qKZHTaH4Fewg8OBDRW/soRoQ2znmhycoCZNMx1tUNCaRb2/C9fZDymrwHn6fUbX03MIPuDimJ5nvtZobg94DB7KvhSD2O4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782813677; c=relaxed/simple;
	bh=BU8JH/JOv4QfhOcoG4nN41cEWWJ+yoErkc6ymqiy3mk=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bF+ZSD96yDoU0VV1gmtESY2I5iXR/B3BDLg1FFbxW0WN3BQ8zMeCZhaHgfN4PnM40wV2YW/0mmp4Utn5Tc1wMJZRe/QZNyeJKc0h6bTkTznV/m00udvTzu/w9pTtjKflk9TD8GnPuf3feXEibz/GYum1hIG4BzYb0vokDPVGtqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPaL+u7t; arc=pass smtp.client-ip=209.85.128.177
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-80fe8f03098so9423117b3.0
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 03:01:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782813675; cv=none;
        d=google.com; s=arc-20260327;
        b=lDKI155gTlLLxdKakIxdNQNEogwmk6tmqWUkbCrrX/SKLIvXD924aTlDtH2FWMsHQ5
         s9xdZC9wXokPdUvZB7bmcjKYTghNp9mxxnDQ4e1UXCnX/DDnqlYZ2MhL0rnDurzHDDAg
         +3kPCDSKOeX+UIWXty4aLa3bgeTuZtdAcAlOatKU4gZQL96yEv18R+gGyXUmYR7Cb5ez
         fWI6ouAFz9xICD/zUGHBrYr7DMd2Gh6ui7de9RUTrMDjTvhFb2aOePPzz4+xuiPtgw0p
         qBBGrux6SjUZRSGt6hu9Hio5KNe/v4UEDzkElc6lCqqaEYiY2ryT233274Lp5NuQrb3c
         7+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=BU8JH/JOv4QfhOcoG4nN41cEWWJ+yoErkc6ymqiy3mk=;
        fh=Wn55ohqkRwy1yDE4z9zZ+hHF4k9iV8yM+O8OEaJLgRY=;
        b=phmABVVu718naGVXXDTU1xcvRlZ/X1uLGuwyUWD32XbZAsLaRi5W23ogiVqm0bAE9n
         PhFpuuwxnqMRJTztiDbhAUSNrCxeC4OcQz4ZX4NpKQeTtZ3LNhdwcuhfhtZYDkPUOBOZ
         tPrwcRmVkd/71A9sSPXiazH7B1e6LOhus8HIzPV0CdajpUOIEX1j6Psaac+9mF0awGBL
         4G52okPLZxJdyfvjIhd1niJSG2s7823HJjTZtDLPzAMT5hek+5ad6xFiktMk6qaizwto
         j3QgdAtOxLRqqpaI58LNmdvM6vNFaBYkT99kr80lhuHXKtbtM5CRd4LJeDs6Ua9OICPZ
         awfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782813675; x=1783418475; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BU8JH/JOv4QfhOcoG4nN41cEWWJ+yoErkc6ymqiy3mk=;
        b=CPaL+u7tZyg6q8JqiZIQCnevYwkTiYcFgN4EXE9XzrjQ3y/dZ6QVG9xiiBPEhjDpws
         lzm82z2pFIfMpTdn0BYvT5xR/bYjw9RYojzy+jJUPUef0E1/F1wtZTpiz29xroJURrah
         R2iTlNt5bxaQ4DWrCkoEhXDpciXJ2I4ml5zjRwrgyscBJ2DNqrCAIkfQAQDrsAHG+z/S
         c0krm2DB9foaeWFusuI22q+7fmEfGX7ht8Qg+raLFo4eugVVLpvVOkl63sSWL9rGCQNQ
         bQh4r8BcOzJwb/mcBOYeJ+lkg62XgIEkszHlUhEooHF7WVez550xwgUHXe3VIr7C41ET
         UVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782813675; x=1783418475;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BU8JH/JOv4QfhOcoG4nN41cEWWJ+yoErkc6ymqiy3mk=;
        b=UTfWQiAT/uadJlWDHVODBO7KRjRDH7RijtLUNZuLGZXDLmSO5k4Q3pBJ0GT4JKdi3E
         d5unz8zo18DakfCMpKw5cu4T1x7FsIg3S7SfsVUtixSrc0jLjUz0SHZqaJ2++40vlyxX
         5Hf4rTeXZS/k7aOY9A+LZQeKmKiJNWem1DMW98Z4sYUWCnwPhVGGxLOIQ6JhduyXEdRY
         3/cNvCob0T8StHGNPIZ+6yWQc9it1gnusVZDJwQXXl4MZWfavAaZZGjawl1JwwI4XyIs
         j2Sb7AEmoA4S/NhvitsEmM8USa7miXnf+rV+U/O+p82DwcrOPbw3fmK/unnkvzTG81H2
         zM3g==
X-Forwarded-Encrypted: i=1; AHgh+RpRR0V3FhR6hOUswbPnrUAtXP2pQoNx/lboQvccx+ghV1RcH7LpeGsX0GtKzN04FJcS8k9cOJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynu5VMdrMhQiIKOQXhsd1C8T8z89cI580RLdZ/sVQjbRiMcO3C
	la3FSseezDwBkcGgJOcMon04s14nsfgGB52ET1q3pm3zG7xWQbki5xJdFm1/XjmmzBBBDxJ31hw
	0/BhM+lI+J0EoZKL3JVCKKE9H1RBUWDc=
X-Gm-Gg: AfdE7ckcCNVy6UeqW3CyOgloPpCuDt5k3b7Qq7TVyPnhJ/S2ExC/mswKjTDvXRbI7c5
	Qzn2x/LzLpfnR6wD2yoIBlQrUVt9zorrJk4M5jkWkLr4QIjujVZl515zQto9Bmkg8WIDKaKXGVb
	LREmobBGN0E3X64yGovT4V0rhkCjuivOHeXAuVlt/PQzFl0UzaH126m8JcLdI/O/cVLFqIFyy1U
	10+CvuyEO16dfpKcEnqvua6tOiakyYuqfvg+XROwSkMl+7zitteeliFGzA3+57lIXyxMn8p
X-Received: by 2002:a05:690c:6186:b0:80a:a005:8415 with SMTP id
 00721157ae682-810d9f0dfdcmr33829617b3.53.1782813674742; Tue, 30 Jun 2026
 03:01:14 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 30 Jun 2026 12:01:13 +0200
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 30 Jun 2026 12:01:13 +0200
In-Reply-To: <20260629203959.GD6078@frogsfrogsfrogs>
References: <20260628094748.46578-1-alhouseenyousef@gmail.com> <20260629203959.GD6078@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Tue, 30 Jun 2026 12:01:13 +0200
X-Gm-Features: AVVi8Cc_DhIdO3oFvX3YF7lE0hO5f0INVLW3aYt7sEymvlUtFIcfTvhSp8X8zwQ
Message-ID: <CAMuQ4bXUrZV000bcc-XfPoyBoWFGWAwZRZb-1WDG+BrT5pzuCg@mail.gmail.com>
Subject: Re: [PATCH] xfs: zero newly allocated btree root space
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+97f2c05378c5d68dcb8c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269933-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:djwong@kernel.org,m:cem@kernel.org,m:linux-xfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:syzbot+97f2c05378c5d68dcb8c@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,97f2c05378c5d68dcb8c];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F22676E2955

It can, but krealloc() requires __GFP_ZERO on the initial allocation
and every subsequent allocation/reallocation of the object. I missed
that requirement here.

I'll send v2 using __GFP_ZERO consistently in xfs_broot_alloc() and
all allocation paths in xfs_broot_realloc(), instead of the explicit
memset.

Thanks,
Yousef

On Mon, 29 Jun 2026 13:39:59 -0700, "Darrick J. Wong" <djwong@kernel.org> wrote:
> On Sun, Jun 28, 2026 at 11:47:48AM +0200, Yousef Alhouseen wrote:
> > xfs_broot_realloc() preserves the existing in-inode btree root while
> > growing its allocation, but leaves the added bytes uninitialized. The
> > inode log formatter copies if_broot_bytes bytes into the journal, so those
> > bytes reach the log record and its CRC calculation before every location
> > has necessarily been overwritten by btree updates.
> >
> > Clear the newly allocated tail immediately after a successful growth to
> > keep stale heap contents out of the filesystem log.
> >
> > Fixes: 6c1c55ac3c05 ("xfs: refactor the inode fork memory allocation functions")
> > Reported-by: syzbot+97f2c05378c5d68dcb8c@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=97f2c05378c5d68dcb8c
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> > ---
> > fs/xfs/libxfs/xfs_inode_fork.c | 3 +++
> > 1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/xfs/libxfs/xfs_inode_fork.c b/fs/xfs/libxfs/xfs_inode_fork.c
> > index 606a36526ce2..0d81c78f5afe 100644
> > --- a/fs/xfs/libxfs/xfs_inode_fork.c
> > +++ b/fs/xfs/libxfs/xfs_inode_fork.c
> > @@ -398,6 +398,8 @@ xfs_broot_realloc(
> > struct xfs_ifork *ifp,
> > size_t new_size)
> > {
> > + size_t old_size = ifp->if_broot_bytes;
> > +
> > /* No size change? No action needed. */
> > if (new_size == ifp->if_broot_bytes)
> > return ifp->if_broot;
> > @@ -430,6 +432,7 @@ xfs_broot_realloc(
> > */
> > ifp->if_broot = krealloc(ifp->if_broot, new_size,
> > GFP_KERNEL | __GFP_NOFAIL);
> > + memset((char *)ifp->if_broot + old_size, 0, new_size - old_size);
>
> Why doesn't GFP_ZERO work to clear the new memory?
>
> --D
>
> > ifp->if_broot_bytes = new_size;
> > return ifp->if_broot;
> > }
> > --
> > 2.54.0
> >
> >

