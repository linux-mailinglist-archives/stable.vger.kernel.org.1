Return-Path: <stable+bounces-192616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A568BC3BA10
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 15:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BFCE62615D
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 14:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB6A33B6D2;
	Thu,  6 Nov 2025 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5l4V/kH"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791FA33A015
	for <stable@vger.kernel.org>; Thu,  6 Nov 2025 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762437774; cv=none; b=hYQtNyXdCbB8iRmhEYcCGQzTgTvTx0y4svHkGlEyZdA9S/iQDNxAbeVvTW8jswp+xM5gRjJEELNF3P62mq++qG7o6DrgqQwEQnDBhBVsC5PRiNYtTs/eDEP+raBFV3qb3YKmYT6TPsmV+VD/9Wt82r0KU5723NtH3SfXrm5UuWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762437774; c=relaxed/simple;
	bh=WvSEkVsKHi18LbupKspxuUo3UwUMwfEICSlrjEE1bZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLc9zM0kcbZLxr6iku/F42juLChoZgALPY/mWWoM7CukWIvs3F2smmTCy5+qsz3ixO3owSstgnunwaVL3KJtmAXB6SAwK5emZ2b6leRbcjTwZ9cVPP5inzrRdHDpLGWBnUkjLQ5E8HRRGuCp1hCN19mu0slKIlQPQHUbjI453yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5l4V/kH; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7864cef1976so30684467b3.0
        for <stable@vger.kernel.org>; Thu, 06 Nov 2025 06:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762437771; x=1763042571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inUDTdZs9Vh0fPhADocRHvWqcynk3OywAFkuRGyh6uA=;
        b=V5l4V/kHC41i3whnRC/eXu8RWcxU9IxGzqexoEkx5ZACrufgvAfwLD5foTzvRYGrSC
         YxmbhRF/8OatLsnCHr/B+ZKLIwz9+MdrriUPGL06Du8IZCeKoLZGRNI4FDDpheKPGq0R
         OFhO7vHKQgaA8lTPM/xUgdE2bhtJtNcCcKkaOnVSmME0/vQ4q6R+ili29qhUJXi5FRe/
         OQE54b2u5K+EW0+hoH+ZZeuL4yJWGD3IM+/i6KY5UHiHLmoXPNe11S8KnH03MA3e2BJR
         HCBXJYSrYUzV2zeYQgOGBJiuaNme8RNluOPSUbZgdo/R8G69+jJu4xCR6O5rav0vBsBd
         AGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762437771; x=1763042571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=inUDTdZs9Vh0fPhADocRHvWqcynk3OywAFkuRGyh6uA=;
        b=n0D3izRZwzM0g/NHQZKezLbp4qpFnBfQe62cJniv948b3s39zLdn5qLnnrwVatZWxl
         yy5z7f6RItVG8uRjavo5Q52xkGBfoLUo57xaOHAF4iAff2KkMh/TcnJGN8ANvGnNd8e9
         RvyOzIx/YJn5GiN0+V7tox9p8JGZNedO6LOtku3zuD2xzbAvHs4UUcnjL5A1kC+wGA+v
         6tfUVm9CZOrBTPzYTokiP3ZCGDOalDMcYWCqEe+/5UzXPY9ESKhvt8J8axrrxwQU12vJ
         Gs5EI/yGfqu5ivjVNS3+EQSKNhyMFzsC7iRIg0r1OeJ1/yQO72pYjaDMtRGYH6xjAfnT
         bSRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4pdf3DBWaIQa4AjWihHe/n3ChPn6TZEWjtjz6Tz4m3x6+EVdFQgwuA8HkowxKQb8DfXnl4Cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWmZ/12Iu2r75MgNfNgs232REJEqLxVn+Ocn1d605zknpstqjk
	QmLdST/abwHOxlmsF6q6UisG493He6WW4D63O5+kctBm4Q67lnLe9flbVMpLpHJ1PoG5CnEYPgP
	L0BJ6XSj10zGAtJoffMA7v96oRrzgZ00=
X-Gm-Gg: ASbGncs8tLsxuX17D/wYTgT+Y2KpeRwUDJd9Pah6YXxcTcMB0vGyZ9Kj3JHZ+fUIZnv
	GUnWopArZl0g4Bey5HWsYWuH/gCDZ8GQNxNdEnbQ2C0meZ+z7Hcs2WlWmJzOK41R9IuYADHYJEL
	W3DKvkGP+4BXTTgQNF7aN2+B53Mb1NCpEF5cqG+LwymfwIZvY1vuuZRcKHAI7q2ghaT/o0bsvKo
	Fa3k8LWtOz7P4ELlZTcBuNPK8A0Jjz51MGkGKmuulF29vQVkOg7tq1XIB2S1sHcOVoNUlrY
