Return-Path: <stable+bounces-81474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E87A2993730
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 21:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A11A28498C
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5014A1DD861;
	Mon,  7 Oct 2024 19:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4oIhAhzp"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4AE13B797
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728328919; cv=none; b=u3VNNdee4fch4j0hzX5WJpw2aRbSkziNgWLq7ZFWYPuNSb+x9iMn3h56yt5vFq5svx6o0XB9iJ90x4egZB3w/lA7NGwMRo/8CzspDJu6ge440QHwOjAYgMAJ+zDMiY7+BEYegMuozj4rvVGU7hmNV6Kh3wtfJvjRAi4Oa94+tIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728328919; c=relaxed/simple;
	bh=zrXiCXoBeB8D12f7qzPsUOnD+a+8b9X+QMXXoE5DKlA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OGuyTinBPTMy6pLq51wkaogsuLFuWtH6YSq4j5slU/sQ5HTUon2qYIgZxZxeALi0LHbvv8fTMFAP2Ww5kLtDcnZ99trXwWJ2mdqsP5JFHjGjPDi/wh26U7U5iDQrA0u7fCZNksogDLDOhBdLDvA7YMUJNyvEaqf//0MSlvqJD2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4oIhAhzp; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e28b624bfcso68104507b3.2
        for <stable@vger.kernel.org>; Mon, 07 Oct 2024 12:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728328916; x=1728933716; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ofUfXptkizC76YvdVCUmcwogwbitwtJzYQ2uC1DdqTM=;
        b=4oIhAhzpq7kXHQ3yyQj7IO+xd3gACJtpeBFY3eOFdw4GnuF1xLzEQrlUCjlkFh8kJe
         IEdogU7xTvqm2eih/+YNe60j7HUwjKuW3Yqt6JRIYMuHSr7xkysezH0NFKzKoqCgRvFM
         BEE1EHhNGrAvbUZ1H64/yBE60Y0odqtdwdCgbjH9zWJBwV8iHaOR1V3w9k2wAY36ndEt
         KAnURxt1SJauh/AKX1SFI+lr6KiJc39Oh+aTnwt+ZPfK/uE/4LsGkoBn3bsAUuKajV0k
         cd0xJOo0NiZWEmJhG1qg3SavdEgpdjXZpEXl+IPP0PUxLGp+H1obZMXwAFPvcIwhj7HR
         Bz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728328916; x=1728933716;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ofUfXptkizC76YvdVCUmcwogwbitwtJzYQ2uC1DdqTM=;
        b=F4rCWpGr1QWRMRcMSc/k1Ro/zU3mCVQvZ9yER4sGKINtX58y5LHW4zUDIlryJ7tQ7g
         X9dLVM8NqLeBvMXtEOkHoUVhMcotZvwjszCCoUXHuSPJEnFOSBwQcO/ZXb236zTT/4Gn
         Je2ccyrzw/paEK6OHtD8OcK45jSX7Agb+xUSx16JoM+LSGkCnYKUekhfSek6iCEHUtV4
         VYWky+GrxcASa9gjemjWGvRCIZsoLNQgQHIU4BgUeqRLXwXmn+lqEC4tYzrpsB5AdcmT
         mtvQVH2vkvl6JbJYe3cqXHHu1ayOqil+kOMHconkmRnlphm66ssBaAjjdBFHsrY0YJ51
         4Qgw==
X-Gm-Message-State: AOJu0Yw59SOPUPxhJ3KLLnFGbpaI1CaC9VN60PHBEXU6VutLNtLuZCY6
	9RzwheEtQDEjwgaBxdiv9X7SlggMll+SzWP1S3iuIdJVElzpPGLTRfMlL7hMcaK9Dxy7muHJRWn
	tCmbCyU+Mj5XzMAjK01MeETXB4QcYGKRuz5MVx/HPmKd5/nA77zxdvLkryJuJ206QZlv5U5ivxC
	lxdj811NN4r6h5HNKjwbnKMR7da4X3IzIiPWWVCwz+uiPW3/U3tCkHxQ==
