Return-Path: <stable+bounces-81477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D972F993761
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 21:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05551C22D77
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43171DDC11;
	Mon,  7 Oct 2024 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uQlGkS/k"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B4E15B12F
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 19:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728329531; cv=none; b=VnT1DbCifiZU2ruPCEwfvq1DlWpRWzhpIU9KHKCtcsXfIXdpSWih8BdSpY06WvYX1jSzVAvRFL1tmn4jsEDeFVEc1S/pX6zeUk/rWFeeODOWkneZrPifpxVhH9cH+mtLkNthpIBj4teS+Um3xvrPsUsOcTLF8QGOz5xqhdMwXM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728329531; c=relaxed/simple;
	bh=gVKaVNcLmPZ8+/HG8hTKQJd793QQPS5a+MPntrepH2A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BC6PqNo4aGNva522eMCrp9A/LTIUmnSCBB/0K8smTJY+Dw3f0x6EHmrgeCNKVRXmJDElgDgjD6qOfPaPM1zbjSB5qycdEmzpRhxm5S+hI46cQO+MgNqRi/W6/PM/yuyddH3p+se3aqYcyCV05wwJSPtBRgciDi+cPTOmQv8wphM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uQlGkS/k; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e25cef43f5aso5702288276.3
        for <stable@vger.kernel.org>; Mon, 07 Oct 2024 12:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728329526; x=1728934326; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aQ4nZK36dvasxpfTiF75+2bg3CsdUZgwatgcnJXcD2c=;
        b=uQlGkS/kfdndfbgfLfBjXychPREs72MR8yrx8B4m56iLkQ36tFCUDsm5ViMUmIhkpQ
         alT0Z1haYhYQd+jgf5QWDUdPgvD+hYkq4EXNulugICL1vhOU0ZcS1S4mf60CYSOLejQS
         2fMt/hIJgpY0CbxgdORR/z+vNG35KvhRfrq8YIS+H+N4H/flIrQG1xCe0+f+dSUbyYNN
         Aiv4ZdHrODDSCf8Ei3hUTDTOO/+7RTzhnV0/TphlFbEYSgZCzxbbRMBFaBQF0m/u6hZI
         A11PAZ4SLLbbrRft3/jqTrnxZ07AB35RzrsZS6RV/omG5djZRfcATylfwIVaONqbDmji
         dPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728329526; x=1728934326;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQ4nZK36dvasxpfTiF75+2bg3CsdUZgwatgcnJXcD2c=;
        b=TlfTBAFHLttOppbMr0uQxNcSlsxN9aEBW/jOeofxyKI03/kA5ypa9WsuFjq+244SkS
         ViPrr0QhfMMmG1zBNhs/1+snpv8g9ghUYeAPlWgducFjYGBSWWhY8NbqnCJt1rtbnEfP
         BRC2BN6aCOLoS1Pn/RxopsR97YuKhz8MQRbBl6kG0C+0gfTjWcz0tEbmKbgupLxuXWUq
         uraLuKS29D43vzSAbISRBhh9COHDcJ5eUrYkbKU+CECWyFPxHLLvUbrE6BqLfLVHpSPS
         Q2cNCEty+FEEbXhz5DGHNX9neDVCsjErM/y3+E3s5X6MYnuQVm/qJLLDtI2N83QshJ4f
         IbKQ==
X-Gm-Message-State: AOJu0YzHQsiUsauCGMRjyiLh0UxcKQgbwGuUiTPEWihFdDPqzd6xiYt4
	PlvBA/DmHTYHXYgf9dF+iswpz9QO4/76tSBwk9GcSiUTS3EZdL7o2L6xf4Quv8kGrVhFh711THn
	rErUznUu+ogZiZMVDg0viZjBEIWbZOhISXFRbWA0YvGeQ35XBjsrPevshl8xkD0RqNH9GSPCk5j
	M8dcoosVuDuxNKcB2zeDywB+vBA1pMgDHYne4NAkudDXSPx+0gRoboVA==
X-Google-Smtp-Source: AGHT+IHeE5wzkX1L2z/jQrdYOlPBvWWl1+rlSAWJvDWDe6VXFB7ccTWFPQjxBJvHgbWgS8phi99t5NVjypgD7bvh
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:a8:616:ac13:f2fc])
 (user=yosryahmed job=sendgmr) by 2002:a5b:6c6:0:b0:e22:5f73:1701 with SMTP id
 3f1490d57ef6-e28934fdfc5mr58056276.0.1728329525568; Mon, 07 Oct 2024 12:32:05
 -0700 (PDT)
Date: Mon,  7 Oct 2024 19:32:00 +0000
In-Reply-To: <2024100711-ebook-refund-46f3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024100711-ebook-refund-46f3@gregkh>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241007193200.2668673-1-yosryahmed@google.com>
Subject: [PATCH 6.1.y] mm: z3fold: deprecate CONFIG_Z3FOLD
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
 mm/Kconfig                                 | 25 ++++++++++++++++------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index 3540e9c0a6310..15b7420c868ba 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -82,7 +82,6 @@ CONFIG_ZSWAP=y
 CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD=y
 CONFIG_ZPOOL=y
 CONFIG_ZBUD=y
-CONFIG_Z3FOLD=y
 CONFIG_ZSMALLOC=m
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/mm/Kconfig b/mm/Kconfig
index a65145fe89f2b..cf782e0474910 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -132,12 +132,15 @@ config ZSWAP_ZPOOL_DEFAULT_ZBUD
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
@@ -149,7 +152,7 @@ config ZSWAP_ZPOOL_DEFAULT
        string
        depends on ZSWAP
        default "zbud" if ZSWAP_ZPOOL_DEFAULT_ZBUD
-       default "z3fold" if ZSWAP_ZPOOL_DEFAULT_Z3FOLD
+       default "z3fold" if ZSWAP_ZPOOL_DEFAULT_Z3FOLD_DEPRECATED
        default "zsmalloc" if ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
        default ""
 
@@ -163,15 +166,25 @@ config ZBUD
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


