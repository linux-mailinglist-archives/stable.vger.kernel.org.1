Return-Path: <stable+bounces-147980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D7FAC6D49
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 17:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE04B9E2D35
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 15:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFFD28CF5B;
	Wed, 28 May 2025 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tW0PZ6E8"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C8828C860;
	Wed, 28 May 2025 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748447911; cv=none; b=VKvbJ0HEJigY8Sg92M5Ay9LKLAEP4LxD4FY7sKVoxG8tfrR2vLm3IZ4f4MHhuFW1oeYP1l+n51u1uU6GfFT3Yeh8kmaRxYb/SmBXmYcyKfTe3yoD75PiLEA04XAGZtaFhZo+MRhw3N/SqSr6EamihNfJdawADqOzevBZG0IR8eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748447911; c=relaxed/simple;
	bh=OtBi/ZITK7WUZHutB/hNpw5QOeKdiYbhIrHeY6xrCpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFkvaX0bZnf+a0hkg9YirD+f1QLsg7tEVuPLrXZexpF6oFlMV6+cHdXA7YdGZgUa2c0Jl8FshP9pPAgYmwn3Nk1C7Sy0RJFLdp2oNeIrJ1OUxpWZDjf3hu7EclEDGMDqya1jwMPeoPRPzRt2LnTD9OBz9fzx9sWfhPCjF9LB3F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tW0PZ6E8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=RoswSQk/PEBsr2RK6KX9ltQEgshvqW8g4fwZIoz7jqs=; b=tW0PZ6E8yx4NYov5nHPcC49wvh
	Kz2J1xJfwGwlcQwNL78Xbi5R5nWGz8VYiTMxidyGDiJyiVFP9OKpP49ZNSkJDc0kfx6aSq4i3yiQL
	Hm4F1fh6NI2uq/jkzPr4rErFYjwWpz/rBxfbtMmR2vmKujf+0o94RtCwJ1FkuSgZjX3QM8BWWik3v
	jA2ifdYUPIIhHWUqNWmEyYMxuiU4aWjf7zdUw0yj4UeNcjq4W55vinm1yuAEIcLIyyfXDZywe/UfD
	ha8KxMNEyROgtrL9c17E/9iLITIHATCtn4m4i+6lf/J5rX772GvhosJcfUA/kH31d9LWLu6JAHC6Z
	fe6gVjzg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKJAc-0000000DomJ-3tZM;
	Wed, 28 May 2025 15:58:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A7F4A3005AF; Wed, 28 May 2025 17:58:21 +0200 (CEST)
Date: Wed, 28 May 2025 17:58:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, xin@zytor.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, stable@vger.kernel.org,
	rppt@kernel.org
Subject: Re: [PATCH 3/3] x86/alternative: make kernel ITS thunks read-only
Message-ID: <20250528155821.GD39944@noisy.programming.kicks-ass.net>
References: <20250528123557.12847-1-jgross@suse.com>
 <20250528123557.12847-4-jgross@suse.com>
 <20250528131052.GZ39944@noisy.programming.kicks-ass.net>
 <044f0048-95bb-4822-978e-a23528f3891f@suse.com>
 <20250528132231.GB39944@noisy.programming.kicks-ass.net>
 <7c8bf4f5-29a0-4147-b31a-5e420b11468e@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7c8bf4f5-29a0-4147-b31a-5e420b11468e@suse.com>

On Wed, May 28, 2025 at 03:30:33PM +0200, J=FCrgen Gro=DF wrote:

> Have a look at its_fini_mod().

Oh, that's what you mean. But this still isn't very nice, you now have
restore_rox() without make_temp_rw(), which was the intended usage
pattern.

Bah, I hate how execmem works different for !PSE, Mike, you see a sane
way to fix this?

Anyway, if we have to do something like this, then I would prefer it
shaped something like so:

---
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ecfe7b497cad..33d4d139cb50 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -111,9 +111,8 @@ static bool cfi_paranoid __ro_after_init;
=20
 #ifdef CONFIG_MITIGATION_ITS
