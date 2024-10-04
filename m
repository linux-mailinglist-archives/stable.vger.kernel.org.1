Return-Path: <stable+bounces-80747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B48B499052A
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 16:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 382DE1F2132D
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 14:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3D1210198;
	Fri,  4 Oct 2024 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5P1AydV"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FBE20FAAF
	for <stable@vger.kernel.org>; Fri,  4 Oct 2024 14:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050519; cv=none; b=p6zR5WMaCgIlYNXkg5Sb3t+xeMtPuEK46qRlkiCZM3MmgMLwuTopxC63rUUs2wyofHBUfvnwOgirti8nZ6LzkRpQhTBHiQF7FJuKf3smODq+VegH0yZ21V+osdPFLWT93WUYuBrTb4eFoJLS99mwMy1xrjdpVEB0sqOc5CNj3Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050519; c=relaxed/simple;
	bh=dXmPelvRHfc4ZdMEj6b9JoK02MhCYD5JgsYCtP+dG9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BrvABUfrF8fYVwzijgYPXhISw0tKvczauxyEU3ycHmAQ6lvAuJEguoZ6L3LRTI9OyiAuKuZRnJ1a6r69I+rG3yOy37oOOkIbtA2AmEX+bZPpYi+fAWeEiOWHGRDydvlsOHFwHGr1RcW5tdxpqZDoxmmKmnHtfcAlxFOflqgUWSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5P1AydV; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e2d65673c7so1530327b3.1
        for <stable@vger.kernel.org>; Fri, 04 Oct 2024 07:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728050517; x=1728655317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IDoNwvuEcJDkjxQtbxhmslZMIhdEHCkCDz1zdzIYfs=;
        b=S5P1AydVL18/6nwzfIjErtZCZ8vLPNouKauhFwwdX1yxVHSsz0q2SZXPg6q5JJIZl+
         eNnbVMmGRVwWIKCxCS3/FQNdk0/YJII1phZVyi8cZzap4o5nxAH4Vo5Q+QJIpq0JRJvp
         qMbVJGwJmoRV4gt59AUgMY6qs1U3RpvZyVNgSenbozxECi7dXdJrPNlPj9FtxuT7L0Xl
         iVsb44QjcsKBzkvLzLjZdmGDvCUMgIEtUWN4qaBBdYawXrMyjfizI3aDLDjwfr/61cKH
         sz2LC1SLZD+ok5YAQV54xj4wP7e08Y8gyz+sEsgNwxb72xCTDEgNTC8xt7uYEaufl4Dc
         suFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728050517; x=1728655317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0IDoNwvuEcJDkjxQtbxhmslZMIhdEHCkCDz1zdzIYfs=;
        b=RQ5cB5poL0H9DI29NEpJHwKsNwev+Sr6i9pb4c+QPnhjr77gg/ztyBi1eS1b/+3qS3
         0Uhl1o8aozcac3eg1t/OGmaWXJmvxU3kxcbBM5KjtT+7gd9m6CErsSZYHRC8MZEYDmye
         iWnKAybTNQEuqRQ0Ts2gCOic83hg/KGvq98muhSTOZnOIAEZR4sSYZnbB+u+Z2laQcOV
         GLepX0PlK2MSHHvXcxKBegmestclTGsVJWhX/mN00n1kqCjeCwqXEZdTTkW+LcOuSNyZ
         dYcdqLSKujb/W1HeIZ143aiH2Yyc2AWHPfQEswzHY5zwwRFHGAgwNX9CuZxR7cKj025D
         HgiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLo4+xXrJBVcSRFeW/b/Bztya5zj6s8NCgbyJHHiEyVMvMyVzHsSTModynXIkrTpMIEQI3Ua8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR3sbtT+lz52pOqN8XVE4m4g4lcaAHwBTQkdNrqknLkoNyjRlG
	aHp0JZXAI1vfAk1KTLcf/5upcoiA6YpvS1I0bP9IBt6IHD5i3+DE3kLdrJc0OHaIPse0Wo2IPak
	de7dIOAPrE8Br/B/O9FfwgaAlegk=
X-Google-Smtp-Source: AGHT+IEOZSDXtUb4SwraSXLmqD5CN+sFVIywEw54MGjfxhmQC74TaW9av8nXD50wicpjGifw/NMkhtmleLyaL9ZPHYI=
X-Received: by 2002:a05:690c:6f11:b0:6e2:ada7:ab89 with SMTP id
 00721157ae682-6e2c7036be1mr31002097b3.26.1728050516758; Fri, 04 Oct 2024
 07:01:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002125822.467776898@linuxfoundation.org> <20241002125838.303136061@linuxfoundation.org>
 <CADpNCvbW+ntip0fWis6zYvQ0btiP6RqQBLFZeKrAwdS8U2N=rw@mail.gmail.com>
 <2024100330-drew-clothing-79c1@gregkh> <A8D6C21F-ACAD-4083-900F-528EB3EB5410@oracle.com>
In-Reply-To: <A8D6C21F-ACAD-4083-900F-528EB3EB5410@oracle.com>
From: Youzhong Yang <youzhong@gmail.com>
Date: Fri, 4 Oct 2024 10:01:46 -0400
Message-ID: <CADpNCvbKGAVcD9=m_YxA6qOF6e0kohOfVsKOqJeVmrYaq0Sd8w@mail.gmail.com>
Subject: Re: [PATCH 6.11 397/695] nfsd: fix refcount leak when file is
 unhashed after being found
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-stable <stable@vger.kernel.org>, 
	"patches@lists.linux.dev" <patches@lists.linux.dev>, Jeff Layton <jlayton@kernel.org>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I applied 2/4, 3/4 and 4/4 on top of kernel 6.6.41 and tested it under
our work load, unfortunately leaks occurred. Here is what I got:

crash>  p nfsd_file_allocations:a | awk '{print $NF}' | perl -e
'while(<>){ $sum +=3D $_; } print $sum, "\n";'
114664232
crash> p nfsd_file_releases:a | awk '{print $NF}' | perl -e
'while(<>){ $sum +=3D $_; } print $sum, "\n";'
114664221

So yes, 1/4 is needed for fixing the issue.

On Thu, Oct 3, 2024 at 9:54=E2=80=AFAM Chuck Lever III <chuck.lever@oracle.=
com> wrote:
>
>
>
> > On Oct 3, 2024, at 3:19=E2=80=AFAM, Greg Kroah-Hartman <gregkh@linuxfou=
ndation.org> wrote:
> >
> > On Wed, Oct 02, 2024 at 10:12:32AM -0400, Youzhong Yang wrote:
> >> My understanding is that the following 4 commits together fix the leak=
ing issue:
> >>
> >> nfsd: add list_head nf_gc to struct nfsd_file
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D8e6e2ffa6569a205f1805cbaeca143b556581da6
> >>
> >> nfsd: fix refcount leak when file is unhashed after being found
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D8a7926176378460e0d91e02b03f0ff20a8709a60
> >>
> >> nfsd: remove unneeded EEXIST error check in nfsd_do_file_acquire
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D81a95c2b1d605743220f28db04b8da13a65c4059
> >>
> >> nfsd: count nfsd_file allocations
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D700bb4ff912f954345286e065ff145753a1d5bbe
> >>
> >> The first two are essential but it's better to have the last two commi=
ts too.
> >
> > So right now only the 2nd and 3rd are in the tree, do we really need th=
e
> > others as well?  And if so, why were none of these marked for a stable
> > inclusion?
>
> IMO 1/4 and 4/4 are not needed in stable, and that's
> why we marked them that way.
>
>
> --
> Chuck Lever
>
>

