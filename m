Return-Path: <stable+bounces-76946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCF4983B32
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 04:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92491F23A74
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 02:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDDEC13C;
	Tue, 24 Sep 2024 02:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rZfh1b+E"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8701311CAF;
	Tue, 24 Sep 2024 02:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727144786; cv=none; b=au+V/fqpJeHqguIIH28vBHgiVIq95bv1AAb/iLPejxbHG/EH4z2mO6eM95O1tyhSBT3ADP3vj25H6Y2ryPtCfLg0zsOjMK67OQJ/MGWxiIek4tBevDdU4VsKnPOn+Te14j8exr2ZSawU2yrqzysQopFCn70b41zUNjD5+LMxMH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727144786; c=relaxed/simple;
	bh=S2wndQObTp59VMkKCdY91fovzsanXHA44Yw9SIbI8Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n59mFapb0SKfcoLqitvo6QJPAVzcv5ONHOO8R1bGm6m8M0aSH+Lf8WPzg5GXuptgTwbDu+RYArPTc6Yc71jlfkrfYg29rgVGlk0MSTKB39FrCRca8vQfBnTK77HcRPZxgDevVbaC2thOXKVDSsmicRwk48+RqUYj3Povq4YfNqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rZfh1b+E; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ZDTM9dgz3joIOALKhYHslbayqUZJuS6PKZj5p9gHktU=; b=rZfh1b+E7V34Xo+laExYEWrKfh
	kKwq0PjG6UHW8YGhbWgVBfkH38g5uUGy6SSiolrvneBDmK2THVCDutrGeGxNkC9JJGHiTnzsVwdoV
	RSN/hyapHRfyu1Eigx1/0RQHmiSY0GFZxJbgWLinbKVKg2m6FGCixOeE+Q03o3wB+VEO5UpaNd3m2
	ubctfg0hs651ObHGNqu8Q13JBE2fTpWd7MD5uFwUcqOPfX6UZF0lvQK2/oMC3KiASU61PBkuO1+YF
	nGpD+i/VWerlXH2a/AxqF/Rp0DK6EbOuixfd6PvNVWPBObGi1gM1/TlHpXwLZQiAEBORrjCZ+32cZ
	vy8OLjSA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1ssvFl-00000000BB7-3eH4;
	Tue, 24 Sep 2024 02:26:13 +0000
Date: Tue, 24 Sep 2024 03:26:13 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
	wangkefeng.wang@huawei.com, ziy@nvidia.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH] mm: migrate: fix data-race in migrate_folio_unmap()
Message-ID: <ZvIjRZgyAGLmys7c@casper.infradead.org>
References: <ZvHIK80Hxd6DK2jw@casper.infradead.org>
 <B1FCFC88-1242-4472-BCED-71BA9530B639@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B1FCFC88-1242-4472-BCED-71BA9530B639@gmail.com>

On Tue, Sep 24, 2024 at 09:28:44AM +0900, Jeongjun Park wrote:
> > Matthew Wilcox <willy@infradead.org> wrote:
> > 
> > ﻿On Mon, Sep 23, 2024 at 05:56:40PM +0200, David Hildenbrand wrote:
> >>> On 22.09.24 17:17, Jeongjun Park wrote:
> >>> I found a report from syzbot [1]
> >>> 
> >>> When __folio_test_movable() is called in migrate_folio_unmap() to read
> >>> folio->mapping, a data race occurs because the folio is read without
> >>> protecting it with folio_lock.
> >>> 
> >>> This can cause unintended behavior because folio->mapping is initialized
> >>> to a NULL value. Therefore, I think it is appropriate to call
> >>> __folio_test_movable() under the protection of folio_lock to prevent
> >>> data-race.
> >> 
> >> We hold a folio reference, would we really see PAGE_MAPPING_MOVABLE flip?
> >> Hmm
> > 
> > No; this shows a page cache folio getting truncated.  It's fine; really
> > a false alarm from the tool.  I don't think the proposed patch
> > introduces any problems, but it's all a bit meh.
> > 
> 
> Well, I still don't understand why it's okay to read folio->mapping 
> without folio_lock .

Because it can't be changed in a way which changes the value of
__folio_test_movable().  We have a refcount on the folio at this point,
so it can't be freed.  And __folio_set_movable() happens at allocation.


