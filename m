Return-Path: <stable+bounces-119973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAF6A4A0BA
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 18:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343FD3B9322
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 17:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F44026B2C8;
	Fri, 28 Feb 2025 17:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqVyloOG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45378170A11;
	Fri, 28 Feb 2025 17:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764696; cv=none; b=tkRSVncEeiDsLX3US5qEfPjW8gFJ3UF+T/pDDoGT9oYLy8khZ4nMNP90TkWrpf6tP9nQDt7xm8RZWeJjFVBQnHDMrzwI42fKDSiISWHGP/Jxy3b85wdySUsVktXDWjJeY4i+SFnXjKhJuGmDwucJT378m9ELDf9UCUMUKAVkWaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764696; c=relaxed/simple;
	bh=CpHYHjQgaydE45no7Ly7KiWjssU9SxTYCGB/N2Wurr8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dkqmKKgyJ0PIwgPEVE52IjAfuw0x/Vi1Jx/iKKPpDVHNr+xRtM4Ru8M99RJdzt3DaDHTuNSZ0g8v9g1qBuT8iMMK0XUWQQ0Z8RgPHL4Glu3mGxI70ip0j+a+xaYtRCuxAWjF22y51s5m+/7KaMpnPnz9Gywx9J4DBcd3i7IeJh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqVyloOG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824A5C4CEE5;
	Fri, 28 Feb 2025 17:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740764695;
	bh=CpHYHjQgaydE45no7Ly7KiWjssU9SxTYCGB/N2Wurr8=;
	h=From:To:Cc:Subject:Date:From;
	b=TqVyloOGnuFDiHVkZOlEqAhPbst8qiUqmRPiTctIKD8DXDOW2T9vIM9fj+JqS4evh
	 9lQPdLeNuG3+s5yESrF2kFYjBfsyNdSYg8Qr5Eh4+Cv7lCfDR8OPgtQiW/8qrfY/ec
	 +isU2iffdX4helLtCOL4y+aGUZRz4MmoVAInEn/FxqAslkKLZJJtrF+1glSKxy+RAH
	 NjopinvZi8/J28wqcRriCJ7Cey8X0kYs2QZ2do+PriiQhd1v+xVl1x6rECutxm+vux
	 iumZFDBYyDqimcBs7rZ2E/mmfI2fUnM4vcKE/rLkBJG3VV2JYGhabykk6KrCD3CFQR
	 RkOauU/MskxCQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH] mm/damon/core: initialize damos->walk_completed in damon_new_scheme()
Date: Fri, 28 Feb 2025 09:44:50 -0800
Message-Id: <20250228174450.41472-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function for allocating and initialize a 'struct damos' object,
damon_new_scheme(), is not initializing damos->walk_completed field.
Only damos_walk_complete() is setting the field.  Hence the field will
be eventually set and used correctly from second damos_walk() call for
the scheme.  But the first damos_walk() could mistakenly not walk on the
regions.  Actually, a common usage of DAMOS for taking an access pattern
snapshot is installing a monitoring-purpose DAMOS scheme, doing
damos_walk() to retrieve the snapshot, and then removing the scheme.
DAMON user-space tool (damo) also gets runtime snapshot in the way.
Hence the problem can continuously happen in such use cases.  Initialize
it properly in the allocation function.

Fixes: bf0eaba0ff9c ("mm/damon/core: implement damos_walk()")
Cc: <stable@vger.kernel.org> # 6.14.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 38f545fea585..cfa105ee9610 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -373,6 +373,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	 * or damon_attrs are updated.
 	 */
 	scheme->next_apply_sis = 0;
+	scheme->walk_completed = false;
 	INIT_LIST_HEAD(&scheme->filters);
 	scheme->stat = (struct damos_stat){};
 	INIT_LIST_HEAD(&scheme->list);

base-commit: 3880bbe477938a3b30ff7bf2ef316adf98876671
-- 
2.39.5

