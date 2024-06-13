Return-Path: <stable+bounces-50480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B0E906879
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28502281532
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 09:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F0813DDB2;
	Thu, 13 Jun 2024 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SItlG2Ri"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6993F13D8A6;
	Thu, 13 Jun 2024 09:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718270622; cv=none; b=emBH0VgRLElteu2d0vZZE58Qb7sy2CvqXjr6Umht0PkepTn3LGs43y5fl8Cbbw1CQtNG4dp/nMV9QRiLo9KiYfDXgJfK6mvDb7+XynJ5xChR6SSjQg6azFWlPgZOj6NlarJdV9RFxRznZVjcnBVOWSmQK0hcNnwiWcCoITJ5iOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718270622; c=relaxed/simple;
	bh=Gg+23UUXLD0QiiaYlgluUVs+RMApwPP3zSxNMn9RCpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L0ociuFTLLGB2NWWjF0c1Q3VmJG43fkXP+FfcdCO8qsZoFkJGS1vwujGIMLuNYx1RkLloQAqOMnBIGY/MVfHrHABvVvMazjuTgRmrjU30FuuZm715SoSbN2z3xtlOu51QNizrXFVnOF5nuvs1ODps3p+G7sCoTD1jjpDbAA2DFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SItlG2Ri; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52bc121fb1eso1123922e87.1;
        Thu, 13 Jun 2024 02:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718270618; x=1718875418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gg+23UUXLD0QiiaYlgluUVs+RMApwPP3zSxNMn9RCpk=;
        b=SItlG2Rion/AxFw875b25LMO0i/gdr8x/fx/Jwm3dqISZ0H1V0h7gdO8CuGdSB7N3L
         md4NPpaxY8ERJS4ZhP7NjkS/1CE6zz1y0KeYciEyhivEStt0wp6+D2uIll0JBCUtyuc3
         AMoqcT0AEoQ4Dd0Tytbwf4xR6wrJtxd8xcz7MbPUVcQpWsEI1nVPMmJLohul+X5YiFTg
         ET2I8rVBB4hDXLAdRin0K5fIDSr4XntYDtpKeVH9E1NxDzidCo1X93w9ebe5JhE9vrqe
         0YXMi3aljVqzVaPjQTIsanfXIk9FeJeLCwLXTespLQRS6YROGtN9umbve/IpdsLxKg9D
         tZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718270618; x=1718875418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gg+23UUXLD0QiiaYlgluUVs+RMApwPP3zSxNMn9RCpk=;
        b=JDLntu9+kzNFVw4RXge6eR5rK/u5EkSwZntS9marEev8XcRn6zWXf9RaBnm2GDhm5u
         ZF6wfM8vhULcgY8Y0ttQza/6+9p2F+p2LPnr8TtXegJvbIrsv7sLFMpiY59LWACh4QpR
         4XX82sCwu0wfFH3Of+gMAQTXHZcLkl+5lFkl66mPoL8S9d7ttiXs3JZSqU8xgrAaQVm1
         jZBwG1IfQCXh95hRThERpIYv99kbRC0ovQtWHwzcAJuDLvTe+t7/rEpmaTHsyhX3jA/3
         vBRmLecmS5lnYhmCJIuR0q7lwwbZrjsJinjR2FtqSyPIl3HLxam8UnH5QJY5JeV7kTx/
         qsrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKSr5GsCTF/RhSMJVtS7Jhj8YMkRCL3tdfwim7dvU+IofES+84MXgeDjiaIJ/9EMFYaL+khO1fPto2MrrF7E4XXYSdLrS6YdLEI/w3kdIeKRHjm6xR+d73y4hDWXfsGiDVw1pz
X-Gm-Message-State: AOJu0YxBdy4nD4U7hFgQgYQ+j+F5d7cxRSEU4CcLFfzF5cnGXVNkcQyX
	cpZJT9SZxv42CPknXmsabiuQ82z2b4qq2xbHXTC3IxF/X53VWOmF9VJRZYcHSPFnfDbxohBb0Iv
	WWwnwHguyG58987527t7700RHzNg=
