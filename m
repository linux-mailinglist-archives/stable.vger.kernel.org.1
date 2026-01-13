Return-Path: <stable+bounces-208289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68ED9D1B037
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 20:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5518330471A9
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 19:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A631A34EF0D;
	Tue, 13 Jan 2026 19:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9I1sV5q"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BF4369982
	for <stable@vger.kernel.org>; Tue, 13 Jan 2026 19:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768331765; cv=none; b=dSXmJWhkU7ByMy4SJuLJ29pAFg4qqszGlFKva0wtI91tzAGVppwTOuYF9Gn0BNn8XtdU8N66jng/WVwOs7HKhNRgPeqmWFi27YhTlvabN2rcwh0KLGPl9STswBC5bKNUcllZC7KgXfBvDTM5FAqU9eAbZKJiAWdadI74II2ntAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768331765; c=relaxed/simple;
	bh=Z5urRHLHK7nLUana3bPqam/CMrPaNzlqkPx1+GvkixM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ea7HyAadWNqL7EoMPHuOS4SV2cJKothXJ0yLHb8KmMK3N9ES8gn7RGkSIPBS577VFdut0HXK1hV6DdiOh/1k+CB5wJCzmhgSdHTHRtpCFXGviRjUPOMoOuQzgbFrk2VesggL52aUzEI8kjHG7yEjgdYSqI3dRastT3FEZWRb4l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9I1sV5q; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3831b6abed6so5397861fa.1
        for <stable@vger.kernel.org>; Tue, 13 Jan 2026 11:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768331761; x=1768936561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNWxc7urAc+WPUb7dtJ1KQJNNzOu7ZjngdMJAMiDVCE=;
        b=U9I1sV5qTsEO7dADG3acuoYUup2uwKdSiXBHrtAWFHyo7QUfAkAxoeqMMbDk8uZBQ4
         +JBkB59hZ3gh7dfMrg7xmIexRV0utaInGglhJG1fz+gztTZGu2kd2jQEM0yePrQwtuiI
         1BWzQbJqWco+IttK4jVTGYj0lnBLFt+KhoXhbeWOg8fSjz/mdCpp0i+CD1z81/RUEESj
         x1WOecDuQsp8zN7M1UyDWgCuizCx2BJrmm36PoXlLtmdLyiUl+418wJh2UW1xZAsxFfa
         tkYW+gHoOgJN9L7uNvqXaCxKXd9/qsurlsJt/mSOoNn893C5oJEgP8VT7KUeZIE5EQOc
         yCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768331761; x=1768936561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kNWxc7urAc+WPUb7dtJ1KQJNNzOu7ZjngdMJAMiDVCE=;
        b=rTro633ipR4MZ1Nk0Rrr8CPEZJ7f3dDuGrMR1yLrIyIs+UwueoNl+MlBiKV1nVcRJv
         ahCr4JJRz5qq/fxNgDR3qDnAwMlVHC6ns7zCV4k9zFZVrFlGqAxB/D/FWpVN+Sh5s2AA
         ut+z2NSJPlwwTJYDqEpuu4SX0SO7nnFzaKSi+S31DCfAh+N5A4b73Cdnb01PzBcxrKwx
         dx8ChpKvMPTHHEGGhhlMkeXMAEJ8hHDcnfjKM5Vl90W7/x/VAN+cm5xBlAKr+5D+ct5z
         txKR68BShuG5V+nZi6yn5lmtwkggCIfGyFVwY4kadFjsu/HAUOrNZVcdJkCmztF2gxcN
         KqgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpEx+Ag9aCie5E9i46NCXcIbXDbkis6A2aNhg6W7hXSRAIoAb014rZkiy9PtFkKyGtns70SZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwsYU158BvxkNLTAO6Fac16KPP6XVdjv4lXMLQL8nehn78fhcL
	8e7AK5OPLvJOLbbboGJlhBrUjdD+zwZ/8fQrnNq9r4PRYpOPed+yyxpt
