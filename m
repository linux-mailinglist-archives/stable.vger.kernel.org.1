Return-Path: <stable+bounces-200173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2480ECA80E0
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 16:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51BDF3020061
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 15:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A92133B963;
	Fri,  5 Dec 2025 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="NvvwT+Xl"
X-Original-To: stable@vger.kernel.org
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1559233B6C6
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764946806; cv=none; b=N/mS/2E6znsWM0CEsLsi3FEe3HuNPJOwV5efODsQuQ1jRlK5b27iZC+EK8bxaeN6rbQydwEmV5mvoeaNLLyK0HudbkW/bevNuNfQl6dwbcIgtLDWd8rSh9A8t7a+YzL6B3i0i7D24/ZGkfzwYzPPrAapr0BqfiMadOckmI8iZJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764946806; c=relaxed/simple;
	bh=0/02Urwl1R2UcfOuwmOptN271hcNqvgGoytef+jUIJo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HNuIf17rl7LiVAZLAdb8LbWzfh2vrL7ZELpNXCCI3bBlaym4TCZseS4vHu+vqeIZbB4uzA+TxTwMKjVnQMzaQIb4l8/YJ/r60Y0nXprymUmRrnn1lJxSHHX09cWMOtX5HmDXZzpwCo+tWLIQB+hhjiFwR9EyouOZEFpYC/DT+M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=NvvwT+Xl; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1764946785; x=1765205985;
	bh=/FxBYSqiLvEPPLBRet/OeAbti72yHyHumcmcCrArpUM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=NvvwT+XlqjIGjbPn28ArTuGmb2NZ/bH055y0UgAlc9MgwM3Qjhw8v4wRgOCWSF3FE
	 xxDf6vS2oJ4EbuZitnh1UD1SJBFGDVFKAamJBHAnPCYB1C8NEixS0HVlu7UdzQZYux
	 hQoL1eTYixZfwrAG9yrJN5uJZWcvEF12qKSsvMo2e3fj6LkO9kXw7A5V4ftW64J1Zq
	 5caW8XihbSl4/zFsDaes5KKg33S9eU/uo35Ys2Cp5vOY90g5seYNCtBGvAjbWJd70V
	 STfedzSroYtFp9F3B3FS8yTldpm2mEy72sSSZjWrz+yAcFJltECbtD5sARdWu8QIMw
	 LUM4XzJtpdkqA==
Date: Fri, 05 Dec 2025 14:59:05 +0000
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, Kees Cook <kees@kernel.org>, Danilo Krummrich <dakr@kernel.org>
From: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: jiayuan.chen@linux.dev, m.wieczorretman@pm.me, stable@vger.kernel.org, syzbot+997752115a851cb0cf36@syzkaller.appspotmail.com, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v4 1/3] mm/kasan: Fix incorrect unpoisoning in vrealloc for KASAN
Message-ID: <247fd641cbf4a8e6c8135051772867f6bd2610ad.1764945396.git.m.wieczorretman@pm.me>
In-Reply-To: <cover.1764945396.git.m.wieczorretman@pm.me>
References: <cover.1764945396.git.m.wieczorretman@pm.me>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: d2dc6589d37d0aba1e593ab762db40d7e36c2a38
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Jiayuan Chen <jiayuan.chen@linux.dev>

Syzkaller reported a memory out-of-bounds bug [1]. This patch fixes two
issues:

1. In vrealloc the KASAN_VMALLOC_VM_ALLOC flag is missing when
   unpoisoning the extended region. This flag is required to correctly
   associate the allocation with KASAN's vmalloc tracking.

   Note: In contrast, vzalloc (via __vmalloc_node_range_noprof) explicitly
   sets KASAN_VMALLOC_VM_ALLOC and calls kasan_unpoison_vmalloc() with it.
   vrealloc must behave consistently =E2=80=94 especially when reusing exis=
ting
   vmalloc regions =E2=80=94 to ensure KASAN can track allocations correctl=
y.

