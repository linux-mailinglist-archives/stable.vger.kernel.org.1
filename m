Return-Path: <stable+bounces-192413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ED2C319D2
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 15:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BAB3A3452E9
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 14:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DF2329375;
	Tue,  4 Nov 2025 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Q45ZqZeY"
X-Original-To: stable@vger.kernel.org
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BCB31B117;
	Tue,  4 Nov 2025 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267800; cv=none; b=sRgSzTomA2ZBCbyi12EfXNBUFxVQHNyaNJcbMnmRC6OKbk7giHfgIsZL9jO/sXm6U7HUYV5+lPzkFifj1b2XJB7nadWENAIwo+mE+85D2nfoEo6ENj3HbFg10cSog/KKsVN6RFYonD2QpRf8VOpVF3h1YmARAo+2tlOQDSwBxus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267800; c=relaxed/simple;
	bh=jPyOeNlQgUZZisQjlGeiGfEr956dNifO7C2Q2JmeBgI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dM5C21HCX67b7pkSjr3+OFkl6C+B3XH2vORX/V/RUPkdlz1hZDbkwwfZ15rH/ENgNZ/6jROhlJz64QCY+MgRw60DfdZZ7K4KiDtCKuf8TAjRNn77klZBQNxpCMqwF82lkuB1f8C+mLywo/4wVqScTA7fH7leWIW4H2vkEPxjoJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Q45ZqZeY; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1762267790; x=1762526990;
	bh=6toufJLKljGqaHG5WZqQpO38Yv3Ls2e+KAx9dPrtmiw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Q45ZqZeYIfexXEzPHWV37QQFzHBmhcuTm8m95wIVxjojEDFnCiwaBpmE4GfVtQpIG
	 Xv+yKdzj99Vix3uQc3UtOqhz0NSwhIIm96fewaISwkdgNrC8SGUAqz5Mu1NqmwqJqB
	 dCQe+XFuWcws2LHUcgn/Lf3r+FckwwwnuuSSJGpJoC0MUnw58rxw/syptWo5sJDVx+
	 tYVn2zN+Gn5L9UnDqHa1hPX9ZqgpL+2U8Qm5+MaR8w1aLLYp8onv/IKmigRlkS/6Oq
	 rLG8qtXFMv9PbZKAMIAh9mJQnCYRk9WQusCfXFE5Bh7s53iuerfhX3vx6OpeWf0WEP
	 vT0fOHegElP4Q==
Date: Tue, 04 Nov 2025 14:49:48 +0000
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Marco Elver <elver@google.com>
From: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: m.wieczorretman@pm.me, stable@vger.kernel.org, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Baoquan He <bhe@redhat.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] kasan: Unpoison vms[area] addresses with a common tag
Message-ID: <cf8fe0ffcdbf54e06d9df26c8473b123c4065f02.1762267022.git.m.wieczorretman@pm.me>
In-Reply-To: <cover.1762267022.git.m.wieczorretman@pm.me>
References: <cover.1762267022.git.m.wieczorretman@pm.me>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: 55cd5ebacaac83958431436550ff0c47705cb95d
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>

A KASAN tag mismatch, possibly causing a kernel panic, can be observed
on systems with a tag-based KASAN enabled and with multiple NUMA nodes.
It was reported on arm64 and reproduced on x86. It can be explained in
the following points:

=091. There can be more than one virtual memory chunk.
=092. Chunk's base address has a tag.
=093. The base address points at the first chunk and thus inherits
=09   the tag of the first chunk.
=094. The subsequent chunks will be accessed with the tag from the
=09   first chunk.
=095. Thus, the subsequent chunks need to have their tag set to
=09   match that of the first chunk.

Unpoison all vm_structs after allocating them for the percpu allocator.
Use the same tag to resolve the pcpu chunk address mismatch.

Fixes: 1d96320f8d53 ("kasan, vmalloc: add vmalloc tagging for SW_TAGS")
Cc: <stable@vger.kernel.org> # 6.1+
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Tested-by: Baoquan He <bhe@redhat.com>
---
Changelog v1 (after splitting of from the KASAN series):
- Rewrite the patch message to point at the user impact of the issue.
- Move helper to common.c so it can be compiled in all KASAN modes.

 mm/kasan/common.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index c63544a98c24..a6bbc68984cd 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -584,12 +584,20 @@ bool __kasan_check_byte(const void *address, unsigned=
 long ip)
 =09return true;
 }
=20
+/*
+ * A tag mismatch happens when calculating per-cpu chunk addresses, becaus=
e
+ * they all inherit the tag from vms[0]->addr, even when nr_vms is bigger
+ * than 1. This is a problem because all the vms[]->addr come from separat=
e
+ * allocations and have different tags so while the calculated address is
+ * correct the tag isn't.
+ */
 void __kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms)
 {
 =09int area;
=20
 =09for (area =3D 0 ; area < nr_vms ; area++) {
 =09=09kasan_poison(vms[area]->addr, vms[area]->size,
-=09=09=09     arch_kasan_get_tag(vms[area]->addr), false);
+=09=09=09     arch_kasan_get_tag(vms[0]->addr), false);
+=09=09arch_kasan_set_tag(vms[area]->addr, arch_kasan_get_tag(vms[0]->addr)=
);
 =09}
 }
--=20
2.51.0



