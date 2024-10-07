Return-Path: <stable+bounces-81476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC5D993748
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 21:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16021C227EA
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E761DDA3C;
	Mon,  7 Oct 2024 19:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4kY2qmlU"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CEC13B797
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 19:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728329120; cv=none; b=DomZsBYGZG27OWHI7gt3vxRPXjj9BxCfNI6W1n0aIIzq9mGpBNb+IJ2ACM7J0GUTlWFw5Tsx4RjJkMzK6jrKXr56n3OYKvd2LyvouaRo6dtyBdXMgzbhepWp/rGONOX/umNK0NDi/lgF9IqCdrdWzvETojqec4Q5cv2f89sAvj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728329120; c=relaxed/simple;
	bh=0IhdWC17rzBAQapljFG63a0hLiPpVx1yPc6Qasf1zpE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SZ5FlKVid3yVmqRRZt8hTM5JHCeYO6ijHEk5ryDEZSUgYyRrQMgqGHbtfeWiURaJA/EEV82/2OmFBWsYSl1oskkMpH9NsdoojxgYAwDGeYwpfz2pM+vpPVwIDmiRAjOBrBmTP0ByOTgz3m/CeTJxLE0A+/gg10nsFFfkvP0XvUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4kY2qmlU; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2b049b64aso77356847b3.3
        for <stable@vger.kernel.org>; Mon, 07 Oct 2024 12:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728329117; x=1728933917; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=INVb5YwfIp0vmB3x3v0V8APhhvcemuk9P/Yoi7NKfgc=;
        b=4kY2qmlUHC+EPJVtUiMMsPzredt6XVl/tx/mzK5+cop4A5neu+5RyTneS1YQFM8oUN
         ZAQIlEJCz68xN331NlKIY9IEDnmMeUaHt53gnaQcDRNIkjA/rLmkGSM++R+/ZoXwx8ZK
         IYQsAbWc3qletFiMka9a7+wcj0A11V0boHGLn9WX1TVcM9smrNt/k2RfYKnI2Jb3iL+N
         nnxIUsRixTJmM+tnfqBGi+M1HsVMNyTWy/QZFhbx5iO628Y+2fbTSsD1zqEIdguvEF54
         7Egpz7o1XXLRD+FImBfk4/aoMHU9xRpJeChwbCrCMm2HzyKJ7cnJ8uFtxKBCbe4aswrr
         MOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728329117; x=1728933917;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=INVb5YwfIp0vmB3x3v0V8APhhvcemuk9P/Yoi7NKfgc=;
        b=fFpT0jT8VjmmLGFXY8l7QrpfdU6m7vjTyu+FccT+ZBgteHXnUaRIWYHt6Q+JajrNW+
         49Ky2LmtkiCt4YniydF3g2fleMD78lkfoW7CGzCzgv4K0mC4v8tkQn1ocz1Y/KY2YMbb
         Nd+USjGSxYJHvYj7pP3af/YoceaWFPnw1shFNjV+cu0epaDPqCRyrsBGlNTMgcOcIr2l
         1JiTN1tjt5OCDY4hwFU88GjWMTtVAMGPNx+ren6fWuWAcwqPWYBtXotbahE+3fmVACuJ
         1QoEmyRiByCDqxBL4+bY3rTiVFSYY5z96FuRq3MlDS4g3rsGBV6rc9L8wBcLXZlSmUyw
         1uoQ==
X-Gm-Message-State: AOJu0YzpOdOJEjZqWfH/ZpwuCujXcegjdF95U9ZSwyDvbYv+7r5vs3pv
	b26o4JYpsTbonj7/tGIqEnYf41F35xfD+tQQWEpqD7Hy8vPzF+E+A3nyizdM1O+uEVtir+8RrmM
	agFY2IRfGynSHysCnlXFtuj2iZ0mNiWz5hAc2z430WiHQkXYNTCWOPDNKPGKqysOuJvtHZ47Jcs
	iMK0Lk9rseKxnzZrqH+Mq7EHsbHvZlv2us5ms+SHBsg29Tm0iIjvW7qg==
X-Google-Smtp-Source: AGHT+IFgFnFEKgq96ZvWBGlYAqd2te13/xTNb00ta5kCriqF3QzSKzZspuOzbr8Zcs6lEiDMrw5dKX10YEyOMTGj
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:a8:616:ac13:f2fc])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:6d0a:b0:6db:c6ac:62a0 with
 SMTP id 00721157ae682-6e2c72a0cc0mr2636847b3.5.1728329116511; Mon, 07 Oct
 2024 12:25:16 -0700 (PDT)
Date: Mon,  7 Oct 2024 19:25:12 +0000
In-Reply-To: <2024100707-delta-trance-5682@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024100707-delta-trance-5682@gregkh>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241007192512.2534138-1-yosryahmed@google.com>
Subject: [PATCH 6.6.y] mm: z3fold: deprecate CONFIG_Z3FOLD
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
---
 arch/loongarch/configs/loongson3_defconfig |  1 -
 arch/powerpc/configs/ppc64_defconfig       |  1 -
 mm/Kconfig                                 | 25 ++++++++++++++++------
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index a3b52aaa83b33..e5f70642ed206 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -83,7 +83,6 @@ CONFIG_ZPOOL=y
 CONFIG_ZSWAP=y
 CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD=y
 CONFIG_ZBUD=y
-CONFIG_Z3FOLD=y
 CONFIG_ZSMALLOC=m
 # CONFIG_COMPAT_BRK is not set
 CONFIG_MEMORY_HOTPLUG=y
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 6e7b9e8fd2251..65e518dde2c2f 100644
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
index ece4f2847e2b4..c11cd01169e8d 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -147,12 +147,15 @@ config ZSWAP_ZPOOL_DEFAULT_ZBUD
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
 	select ZSMALLOC
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
 config ZSMALLOC
 	tristate
 	prompt "N:1 compression allocator (zsmalloc)" if ZSWAP
-- 
2.47.0.rc0.187.ge670bccf7e-goog


