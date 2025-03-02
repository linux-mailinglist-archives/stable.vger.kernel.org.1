Return-Path: <stable+bounces-120022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75549A4B3F0
	for <lists+stable@lfdr.de>; Sun,  2 Mar 2025 19:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5771887965
	for <lists+stable@lfdr.de>; Sun,  2 Mar 2025 18:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5111EB18E;
	Sun,  2 Mar 2025 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="aRhUo8BY"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1351E98ED;
	Sun,  2 Mar 2025 18:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740939231; cv=none; b=tdAB3uZ6Z6xrMOHVXV00V1k1j9zaJwIf1GTeEPUYS9AeLrkzXu20bskQTDT0+aS8RIPgd5Nw6oW9dsaaOp9eHxTRLKfpyOs+LWMJxjHqcbasixQwpXy2+pLBFvFz4CkOg47ENfd03hBT0cF6w6a0oy4LvCuQctISNWZfzA9p5Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740939231; c=relaxed/simple;
	bh=n7S/w4v9XbJ+ptmMFOKGR1GrL0+6YsWIF0XXtY7+IXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8/SOt7hUpmgZL31PKunzs3gDoRtKK4e5dGzwjTMAK3rRZ3tetYtHW+WZEswqzXAhNOjYD+bHZvMOKmk0OGnA8IZXM6lOKzGTLRcTutKDMeRIGz1YCGuwymSjBWCitFT63bdpRgzA4r+wr99UJagcS34/O1X7S6t4Vyvpay1oZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=aRhUo8BY; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.4])
	by mail.ispras.ru (Postfix) with ESMTPSA id 8500740CE190;
	Sun,  2 Mar 2025 18:13:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8500740CE190
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1740939225;
	bh=H0EDeRRfwEJ7O4uee6odQGPJWEcdHTvlhAexVbp9No0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aRhUo8BY3IT/9HrU/p5zGEBXVqKU/8RYbsa7oPXqeU+cM1TdBpJFqYKIEc/eCEyOv
	 JDBxOHRs3OHGGGP8u0V+/cFxuI+bnGvUYOdXK0YedbB/CXaIwt2UCNTMdBqb5Xv9lN
	 14VMUnauswAUzpInicqMJG4sRyuWU8tsgz9/hyt4=
Date: Sun, 2 Mar 2025 21:13:45 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Alexey Panov <apanov@astralinux.ru>, stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Max Kellermann <max.kellermann@ionos.com>, 
	lvc-project@linuxtesting.org, syzbot+de04e06b28cfecf2281c@syzkaller.appspotmail.com, 
	syzbot+c8c8238b394be4a1087d@syzkaller.appspotmail.com, Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org, 
	Yue Hu <huyue2@coolpad.com>, syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH 6.1 1/2] erofs: handle overlapped pclusters out of
 crafted images properly
Message-ID: <3vutme7tf24cqdfbf4wjti22u6jfxjewe6gt4ufppp4xplyb5e@xls7aozstoqr>
References: <20250228165103.26775-1-apanov@astralinux.ru>
 <20250228165103.26775-2-apanov@astralinux.ru>
 <kcsbxadkk4wow7554zonb6cjvzmkh2pbncsvioloucv3npvbtt@rpthpmo7cjja>
 <fb801c0f-105e-4aa7-80e2-fcf622179446@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb801c0f-105e-4aa7-80e2-fcf622179446@linux.alibaba.com>

On Mon, 03. Mar 01:41, Gao Xiang wrote:
> > > diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> > > index 94e9e0bf3bbd..ac01c0ede7f7 100644
> > 
> > I'm looking at the diff of upstream commit and the first thing it does
> > is to remove zeroing out the folio/page private field here:
> > 
> >    // upstream commit 9e2f9d34dd12 ("erofs: handle overlapped pclusters out of crafted images properly")
> >    @@ -1450,7 +1451,6 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
> >             * file-backed folios will be used instead.
> >             */
> >            if (folio->private == (void *)Z_EROFS_PREALLOCATED_PAGE) {
> >    -               folio->private = 0;
> >                    tocache = true;
> >                    goto out_tocache;
> >            }
> > 
> > while in 6.1.129 the corresponding fragment seems untouched with the
> > backport patch. Is it intended?
> 
> Yes, because it was added in
> commit 2080ca1ed3e4 ("erofs: tidy up `struct z_erofs_bvec`")
> and dropped again.
> 
> But for Linux 6.6.y and 6.1.y, we don't need to backport
> 2080ca1ed3e4.

Thanks for overall clarification, Gao!

My concern was that in 6.1 and 6.6 there is still a pattern at that
place, not directly related to 2080ca1ed3e4 ("erofs: tidy up
`struct z_erofs_bvec`"):

1. checking ->private against Z_EROFS_PREALLOCATED_PAGE
2. zeroing out ->private if the previous check holds true

// 6.1/6.6 fragment

	if (page->private == Z_EROFS_PREALLOCATED_PAGE) {
		WRITE_ONCE(pcl->compressed_bvecs[nr].page, page);
		set_page_private(page, 0);
		tocache = true;
		goto out_tocache;
	}

while the upstream patch changed the situation. If it's okay then no
remarks from me. Sorry for the noise..

