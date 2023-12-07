Return-Path: <stable+bounces-4885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C8A807CD2
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 01:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CB14282468
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 00:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD2F37C;
	Thu,  7 Dec 2023 00:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="uhSZoelT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DBF7E
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 00:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89AC8C433C7;
	Thu,  7 Dec 2023 00:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701908023;
	bh=avkiMx18Ryu92tGrUssXSu4jxP6uzPGkyqD2DFemp8Y=;
	h=Date:To:From:Subject:From;
	b=uhSZoelTggiBe453eiegTkYLo5i2pV8oiJiF/8tcc/NluTx/8mk1bGCq19VV7SKV5
	 tpTWGY1f/WHTLO68jcSLVXJH8hRihlTNpxDhETZdowO8h8ZrI2XE0WaxqTIK721gVA
	 pGOXNw6E9DC0xS1cDcwHC9eSyV3mmBst+2eJlQ+s=
Date: Wed, 06 Dec 2023 16:13:42 -0800
To: mm-commits@vger.kernel.org,willy@infradead.org,trix@redhat.com,tony.luck@intel.com,stable@vger.kernel.org,pcc@google.com,ndesaulniers@google.com,nathan@kernel.org,jiaqiyan@google.com,ira.weiny@intel.com,suhui@nfschina.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] highmem-fix-a-memory-copy-problem-in-memcpy_from_folio.patch removed from -mm tree
Message-Id: <20231207001343.89AC8C433C7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: highmem: fix a memory copy problem in memcpy_from_folio
has been removed from the -mm tree.  Its filename was
     highmem-fix-a-memory-copy-problem-in-memcpy_from_folio.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Su Hui <suhui@nfschina.com>
Subject: highmem: fix a memory copy problem in memcpy_from_folio
Date: Thu, 30 Nov 2023 11:40:18 +0800

Clang static checker complains that value stored to 'from' is never read. 
And memcpy_from_folio() only copy the last chunk memory from folio to
destination.  Use 'to += chunk' to replace 'from += chunk' to fix this
typo problem.

Link: https://lkml.kernel.org/r/20231130034017.1210429-1-suhui@nfschina.com
Fixes: b23d03ef7af5 ("highmem: add memcpy_to_folio() and memcpy_from_folio()")
Signed-off-by: Su Hui <suhui@nfschina.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jiaqi Yan <jiaqiyan@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Collingbourne <pcc@google.com>
Cc: Tom Rix <trix@redhat.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/highmem.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/highmem.h~highmem-fix-a-memory-copy-problem-in-memcpy_from_folio
+++ a/include/linux/highmem.h
@@ -454,7 +454,7 @@ static inline void memcpy_from_folio(cha
 		memcpy(to, from, chunk);
 		kunmap_local(from);
 
-		from += chunk;
+		to += chunk;
 		offset += chunk;
 		len -= chunk;
 	} while (len > 0);
_

Patches currently in -mm which might be from suhui@nfschina.com are



