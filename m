Return-Path: <stable+bounces-141962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F16AAD3AF
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 05:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C39281BA11DF
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 03:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316C018FC92;
	Wed,  7 May 2025 03:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-sg.20230601.gappssmtp.com header.i=@starlabs-sg.20230601.gappssmtp.com header.b="tlOZJKqG"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D62118952C
	for <stable@vger.kernel.org>; Wed,  7 May 2025 03:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746586823; cv=none; b=MqyXaQDL5QmX1wC4apY+ORuvlp+l7b0BokXWOJ/dMe0GQ58y/URd1WHBTxzlZ7IdaOhcHmOCauhF6CARI9EPLL26UYipcXiLNx0jV788/WbcVlZ9ZjLcZWssenOXYCwwNcPXR6iQlXFqhpUtoP/f7bmEcY+4llMFspiVaa2nejY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746586823; c=relaxed/simple;
	bh=5JDagOBJhi69/Z0miRzYPNWtGi/LGnLQuCjRfdTjCTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKLwpefWinFicwolJ3Kf0bqMfaEEWJeX/GKtIaNMyZ823w5nCQsff/8V57QphK/l7XQV57mOIr8dbI5aEzh0609XuIeMTonO75buF72ZbG1C+OR9WAZ+ZnIl8Zayva9vpcTpTdpY8O4yxiw/EmzVACUEXel7fJfCo1R4s0TPFHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starlabs.sg; spf=pass smtp.mailfrom=starlabs.sg; dkim=pass (2048-bit key) header.d=starlabs-sg.20230601.gappssmtp.com header.i=@starlabs-sg.20230601.gappssmtp.com header.b=tlOZJKqG; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starlabs.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.sg
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54e816aeca6so8320624e87.2
        for <stable@vger.kernel.org>; Tue, 06 May 2025 20:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-sg.20230601.gappssmtp.com; s=20230601; t=1746586816; x=1747191616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JDagOBJhi69/Z0miRzYPNWtGi/LGnLQuCjRfdTjCTY=;
        b=tlOZJKqGdkdjXltlXRjJVHoXhFoRisUY4zZoEQE+1xR6spPsrvTy9v7xvG+QbABHVI
         By3urrpfo5L1YQgX+edZcdldYsaJiPejYiXLglDrBriN1WNWOTBV5a+BuLJnVIrk70pc
         O+a80DX6mMd1z32vqoDnbFO13RorPUtcSD7suXAVrTVReX9ls8ma2w8pBBSywIF5SxTn
         3k32jL0iqmG2glqElJK9nf0U6CcFs5Sr+E/pTmE6XoJO3ZDJ29hdbmuUdCVfFSuyWMrl
         Byn30Rzn9R8gP+WIPdgjrCCGj5UlN8JGrfBsSau4hNCEjNkPYrfl0VgjnYjQv8cWUDrd
         wQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746586816; x=1747191616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JDagOBJhi69/Z0miRzYPNWtGi/LGnLQuCjRfdTjCTY=;
        b=uJvgy+iBYS5RAT4fsZj3C983xQ+9mbcUwSO9Xc46kmy8DwLyU5BRKVl/o0XEdqpO7+
         HJhD7R8UxGATAoIAspL6HbjuSPSMrll/wgG+S16eUAAaWk7e6yKGhBPnyAdlKc9mjeZ3
         V1NsR9qPHnB6GVKJnNywMGa63x9dLrRMGtRmtj/6He3uf94c/FF17N0HiC4u7pjVUwQT
         gvYjp2XFLGTwamEhVx5io5PeJdAaCtagmgg2FYB+uPzeHe/CWP5uXQMQBdGvJ66DcO1y
         D9bjJspbcVZ7LhZkoh7XMfRBI/74Q6BlRcjQoWqrsmsmeskfUOatwIAneb+hjNsaryf6
         siMA==
X-Gm-Message-State: AOJu0YzfJWBuYt7cJYn74epm2wNPZ4NWAYWNi+OGBLPMs/sQsBvLVyuP
	9dgLN3+bpG0ifOUAKNooUZD3tn2rvmfBmN4oqpfeU5NvTx9dPKLMOopbivPy4hz32dq7Gv/9M52
	BPLkt6LZh1uq/pWgBeqLBecyycdrWrzN3v9IAaGCeMCPGS8tSQQg=
X-Gm-Gg: ASbGncvmwyZkCIlwW5iCfWU4bML4CDUypR7IcDx7owxUfoqPYy17UE8z1nSyFGOryc5
	YTQDvqPchsvFBwZfZd9IXX2Au7CWVWVIpmaWIIjnMx3aMRdlaCHkhPronU6iVzsnPf/XJNT0Xye
	4Ag/AigOxFrKAGger79vT2hd5Y
X-Google-Smtp-Source: AGHT+IH+GRV7N1UIr5FtQt5I+kjU/jZEEl/lAOfID68gVGxwYmTKC5QxaGQMqFIA/UkDgI9HyoPcAoraNJBmboK+hyo=
X-Received: by 2002:a17:907:1b05:b0:abf:7453:1f1a with SMTP id
 a640c23a62f3a-ad1e8c524a6mr173897366b.36.1746586805626; Tue, 06 May 2025
 20:00:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHcdcOkW1D_zKh-HPsfjX-oGYhv-OwojPXVwcA=NYoO0hcCbZQ@mail.gmail.com>
 <2025050519-stem-fidelity-25b1@gregkh>
