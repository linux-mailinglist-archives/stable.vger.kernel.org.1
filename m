Return-Path: <stable+bounces-148095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA3FAC7DBD
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 14:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 132B61C03E12
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 12:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B032222C1;
	Thu, 29 May 2025 12:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEYp5lcB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EA41B21BF;
	Thu, 29 May 2025 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748521873; cv=none; b=IqJ1slPDm1Kesy8liT81WEJizEXVNSR/Q24uH78iEYsRQ5nAGfxO3nCujezTXsdtq4aUVHO7V8+BDq75piTjrAJcP5fgnOzdBOkGNIug3iZ25TxDua9sOkIUn3K6k2A+cLXkCedD+eLcgwktwF3SAAtUGwVp3wiOY7gopjwPnQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748521873; c=relaxed/simple;
	bh=GmoWsPXXNONnNCn/pziHPId+sw7VHnYucb263mI8g+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6c1xt+3eFvrCNrWS0dDytUhZ+3Q8BC+3usygc2aYAZuzP018XjMDJZ5v8vjvPbVTL8q8HiDTGI5GdcTih7pDzeWZJUAk82HlrEPwCp7otoAqYrfux7Bl6MJ7Ig3yGdkfPk1/QLeIx/LoF6cwBxRqCMpohwT147tm1DTN0lGRUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEYp5lcB; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-afc857702d1so661955a12.3;
        Thu, 29 May 2025 05:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748521871; x=1749126671; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tq1cwOPaR4vKxoX32nv3/DyAYjBA3wRhSPzfXs5sjXU=;
        b=mEYp5lcBCU/cbats7ME726Kz8efkMLJRlTeNrvuRXZ8aDKEwpLvLnbh+8Uv/7G4riC
         p9BBCGkJouV2pWJw7XromVMzH3Ei32CfSHIzsCBFyPl/evNwvy7nc/mgk29iH2Yx3qXr
         61zEis9ETF3LGOrGVxZTlu1cOYt1xKFRAsvCkf1dVVCw8umn8E2eeL+902ojAsAxtu9e
         mvTwy7TLHQnT98lK2soDbvBRpG3cxJTt1U5PIqViJOOTH7yyuGi/+U1T/Mwqt63cTBqq
         lAMyH++h80TuvLxKQz2QcunMFWNWPw3MeWqCj/FsxLMMmsY+vLjg+DPEo5r7MyJwfkAE
         hPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748521871; x=1749126671;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tq1cwOPaR4vKxoX32nv3/DyAYjBA3wRhSPzfXs5sjXU=;
        b=EFyaZ0KsI5XwXX1vlvq746R2RmNaugoezvJ9wDtGaKgcXhn9JR+TLD30e/VJA9OFBs
         41mtCxaLXjmSzaK8leymKVIQQAQ7JMV9uHsyj0YrZwC5RiTF4IAw1eT/F9SnxPfFHW8N
         k4aEOGY/x7er2UVDosVPzYFinW9Ok9Gmtc2YTCGi9WSenOVTAKmfpJFlh31IfVM6sK0H
         KNur9ZqhtCoT9IWw7Mtc0VVywJKMcPoyb06CYN3YzR08b4dc3QnmTwf5yxQT88b5s7v1
         ZZtkATNZs67JWKWSGIEj8pla54TYH0jA7KF4ld0Ks8Oiq7CHNRBJmEgNrfvRCMju/erd
         hOkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpKX22mbR/yWm2PJme0sBc++R7MH8+lq/mQU0lic4BbcUwjtWQS6pIVCngKroRTWdIVYrLeGjcvA4odSg=@vger.kernel.org, AJvYcCV+NHmI6jpsy+XyBcfEdIoAw96QUHZbctIgBrCOOQCweZFsI0kcy8P9Pz3qgB73e3mAqAG/Xxn2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9g94fjtt1oMSNsi2IXliI6yRjEClGNxUACTdRtuGMViRH9ZL6
	LQV1s+sBRlic7w8Lto4WkbeEHRKvkChvFAmdIpn0Cp2OCmfvNiy8LEu22Zxc0HI4vGk53dBQcIq
	iBTe1v73AwFDsEi1kq0043sMdaW5FXNc=
