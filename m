Return-Path: <stable+bounces-56052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3ED91B6C2
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 08:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F53282FF7
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 06:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EF8482DA;
	Fri, 28 Jun 2024 06:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b3ZIr8qt"
X-Original-To: stable@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60BF21A04;
	Fri, 28 Jun 2024 06:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719555080; cv=none; b=PmGHSYliVpAX114v/ZeP5yjXXrlwTmSpkCp8HKVktqC2xXQCIkpBN4G/Fn2wvUh2zXDvy72KVcURrqiIBode+SgSokryhB3zGRU8GS+oxOQUFSenogDXJDeWkYjb6g2BLlQirHwcw4fI+acXms6AqyxtnaC/kfmqc0dIiKCSO2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719555080; c=relaxed/simple;
	bh=PRk9JhKSfkR4xjlzu725DDk2sKe3ecO3JhRz/q003xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7bLmoDO+XyP5KtEnd69Y3q599sXUS+LSHRxYsXw/6euNyZzLFkUADF2BFOVZKkgCKfzl4AhO7F2sVZlqdfPU9HWS1omPRKmFXv+Yk9phjW9yHVyFwOT9cZdRPIWGNBjDbaWDZ0POmkBGM/px9GhRyNhLjUVhj8NMTa5zmMLAX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b3ZIr8qt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rKTNBJBJKDz518tdZXOqKQN7DnihTTlAfqvYX8RQNoA=; b=b3ZIr8qtndMhPGRTQuFkOe5mym
	oyGQt5Dl2XtwkJmnvecBhJupUImbVwDK4/hlAknxekMORhPEoi6lvCWXlHB3Ap4o1iGtDF6jnY3tC
	F4YyCOV4cB2K7OotMrabvvC78ZMPTxhSGa2QX6wgpVn/JepeswgQJvzeuhjj0mNpYqNCIW+6OguFc
	akJ3BkVIbwGAWdpBhV18N56xK+xnTv8SUptGD3kHuOK511FKJdtaWUrOlVMfcJH7ttSIEaEPnVrA6
	1Au3X1zqYh7qGd5Kn3BmhcG3ki8ZAaIRI8FJgfyazKySOov1oAkbkEwxFmz9vpOC/ZYIxCpeaWukU
	yXxKxjpA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sN4pI-0000000CiPr-1wX3;
	Fri, 28 Jun 2024 06:11:16 +0000
Date: Thu, 27 Jun 2024 23:11:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: yangge1116@126.com
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	21cnbao@gmail.com, peterx@redhat.com, baolin.wang@linux.alibaba.com,
	liuzixing@hygon.cn
Subject: Re: [PATCH] mm/gup: Use try_grab_page() instead of try_grab_folio()
 in gup slow path
Message-ID: <Zn5UBMfT6LEpdpNW@infradead.org>
References: <1719478388-31917-1-git-send-email-yangge1116@126.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1719478388-31917-1-git-send-email-yangge1116@126.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

I was complaining that switching from a folio to a page interface
is a retro-step.  But try_grab_page and try_grab_folio actually
both take a strut page argument and do similar but different things.

Yikes!

> -int __must_check try_grab_page(struct page *page, unsigned int flags)
> +int __must_check try_grab_page(struct page *page, int refs, unsigned int flags)

This would now make it a try_grab_pages.  Also please try to avoid
the overly lone lines here and in the external declaration.