X-Google-Smtp-Source: AGHT+IEyjkiYRkpRmZFX0tFO5CITURKnYW7ZNDKUZIIkRzPKMKLjOPHyMQOEfonlSA13zc2Nl8d299pY8Mwk88or
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:a8:616:ac13:f2fc])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:961:b0:64a:e220:bfb5 with SMTP
 id 00721157ae682-6e2c6fbe3edmr1549737b3.1.1728328915808; Mon, 07 Oct 2024
 12:21:55 -0700 (PDT)
Date: Mon,  7 Oct 2024 19:21:16 +0000
In-Reply-To: <2024100707-delta-trance-5682@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024100707-delta-trance-5682@gregkh>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241007192116.2529593-1-yosryahmed@google.com>
Subject: [PATCH 6.11.y] mm: z3fold: deprecate CONFIG_Z3FOLD
From: Yosry Ahmed <yosryahmed@google.com>
To: stable@vger.kernel.org
Cc: Yosry Ahmed <yosryahmed@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Chris Down <chris@chrisdown.name>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Vitaly Wool <vitaly.wool@konsulko.com>, 
	Christoph Hellwig <hch@lst.de>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Huacai Chen <chenhuacai@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, WANG Xuerui <kernel@xen0n.name>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

The z3fold compressed pages allocator is rarely used, most users use
zsmalloc.  The only disadvantage of zsmalloc in comparison is the
dependency on MMU, and zbud is a more common option for !MMU as it was the
default zswap allocator for a long time.

Historically, zsmalloc had worse latency than zbud and z3fold but offered
better memory savings.  This is no longer the case as shown by a simple
recent analysis [1].  That analysis showed that z3fold does not have any
advantage over zsmalloc or zbud considering both performance and memory
usage.  In a kernel build test on tmpfs in a limited cgroup, z3fold took
3% more time and used 1.8% more memory.  The latency of zswap_load() was
7% higher, and that of zswap_store() was 10% higher.  Zsmalloc is better
in all metrics.

Moreover, z3fold apparently has latent bugs, which was made noticeable by
a recent soft lockup bug report with z3fold [2].  Switching to zsmalloc
not only fixed the problem, but also reduced the swap usage from 6~8G to
1~2G.  Other users have also reported being bitten by mistakenly enabling
z3fold.

Other than hurting users, z3fold is repeatedly causing wasted engineering
effort.  Apart from investigating the above bug, it came up in multiple
development discussions (e.g.  [3]) as something we need to handle, when
there aren't any legit users (at least not intentionally).

The natural course of action is to deprecate z3fold, and remove in a few
cycles if no objections are raised from active users.  Next on the list
should be zbud, as it offers marginal latency gains at the cost of huge
memory waste when compared to zsmalloc.  That one will need to wait until
zsmalloc does not depend on MMU.

Rename the user-visible config option from CONFIG_Z3FOLD to
CONFIG_Z3FOLD_DEPRECATED so that users with CONFIG_Z3FOLD=y get a new
prompt with explanation during make oldconfig.  Also, remove
CONFIG_Z3FOLD=y from defconfigs.

[1]https://lore.kernel.org/lkml/CAJD7tkbRF6od-2x_L8-A1QL3=2Ww13sCj4S3i4bNndqF+3+_Vg@mail.gmail.com/
[2]https://lore.kernel.org/lkml/EF0ABD3E-A239-4111-A8AB-5C442E759CF3@gmail.com/
[3]https://lore.kernel.org/lkml/CAJD7tkbnmeVugfunffSovJf9FAgy9rhBVt_tx=nxUveLUfqVsA@mail.gmail.com/

[arnd@arndb.de: deprecate ZSWAP_ZPOOL_DEFAULT_Z3FOLD as well]
  Link: https://lkml.kernel.org/r/20240909202625.1054880-1-arnd@kernel.org