X-Gm-Gg: AY/fxX4glcdUqzuj8wbIoe57b5xfnSDJkNbuEeyGK3RKzIkyBTWmLBJW0R7Mlv+3FR7
	uAsld1ekvGqCAAZmw0tV4ipRoPLJIWSVU1Q9aR9G45aeSjnhDMspg/5zMGqrq/sOJ/9ZMD8Gpeq
	2VYvTwuSOg5kBASOZfka6MpmXENjHTKHWH9L1JgCVEl+LmosL4UetDILVPEKQdLlv6n+LuVuoU9
	Gt3dXsakNUlvF0gzbs1t7OHsxD1JIGocGEFrsAUR9xtSVb1sfMo663kTr/AlqWzwNNT2a4sB6Jz
	Wy66TdHB17g+xLdE/bpfUd+/Ovd+Z/iQlJTzgxiPZgx/jNjItFT66fDEmOcIjFNsM+8ETJLSb9r
	isifjGkL0g2Wc3HzMUJZc7TTh4XbibzgGLJIfTalQcjW0ihN/1armXKft8xnvFLDxVx+PJ/QqFs
	YV3Lwl12X/4sJGNQeawwZrvTyTH8v/GEq+sg==
X-Google-Smtp-Source: AGHT+IEWr6drC+zpyxpYdRsl+WTpwPbMxB4PxC6CXmyNXqXAc6ksEPPqWnLy4U69o0ywwEWEZ9DZXw==
X-Received: by 2002:a05:6512:3b25:b0:59b:7291:9cd8 with SMTP id 2adb3069b0e04-59b72919e55mr4212248e87.7.1768331760373;
        Tue, 13 Jan 2026 11:16:00 -0800 (PST)
Received: from dellarbn.yandex.net ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b6a97e94csm5568773e87.91.2026.01.13.11.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 11:15:59 -0800 (PST)
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
	Maciej Wieczor-Retman <m.wieczorretman@pm.me>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com,
	Uladzislau Rezki <urezki@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	joonki.min@samsung-slsi.corp-partner.google.com,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mm/kasan: Fix KASAN poisoning in vrealloc()
Date: Tue, 13 Jan 2026 20:15:15 +0100
Message-ID: <20260113191516.31015-1-ryabinin.a.a@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CANP3RGeuRW53vukDy7WDO3FiVgu34-xVJYkfpm08oLO3odYFrA@mail.gmail.com>
References: <CANP3RGeuRW53vukDy7WDO3FiVgu34-xVJYkfpm08oLO3odYFrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A KASAN warning can be triggered when vrealloc() changes the requested
size to a value that is not aligned to KASAN_GRANULE_SIZE.

    ------------[ cut here ]------------
    WARNING: CPU: 2 PID: 1 at mm/kasan/shadow.c:174 kasan_unpoison+0x40/0x48
    ...
    pc : kasan_unpoison+0x40/0x48
    lr : __kasan_unpoison_vmalloc+0x40/0x68
    Call trace:
     kasan_unpoison+0x40/0x48 (P)
     vrealloc_node_align_noprof+0x200/0x320
     bpf_patch_insn_data+0x90/0x2f0
     convert_ctx_accesses+0x8c0/0x1158
     bpf_check+0x1488/0x1900
     bpf_prog_load+0xd20/0x1258
     __sys_bpf+0x96c/0xdf0
     __arm64_sys_bpf+0x50/0xa0
     invoke_syscall+0x90/0x160

Introduce a dedicated kasan_vrealloc() helper that centralizes
KASAN handling for vmalloc reallocations. The helper accounts for KASAN
granule alignment when growing or shrinking an allocation and ensures
that partial granules are handled correctly.

Use this helper from vrealloc_node_align_noprof() to fix poisoning
logic.