X-Google-Smtp-Source: AGHT+IHNHTBRcHOOmC217Up4Ka0WkhyYvVN+oWQ2WndOVDn1z0YjAqT/Ba384DNdoh/dvoO13r92M/g7kfJ30eTfu7U=
X-Received: by 2002:a19:ad09:0:b0:529:b79f:ab1d with SMTP id
 2adb3069b0e04-52c9a3c6cefmr2451182e87.22.1718270618150; Thu, 13 Jun 2024
 02:23:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607023116.1720640-1-zhaoyang.huang@unisoc.com>
 <CAGWkznEODMbDngM3toQFo-bgkezEpmXf_qE=SpuYcqsjEJk1DQ@mail.gmail.com>
 <CAGWkznE-HcYBia2HDcHt6trM9oeJ2x6KdyFzR3Jd_-L5HyPxSA@mail.gmail.com>
 <ZmiUgPDjzI32Cqr9@pc636> <CAGWkznGnaV8Tz0XrgaVWEVG0ug7dp3w23ygKKmq8SPu_AMBhoA@mail.gmail.com>
 <ZmmGHhUDk5PqSHPB@pc636> <ZmqwvtZQwYLNYf+V@MiWiFi-R3L-srv> <20240613091106.sfgtmoto6u4tslq6@oppo.com>
In-Reply-To: <20240613091106.sfgtmoto6u4tslq6@oppo.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Thu, 13 Jun 2024 17:23:26 +0800
Message-ID: <CAGWkznEJgUZ6bsuhb0Q+3-Jny+AGxPpaBnSmJJqoWz-mgU43sQ@mail.gmail.com>
Subject: Re: [Resend PATCHv4 1/1] mm: fix incorrect vbq reference in purge_fragmented_block
To: hailong liu <hailong.liu@oppo.com>
Cc: Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>, 
	"zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 5:11=E2=80=AFPM hailong liu <hailong.liu@oppo.com> =
wrote:
>
> On Thu, 13. Jun 16:41, Baoquan He wrote:
> > On 06/12/24 at 01:27pm, Uladzislau Rezki wrote:
> > > On Wed, Jun 12, 2024 at 10:00:14AM +0800, Zhaoyang Huang wrote:
> > > > On Wed, Jun 12, 2024 at 2:16=E2=80=AFAM Uladzislau Rezki <urezki@gm=
ail.com> wrote:
> > > > >
> > > > > >
> > > > > > Sorry to bother you again. Are there any other comments or new =
patch
> > > > > > on this which block some test cases of ANDROID that only accept=
 ACKed
> > > > > > one on its tree.
> > > > > >
> > > > > I have just returned from vacation. Give me some time to review y=
our
> > > > > patch. Meanwhile, do you have a reproducer? So i would like to se=
e how
> > > > > i can trigger an issue that is in question.
> > > > This bug arises from an system wide android test which has been
> > > > reported by many vendors. Keep mount/unmount an erofs partition is
> > > > supposed to be a simple reproducer. IMO, the logic defect is obviou=
s
> > > > enough to be found by code review.
> > > >
> > > Baoquan, any objection about this v4?
> > >
> > > Your proposal about inserting a new vmap-block based on it belongs
> > > to, i.e. not per-this-cpu, should fix an issue. The problem is that
> > > such way does __not__ pre-load a current CPU what is not good.
> >
> > With my understand, when we start handling to insert vb to vbq->xa and
> > vbq->free, the vmap_area allocation has been done, it doesn't impact th=
e
> > CPU preloading when adding it into which CPU's vbq->free, does it?
> >
> > Not sure if I miss anything about the CPU preloading.
> >
> >
>
> IIUC, if vb put by hashing funcation. and the following scenario may occu=
r:
>
> A kthread limit on CPU_x and continuously calls vm_map_ram()
> The 1 call vm_map_ram(): no vb in cpu_x->free, so
> CPU_0->vb
> CPU_1
> ...
> CPU_x
>
> The 2 call vm_map_ram(): no vb in cpu_x->free, so
> CPU_0->vb
> CPU_1->vb
> ...
> CPU_x
Yes, this could make the per_cpu vbq meaningless and the VMALLOC area
be abnormally consumed(like 8KB in 4MB for each allocation)
>
> --
> help you, help me,
> Hailong.