=20
-#ifdef CONFIG_MODULES
 static struct module *its_mod;
-#endif
+static struct its_array its_pages;
 static void *its_page;
 static unsigned int its_offset;
=20
@@ -151,68 +150,78 @@ static void *its_init_thunk(void *thunk, int reg)
 	return thunk + offset;
 }
=20
-#ifdef CONFIG_MODULES
 void its_init_mod(struct module *mod)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS))
 		return;
=20
-	mutex_lock(&text_mutex);
-	its_mod =3D mod;
-	its_page =3D NULL;
+	if (mod) {
+		mutex_lock(&text_mutex);
+		its_mod =3D mod;
+		its_page =3D NULL;
+	}
 }
=20
 void its_fini_mod(struct module *mod)
 {
+	struct its_array *pages =3D &its_pages;
+
 	if (!cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS))
 		return;
=20
 	WARN_ON_ONCE(its_mod !=3D mod);
=20
-	its_mod =3D NULL;
-	its_page =3D NULL;
-	mutex_unlock(&text_mutex);
+	if (mod) {
+		pages =3D &mod->arch.its_pages;
+		its_mod =3D NULL;
+		its_page =3D NULL;
+		mutex_unlock(&text_mutex);
+	}
=20
-	for (int i =3D 0; i < mod->its_num_pages; i++) {
-		void *page =3D mod->its_page_array[i];
+	for (int i =3D 0; i < pages->num; i++) {
+		void *page =3D pages->pages[i];
 		execmem_restore_rox(page, PAGE_SIZE);
 	}
+
+	if (!mod)
+		kfree(pages->pages);
 }
=20
 void its_free_mod(struct module *mod)
 {
+	struct its_array *pages =3D &its_pages;
+
 	if (!cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS))
 		return;
=20
-	for (int i =3D 0; i < mod->its_num_pages; i++) {
-		void *page =3D mod->its_page_array[i];
+	if (mod)
+		pages =3D &mod->arch.its_pages;
+
+	for (int i =3D 0; i < pages->num; i++) {
+		void *page =3D pages->pages[i];
 		execmem_free(page);
 	}
-	kfree(mod->its_page_array);
+	kfree(pages->pages);
 }
-#endif /* CONFIG_MODULES */
=20
 static void *its_alloc(void)
 {
-	void *page __free(execmem) =3D execmem_alloc(EXECMEM_MODULE_TEXT, PAGE_SI=
ZE);
+	struct its_array *pages =3D &its_pages;
+	void *tmp;
=20
+	void *page __free(execmem) =3D execmem_alloc(EXECMEM_MODULE_TEXT, PAGE_SI=
ZE);
 	if (!page)
 		return NULL;
=20
-#ifdef CONFIG_MODULES
-	if (its_mod) {
-		void *tmp =3D krealloc(its_mod->its_page_array,
-				     (its_mod->its_num_pages+1) * sizeof(void *),
-				     GFP_KERNEL);
-		if (!tmp)
-			return NULL;
+	tmp =3D krealloc(pages->pages, (pages->num + 1) * sizeof(void *), GFP_KER=
NEL);
+	if (!tmp)
+		return NULL;
=20
-		its_mod->its_page_array =3D tmp;
-		its_mod->its_page_array[its_mod->its_num_pages++] =3D page;
+	pages->pages =3D tmp;
+	pages->pages[pages->num++] =3D page;
=20
+	if (its_mod)
 		execmem_make_temp_rw(page, PAGE_SIZE);
-	}
-#endif /* CONFIG_MODULES */
=20
 	return no_free_ptr(page);
 }
@@ -2338,6 +2347,8 @@ void __init alternative_instructions(void)
 	apply_retpolines(__retpoline_sites, __retpoline_sites_end);
 	apply_returns(__return_sites, __return_sites_end);
=20
+	its_fini_mod(NULL);
+
 	/*
 	 * Adjust all CALL instructions to point to func()-10, including
 	 * those in .altinstr_replacement.

