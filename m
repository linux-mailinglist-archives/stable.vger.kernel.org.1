Return-Path: <stable+bounces-108659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBBFA1165E
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 02:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D87D188774A
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 01:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7779835976;
	Wed, 15 Jan 2025 01:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eWEkpt4+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D73B35960;
	Wed, 15 Jan 2025 01:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736903447; cv=none; b=O5KX2b3clv1x3AeUELuyksRwJf2fk2ntPXWpjpGOXI/izxtyAFAIydLn4uuBWMABAkTZBkyfsImt23XAk33vraf+Otpxj9ZlT09U89KGGLKGM3sUHE7527HaGbm/ZgVV0NA9TeDUfXVdplcrfXqotWEAk5HaiKido36KvunVNTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736903447; c=relaxed/simple;
	bh=CVZEHx6Eh830JyI4aKceXPSCIH8O/uVKjeo6hr322K0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MCtAPnWcmPEMkwVcckB3eGsooMhd2xt/QeM9sDXDurWLzsZwlFfraPuACtBh9DAcyH904bKEH8z3PxauT5uO6jbzepfvLjZEP0KTBjT57GVIlXSA8vk8gA0ZU2ey6K5fphcq+0HMeVFiTi4sFEEUIWR3l6E6mLn9qwgCDbZB9Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eWEkpt4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC50C4CEDD;
	Wed, 15 Jan 2025 01:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1736903446;
	bh=CVZEHx6Eh830JyI4aKceXPSCIH8O/uVKjeo6hr322K0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eWEkpt4+9LYfkwGuv6PXIk3wA7xv/c06xCt6oTLN4TNojw1EUKQ/IqoJCmdL0h531
	 MZkEtJUcydBHl7qmoNHiDEv3TywWqm4MU9gIXG/rdE9jNpnzZhOZjKbZaCsvzgEzFx
	 X1r+iSoPq0OMilQ3Nmdw+5XAbauGxKMAZP4SbrO0=
Date: Tue, 14 Jan 2025 17:10:45 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: kent.overstreet@linux.dev, yuzhao@google.com, 00107082@163.com,
 quic_zhenhuah@quicinc.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] alloc_tag: skip pgalloc_tag_swap if profiling is
 disabled
Message-Id: <20250114171045.e5fadb8db51902ee0181fa0b@linux-foundation.org>
In-Reply-To: <CAJuCfpHu=nzDNMSFUuxze7V8NDahKPgO6YdF7pk9W8VDC4ME4g@mail.gmail.com>
References: <20241226211639.1357704-1-surenb@google.com>
	<20241226211639.1357704-2-surenb@google.com>
	<20241226150127.73d1b2a08cf31dac1a900c1e@linux-foundation.org>
	<CAJuCfpFSYqQ1LN0OZQT+jU=vLXZa5-L2Agdk1gzMdk9J0Zb-vg@mail.gmail.com>
	<20241226162315.cbf088cb28fe897bfe1b075b@linux-foundation.org>
	<CAJuCfpG_cbwFSdL5mt0_M_t0Ejc_P3TA+QGxZvHMAK1P+z7_BA@mail.gmail.com>
	<20241226235900.5a4e3ab79840e08482380976@linux-foundation.org>
	<CAJuCfpHJ7D0oLfHYzb9jvktP4X6O=ySGe7CK7sZmVNpSnzDeiQ@mail.gmail.com>
	<CAJuCfpHu=nzDNMSFUuxze7V8NDahKPgO6YdF7pk9W8VDC4ME4g@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jan 2025 08:38:37 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> > > Well, a 50% reduction in a 0.0000000001% overhead ain't much.
> >
> > I wish the overhead was that low :)
> >
> > I ran more comprehensive testing on Pixel 6 on Big, Medium and Little cores:
> >
> >                  Overhead before fixes            Overhead after fixes
> >                  slab alloc      page alloc          slab alloc      page alloc
> > Big               6.21%           5.32%                3.31%          4.93%
> > Medium       4.51%           5.05%                3.79%          4.39%
> > Little            7.62%           1.82%                6.68%          1.02%
> 
> Hi Andrew,
> I just noticed that you added the above results to the description of
> this patch in mm-unstable: 366507569511 ("alloc_tag: skip
> pgalloc_tag_swap if profiling is disabled") but this improvement is
> mostly caused the the other patch in this series: 80aded2b9492
> ("alloc_tag: avoid current->alloc_tag manipulations when profiling is
> disabled"). If this is not too much trouble, could you please move it
> into the description of the latter patch?

No probs, done, thanks.

