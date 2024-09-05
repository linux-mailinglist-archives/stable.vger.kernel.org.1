Return-Path: <stable+bounces-73128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F379B96CE45
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 07:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328FC1C2271B
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 05:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36817158D9C;
	Thu,  5 Sep 2024 05:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXmgNl9f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB6A158853
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 05:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725512458; cv=none; b=BUWF6d4/N8AU7En/vylt+30BY2JfwoXqcpr5rpTIRIHEkMdKQxZmkZA3kWZafR4Q+Cn51Y16VHv/MAp80/ZNiHR+ce87I17XsaHVI8qTHps3LnOkjHGwKNBom6jqFooHMTDGrmUXPlWEhrCHwvAo7Qod82kZ5NwBvwCI00kqJaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725512458; c=relaxed/simple;
	bh=Wv5Kk0LeNTuRHeczRYjQUdmtIoAX70LujmlvEI/jIF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u8fXra8Omxn06BeJ0S3htu6shxTqdyMWl2syqy8VHZgNMM02Oann9CIdxBE1dsRrGqgZkknSZN97u3mbsZJe1M88Lz17WQqMCgMXN2fF+n/syqLIJ7G0s5QSjW1V8qFjr2MFy3S3seqPBX8Khv55R65q+GZHsss5GIDxeIFYEjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXmgNl9f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846F0C4CEC4
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 05:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725512457;
	bh=Wv5Kk0LeNTuRHeczRYjQUdmtIoAX70LujmlvEI/jIF0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rXmgNl9f6iJjZ+SOPkuMIMhsquSfq2OblwnsdEKhAoUQ8/n/quJ4I38tVwcHKZb9P
	 M/ETZzwT+/YB6Q7vWOQGCUHRGbstEElhz81Dl2brSNrLhYqculnLDSWgo6lBVW8DVs
	 PTofTgicUnWa4KFQQvpjgnVr2tVZiKbNcRZ5TnUpqX+hJLopImNYtZzs0/A3Ur3ylB
	 urqapjvczCAfpn+QXBlCZKG/Mq+h6bqanPi2ujDqqq6+I008W262jga/cDRKFO4MRp
	 aSkYeSl4nXe1fxg1NO/n8zALdm3hDajMTseuWnFVRdFh684/RsB54SXQRTKf+bNPdh
	 Njjmmg/1wGiMA==
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a045f08fd6so108615ab.0
        for <stable@vger.kernel.org>; Wed, 04 Sep 2024 22:00:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUT+IoDHy03fVMA/WG6/PdrgWA9NdbLYHJGP7oqC/Gyx7bn8WnG7gZevlppfDZMHSYPpIlMafc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBO1+wGa3lTlTB4+g9alITEAs093MkJLR/G4eELuMDZlLge1IU
	zfkh89/LrbhYbppOFBnyj0r8EbuvAwbBpAyBQT0ApTQUmRzY6HKoBdaT1rjWjOHhW6XogNWAffz
	xempGWSNCjrALLTLj4xK28NTR+TaCYrjcJK8S
X-Google-Smtp-Source: AGHT+IFDBoIur5pix1vcCpgWhNewDPqGPR9thFq+HmC1zuxlXLSxQ4sUpDhQbT3jHAsSOYV9mgX/x3Y0D1FcdjsyApY=
X-Received: by 2002:a05:6e02:1605:b0:381:aa0b:3ccf with SMTP id
 e9e14a558f8ab-3a0475c88e0mr2417985ab.26.1725512456844; Wed, 04 Sep 2024
 22:00:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1719038884-1903-1-git-send-email-yangge1116@126.com>
 <CAF8kJuNP5iTj2p07QgHSGOJsiUfYpJ2f4R1Q5-3BN9JiD9W_KA@mail.gmail.com>
 <0f9f7a2e-23c3-43fe-b5c1-dab3a7b31c2d@126.com> <CACePvbXU8K4wxECroEPr5T3iAsG6cCDLa12WmrvEBMskcNmOuQ@mail.gmail.com>
 <b5f5b215-fdf2-4287-96a9-230a87662194@126.com> <CACePvbV4L-gRN9UKKuUnksfVJjOTq_5Sti2-e=pb_w51kucLKQ@mail.gmail.com>
 <00a27e2b-0fc2-4980-bc4e-b383f15d3ad9@126.com> <CAOUHufYi9h0kz5uW3LHHS3ZrVwEq-kKp8S6N-MZUmErNAXoXmw@mail.gmail.com>
 <CAMgjq7CLObfnEcPgrPSHtRw0RtTXLjiS=wjGnOT+xv1BhdCRHg@mail.gmail.com>
 <CAMgjq7DLGczt=_yWNe-CY=U8rW+RBrx+9VVi4AJU3HYr-BdLnQ@mail.gmail.com>
 <CACePvbXJKskfo-bd5jr2GfagaFDoYz__dbQTKmq2=rqOpJzqYQ@mail.gmail.com>
 <CACePvbWTALuB7-jH5ZxCDAy_Dxeh70Y4=eYE5Mixr2qW+Z9sVA@mail.gmail.com> <56651be8-1466-475f-b1c5-4087995cc5ae@leemhuis.info>
In-Reply-To: <56651be8-1466-475f-b1c5-4087995cc5ae@leemhuis.info>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 4 Sep 2024 22:00:44 -0700
X-Gmail-Original-Message-ID: <CAF8kJuMBMJCdmjwwPxWn44CDMSngB+uqNYERDU=xPAQYNPrbNQ@mail.gmail.com>
Message-ID: <CAF8kJuMBMJCdmjwwPxWn44CDMSngB+uqNYERDU=xPAQYNPrbNQ@mail.gmail.com>
Subject: Re: [PATCH V2] mm/gup: Clear the LRU flag of a page before adding to
 LRU batch
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Kairui Song <ryncsn@gmail.com>, Ge Yang <yangge1116@126.com>, Yu Zhao <yuzhao@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, 
	Barry Song <21cnbao@gmail.com>, David Hildenbrand <david@redhat.com>, baolin.wang@linux.alibaba.com, 
	liuzixing@hygon.cn, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thorsten,

On Mon, Sep 2, 2024 at 5:54=E2=80=AFAM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> for once, to make this easily accessible to everyone.
>
> Chris et. al., was that fix from Yu ever submitted? From here it looks

Not yet. Let me make a proper patch and add "suggested-by" Yu.

It is one patch I have to apply to the mm-unstable before stress
testing the swapping code. I even have a script performing the bisect
after applying this one line fix, so that I can hunt down the other
swap unstable patch.

> like fixing this regression fell through the cracks; but at the same
> time I have this strange feeling that I'm missing something obvious here
> and will look stupid by writing this mail... If that's the case: sorry
> for the noise.

Not at all. You did the right thing. Thanks for the reminder. I also
want to get rid of my one off private patch fix as well.

Chris

