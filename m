Return-Path: <stable+bounces-189261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EA2C08A3E
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 05:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EE1A4E9A13
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 03:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524F31CD15;
	Sat, 25 Oct 2025 03:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzFcust0"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE9578F2F
	for <stable@vger.kernel.org>; Sat, 25 Oct 2025 03:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761363106; cv=none; b=edrx9s8MaJhG+oHJ/Exg7nKOtWMZxt2fEbiYB+XrmE4qMv8a0vruMoTPuTmmZjWu2Sg572pgw7Np9diRygjp5xGIsxfn8x64w/YBT7BCIEJ7Ns/Ep1tbJ1rNTVDsBnzubWI60lcIg8iHEC1GaXggc8FK6HpBAwQcFkibF5Ishks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761363106; c=relaxed/simple;
	bh=NjEF5Ss4G57nzxhxDgz5MaE46uG/fiVF0ICE9nxzlac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/yq/BD36nOrK0+OIRkoGg4zJqeQwnmAy4tbH4BmO4YuBBTsggHngbNbk2Xr6dyKU3ptbBzJV1c4x6ihrmEhBY2/ewKizmuq9ooLqny9eL10VSDytoE1HMuLgXerX+WNs6UVql6KXtTxZlRBjLJlIpb1rPPEuhYmDfj+CtsHVqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gzFcust0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761363103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vrOROuAh2t0TxV1g/ZHhUSBmu1NMnGW6lj5cEu+eCAM=;
	b=gzFcust0AuB045RLmgh/UIUwNd1XJ+/nN1H1aPL0J6duErc1NqnmJsyf9o8MXud04DOj3x
	R5q/dHDXgJ+NhtPDlaWjJgFnZrU0nM1ldKwlAKhTq7WaeMob9LM575xc2CfSE6EwdruD52
	9BS8PEk0xk9eW1fxgBuPwylpGII6gqo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-a0_GJqOkP2-gwcGckHzPLQ-1; Fri,
 24 Oct 2025 23:31:39 -0400
X-MC-Unique: a0_GJqOkP2-gwcGckHzPLQ-1
X-Mimecast-MFC-AGG-ID: a0_GJqOkP2-gwcGckHzPLQ_1761363097
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E2B41954197;
	Sat, 25 Oct 2025 03:31:36 +0000 (UTC)
Received: from localhost (unknown [10.72.112.41])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B7FA81800576;
	Sat, 25 Oct 2025 03:31:33 +0000 (UTC)
Date: Sat, 25 Oct 2025 11:31:29 +0800
From: Baoquan He <bhe@redhat.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>,
	Chris Li <chrisl@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	YoungJun Park <youngjun.park@lge.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/5] mm, swap: misc cleanup and bugfix
Message-ID: <aPxEkSIUI5VAUXt0@MiWiFi-R3L-srv>
References: <20251024-swap-clean-after-swap-table-p1-v2-0-a709469052e7@tencent.com>
 <178e2579-0208-4d40-8ab2-31392aa3f920@lucifer.local>
 <CAMgjq7DuJp_zyW4NLHPoA8iDYC+2PaVZT4XzETV-okVUPLNzSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7DuJp_zyW4NLHPoA8iDYC+2PaVZT4XzETV-okVUPLNzSw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 10/24/25 at 09:26pm, Kairui Song wrote:
> On Fri, Oct 24, 2025 at 9:18 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Fri, Oct 24, 2025 at 02:00:38AM +0800, Kairui Song wrote:
> > > A few cleanups and a bugfix that are either suitable after the swap
> > > table phase I or found during code review.
> > >
> > > Patch 1 is a bugfix and needs to be included in the stable branch,
> > > the rest have no behavior change.
> > >
> > > ---
> > > Changes in v2:
> > > - Update commit message for patch 1, it's a sub-optimal fix and a better
> > >   fix can be done later. [ Chris Li ]
> > > - Fix a lock balance issue in patch 1. [ YoungJun Park ]
> > > - Add a trivial cleanup patch to remove an unused argument,
> > >   no behavior change.
> > > - Update kernel doc.
> > > - Fix minor issue with commit message [ Nhat Pham ]
> > > - Link to v1: https://lore.kernel.org/r/20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com
> > >
> > > ---
> > > Kairui Song (5):
> > >       mm, swap: do not perform synchronous discard during allocation
> >
> > FYI For some reason this commit is not present on lore, see [0]
> >
> > [0]: https://lore.kernel.org/all/20251024-swap-clean-after-swap-table-p1-v2-0-a709469052e7@tencent.com/
> 
> Thanks for letting me know, strangely, it is here:
> https://lkml.kernel.org/r/20251024-swap-clean-after-swap-table-p1-v2-1-c5b0e1092927@tencent.com

I don't receive the patch 1/5, thanks to the link.

> 
> But the In-reply-to id is wrong. I'm using b4 and somehow patch 1 was
> blocked by gmail's SMTP so I had to try to resend patch 1 again,
> something went wrong with that part. I'll try to find out the problem
> and avoid that from happening again.
> 
> I'm seeing that patch 1 is being merged into mm tree just fine, I
> guess that should be OK.
> 
> If anyone is reading the threads, this url above should be helpful.
> 