Reported-by: Maciej Żenczykowski <maze@google.com>
Reported-by: <joonki.min@samsung-slsi.corp-partner.google.com>
Closes: https://lkml.kernel.org/r/CANP3RGeuRW53vukDy7WDO3FiVgu34-xVJYkfpm08oLO3odYFrA@mail.gmail.com
Fixes: d699440f58ce ("mm: fix vrealloc()'s KASAN poisoning logic")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
---
 include/linux/kasan.h |  6 ++++++
 mm/kasan/shadow.c     | 24 ++++++++++++++++++++++++
 mm/vmalloc.c          |  7 ++-----
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 9c6ac4b62eb9..ff27712dd3c8 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -641,6 +641,9 @@ kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms,
 		__kasan_unpoison_vmap_areas(vms, nr_vms, flags);
 }
 
+void kasan_vrealloc(const void *start, unsigned long old_size,
+		unsigned long new_size);
+
 #else /* CONFIG_KASAN_VMALLOC */
 
 static inline void kasan_populate_early_vm_area_shadow(void *start,
@@ -670,6 +673,9 @@ kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms,
 			  kasan_vmalloc_flags_t flags)
 { }
 
+static inline void kasan_vrealloc(const void *start, unsigned long old_size,
+				unsigned long new_size) { }
+
 #endif /* CONFIG_KASAN_VMALLOC */
 
 #if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 32fbdf759ea2..e9b6b2d8e651 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -651,6 +651,30 @@ void __kasan_poison_vmalloc(const void *start, unsigned long size)
 	kasan_poison(start, size, KASAN_VMALLOC_INVALID, false);
 }
 
+void kasan_vrealloc(const void *addr, unsigned long old_size,
+		unsigned long new_size)
+{
+	if (!kasan_enabled())
+		return;
+
+	if (new_size < old_size) {
+		kasan_poison_last_granule(addr, new_size);
+
+		new_size = round_up(new_size, KASAN_GRANULE_SIZE);
+		old_size = round_up(old_size, KASAN_GRANULE_SIZE);
+		if (new_size < old_size)
+			__kasan_poison_vmalloc(addr + new_size,
+					old_size - new_size);
+	} else if (new_size > old_size) {
+		old_size = round_down(old_size, KASAN_GRANULE_SIZE);
+		__kasan_unpoison_vmalloc(addr + old_size,
+					new_size - old_size,
+					KASAN_VMALLOC_PROT_NORMAL |
+					KASAN_VMALLOC_VM_ALLOC |
+					KASAN_VMALLOC_KEEP_TAG);
+	}
+}
+
 #else /* CONFIG_KASAN_VMALLOC */
 
 int kasan_alloc_module_shadow(void *addr, size_t size, gfp_t gfp_mask)
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 41dd01e8430c..2536d34df058 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4322,7 +4322,7 @@ void *vrealloc_node_align_noprof(const void *p, size_t size, unsigned long align
 		if (want_init_on_free() || want_init_on_alloc(flags))
 			memset((void *)p + size, 0, old_size - size);
 		vm->requested_size = size;
-		kasan_poison_vmalloc(p + size, old_size - size);
+		kasan_vrealloc(p, old_size, size);
 		return (void *)p;
 	}
 
@@ -4330,16 +4330,13 @@ void *vrealloc_node_align_noprof(const void *p, size_t size, unsigned long align
 	 * We already have the bytes available in the allocation; use them.
 	 */
 	if (size <= alloced_size) {
-		kasan_unpoison_vmalloc(p + old_size, size - old_size,
-				       KASAN_VMALLOC_PROT_NORMAL |
-				       KASAN_VMALLOC_VM_ALLOC |
-				       KASAN_VMALLOC_KEEP_TAG);
 		/*
 		 * No need to zero memory here, as unused memory will have
 		 * already been zeroed at initial allocation time or during
 		 * realloc shrink time.
 		 */
 		vm->requested_size = size;
+		kasan_vrealloc(p, old_size, size);
 		return (void *)p;
 	}
 
-- 
2.52.0


