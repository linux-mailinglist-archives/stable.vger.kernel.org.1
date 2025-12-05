Return-Path: <stable+bounces-200104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5C4CA5FDE
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 04:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CB623151442
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 03:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226A226A0D5;
	Fri,  5 Dec 2025 03:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AXGCPgWd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C2323D7E6;
	Fri,  5 Dec 2025 03:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764904958; cv=none; b=Va0+cn/F+xwyqNMbL40pifIUMHku4iWpVg/gzuHsQGJiCgTsWaIeUjGRych6b86wjo/HMXa2Dm68+Gln5iikwIzW45nhnZUYnoZ2UwkRepQDSkxSsfY8V5GahYtZ1rq4hEr0FFEMGcCP6o+HAMpNPu9R+btOJ9ErRJg8J5Ljl3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764904958; c=relaxed/simple;
	bh=QBrTDsRqo/yw2j45O40D+5dX5EYnM1bJwpbdQGzAzdQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mhhbJ+WsWAvQm0Ns7Ve8M+QbCX/gIM+buXAd6Dn/zvYx0V9hE2T/lBd2aMZkQrWz9bKe6Jgsb/JOgPrAelpdH5QWEQrN+IDapxr8jYw5IMjcjPpMF4ExmWgruRb3AoqI/NEHxCodqL7lrKJnsTjOxux8nnw+K5Innbst0BNin+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AXGCPgWd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C737FC4CEFB;
	Fri,  5 Dec 2025 03:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1764904958;
	bh=QBrTDsRqo/yw2j45O40D+5dX5EYnM1bJwpbdQGzAzdQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AXGCPgWd4mydusswaGZKqx4kEvlENRvG/I3+tUFWa0XByeiLMpFRYIlajA9z/nRJr
	 OlYuonufde9e5Fdl6T5Jf96rlSRlq5NLs/fKAvUS2+aIDY2nF+a4qvHLrT5ZwCgzld
	 q4v4GbSKtg0dLAjab3P3ybv7nvWbSbKQ2XgDr0YM=
Date: Thu, 4 Dec 2025 19:22:37 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Maciej Wieczor-Retman <m.wieczorretman@pm.me>, Andrey Ryabinin
 <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, Dmitry
 Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Marco Elver <elver@google.com>, jiayuan.chen@linux.dev,
 stable@vger.kernel.org, Maciej Wieczor-Retman
 <maciej.wieczor-retman@intel.com>, kasan-dev@googlegroups.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] kasan: Unpoison vms[area] addresses with a
 common tag
Message-Id: <20251204192237.0d7a07c9961843503c08ebab@linux-foundation.org>
In-Reply-To: <CA+fCnZeuGdKSEm11oGT6FS71_vGq1vjq-xY36kxVdFvwmag2ZQ@mail.gmail.com>
References: <cover.1764874575.git.m.wieczorretman@pm.me>
	<873821114a9f722ffb5d6702b94782e902883fdf.1764874575.git.m.wieczorretman@pm.me>
	<CA+fCnZeuGdKSEm11oGT6FS71_vGq1vjq-xY36kxVdFvwmag2ZQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Dec 2025 02:09:06 +0100 Andrey Konovalov <andreyknvl@gmail.com> wrote:

> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -591,11 +591,28 @@ void __kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms,
> >         unsigned long size;
> >         void *addr;
> >         int area;
> > +       u8 tag;
> > +
> > +       /*
> > +        * If KASAN_VMALLOC_KEEP_TAG was set at this point, all vms[] pointers
> > +        * would be unpoisoned with the KASAN_TAG_KERNEL which would disable
> > +        * KASAN checks down the line.
> > +        */
> > +       if (flags & KASAN_VMALLOC_KEEP_TAG) {
> 
> I think we can do a WARN_ON() here: passing KASAN_VMALLOC_KEEP_TAG to
> this function would be a bug in KASAN annotations and thus a kernel
> bug. Therefore, printing a WARNING seems justified.

This?

--- a/mm/kasan/common.c~kasan-unpoison-vms-addresses-with-a-common-tag-fix
+++ a/mm/kasan/common.c
@@ -598,7 +598,7 @@ void __kasan_unpoison_vmap_areas(struct
 	 * would be unpoisoned with the KASAN_TAG_KERNEL which would disable
 	 * KASAN checks down the line.
 	 */
-	if (flags & KASAN_VMALLOC_KEEP_TAG) {
+	if (WARN_ON_ONCE(flags & KASAN_VMALLOC_KEEP_TAG)) {
 		pr_warn("KASAN_VMALLOC_KEEP_TAG flag shouldn't be already set!\n");
 		return;
 	}
_