Link: https://lkml.kernel.org/r/20240904233343.933462-1-yosryahmed@google.com
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Chris Down <chris@chrisdown.name>
Acked-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Vitaly Wool <vitaly.wool@konsulko.com>
Acked-by: Christoph Hellwig <hch@lst.de>
Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 7a2369b74abf76cd3e54c45b30f6addb497f831b)
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 arch/loongarch/configs/loongson3_defconfig |  1 -
 arch/powerpc/configs/ppc64_defconfig       |  1 -
 mm/Kconfig                                 | 25 ++++++++++++++++------
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index b4252c357c8e2..75b366407a60a 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -96,7 +96,6 @@ CONFIG_ZPOOL=y
 CONFIG_ZSWAP=y
 CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD=y
 CONFIG_ZBUD=y
-CONFIG_Z3FOLD=y
 CONFIG_ZSMALLOC=m
 # CONFIG_COMPAT_BRK is not set
 CONFIG_MEMORY_HOTPLUG=y
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 544a65fda77bc..d39284489aa26 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -81,7 +81,6 @@ CONFIG_MODULE_SIG_SHA512=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_BINFMT_MISC=m
 CONFIG_ZSWAP=y
-CONFIG_Z3FOLD=y
 CONFIG_ZSMALLOC=y
 # CONFIG_SLAB_MERGE_DEFAULT is not set
 CONFIG_SLAB_FREELIST_RANDOM=y
diff --git a/mm/Kconfig b/mm/Kconfig
index b72e7d040f789..03395624bc709 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -146,12 +146,15 @@ config ZSWAP_ZPOOL_DEFAULT_ZBUD
 	help
 	  Use the zbud allocator as the default allocator.
 
-config ZSWAP_ZPOOL_DEFAULT_Z3FOLD
-	bool "z3fold"
-	select Z3FOLD
+config ZSWAP_ZPOOL_DEFAULT_Z3FOLD_DEPRECATED
+	bool "z3foldi (DEPRECATED)"
+	select Z3FOLD_DEPRECATED
 	help
 	  Use the z3fold allocator as the default allocator.
 
+	  Deprecated and scheduled for removal in a few cycles,
+	  see CONFIG_Z3FOLD_DEPRECATED.
+
 config ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
 	bool "zsmalloc"
 	depends on HAVE_ZSMALLOC
@@ -164,7 +167,7 @@ config ZSWAP_ZPOOL_DEFAULT
        string
        depends on ZSWAP
        default "zbud" if ZSWAP_ZPOOL_DEFAULT_ZBUD
-       default "z3fold" if ZSWAP_ZPOOL_DEFAULT_Z3FOLD
+       default "z3fold" if ZSWAP_ZPOOL_DEFAULT_Z3FOLD_DEPRECATED
        default "zsmalloc" if ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
        default ""
 
@@ -178,15 +181,25 @@ config ZBUD
 	  deterministic reclaim properties that make it preferable to a higher
 	  density approach when reclaim will be used.
 
-config Z3FOLD
-	tristate "3:1 compression allocator (z3fold)"
+config Z3FOLD_DEPRECATED
+	tristate "3:1 compression allocator (z3fold) (DEPRECATED)"
 	depends on ZSWAP
 	help
+	  Deprecated and scheduled for removal in a few cycles. If you have
+	  a good reason for using Z3FOLD over ZSMALLOC, please contact
+	  linux-mm@kvack.org and the zswap maintainers.
+
 	  A special purpose allocator for storing compressed pages.
 	  It is designed to store up to three compressed pages per physical
 	  page. It is a ZBUD derivative so the simplicity and determinism are
 	  still there.
 
+config Z3FOLD
+	tristate
+	default y if Z3FOLD_DEPRECATED=y
+	default m if Z3FOLD_DEPRECATED=m
+	depends on Z3FOLD_DEPRECATED
+
 config HAVE_ZSMALLOC
 	def_bool y
 	depends on MMU
-- 
2.47.0.rc0.187.ge670bccf7e-goog


