Return-Path: <stable+bounces-84874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7871799D2A0
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9A34B23A36
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2668F1AE006;
	Mon, 14 Oct 2024 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IfT79mD0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C7B1ABEBF;
	Mon, 14 Oct 2024 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919523; cv=none; b=DadSvQeb/vFoPklaAPap2Yda/X3u7niz+Tl2GgggRl91p8FdAhvEjWTzi20z1fpKTJF8iMvpXDyYQMk3lQFAKJnyYYrTOIZCrVTZQc6Fo9IV1cijEZXt6N5h47Q24hXbZNFN0NraHOTOjc+fPu56h+rd8BTi3O02g/fCnIKhXYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919523; c=relaxed/simple;
	bh=wiCikzPZUf+cwRYIgpKc+KO+ABwhhnn4JMO5uXBGb9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDbMr+/6dJYD5EUk3P3JS3OmTNVhInz/XDY6JbqbJNvv+mXNxxM5V0dpqDcvcV166A1li3RzjP61U6O64x2M6CofZMejFeVJ4NaPlrJdyAEKDCdhMgDWsa35GJfSy/z4UFbVDnPPrgMhqJd80Och71pKOgsqv+KOS6LvbO0wMuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IfT79mD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76D1C4CEC3;
	Mon, 14 Oct 2024 15:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728919523;
	bh=wiCikzPZUf+cwRYIgpKc+KO+ABwhhnn4JMO5uXBGb9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IfT79mD0YfZoM87Ss183zky46sQclplSWfcN7ZMnv1seYGLxZOy8GgB4wErk4Yjhe
	 xFkEBjWchU1tMIFalG8gRswD6ZDm6LiUZmwbxxKEZQB3RdD81WgATwmLlze8A9GDn2
	 LjI23Sx8ABifbDunMym8WZZ0Ma0QeOHylTVBQ5fw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yosry Ahmed <yosryahmed@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Chris Down <chris@chrisdown.name>,
	Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Vitaly Wool <vitaly.wool@konsulko.com>,
	Christoph Hellwig <hch@lst.de>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huacai Chen <chenhuacai@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 629/798] mm: z3fold: deprecate CONFIG_Z3FOLD
Date: Mon, 14 Oct 2024 16:19:43 +0200
Message-ID: <20241014141242.749558423@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yosry Ahmed <yosryahmed@google.com>

[ Upstream commit 7a2369b74abf76cd3e54c45b30f6addb497f831b ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.43.0




