Return-Path: <stable+bounces-65852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7089E94AC34
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 17:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187761F216E9
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 15:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328E28615A;
	Wed,  7 Aug 2024 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c1AsEuRn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E419985626;
	Wed,  7 Aug 2024 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043578; cv=none; b=jufNVT+mkF57yc9xwa8m7AcyIC2Dxk+rBRb8VPHb7FP8t1EzbZNsd5FBxxGTnQv1mcKQYzlip6kHR95pziJSsKZkgtczNIk7QuiFuhVOTiZkrGpllLQPbwASG8Jsy+x6D9ARWHENqWAovoWuP961SyvjD/gtMbOGjruCLyrWVG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043578; c=relaxed/simple;
	bh=UM7m/RydvIXoe1xoZ0jtHACBMQ80osKGDJtqRcRIUF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpKuwxHj9J62sukbXcy9IEAZTBm09Lfr0WRzGNUnIzdq0z37iZibj85uAbC6RCGb7JiygGh9Evpnw7cm2M+Tw55e53Srw/kK6AAE9q4Zmfx9Ukk3ypM5f5PMA+WCv2m59ygc0lTSkIaH+Q8odflQqcwW09ACLyaSSWwDKufn8zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c1AsEuRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44310C32781;
	Wed,  7 Aug 2024 15:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723043577;
	bh=UM7m/RydvIXoe1xoZ0jtHACBMQ80osKGDJtqRcRIUF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c1AsEuRnk4QjwM+oLvzIMVmQUFIQT3fqPLjDCBR4i+3xrVbCcDsCZNr2GJFX9PW8B
	 pwHDzLU2y3yCkCoNJ8k/iIheUnIe2zGj0pVdXz+hW7+ChE2O0u8jzPvC79/7FLkwRv
	 M9DQXDC8rLqDiv2kJ6tv9Abpa0hbiuQQQOfEPphw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lucas Stach <l.stach@pengutronix.de>,
	Peter Xu <peterx@redhat.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jason Gunthorpe <jgg@nvidia.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Alistair Popple <apopple@nvidia.com>,
	Andreas Larsson <andreas@gaisler.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Fabio Estevam <festevam@denx.de>,
	Ingo Molnar <mingo@redhat.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mark Salter <msalter@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 21/86] mm: page_alloc: control latency caused by zone PCP draining
Date: Wed,  7 Aug 2024 17:00:00 +0200
Message-ID: <20240807150039.940547802@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807150039.247123516@linuxfoundation.org>
References: <20240807150039.247123516@linuxfoundation.org>
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

From: Lucas Stach <l.stach@pengutronix.de>

[ Upstream commit 55f77df7d715110299f12c27f4365bd6332d1adb ]

Patch series "mm/treewide: Remove pXd_huge() API", v2.

In previous work [1], we removed the pXd_large() API, which is arch
specific.  This patchset further removes the hugetlb pXd_huge() API.

Hugetlb was never special on creating huge mappings when compared with
other huge mappings.  Having a standalone API just to detect such pgtable
entries is more or less redundant, especially after the pXd_leaf() API set
is introduced with/without CONFIG_HUGETLB_PAGE.

When looking at this problem, a few issues are also exposed that we don't
have a clear definition of the *_huge() variance API.  This patchset
started by cleaning these issues first, then replace all *_huge() users to
use *_leaf(), then drop all *_huge() code.

On x86/sparc, swap entries will be reported "true" in pXd_huge(), while
for all the rest archs they're reported "false" instead.  This part is
done in patch 1-5, in which I suspect patch 1 can be seen as a bug fix,
but I'll leave that to hmm experts to decide.

Besides, there are three archs (arm, arm64, powerpc) that have slightly
different definitions between the *_huge() v.s.  *_leaf() variances.  I
tackled them separately so that it'll be easier for arch experts to chim
in when necessary.  This part is done in patch 6-9.

The final patches 10-14 do the rest on the final removal, since *_leaf()
will be the ultimate API in the future, and we seem to have quite some
confusions on how *_huge() APIs can be defined, provide a rich comment for
*_leaf() API set to define them properly to avoid future misuse, and
hopefully that'll also help new archs to start support huge mappings and
avoid traps (like either swap entries, or PROT_NONE entry checks).

[1] https://lore.kernel.org/r/20240305043750.93762-1-peterx@redhat.com

This patch (of 14):

When the complete PCP is drained a much larger number of pages than the
usual batch size might be freed at once, causing large IRQ and preemption
latency spikes, as they are all freed while holding the pcp and zone
spinlocks.

To avoid those latency spikes, limit the number of pages freed in a single
bulk operation to common batch limits.

Link: https://lkml.kernel.org/r/20240318200404.448346-1-peterx@redhat.com
Link: https://lkml.kernel.org/r/20240318200736.2835502-1-l.stach@pengutronix.de
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Mark Salter <msalter@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 66eca1021a42 ("mm/page_alloc: fix pcp->count race between drain_pages_zone() vs __rmqueue_pcplist()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8eaf51257db5f..4029d13636ece 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3176,12 +3176,15 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
  */
 static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 {
-	struct per_cpu_pages *pcp;
+	struct per_cpu_pages *pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
+	int count = READ_ONCE(pcp->count);
+
+	while (count) {
+		int to_drain = min(count, pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX);
+		count -= to_drain;
 
-	pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
-	if (pcp->count) {
 		spin_lock(&pcp->lock);
-		free_pcppages_bulk(zone, pcp->count, pcp, 0);
+		free_pcppages_bulk(zone, to_drain, pcp, 0);
 		spin_unlock(&pcp->lock);
 	}
 }
-- 
2.43.0