In-Reply-To: <2025050519-stem-fidelity-25b1@gregkh>
From: "Tai, Gerrard" <gerrard.tai@starlabs.sg>
Date: Wed, 7 May 2025 10:59:53 +0800
X-Gm-Features: ATxdqUHqYIbPstDEIaQN0aaQiKYxtgLr1_9QylxIxA0iyVxaPBUw62bO1vjlDEc
Message-ID: <CAHcdcOkMt_Mpcm1AjxbU8MurGO5e--LPPJOrSTA+utDOzVHE3g@mail.gmail.com>
Subject: Re: net/sched: codel: Inclusion of patchset
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Cong Wang <xiyou.wangcong@gmail.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 5:28=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, May 02, 2025 at 12:49:48PM +0800, Tai, Gerrard wrote:
> > Upstream commits:
> > 01: 5ba8b837b522d7051ef81bacf3d95383ff8edce5 ("sch_htb: make
> > htb_qlen_notify() idempotent")
> > 02: df008598b3a00be02a8051fde89ca0fbc416bd55 ("sch_drr: make
> > drr_qlen_notify() idempotent")
> > 03: 51eb3b65544c9efd6a1026889ee5fb5aa62da3bb ("sch_hfsc: make
> > hfsc_qlen_notify() idempotent")
> > 04: 55f9eca4bfe30a15d8656f915922e8c98b7f0728 ("sch_qfq: make
> > qfq_qlen_notify() idempotent")
> > 05: a7a15f39c682ac4268624da2abdb9114bdde96d5 ("sch_ets: make
> > est_qlen_notify() idempotent")
> > 06: 342debc12183b51773b3345ba267e9263bdfaaef ("codel: remove
> > sch->q.qlen check before qdisc_tree_reduce_backlog()")
> >
> > These patches are patch 01-06 of the original patchset ([1]) authored b=
y
> > Cong Wang. I have omitted patches 07-11 which are selftests. This patch=
set
> > addresses a UAF vulnerability.
> >
> > Originally, only the last commit (06) was picked to merge into the late=
st
> > round of stable queues 5.15,5.10,5.4. For 6.x stable branches, that sol=
e
> > commit has already been merged in a previous cycle.
> >
> > >From my understanding, this patch depends on the previous patches to w=
ork.
> > Without patches 01-05 which make various classful qdiscs' qlen_notify()
> > idempotent, if an fq_codel's dequeue() routine empties the fq_codel qdi=
sc,
> > it will be doubly deactivated - first in the parent qlen_notify and the=
n
> > again in the parent dequeue. For instance, in the case of parent drr,
> > the double deactivation will either cause a fault on an invalid address=
,
> > or trigger a splat if list checks are compiled into the kernel. This is
> > also why the original unpatched code included the qlen check in the fir=
st
> > place.
> >
> > After discussion with Greg, he has helped to temporarily drop the patch
> > from the 5.x queues ([2]). My suggestion is to include patches 01-06 of=
 the
> > patchset, as listed above, for the 5.x queues. For the 6.x queues that =
have
> > already merged patch 06, the earlier patches 01-05 should be merged too=
.
> >
> > I'm not too familiar with the stable patch process, so I may be complet=
ely
> > mistaken here.
>
> I'll be glad to take what is needed, but please list what commits need
> to go to what branches and in what exact order please.

Here's the list of commits. The order should be the sequence as listed
below.

6.14, 6.13, 6.12, 6.6, 6.1: (all 6.* branches)
5ba8b837b522d7051ef81bacf3d95383ff8edce5 ("sch_htb: make
htb_qlen_notify() idempotent")
df008598b3a00be02a8051fde89ca0fbc416bd55 ("sch_drr: make
drr_qlen_notify() idempotent")
51eb3b65544c9efd6a1026889ee5fb5aa62da3bb ("sch_hfsc: make
hfsc_qlen_notify() idempotent")
55f9eca4bfe30a15d8656f915922e8c98b7f0728 ("sch_qfq: make
qfq_qlen_notify() idempotent")
a7a15f39c682ac4268624da2abdb9114bdde96d5 ("sch_ets: make
est_qlen_notify() idempotent")

5.15, 5.10, 5.4: (all 5.* branches)
5ba8b837b522d7051ef81bacf3d95383ff8edce5 ("sch_htb: make
htb_qlen_notify() idempotent")
df008598b3a00be02a8051fde89ca0fbc416bd55 ("sch_drr: make
drr_qlen_notify() idempotent")
51eb3b65544c9efd6a1026889ee5fb5aa62da3bb ("sch_hfsc: make
hfsc_qlen_notify() idempotent")
55f9eca4bfe30a15d8656f915922e8c98b7f0728 ("sch_qfq: make
qfq_qlen_notify() idempotent")
a7a15f39c682ac4268624da2abdb9114bdde96d5 ("sch_ets: make
est_qlen_notify() idempotent")
342debc12183b51773b3345ba267e9263bdfaaef ("codel: remove
sch->q.qlen check before qdisc_tree_reduce_backlog()")

Cheers,
Gerrard

