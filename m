Return-Path: <stable+bounces-189178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E241DC03F8B
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 02:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E590A4E73F3
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 00:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5953F78F4B;
	Fri, 24 Oct 2025 00:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPyCg07/"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966C312CD8B
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 00:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761266843; cv=none; b=QTRFYS1LcliW8IgcWTIzkFVOD5cd9MsrkCOPL5QaBk/K8nSM3iKpZihibATMyupRyD5b5W04sM/iiDYf8yylo/N+uOiu4wNdMHm3OrEh248G2ZHBpJOv7kMD9Fg2Lnest7Zptm3iNqUMXKw4MIavshvWkXz6I7xXcLan0wB7aXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761266843; c=relaxed/simple;
	bh=8dekchQfMYsPgwmIHu1U8iRd6IWXI+KU+TikQrx5aks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CjPJZqkhFxJiIA9OXmztZhejIKM1e73EIQZcdLW0/d2dWmcwovSGhK4vVVtzTw+vR6w80YufPIa8mO9Giu0scInm8DB65tYWPCCFLY6+vv9LGdPKhK1/q8T/jstmegsdgiAamFQd1JAljhB8eQ2gqSHqGHDzOAdR1XEMP59CFdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPyCg07/; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8901a7d171bso146344285a.1
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 17:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761266840; x=1761871640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dekchQfMYsPgwmIHu1U8iRd6IWXI+KU+TikQrx5aks=;
        b=KPyCg07/6NdhcIpy/Mz7mQj5L1sQId9Ulr0/rtDT97281k9S405zuQ0NMlLo+b4zo5
         k0rLwXb8eoUyNP/0K3LjX+jKuWg4UE2rUGPMpQQKMq+F+FBA+W7ovTgPwf/+k4TDKh51
         91g9YD6F29iJAgbJwUwxr/J6qLTvexe0EmAaZgpOpt1esC4c8PuQ3tB7MoLF54+WoT0r
         bX44Zv0m0pUsFunGpRgxGu4gpRcsxoAd6dyQWk1iDmkENMn8Ssit1WQSTRGAZ2URKp4m
         6l5pKTfJdLNrpKlHaFmcfd8WRRBVaVMgKJkV+e+LyQZ3W3Xz2W2IsJoRj+67n8M4/aKt
         DKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761266840; x=1761871640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8dekchQfMYsPgwmIHu1U8iRd6IWXI+KU+TikQrx5aks=;
        b=Pz9zfH0LAPaw4QjOntwPVxYjwpWEuGBhG+aH3M6cAF/8WgpFwyO7fvSR/bxf/MSkvs
         3/atVCuYNVaVsvTHDjfzodTSp4WKso/ieSXjuHbo0K1uPIcfbjMbNJIGj9mZeG+5pexL
         /4YASlYjS9y6G1HoEsFhBmim217bZdySRILYSGVvIKhLkEg+3qw0A5FnJtGH9y2kfkBm
         0sevbCiP6Zm3ijItjIf29od1b3Z3Mj4SrlN/fPWjfbMTIewx9wP5kNASTZHfUqsdj0iP
         ppwonwFwRAKrL1prYvG9Ho8FAZt7JprCHk8YB/CSt99XVjRKDQXIKgjzMzh4YmsnOZSK
         3ceQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmF6d94UpdiF28LQEsRCGxQ+uXaew+EqZV/FaC7shLujOn62TPjXgls+Jam7lq29EEHKy32ek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/abwIqAzq9dx9enVmnNXe040t0yidGp4/ZjVJI652cm8n7Z+6
	v3xLXgcCAbfIci3g4IVf8E9IBGuOby9ITpdk3W0y619vbGTTEzjZwPOSRKVCgTV6vb28jgZCBl4
	dn8xtTL0D21q843QHPf0dU2mFDW6K4Vw=
X-Gm-Gg: ASbGncvvUd+speKl9d+cM1TMHsfEMCrbg0iC5auPp8nsH1aERB3LuhEcloJ8Nzz4mHZ
	BXaQgb5qPvcw7n+WdHqzRwkUiYsSkEEmhRj/WawoRSjwalu0APR9QZ77y9PY9rB5TII2+9RtLG1
	eKJl/GQh1PDiiiqYkmcutk4cT4VRuoHAzu1MJvT7aHuMRC7JT5PtTDOhKP3uq8TKB4YqQD4hh2P
	Ct3fdKo+YDQIBAdjeyL5vVsFe9LAa7+pBgBGYO0HomIHvqxRSt8ncE1qBtILRnBLDUGPqKChDpd
	ryxBo8pOxSDk+WKjfbQxtDEvRCU=
X-Google-Smtp-Source: AGHT+IGokajvF01sX9F7KXkvDGH2BAi4A0xlPGkcF5m+/FFCBakkYwkQlnjuvwYu0COErqKt6mUfvQXhm2R9aA7CSo0=
X-Received: by 2002:a05:620a:4510:b0:892:624f:7f74 with SMTP id
 af79cd13be357-892624f836fmr2622571385a.28.1761266840350; Thu, 23 Oct 2025
 17:47:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023065913.36925-1-ryncsn@gmail.com> <774c443f-f12f-4d4f-93b1-8913734b62b2@redhat.com>
 <f0715f2c-ee27-4e13-84d0-5df156410527@redhat.com> <CAMgjq7Chg6e_xL4wxYJqMzmCRENawQ63KSABrZ9zVbR4ET=YFA@mail.gmail.com>
In-Reply-To: <CAMgjq7Chg6e_xL4wxYJqMzmCRENawQ63KSABrZ9zVbR4ET=YFA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 24 Oct 2025 08:47:08 +0800
X-Gm-Features: AS18NWCj9MGFG1npl-3BLgwz1S4LiopMlEcRzQLs-xgJmd9nWQbr_QcVvyIi32Q
Message-ID: <CAGsJ_4wQ_9xTHxbRsipir7aiEdjeUNnYO5Xy67tRcFTQxfpZhQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm/shmem: fix THP allocation and fallback loop
To: Kairui Song <ryncsn@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins <hughd@google.com>, 
	Dev Jain <dev.jain@arm.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Mariano Pache <npache@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> >
> > Answering my own question, the "Link:" above should be
> >
> > Closes:
> > https://lore.kernel.org/linux-mm/CAMgjq7DqgAmj25nDUwwu1U2cSGSn8n4-Hqpgo=
ttedy0S6YYeUw@mail.gmail.com/
> >
>
> Thanks for the review. It's reported by and fixed by me, so I didn't
> include an extra Report-By & Closes, I thought that's kind of
> redundant. Do we need that? Maybe Andrew can help add it :) ?

I also think it=E2=80=99s better to use =E2=80=9CCloses:=E2=80=9D. In that =
case, we might need
to slightly
adjust the commit log to remove "[1]" here.

" This may result in inserting and returning a folio of the wrong index
 and cause data corruption with some userspace workloads [1]."

With that,
Reviewed-by: Barry Song <baohua@kernel.org>

Thanks
Barry

