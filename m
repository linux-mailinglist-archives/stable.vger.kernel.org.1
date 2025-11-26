Return-Path: <stable+bounces-196968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D6AC885BB
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 08:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74DD83B53C7
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 07:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118D327FD5B;
	Wed, 26 Nov 2025 07:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEXTSbGe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C57267AF6
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 07:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764140953; cv=none; b=D44khfhp+RaOYXaSLpAum2pgZWvjMy8ZflOTY4C8aVZUfW6o3L9E97KYgeveM/KVeG0DtTQ0b1ljFeE2uQqRSnNsRi610BR3ZBPerCr4MvLyGehHeWyAeD1QXVWkG40VH2vasC14dgHcGJoKIui3LjfUzUiEWxBbuyU1dcrMc4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764140953; c=relaxed/simple;
	bh=D81/U/r4ll/aJ46lwh5MjYT3sLwCXZh8GWYMYdx8Iik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ig2L1ctbne1Wd8ElePy9eNPmem7OEW25vYFsaT4YG2Gzf+Eff662J1aX++lp5AEMpGfJyfLA9HhlXZ2EPHV4m0F8CQJlEfFFjxU5Q3cbbcgGbduWWEqmVMZza/uVObB31loh6uigrYJ0ToZMgSeUoc9UpHNbQtTfMefylBSo3DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEXTSbGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42281C19422
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 07:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764140953;
	bh=D81/U/r4ll/aJ46lwh5MjYT3sLwCXZh8GWYMYdx8Iik=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nEXTSbGeDR/PNHwycuEXDvsQtIzib3DmjE1YTWaFbECGm6T7hbOtTTvN2vdEkHMA7
	 y5ASpjG+Inutm84t5SsyznW1QsoQGGaIXMgcvDzROkKZJKXQGHxURqGY7AZC8/5E62
	 xAgQtq94e5a80U9iJi6jucG7+RwMx5fH2eO8CW6U5Zfd0Opt9cB4+geruS5irDG5lA
	 +xJnuLsJl+1PHntNpF9VzxWJzrBq6UL/6v++1I5fKiDuNjL2ogK759WIdqC+9g81qp
	 4DbqdWoo7Lim2P5nfFHVh8+lA3gFJtEL+oJxLW0zffKdFnANNPGbunEQSmyLucb+Ux
	 8k5iL9P3+zedg==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b71397df721so313936066b.1
        for <stable@vger.kernel.org>; Tue, 25 Nov 2025 23:09:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVwDAH/nBe47MrvQNAvzlgJGkM9htxG8Q3MWSHjf3dRGWwY02HyFnr1cBB59LEl5B/akjcTDlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsneoQ2/EwktDi2LXQ6f12JNM529KnwfCX2yi8+i2dTpDk9SxP
	VCJ+iVVU5AxCZnjbcYhjLnWI1XHqYKT8DkyR/jMIQB6H9kZ3ENIc4QVf8t1JTHCOw/Tle5V8FWw
	MVz6Go65QPCE/toU9A8eOVA9tRR48rtw=
X-Google-Smtp-Source: AGHT+IEntSPkO8+ZDsOZT/nZua3PcaJiN8EYEyx0cfSy5NAMd+3VAXax17CQGCTirCAERp+Sb04uM2EZvGmVHYdfG/A=
X-Received: by 2002:a17:907:7f1b:b0:b4f:e12e:aa24 with SMTP id
 a640c23a62f3a-b76c53c3547mr535421866b.22.1764140951808; Tue, 25 Nov 2025
 23:09:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125082559.488612-1-chenhuacai@loongson.cn> <9c732952-2ff6-4672-ab9a-76ac8590bf88@app.fastmail.com>
In-Reply-To: <9c732952-2ff6-4672-ab9a-76ac8590bf88@app.fastmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 26 Nov 2025 15:09:16 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5m=oowvFLwbZKMDvWp3qPKCmKp5uoS4WU1XsAWzwWMmQ@mail.gmail.com>
X-Gm-Features: AWmQ_bk2gFzHkiCRAud-nVJQutbl2f7pk_UGKmDfKWV0Eqt6hPQydltN7smjh_I
Message-ID: <CAAhV-H5m=oowvFLwbZKMDvWp3qPKCmKp5uoS4WU1XsAWzwWMmQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Fix build errors for CONFIG_RANDSTRUCT
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, 
	Xuefeng Li <lixuefeng@loongson.cn>, Guo Ren <guoren@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, linux-kernel@vger.kernel.org, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, kernel test robot <lkp@intel.com>, Rui Wang <wangrui@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 9:49=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoat.co=
m> wrote:
>
>
>
> On Tue, 25 Nov 2025, at 4:25 PM, Huacai Chen wrote:
> > When CONFIG_RANDSTRUCT enabled, members of task_struct are randomized.
> > There is a chance that TASK_STACK_CANARY be out of 12bit immediate's
> > range and causes build errors. TASK_STACK_CANARY is naturally aligned,
> > so fix it by replacing ld.d/st.d with ldptr.d/stptr.d which have 14bit
> > immediates.
>
> Hi Huacai,
>
> What about 32bit build in this case?
Use the same solution as other registers, please see:
https://lore.kernel.org/loongarch/20251122043634.3447854-7-chenhuacai@loong=
son.cn/T/#u

Huacai

>
> Thanks
> Jiaxun
>
> >

