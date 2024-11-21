Return-Path: <stable+bounces-94540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85F09D504F
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 17:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1086FB2442D
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 16:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217021990AF;
	Thu, 21 Nov 2024 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WQQNQN55"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5698113F43B;
	Thu, 21 Nov 2024 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732204931; cv=none; b=rEkRKbT37UpQeka7gVzS9ZNNNINeFcWoC6ZjDg/iUv1FwwiMCoIy8RBsbNRDcV1UfNKaIT52sAutoU4c9ljjIIiYMs5dBIw1/b19T3G9n9n4nBl0DWKOKDHsXpvHEdOV3mgACFI6v5wYXaTR7KZLq9WLuDHGJFEoccwURy2w73A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732204931; c=relaxed/simple;
	bh=Kh4aJBp663sZF0gNmhoVRvg4KFXYsQigJuqU+FwivpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqyDP9T0DlAyurinKvycqfbm1bNO+OfgsMrPGzOYrVJZw5fgtTJPDn/aapu76x4iFCaGhYStfuY2txozxw6Prl+Mgrq8rR74C2qQo42ex+18nv58BcVnYgt6MdNgwuwO6dFJF2ktnyDx0CMeDZJGiLs85CERXPGJBY7XB/7QemE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WQQNQN55; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Kh4aJBp663sZF0gNmhoVRvg4KFXYsQigJuqU+FwivpA=; b=WQQNQN55cyPyaGfXznyYljEubl
	QY29/yTRHeaOMh00hFeAgrTER0So1DJmo8KC+2XnZ1akC5f1jJOxnlDbLxyCzqknaNjWcFVqQYFsW
	yg4N5TfkzxR7TQ+5/zIDOmW+RPWrND3cg8n2Dsn7lmuv1sreZAViLcCYm6y5jZvW9vYFLP9a0pk0x
	ugvgv9mCxXCJlQLatGMQAnwJKmBH8t+1fTxkEHez7VxnjCHXYUXI5i2yxrvqsJBjaJpA0ojHSvzid
	GPCWG4OV+1+DphDOHiB2emjNV3V40yC6jgfCKXbtrbKSJgki9+qe3JHsPiTX13yGgueJwb4HXBTfF
	YJ95BgvQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tE9d6-00000006YCj-2oMD;
	Thu, 21 Nov 2024 16:02:04 +0000
Date: Thu, 21 Nov 2024 16:02:04 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: akpm@linux-foundation.org, dave@stgolabs.net, Liam.Howlett@oracle.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: Fix to make vma_adjust_trans_huge() use
 find_vma() correctly
Message-ID: <Zz9ZfGy2veK0zGW0@casper.infradead.org>
References: <20241121124113.66166-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121124113.66166-1-aha310510@gmail.com>

On Thu, Nov 21, 2024 at 09:41:13PM +0900, Jeongjun Park wrote:
> vma_adjust_trans_huge() uses find_vma() to get the VMA, but find_vma() uses
> the returned pointer without any verification, even though it may return NULL.
> In this case, NULL pointer dereference may occur, so to prevent this,
> vma_adjust_trans_huge() should be fix to verify the return value of find_vma().

I don't think we should change anything here.

