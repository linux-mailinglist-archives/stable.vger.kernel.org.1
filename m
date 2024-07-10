Return-Path: <stable+bounces-58957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9E092C6EF
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 02:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C0551C21C99
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 00:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E75BA35;
	Wed, 10 Jul 2024 00:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JxhNR7St"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FFC1366;
	Wed, 10 Jul 2024 00:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720570429; cv=none; b=d5imNXP8cP2mWftpivsgtxIg0keAqj/xcz38/OXsz4hz/J03LkOu1+GVH+7RvWxeFU6K53/VLvC0TU2B0b1PuM7WHJ7uqCxi4A7iQd64bsNQEtXmulB3solZd8kXn5hVJQA1YQV6NMMAYo3p3KyjjF2dO84hJNmX8P/C+JiDD3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720570429; c=relaxed/simple;
	bh=EibiTzLr2qa+oH2HKV/cZW2EB7ch+eovc3WHYxkuENw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSi9Uk7OKJXpZLg51xxC82NrsBvRtxN6cHl68ebBmE94TFTvDkzyVs6cVxadqKxJ5uQx+MzDzlJVCtjQCSa76Xn19/KHaXnvTalpb1EmvsKiFycydmXmnKp8ZyQoSl96LKdkc88aeFKCNrILM6Qyk2k5cPfI4gtxT++8xZYvbU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JxhNR7St; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EibiTzLr2qa+oH2HKV/cZW2EB7ch+eovc3WHYxkuENw=; b=JxhNR7St7Jz6DRFiCjc1RIjZ3/
	iaX4ybgaOmhY1D5W64YQ+GArS2tz57+jlYuy4dJlXXLd3oC6IqI9+XOu1T8CkOQfX/Y8TxT4+fcBJ
	rjX3NKAfrdu3fYfOKbMcokyUdTq5jqerg77ZVuOwJlS8CXsZLiaVcqgdWE/7omuwpvc7VvZ0vpZVJ
	DjVGDlQleyQVEfSHFu3+9umlGSOra/yHYiSUdJud3t1OMjDVHY8Fsl/EXrjQDtEbt6XOe2D/HoNUH
	u6D/8Q9T0GtuNRonWWWsxF39yrJ2ZPFfxuUGIuEM72DwAQFM1GIlM+rrTqbTN3S4CDdSFHGi4Lqpg
	Gc6R6BRw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRKxr-00000008VZH-3cTz;
	Wed, 10 Jul 2024 00:13:43 +0000
Date: Wed, 10 Jul 2024 01:13:43 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Ram Tummala <rtummala@nvidia.com>
Cc: akpm@linux-foundation.org, fengwei.yin@intel.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, apopple@nvidia.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: Fix PTE_AF handling in fault path on architectures
 with HW AF support
Message-ID: <Zo3SN_qlYUWLAlyR@casper.infradead.org>
References: <20240710000942.623704-1-rtummala@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710000942.623704-1-rtummala@nvidia.com>

On Tue, Jul 09, 2024 at 05:09:42PM -0700, Ram Tummala wrote:
> Commit 3bd786f76de2 ("mm: convert do_set_pte() to set_pte_range()")
> replaced do_set_pte() with set_pte_range() and that introduced a regression
> in the following faulting path of non-anonymous vmas on CPUs with HW AF

At no point in this do you say what "AF" stands for.

