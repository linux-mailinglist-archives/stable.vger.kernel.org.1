Return-Path: <stable+bounces-191670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B07F8C1CEA6
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 20:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A7340611C
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 19:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921373590D0;
	Wed, 29 Oct 2025 19:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="auxqsyOv"
X-Original-To: stable@vger.kernel.org
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAF0358D3D;
	Wed, 29 Oct 2025 19:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764784; cv=none; b=Z64qn7weCdgsS2xPxriQSZO8+7tqrKmOGsFDmPIYEcih/NVx+/qYrsAF5pKiUvqadf8SjFDv36tTV6ukvyin4MWRuh/+3YbQLXwoVY1Pxw+ScchgxJr+xGfp72PqOZkVmb6TQPzqYo/sacBSMv0Uf90Bgj5IobYxr8QHnGz8Ccg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764784; c=relaxed/simple;
	bh=X4z1GYkQrRVKx5pqYKCrGoe/bG8bmW9/6rB10Yrnyzg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=neGhl3TIrsGQQDXDWfLGu533Jr2V3vKfhx/Jz3V0GxOuxttX7okArr6jG6QroC2b9NasE1k9R31XSec7OEwKr3PCXwWKNe2gTjX3ak0R++vbyssWDjLgqewqLpIPHcWLAlsSKXc3uHeNM0xjZVkUDutamjYIN+R9gtMd7/ojnTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=auxqsyOv; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1761764770; x=1762023970;
	bh=oOT+8LaCSd2bsGWZH31RqkbowzlJMvnmRkALmEb4OMQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=auxqsyOvljSpXFTF5AKB3T/509bEa7/sfm3pUYNafcxp0ATbiM7w+PvdgHqDzP/Kl
	 o6m94wJHeNA3LtEU9nJ3AbSjzlGm7hiKBmLb/V/GAJmJs7bw09PVZ8hQvZKOkhPZvg
	 DJMBZlr4c42lwpCP6cG0IYpaei1wF90rYUs7RQpjzwhRHBhBgw2CbJTJkF9OyZXbaZ
	 yfuwOUsn32t9bC5lYqxSFDkgHGelKaEZELumFwoYqF2EusJKk8QLDQkIBqE9T1z3V5
	 wXfTIeT/vk723bJXmhmoHgApPMBuwmceI0urqM/axJShS22fMn8OyttRP9uyR911Xi
	 er2jNGKegxn+g==
Date: Wed, 29 Oct 2025 19:06:03 +0000
To: xin@zytor.com, peterz@infradead.org, kaleshsingh@google.com, kbingham@kernel.org, akpm@linux-foundation.org, nathan@kernel.org, ryabinin.a.a@gmail.com, dave.hansen@linux.intel.com, bp@alien8.de, morbo@google.com, jeremy.linton@arm.com, smostafa@google.com, kees@kernel.org, baohua@kernel.org, vbabka@suse.cz, justinstitt@google.com, wangkefeng.wang@huawei.com, leitao@debian.org, jan.kiszka@siemens.com, fujita.tomonori@gmail.com, hpa@zytor.com, urezki@gmail.com, ubizjak@gmail.com, ada.coupriediaz@arm.com, nick.desaulniers+lkml@gmail.com, ojeda@kernel.org, brgerst@gmail.com, elver@google.com, pankaj.gupta@amd.com, glider@google.com, mark.rutland@arm.com, trintaeoitogc@gmail.com, jpoimboe@kernel.org, thuth@redhat.com, pasha.tatashin@soleen.com, dvyukov@google.com, jhubbard@nvidia.com, catalin.marinas@arm.com, yeoreum.yun@arm.com, mhocko@suse.com, lorenzo.stoakes@oracle.com, samuel.holland@sifive.com, vincenzo.frascino@arm.com, bigeasy@linutronix.de, surenb@google.com,
	ardb@kernel.org, Liam.Howlett@oracle.com, nicolas.schier@linux.dev, ziy@nvidia.com, kas@kernel.org, tglx@linutronix.de, mingo@redhat.com, broonie@kernel.org, corbet@lwn.net, andreyknvl@gmail.com, maciej.wieczor-retman@intel.com, david@redhat.com, maz@kernel.org, rppt@kernel.org, will@kernel.org, luto@kernel.org
From: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-kbuild@vger.kernel.org, linux-mm@kvack.org, llvm@lists.linux.dev, linux-doc@vger.kernel.org, m.wieczorretman@pm.me, stable@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH v6 02/18] kasan: Unpoison vms[area] addresses with a common tag
Message-ID: <932121edc75be8e2038d64ecb4853df2e2b258df.1761763681.git.m.wieczorretman@pm.me>
In-Reply-To: <cover.1761763681.git.m.wieczorretman@pm.me>
References: <cover.1761763681.git.m.wieczorretman@pm.me>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: b78f8be95b4a3268cc028d63fcca55df4e5c6664
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>

The problem presented here is related to NUMA systems and tag-based
KASAN modes - software and hardware ones. It can be explained in the
following points:

        1. There can be more than one virtual memory chunk.
        2. Chunk's base address has a tag.
        3. The base address points at the first chunk and thus inherits
           the tag of the first chunk.
        4. The subsequent chunks will be accessed with the tag from the
           first chunk.
        5. Thus, the subsequent chunks need to have their tag set to
           match that of the first chunk.

Unpoison all vms[]->addr memory and pointers with the same tag to
resolve the mismatch.

Fixes: 1d96320f8d53 ("kasan, vmalloc: add vmalloc tagging for SW_TAGS")
Cc: <stable@vger.kernel.org> # 6.1+
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Tested-by: Baoquan He <bhe@redhat.com>
---
Changelog v6:
- Add Baoquan's tested-by tag.
- Move patch to the beginning of the series as it is a fix.
- Add fixes tag.

 mm/kasan/tags.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index ecc17c7c675a..c6b40cbffae3 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -148,12 +148,20 @@ void __kasan_save_free_info(struct kmem_cache *cache,=
 void *object)
 =09save_stack_info(cache, object, 0, true);
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



