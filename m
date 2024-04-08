Return-Path: <stable+bounces-37789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A89E89CAF7
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 19:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DAC81C219D3
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 17:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35206143C7A;
	Mon,  8 Apr 2024 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q4zTfmam"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D083143C60
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 17:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598423; cv=none; b=NloxUAfi4qGAPxYULOFFUghiIhtLKKWNJ5jM2ROfaBJrikWjUCiKVjjsBWRFyO9B/oI2wBddtnnvJI9XnGzHVcWCTkNHTrsVBjjF9vc4sDl192ovv8bAcQJnYVo74TifPrIjmQZHHyMmYBLd9EKCoI0e+BKAHqdHC6SeoT74AFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598423; c=relaxed/simple;
	bh=0YbW5SOLOTenM+r6RQas4H/M9J4T+E9gkfjLqxxbMwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6uFloNmi6kUCHUhFZfXdMlr1LcE5EvjLun3qdejPO+um9qmeru6rcLZMHX6+x3ewwEPkXX0lmVt+YCfpgmSoWcBBZVejO6BHln0xll0t0tahtcJuPiZk2mflvj8axVBZ2UWPUH3FLuzDNP9PVu/puKzjchx+No6fMGVZ42on/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Q4zTfmam; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dde0b30ebe2so4042567276.0
        for <stable@vger.kernel.org>; Mon, 08 Apr 2024 10:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712598420; x=1713203220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YbW5SOLOTenM+r6RQas4H/M9J4T+E9gkfjLqxxbMwg=;
        b=Q4zTfmamJ1Q6kXNdlC/fVn6zTRUwsc0gZs+hVpDAGbkL0UW0w/iyoQ5SLfJUA20Igj
         UBbIfPFHxdrB7SbtpCf/AAJa4rNEmdWHO5CYFQ39eQVjXVPUZJ3JamV6Y6S3DIO4TrP+
         VKFovoHDUTdsMg8wWiDsyjmZypVJP4VuCzB0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712598420; x=1713203220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0YbW5SOLOTenM+r6RQas4H/M9J4T+E9gkfjLqxxbMwg=;
        b=rEpAJrgtXOyDgkQgvrcUiL5slpwCVfzPH95N+fkjOM8koZ7jk34U13PfnZ6yU2oKRb
         aPzVEYz6q7eS+gtP1x3tifPCfG0abMDkmZYs2cRri4lyVDYcYe0dgh0Eo7/2vCQm1mYQ
         PP2natlqauOnEg9z1ji1Z51FCDRzVRdTn5XCMyJ9pcsDDVTnsieyOw2GGWmipMZgIaXj
         Mio8Owu0xwSeKUkFS6CMk6dJyQcB2t1nX05xUVFW0UXQfnWSnKWUzIhJj+g7INRoxvhM
         nl7rfTlDnehb8rieAWucpWOqdmMjLBbVVibuRy7LJVXPt2Q+ILVGAUIA61erGlzemrmK
         n1Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUMNz91x92dxOsIXc92ZZrVWnk7szP4BNR+otSxy1/aP+6VD6wglagaGEsrzL82iVMCneIfQAIq6iKGXrpfhZmG4D7XNzzD
X-Gm-Message-State: AOJu0YyKiCN6m9Zyp0ItFataH9mTLS/7H3NG0YU/ZDNLIXpxLTMTxc4W
	utObMsRcA2mvjgRmnuogaCatIYbPG3FHKY/kfzR+u1gKjugjtTn1ix4XZerfg23MNYipY40OXAK
	YPCHB25kX9UnaopApVSki7urKUZlluzPITY3v
X-Google-Smtp-Source: AGHT+IHJElG6RyxN5KsSAQgpDvZ6UdSTRc5tikioKhfMtj/AlFIOyYZ9i8vPa7wr84cqzBwszV2q3jnb2JLEmmtXWQw=
X-Received: by 2002:a25:bbc2:0:b0:dcd:2aa3:d73b with SMTP id
 c2-20020a25bbc2000000b00dcd2aa3d73bmr7422172ybk.50.1712598420397; Mon, 08 Apr
 2024 10:47:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408155605.1398631-1-zack.rusin@broadcom.com>
 <843fdfa2-348b-410e-8ff1-84ab86cac17d@amd.com> <CABQX2QMtTB9iiQuce36dnk6eO1Xcsm+Xt3vc1Nk93TGD+TtV9w@mail.gmail.com>
 <5ca415e9-fb3e-4d81-b385-71e8780a1399@amd.com>
In-Reply-To: <5ca415e9-fb3e-4d81-b385-71e8780a1399@amd.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Mon, 8 Apr 2024 13:46:49 -0400
Message-ID: <CABQX2QMaF6e6o4Ewg6sExfaEZMXRaUrNHNYUCAYG3+44P=7epQ@mail.gmail.com>
Subject: Re: [PATCH] drm/ttm: Print the memory decryption status just once
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Ian Forbes <ian.forbes@broadcom.com>, Martin Krastev <martin.krastev@broadcom.com>, 
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, apologies to everyone. By accident I replied off the list.
Redoing it now on the list. More below.

On Mon, Apr 8, 2024 at 12:10=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 08.04.24 um 18:04 schrieb Zack Rusin:
> > On Mon, Apr 8, 2024 at 11:59=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >> Am 08.04.24 um 17:56 schrieb Zack Rusin:
> >>> Stop printing the TT memory decryption status info each time tt is cr=
eated
> >>> and instead print it just once.
> >>>
> >>> Reduces the spam in the system logs when running guests with SEV enab=
led.
> >> Do we then really need this in the first place?
> > Thomas asked for it just to have an indication when those paths are
> > being used because they could potentially break things pretty bad. I
> > think it is useful knowing that those paths are hit (but only once).
> > It makes it pretty easy for me to tell whether bug reports with people
> > who report black screen can be answered with "the kernel needs to be
> > upgraded" ;)
>
> Sounds reasonable, but my expectation was rather that we would print
> something on the device level.
>
> If that's not feasible for whatever reason than printing it once works
> as well of course.

TBH, I think it's pretty convenient to have the drm_info in the TT
just to make sure that when drivers request use_dma_alloc on SEV
systems TT turns decryption on correctly, i.e. it's a nice sanity
check when reading the logs. But if you'd prefer it in the driver I
can move this logic there as well.

z

