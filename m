Return-Path: <stable+bounces-79752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E125498DA07
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4AA8286A13
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E8E1D0DD9;
	Wed,  2 Oct 2024 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5HUtn2Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2FF1D0414
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878366; cv=none; b=C/jPzoGz1nZsFITtvlowhyn2MEIhOwQC1HGurwhAMYsWbcWo6aq7/+vV3Vrw2ApBPyEYyzt1/T5TuT6S2fzvASEPAELvtCahMfeQOeJvWrWkLPH7PjbdJRpLAauoFQ5OT6vNiTgWpFzYFMl9dWlXP468wTrp1veWHT5Dj53bX6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878366; c=relaxed/simple;
	bh=WZNZWR8PAJ7rcNRr0luQIreWcIo/NJ+TNCYGucATcqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kkr75Fi3M6+p4I7/OcM65N1dvbdsfEJI0qf6+prCePYUGKoJSsGHDO/gOiyDL+68Hk2dM0YzTIAK3nTvM+eYP9+3t0mKYAwd06dlSe8hRSGjgyZz/QnuWJUKl9v73rNk5yBOpQSwZojisVsz0rhrGHh+KHBvR994QSNW37UdmHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5HUtn2Y; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e26114a1b16so3651058276.1
        for <stable@vger.kernel.org>; Wed, 02 Oct 2024 07:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727878364; x=1728483164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYUL+R6ZwmGNZ5hFEprKY1nHV3Bj9gxb2dqTmv+1DgE=;
        b=K5HUtn2YgdcoEFjBK1Gcexme9Ejs9d/Af3b+cDQuaBJFCmRuB5ax8AFGts/xNQFNP+
         BrByBbwN5xO/Pg2rswafC6vwKzRgwB94vqvKeb/3Iq7k3ZwAfIQkfPlhsbfYKnRqci2J
         077fQ6RX8IpC21vXRMdQ2LTRp5v0P1/a04a95wY3VHLKrZo+GhzVkS2Ld5xB2Md/FDDN
         TPH+MhiAVdFyiL4B9Q06JiC6oLlQ2x+toOExJpu1NoSGFIFdKRvf7vg17PwKwltdKNY4
         1Cn+H7lANdNGCPAlzHeX4vck7livsysAsUzH8j5/4AuSdaZTfxre/ygRzbgrTnyTcEiU
         NrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727878364; x=1728483164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYUL+R6ZwmGNZ5hFEprKY1nHV3Bj9gxb2dqTmv+1DgE=;
        b=I8yuVCXPGS17ZtYKGD0vguACoXS8ygjjZq0tGMV+vXROtNRHatQdbSZOB7Zc2E8v4b
         /nyP6KK8fkm4WAqNlnB2TMviwKl6cta+JGJpvfoOTKPuDpkW8Lvfco8rzg8w0Ob6Klm4
         lR8yx5YN0li3qk4WaFTB/xQJA9oLYDqY8Oa/iYAC+0pmEdglO/VYTGhg+44OhHvHqstR
         jbM1Nvs8pwbZliXYIReTPVXxyifeE9RoJFznukjj3aLCOTTirXTuxMuyx/WHo1/HVYPf
         eckeOhFJZ0ODiboHv5C9skn1fi9gsol00YqYc/6unHhytDC2MUYY0MQ3TDH4OnOMvKTD
         pOXg==
X-Gm-Message-State: AOJu0YxU5FpQf350nG6WUlknePbBkE7Dn4VGiLoareZWZPKKTMdfNKL7
	q97IlrTcdXk/RDvE1GNvsyBE8WTWFnJRDKzxS0Eu3VEwIqIhyfCneVQDhpWNHXiuFFD0X7hOlZR
	Gr3duuWhdYNFlXdVMzXd2d73Nnnc=
X-Google-Smtp-Source: AGHT+IGko3RG5jLjXuXWqCg7C28LBR5vxeznyQ+uBLd78nTmkdYpiggka2aMVA91vpHO23oFYPRyXkgERnILAXSRns0=
X-Received: by 2002:a05:690c:6187:b0:6db:e55a:1c88 with SMTP id
 00721157ae682-6e2a2e1bb87mr32120917b3.23.1727878363736; Wed, 02 Oct 2024
 07:12:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002125822.467776898@linuxfoundation.org> <20241002125838.303136061@linuxfoundation.org>
In-Reply-To: <20241002125838.303136061@linuxfoundation.org>
From: Youzhong Yang <youzhong@gmail.com>
Date: Wed, 2 Oct 2024 10:12:32 -0400
Message-ID: <CADpNCvbW+ntip0fWis6zYvQ0btiP6RqQBLFZeKrAwdS8U2N=rw@mail.gmail.com>
Subject: Re: [PATCH 6.11 397/695] nfsd: fix refcount leak when file is
 unhashed after being found
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

My understanding is that the following 4 commits together fix the leaking i=
ssue:

nfsd: add list_head nf_gc to struct nfsd_file
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D8e6e2ffa6569a205f1805cbaeca143b556581da6

nfsd: fix refcount leak when file is unhashed after being found
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D8a7926176378460e0d91e02b03f0ff20a8709a60

nfsd: remove unneeded EEXIST error check in nfsd_do_file_acquire
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D81a95c2b1d605743220f28db04b8da13a65c4059

nfsd: count nfsd_file allocations
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D700bb4ff912f954345286e065ff145753a1d5bbe

The first two are essential but it's better to have the last two commits to=
o.

On Wed, Oct 2, 2024 at 9:38=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.11-stable review patch.  If anyone has any objections, please let me kn=
ow.
>
> ------------------
>
> From: Jeff Layton <jlayton@kernel.org>
>
> [ Upstream commit 8a7926176378460e0d91e02b03f0ff20a8709a60 ]
>
> If we wait_for_construction and find that the file is no longer hashed,
> and we're going to retry the open, the old nfsd_file reference is
> currently leaked. Put the reference before retrying.
>
> Fixes: c6593366c0bf ("nfsd: don't kill nfsd_files because of lease break =
error")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> Tested-by: Youzhong Yang <youzhong@gmail.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/nfsd/filecache.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index f09d96ff20652..e2e248032bfd0 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -1049,6 +1049,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
>                         status =3D nfserr_jukebox;
>                         goto construction_err;
>                 }
> +               nfsd_file_put(nf);
>                 open_retry =3D false;
>                 fh_put(fhp);
>                 goto retry;
> --
> 2.43.0
>
>
>