2. When vrealloc reuses an existing vmalloc region (without allocating
   new pages) KASAN generates a new tag, which breaks tag-based memory
   access tracking.

Introduce KASAN_VMALLOC_KEEP_TAG, a new KASAN flag that allows reusing
the tag already attached to the pointer, ensuring consistent tag
behavior during reallocation.

Pass KASAN_VMALLOC_KEEP_TAG and KASAN_VMALLOC_VM_ALLOC to the
kasan_unpoison_vmalloc inside vrealloc_node_align_noprof().

[1]: https://syzkaller.appspot.com/bug?extid=3D997752115a851cb0cf36

Fixes: a0309faf1cb0 ("mm: vmalloc: support more granular vrealloc() sizing"=
)
Cc: <stable@vger.kernel.org>
Reported-by: syzbot+997752115a851cb0cf36@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68e243a2.050a0220.1696c6.007d.GAE@googl=
e.com/T/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Co-developed-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
---
 include/linux/kasan.h | 1 +
 mm/kasan/hw_tags.c    | 2 +-
 mm/kasan/shadow.c     | 4 +++-
 mm/vmalloc.c          | 4 +++-
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index d12e1a5f5a9a..6d7972bb390c 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -28,6 +28,7 @@ typedef unsigned int __bitwise kasan_vmalloc_flags_t;
 #define KASAN_VMALLOC_INIT=09=09((__force kasan_vmalloc_flags_t)0x01u)
 #define KASAN_VMALLOC_VM_ALLOC=09=09((__force kasan_vmalloc_flags_t)0x02u)
 #define KASAN_VMALLOC_PROT_NORMAL=09((__force kasan_vmalloc_flags_t)0x04u)
+#define KASAN_VMALLOC_KEEP_TAG=09=09((__force kasan_vmalloc_flags_t)0x08u)
=20
 #define KASAN_VMALLOC_PAGE_RANGE 0x1 /* Apply exsiting page range */
 #define KASAN_VMALLOC_TLB_FLUSH  0x2 /* TLB flush */
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 1c373cc4b3fa..cbef5e450954 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -361,7 +361,7 @@ void *__kasan_unpoison_vmalloc(const void *start, unsig=
ned long size,
 =09=09return (void *)start;
 =09}
=20
-=09tag =3D kasan_random_tag();
+=09tag =3D (flags & KASAN_VMALLOC_KEEP_TAG) ? get_tag(start) : kasan_rando=
m_tag();
 =09start =3D set_tag(start, tag);
=20
 =09/* Unpoison and initialize memory up to size. */
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 5d2a876035d6..5e47ae7fdd59 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -648,7 +648,9 @@ void *__kasan_unpoison_vmalloc(const void *start, unsig=
ned long size,
 =09    !(flags & KASAN_VMALLOC_PROT_NORMAL))
 =09=09return (void *)start;
=20
-=09start =3D set_tag(start, kasan_random_tag());
+=09if (unlikely(!(flags & KASAN_VMALLOC_KEEP_TAG)))
+=09=09start =3D set_tag(start, kasan_random_tag());
+
 =09kasan_unpoison(start, size, false);
 =09return (void *)start;
 }
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 798b2ed21e46..22a73a087135 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4176,7 +4176,9 @@ void *vrealloc_node_align_noprof(const void *p, size_=
t size, unsigned long align
 =09 */
 =09if (size <=3D alloced_size) {
 =09=09kasan_unpoison_vmalloc(p + old_size, size - old_size,
-=09=09=09=09       KASAN_VMALLOC_PROT_NORMAL);
+=09=09=09=09       KASAN_VMALLOC_PROT_NORMAL |
+=09=09=09=09       KASAN_VMALLOC_VM_ALLOC |
+=09=09=09=09       KASAN_VMALLOC_KEEP_TAG);
 =09=09/*
 =09=09 * No need to zero memory here, as unused memory will have
 =09=09 * already been zeroed at initial allocation time or during
--=20
2.52.0



