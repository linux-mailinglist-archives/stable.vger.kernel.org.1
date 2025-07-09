Return-Path: <stable+bounces-161495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F52AFF416
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 23:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB6D71C863EF
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 21:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD3D243951;
	Wed,  9 Jul 2025 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="M+Vjkmar"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD6123B615
	for <stable@vger.kernel.org>; Wed,  9 Jul 2025 21:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097457; cv=none; b=MDXAmUnID3ayjjjmxJ+98FARelerWwuptTHOy3xNs38q5V5p0HFyvWtcKZKK9I7hvRVD9qsWW/Djyp6j10Cy84kvv+pa03KDqw+pSJlkufBnDvXMKkD7OzSjRWSgqwVNXhnGQs6FCnspfGFxQZ2UdnBlmUwcnuMSerRYeHag5Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097457; c=relaxed/simple;
	bh=QM3ZwKzZ3tmooQKRsyzdW8dMI+e0bgrGReSxQbsBbz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nhxf74pud0eo8E+W1LTwvAqhKAf+NVi3iKyR9aUidPGr5o2V6nnbRqS9DVvWLxoGhBYTY/zA21OUSfoLHlfT2rpSUymHJCQgF7O3zTht5bjD98gS3MsQwVsh/k9PmXlaBUXEClD4QeTUnm2l+FopTYgg1ytRrZTXK/tjG3sHSPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=M+Vjkmar; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60768f080d8so489083a12.1
        for <stable@vger.kernel.org>; Wed, 09 Jul 2025 14:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1752097453; x=1752702253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2oOfilMeJ3fSH+1jR5dPS+6bpms3vDBaMx9PS7L2n8=;
        b=M+Vjkmar2DZR01VBbGidpjLsj5WkhccV4HkYK/+hg7utLrEMINgnjypBRimA/63N9Z
         yYsj7DHfmQMKO1QAv71VK0sNBQkM9peUJhNd+uT1+KdZik4D91/04Eja8bsYuFfp0NYO
         FQ3oMpJJIDemPPNuxCCNSfbuS55si7hddv+RnXQA0b+5DhFQB8Z7rNyJQXBnKOOuK4Rl
         95Iib0HNh/m9cbmeeGI8t7IUpxYr+cfY+DNwK7eo7gUezPshoSEvsBIeAy7Pg6vTmmhV
         h3t0qqhwOB/bMwwUqNpEiS29wNroRRQR/3a4uP4NUgAMh9KoBsErPHFfXlzrhjWBnwHO
         DNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097453; x=1752702253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2oOfilMeJ3fSH+1jR5dPS+6bpms3vDBaMx9PS7L2n8=;
        b=YLWh+wKzov/PMYxZf9YV5+bzz0SnlJqSjUHVG1sbc+jJLwYJGPn5rovjXNUKGLjLSE
         5L8Tn2+7ZcTs7Om+xZxytnsbuex46JSmAQfk+bbFI+s3VCk5edRz1G7mqETckMiKdGaX
         O8if8tzuEfwTS/zYD0P/8d2AcB9e7U4tDMD/6uGE5+6sHuAzbbrt0TBaovsbcZ3F5yIg
         FDt2bOgqR0BikWxrLr1pWGNf6PRcmZp3+LstWJ9Go4K2Fmsgkfv7Bs3JQpAVks7sY497
         uWx76xOF/MC8VzG4YtJmlABG+XPVAoYyrlfjMzhr00r56b4bTwRyXremQ7BTfk1t4lgF
         68Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWc5LLZoamyHr8CCHZbVLltzJMccJO+QC2S/sv1trJkZ30KCZvY5cf6EKvGznLg9m4IAW+F6UI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZsPld1vCqDY4hE6izmBQnvd/DhYQxbTxPGXbMD8mPsXBHCjEX
	2eDG7PtMcXWAqewXBXkArjBRmpZSd+IygEHd/TExqsuz4i/fmYrrUK1jtRVEiSIlssj1cHMSEI2
	5nJgyiy4Lq/wWuhXR/UQXQIUkbmQWfUc2ilPFKmARqA==
X-Gm-Gg: ASbGnctLi7Q6bhcZ7TozK2tNGcWTmlGV486Lsse/iGSM2xQGo9ZycsZuSJ83VElA1aQ
	Pp4l7MiEIQ+X2HwCmiVffIUFPTQOpRfhq2FY3O1oAapUD0O1LKR40IIbVnA+Uc9DfJNTHDzkYPd
	+R0vH/7TEgk94hKCVV40Vqf4gCXZ3O81AHw9Uy8l1cX5/+4UG1f4GaiSFKsgjSqyEksl8Pg6Q=
X-Google-Smtp-Source: AGHT+IHRfBgI+JpvIFW5bdEhu8EMbBsinsmaICn0S2xVCrLK7zPglEC6AbVpvLywHBFg/8fSMjerPI4gbWHSZhnMN/4=
X-Received: by 2002:a17:906:46d9:b0:ae3:d1fe:f953 with SMTP id
 a640c23a62f3a-ae6e7099e16mr25848366b.43.1752097453229; Wed, 09 Jul 2025
 14:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701163852.2171681-1-dhowells@redhat.com> <CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=shxyGLwfe-L7AV3DhebS3w@mail.gmail.com>
 <2724318.1752066097@warthog.procyon.org.uk> <CAKPOu+_ZXJqftqFj6fZ=hErPMOuEEtjhnQ3pxMr9OAtu+sw=KQ@mail.gmail.com>
 <2738562.1752092552@warthog.procyon.org.uk>
In-Reply-To: <2738562.1752092552@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 9 Jul 2025 23:44:02 +0200
X-Gm-Features: Ac12FXwGyOaYIBhD6kJLi5Rdp0KMSI4jWTqWW8bY_UVcRj5P-WQCdanG6BjA4Q0
Message-ID: <CAKPOu+-qYtC0iFWv856JZinO-0E=SEoQ6pOLvc0bZfsbSakR8w@mail.gmail.com>
Subject: Re: [PATCH 00/13] netfs, cifs: Fixes to retry-related code
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev, linux-afs@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 10:22=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> > (The above was 6.15.5 plus all patches in this PR.)
>
> Can you check that, please?  If you have patch 12 applied, then the flags
> should be renumbered and there shouldn't be a NETFS_RREQ_ flag with 13, b=
ut
> f=3D80002020 would seem to have 0x2000 (ie. bit 13) set in it.

Oh, I was slightly wrong, I merged only 12 patches, omitting the
renumbering patch because it had conflicts with my branch, and it was
only a cosmetic change, not relevant for the bug. Sorry for the
confusion!

