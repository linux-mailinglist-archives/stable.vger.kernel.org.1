Return-Path: <stable+bounces-148142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 144EFAC8934
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 09:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074401BA69FD
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 07:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A931DE4C8;
	Fri, 30 May 2025 07:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OjuvM95V"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8BF211460;
	Fri, 30 May 2025 07:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748591108; cv=none; b=ojbW8XQiWhOLfjj893Z+4zD1JM8e0i7+rBc52Gzv2uUIxrD//d7vaOj7mkmA07hk/ewL88n8xb0DUqv8s/qixKgiecy1P5D5181i/7x4VOwFd68beoAslJnsTn1mCien2bDESBOA0jj5h0K/7DvMNPRPJRrPTwnHzZBxVPDCuBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748591108; c=relaxed/simple;
	bh=uGdOVtddhxaxBRd29KpCqAVkDSswK1sItiY62AIVya4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkIShQFOe6TyqgGlCzZqpgoR9StUOBw9bdgeDdyeuUUtedKzaJCjz1TPKl1WiZIqqZML257vurQSJrH+EOVsJ6nWt4uGbIQnzHfif3AgoAvVDpxDadKUm1wIwjCOlTJVa5idVZvqsF5echK1qp9/vWW9V4z9i8St4NfwiLNZXvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OjuvM95V; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sDfVHR/wCQYqHHG+BTpVWxebqA5paftiQgcZz9s2BbI=; b=OjuvM95VpMa3VS4r8W2UEl/wY5
	IMizMyyXbYaDdk+YlrOVlJL/K5AtkhIzVjIjBseZrbaMy9zHnxSj/kYAy/pZyvcpv/tZ4FHYO2ChC
	sngFBX6JTxIH2XFEslq/QASqR0WeKiywh/AdINfTdCdMj5sAvlV5HxKcM8g9qJxOHwNXKw9c/ipJ/
	Ge1kRYKvRVd8AarsUkjaygeh2n4YWndz1Qc70ZzlqHbUO56jjuNv7WE290f8rnKwpCcoeZhzIUDQ1
	NFy9mQfae2+T/kC8TMwqseaZSWceWmcgOYhmo8eCGPpOdKiIVRr/qxbGYeJTY9+H2i2BHOgQ9mTmU
	6GQLD3MQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKuQ9-00000000DjN-4BZP;
	Fri, 30 May 2025 07:44:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 643D530066A; Fri, 30 May 2025 09:44:53 +0200 (CEST)
Date: Fri, 30 May 2025 09:44:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, xin@zytor.com,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] x86/execmem: don't use PAGE_KERNEL protection for
 code pages
Message-ID: <20250530074453.GG39944@noisy.programming.kicks-ass.net>
References: <20250528123557.12847-1-jgross@suse.com>
 <20250528123557.12847-2-jgross@suse.com>
 <aDdHdwf8REvdu5FF@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDdHdwf8REvdu5FF@kernel.org>

On Wed, May 28, 2025 at 08:27:19PM +0300, Mike Rapoport wrote:
> On Wed, May 28, 2025 at 02:35:55PM +0200, Juergen Gross wrote:
> > In case X86_FEATURE_PSE isn't available (e.g. when running as a Xen
> > PV guest), execmem_arch_setup() will fall back to use PAGE_KERNEL
> > protection for the EXECMEM_MODULE_TEXT range.
> > 
> > This will result in attempts to execute code with the NX bit set in
> > case of ITS mitigation being applied.
> > 
> > Avoid this problem by using PAGE_KERNEL_EXEC protection instead,
> > which will not set the NX bit.
> > 
> > Cc: <stable@vger.kernel.org>
> > Reported-by: Xin Li <xin@zytor.com>
> > Fixes: 5185e7f9f3bd ("x86/module: enable ROX caches for module text on 64 bit")
> > Signed-off-by: Juergen Gross <jgross@suse.com>
> > ---
> >  arch/x86/mm/init.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> > index 7456df985d96..f5012ae31d8b 100644
> > --- a/arch/x86/mm/init.c
> > +++ b/arch/x86/mm/init.c
> > @@ -1089,7 +1089,7 @@ struct execmem_info __init *execmem_arch_setup(void)
> >  		pgprot = PAGE_KERNEL_ROX;
> >  		flags = EXECMEM_KASAN_SHADOW | EXECMEM_ROX_CACHE;
> >  	} else {
> > -		pgprot = PAGE_KERNEL;
> > +		pgprot = PAGE_KERNEL_EXEC;
> 
> Please don't. Everything except ITS can work with PAGE_KENREL so the fix
> should be on ITS side. 

Well, this is early vs post make_ro again.

Does something like so work for you?

---
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 7456df985d96..f5012ae31d8b 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -1089,7 +1089,7 @@ struct execmem_info __init *execmem_arch_setup(void)
 		pgprot = PAGE_KERNEL_ROX;
 		flags = EXECMEM_KASAN_SHADOW | EXECMEM_ROX_CACHE;
 	} else {
-		pgprot = PAGE_KERNEL;
+		pgprot = PAGE_KERNEL_EXEC;
 		flags = EXECMEM_KASAN_SHADOW;
 	}
 
diff --git a/mm/execmem.c b/mm/execmem.c
index 6f7a2653b280..dbe2eedea0e6 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -258,6 +258,7 @@ static bool execmem_cache_rox = false;
 
 void execmem_cache_make_ro(void)
 {
+	struct execmem_range *module_text = &execmem_info->ranges[EXECMEM_MODULE_TEXT];
 	struct maple_tree *free_areas = &execmem_cache.free_areas;
 	struct maple_tree *busy_areas = &execmem_cache.busy_areas;
 	MA_STATE(mas_free, free_areas, 0, ULONG_MAX);
@@ -269,6 +270,9 @@ void execmem_cache_make_ro(void)
 
 	mutex_lock(mutex);
 
+	if (!(module_text->flags & EXECMEM_ROX_CACHE))
+		module_text->pgprot = PAGE_KERNEL;
+
 	mas_for_each(&mas_free, area, ULONG_MAX) {
 		unsigned long pages = mas_range_len(&mas_free) >> PAGE_SHIFT;
 		set_memory_ro(mas_free.index, pages);