X-Google-Smtp-Source: AGHT+IH5rRqBdd0h/d3zF3xb5h/Gzp7i9AdCeqJZxt2JD7xsPG0L9f8JF4omL+mDvX2gYJDASpEwCiiiUakTCt5oCqo=
X-Received: by 2002:a05:690e:1402:b0:63f:ae5f:d7cb with SMTP id
 956f58d0204a3-640b52ae4e7mr2498693d50.0.1762437770721; Thu, 06 Nov 2025
 06:02:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710165040.3525304-1-henrique.carvalho@suse.com>
 <2944136.1752224518@warthog.procyon.org.uk> <aHE0--yUyFJqK6lb@precision>
In-Reply-To: <aHE0--yUyFJqK6lb@precision>
From: Bharath SM <bharathsm.hsk@gmail.com>
Date: Thu, 6 Nov 2025 06:02:39 -0800
X-Gm-Features: AWmQ_bmoYkmo6SDuLYq4N60l8-Fq8PbA7W5LXKJcb8BD7Nyh0avwRGwuCYHfANg
Message-ID: <CAGypqWyyA6nUfH-bGhQxLYD74O7EcE_6_W15=AB8jvi6yZiV_Q@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] smb: client: support kvec iterators in async read path
To: Henrique Carvalho <henrique.carvalho@suse.com>, gregkh@linuxfoundation.org, 
	stable@vger.kernel.org, Shyam Prasad N <sprasad@microsoft.com>, apais@microsoft.com, 
	Bharath S M <bharathsm@microsoft.com>
Cc: David Howells <dhowells@redhat.com>, smfrench@gmail.com, linux-cifs@vger.kernel.org, 
	Laura Kerner <laura.kerner@ichaus.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 9:01=E2=80=AFAM Henrique Carvalho
<henrique.carvalho@suse.com> wrote:
>
> On Fri, Jul 11, 2025 at 10:01:58AM +0100, David Howells wrote:
> > Henrique Carvalho <henrique.carvalho@suse.com> wrote:
> >
> > > Add cifs_limit_kvec_subset() and select the appropriate limiter in
> > > cifs_send_async_read() to handle kvec iterators in async read path,
> > > fixing the EIO bug when running executables in cifs shares mounted
> > > with nolease.
> > >
> > > This patch -- or equivalent patch, does not exist upstream, as the
> > > upstream code has suffered considerable API changes. The affected pat=
h
> > > is currently handled by netfs lib and located under netfs/direct_read=
.c.
> >
> > Are you saying that you do see this upstream too?
> >
>
> No, the patch only targets the 6.6.y stable tree. Since version 6.8,
> this path has moved into the netfs layer, so the original bug no longer
> exists.
>
> The bug was fixed at least since the commit referred in the commit
> message -- 3ee1a1fc3981. In this commit, the call to cifs_user_readv()
> is replaced by a call to netfs_unbuffered_read_iter(), inside the
> function cifs_strict_readv().
>
> netfs_unbuffered_read_iter() itself was introduced in commit
> 016dc8516aec8, along with other netfs api changes, present in kernel
> versions 6.8+.
>
> Backporting netfs directly would be non-trivial. Instead, I:
>
> - add cifs_limit_kvec_subset(), modeled on the existing
>   cifs_limit_bvec_subset()
> - choose between the kvec or bvec limiter function early in
>   cifs_write_from_iter().
>
> The Fixes tag references d08089f649a0c, which implements
> cifs_limit_bvec_subset() and uses it inside cifs_write_from_iter().
>
> > > Reproducer:
> > >
> > > $ mount.cifs //server/share /mnt -o nolease
> > > $ cat - > /mnt/test.sh <<EOL
> > > echo hallo
> > > EOL
> > > $ chmod +x /mnt/test.sh
> > > $ /mnt/test.sh
> > > bash: /mnt/test.sh: /bin/bash: Defekter Interpreter: Eingabe-/Ausgabe=
fehler
> > > $ rm -f /mnt/test.sh
> >
> > Is this what you are expecting to see when it works or when it fails?
> >
>
> This is the reproducer for the observed bug. In english it reads "Bad
> interpreter: Input/Output error".
>
> FYI: I tried to follow Option 3 of the stable-kernel rules for submission=
:
> <https://www.kernel.org/doc/html/v6.15/process/stable-kernel-rules.html>
> Please let me know if you'd prefer a different approach or any further
> changes.
Thanks Henrique.

Hi Greg,

We are observing the same issue with the 6.6 Kernel, Can you please
help include this patch in the 6.6 stable kernel.?

Hi David and Steve,

Can you please review this patch and share your comments.?

-Bharath