X-Gm-Gg: ASbGnct6Bzf6ygi5VtjYTGCAlSbaQQjS8spP9Rsq8J/5r5aAEpczF1dzJoQ7Ysk1QWf
	ZMsIuqDESswY2D88hJ2i5e17NgK4ZbHFWtB0lMp9Wb/cIxnzekXIadZW8n+zep6UqzEU5DQUbIg
	LXXVDAgU/TSJ8+eqAUfaYqGTxrZz7jRLBwbIFuRRAaRN1ZmoK/zr7O97llxLieMOStsmmSDVYZf
	WxM
X-Google-Smtp-Source: AGHT+IGp4zLKOpGdYRvmDVdlnQvGHcsBhKQmRHDUVcglWg+1oqojMwVl/cOxeFOXeuqJpSpTyoxtX5MLpnOMxIiVSSs=
X-Received: by 2002:a17:90b:2e83:b0:312:1516:5ef1 with SMTP id
 98e67ed59e1d1-3121dc21454mr3407822a91.7.1748521870864; Thu, 29 May 2025
 05:31:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529103832.2937460-1-kirill.shutemov@linux.intel.com>
 <7ae9e9f9-80e7-4285-83f0-a0946d238243@suse.cz> <ow3adiccumedegsm4agxlvaiaq3ypeto42hxr4ln6v3zzluhyu@2cdoez7of6ic>
 <scchmajjawfmmoreihui4yyzuyutzf3evhmmx2j4f2lhu6r62n@ovaamezmqgun>
In-Reply-To: <scchmajjawfmmoreihui4yyzuyutzf3evhmmx2j4f2lhu6r62n@ovaamezmqgun>
From: Konstantin Khlebnikov <koct9i@gmail.com>
Date: Thu, 29 May 2025 14:30:58 +0200
X-Gm-Features: AX0GCFuljSryuZeYsXkIUeJyWk2K7LZ8ro-jiJpu63bVcI17YSh4usFoQKWXwyE
Message-ID: <CALYGNiMBP5C0-6c_3MXpAEswYn8P6CH4eG3Kr5asu70uJg+CXg@mail.gmail.com>
Subject: Re: [PATCH] mm: Fix vmstat after removing NR_BOUNCE
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Hongyu Ning <hongyu.ning@linux.intel.com>, 
	stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 May 2025 at 12:51, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Thu, May 29, 2025 at 01:47:10PM +0300, Kirill A. Shutemov wrote:
> > On Thu, May 29, 2025 at 12:40:21PM +0200, Vlastimil Babka wrote:
> > > On 5/29/25 12:38, Kirill A. Shutemov wrote:
> > > > Hongyu noticed that the nr_unaccepted counter kept growing even in the
> > > > absence of unaccepted memory on the machine.
> > > >
> > > > This happens due to a commit that removed NR_BOUNCE: it removed the
> > > > counter from the enum zone_stat_item, but left it in the vmstat_text
> > > > array.
> > > >
> > > > As a result, all counters below nr_bounce in /proc/vmstat are
> > > > shifted by one line, causing the numa_hit counter to be labeled as
> > > > nr_unaccepted.
> > > >
> > > > To fix this issue, remove nr_bounce from the vmstat_text array.
> > > >
> > > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> > > > Fixes: 194df9f66db8 ("mm: remove NR_BOUNCE zone stat")
> > > > Cc: stable@vger.kernel.org
> > > > Cc: Christoph Hellwig <hch@lst.de>
> > > > Cc: Hannes Reinecke <hare@suse.de>
> > > > Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > > > Cc: Jens Axboe <axboe@kernel.dk>
> > >
> > > Is there a way to add a BUILD_BUG_ON to catch a future case like this one?
> >
> > There's
> >
> >       BUILD_BUG_ON(ARRAY_SIZE(vmstat_text) < NR_VMSTAT_ITEMS);
> >
> > in vmstat_start().
> >
> > Making it strict != seems to do the trick for my config. But it requires
> > wider testing.
> >
> > I can prepare a patch for that.
>
> There was a strict check before 9d7ea9a297e6 ("mm/vmstat: add helpers to
> get vmstat item names for each enum type"). Not sure if changing != to <
> was intentional.
>
> Konstantin?

I have no clue. Sorry.

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

