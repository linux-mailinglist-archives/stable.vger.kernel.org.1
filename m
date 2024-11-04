Return-Path: <stable+bounces-89735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86DB9BBCB9
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 19:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE4528329E
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 18:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42861CB9E6;
	Mon,  4 Nov 2024 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OCVcJhXU"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BE81C9DDF;
	Mon,  4 Nov 2024 18:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730743248; cv=none; b=SGvcTnLEGLal5EP0ryIN3ffc1joFHlhZWN0LaytBH2PVQlTYO75VvsgdhL9A0jJaR4z3RNeUsFZQa2RbABL8gOCtHjLiwHA+IToGcs2bJL+A6ZqLeAu48x41R50XqHhj0C0+hbimL1wq+p6ZkSRCSPxDwutmU1Be//Wl10rX9zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730743248; c=relaxed/simple;
	bh=B9jWPczjZgAONNpThKHexUQW24Xju40V9hSbN7FE1dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJlVRcz0xG7JdUbbBhbVepvBQWfCfxZuKP8SAD4mYts1WF91c0nLejOSjQlab0dLKi5n3U5xFIetB+Zlje6obece/eKak9lONwrNnN3Ed0GV8IGiZf1fhR0xL7WXNfPtZDuJtaXOEc/uaGKbCe26qClsQ+t0LyBYNX/65tbxhk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OCVcJhXU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0KEUojX769cFGFmjiOJu9LFcNjv63c+8Mtn9KKoSfvQ=; b=OCVcJhXUUUxPqDlx3lGFnhCT0L
	M5kJrwySKofGEFCLf8XdvyIbdHMy8vHdTTPP/gMM2LrzKhKR65E8zYdeYo5bCY+WjlV4Nf+66G/pD
	hQD/cYTgGWXIFgt550GAATKhBmAXmYpN1b2WIjj3E8BWbAnc2Vbx415/UTg2URtFKpRFag12RuaHx
	TcggLzHKnbQK5vjnfxxD5GTDmpA+rkcVoXhpsV542JItdJIL3deXSCmQNDEkRtAacNGhhn6WudeAJ
	Fq1x8N6IXpomeov0dISYwozNLAL9s60AvFqqwqT13JZQ3QLJ5rQHsOTIFuQTV/EyWRlcUWCcJKBCv
	nWFVznRQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t81NV-00000001Qps-0up4;
	Mon, 04 Nov 2024 18:00:37 +0000
Date: Mon, 4 Nov 2024 18:00:36 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Koichiro Den <koichiro.den@gmail.com>
Cc: vbabka@suse.cz, cl@linux.com, penberg@kernel.org, rientjes@google.com,
	iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, kees@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/slab: fix warning caused by duplicate kmem_cache
 creation in kmem_buckets_create
Message-ID: <ZykLxG5Tyet5HcwL@casper.infradead.org>
References: <20241104150837.2756047-1-koichiro.den@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104150837.2756047-1-koichiro.den@gmail.com>

On Tue, Nov 05, 2024 at 12:08:37AM +0900, Koichiro Den wrote:
> Commit b035f5a6d852 ("mm: slab: reduce the kmalloc() minimum alignment
> if DMA bouncing possible") reduced ARCH_KMALLOC_MINALIGN to 8 on arm64.
> However, with KASAN_HW_TAGS enabled, arch_slab_minalign() becomes 16.
> This causes kmalloc_caches[*][8] to be aliased to kmalloc_caches[*][16],
> resulting in kmem_buckets_create() attempting to create a kmem_cache for
> size 16 twice. This duplication triggers warnings on boot:

Wouldn't this be easier?

+++ b/arch/arm64/include/asm/cache.h
@@ -33,7 +33,11 @@
  * the CPU.
  */
 #define ARCH_DMA_MINALIGN      (128)
+#ifdef CONFIG_KASAN_HW_TAGS
+#define ARCH_KMALLOC_MINALIGN  (16)
+#else
 #define ARCH_KMALLOC_MINALIGN  (8)
+#endif

 #ifndef __ASSEMBLY__



