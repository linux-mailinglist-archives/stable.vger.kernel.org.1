Return-Path: <stable+bounces-141816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5C7AAC6CF
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 15:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7CA74A661A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 13:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCB7280A2C;
	Tue,  6 May 2025 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhQoYpk7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BBD27A932;
	Tue,  6 May 2025 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539075; cv=none; b=RGMDyv0iFaEGkGbLrO6HIzzcjXkG4i1Meuk2+gUii0r/OU7Zwz/3vCAjdAg8r3sO0/cbCl0CG5ZZr9sFGUB+jEF6LX+W5r5URgAX3bU2ekI/43/rTuSGVs80GcXgl6SYvIqIqht/DunEYJUPjKXHHnvFszdTOlFXBdjKcVHGaRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539075; c=relaxed/simple;
	bh=ilPU3kHXp7rUlXp/tVdwQH8b/OLryQpTRvXT0OKoe/o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jZBi59WBRmQR2Xk0hVgszUNdGBh5FPpRraF+pM+mV2Q2PV9udBN4kyiZR/fcudxMhJKd1xSt3XrEb/hSFuN8Lh6yim6MgDFE6Cqs5QQ43Wjf4qP69jLLPnTBpQa7EXXdA+zQm/FiJPu4YNTblWCNF1584kWLjndT6R2zr5kZgVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhQoYpk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FC87C4CEE4;
	Tue,  6 May 2025 13:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746539075;
	bh=ilPU3kHXp7rUlXp/tVdwQH8b/OLryQpTRvXT0OKoe/o=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=PhQoYpk7kvk06QyLdg8METHb3TDGTyRGwdnPmDzQkZ4B637EvOnJ1K8WfdbshMmS5
	 PogY7RBbpqik8zQtFrWv6LWa1o4EJHP5g5CjrfsxgPjfzP797aHxmJ9Vy1Ayfhbhqr
	 Dcukm/WWLUK6eUngDRGVwdaCXYljAx2lA3Hf7cFtH2639qPfsc53HSou3F0J1KkwRt
	 9Zlr/4KMFta89GgsNjuDC9KbZUCXKGUBcteazlUnwb/mPjV5EQ2qmIqE7ZbZw7Tjc1
	 YNPgpq1XOkQ57leZr+1X2LzaNsYu0VnfGa6Zptycxl31xyw0SIuCf3Jyb+zPc90G1n
	 grawZ+jaW7ZDg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3AEC3ABAC;
	Tue,  6 May 2025 13:44:34 +0000 (UTC)
From: Ignacio Moreno Gonzalez via B4 Relay <devnull+Ignacio.MorenoGonzalez.kuka.com@kernel.org>
Subject: [PATCH v2 0/2] Map MAP_STACK to VM_NOHUGEPAGE only if THP is
 enabled
Date: Tue, 06 May 2025 15:44:31 +0200
Message-Id: <20250506-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-v2-0-f11f0c794872@kuka.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD8SGmgC/52OQQqDMBBFryJZd0oStbRd9R5FJE1GHaxJSFQq4
 t0b7Q3K8BdvGP6blUUMhJHds5UFnCmSswnkKWO6U7ZFIJOYSS5LXsgrDMrvqeOodA+jg3moreu
 mFr1K186+F6AGxs4DRUCrXm80oLHgShjkt9Kw1O0DNvQ5vM8qcUdxdGE53pjFvv0ZSy7/NM4C0
 ohc60teaFOKRz/16qzdwKpt274ztqPr+QAAAA==
X-Change-ID: 20250428-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-ce40a1de095d
To: lorenzo.stoakes@oracle.com
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
 yang@os.amperecomputing.com, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, 
 Ignacio Moreno Gonzalez <Ignacio.MorenoGonzalez@kuka.com>, 
 stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746539072; l=1539;
 i=Ignacio.MorenoGonzalez@kuka.com; s=20220915; h=from:subject:message-id;
 bh=ilPU3kHXp7rUlXp/tVdwQH8b/OLryQpTRvXT0OKoe/o=;
 b=YUAyBvIkP4DkqhnQf03JeOpLsT887STIasmrXklw3hNcbYHWZSK/cPM1iclzn05/yf40kFG17
 lWLf5vFUOilCBLR+PlXFl2odw5ukLe/nHo8dQFyt+ou8jr8/8rdsO8u
X-Developer-Key: i=Ignacio.MorenoGonzalez@kuka.com; a=ed25519;
 pk=j7nClQnc5Q1IDuT4eS/rYkcLHXzxszu2jziMcJaFdBQ=
X-Endpoint-Received: by B4 Relay for
 Ignacio.MorenoGonzalez@kuka.com/20220915 with auth_id=391
X-Original-From: Ignacio Moreno Gonzalez <Ignacio.MorenoGonzalez@kuka.com>
Reply-To: Ignacio.MorenoGonzalez@kuka.com

... and make setting MADV_NOHUGEPAGE with madvise() into a no-op if THP
is not enabled.

I discovered this issue when trying to use the tool CRIU to checkpoint
and restore a container. Our running kernel is compiled without
CONFIG_TRANSPARENT_HUGETABLES. CRIU parses the output of
/proc/<pid>/smaps and saves the "nh" flag. When trying to restore the
container, CRIU fails to restore the "nh" mappings, since madvise()
MADV_NOHUGEPAGE always returns an error because
CONFIG_TRANSPARENT_HUGETABLES is not defined.

These patches:
- Avoid mapping MAP_STACK to VM_NOHUGEPAGE if !THP
- Avoid returning an error when calling madvise() with MADV_NOHUGEPAGE
  if !THP

Signed-off-by: Ignacio Moreno Gonzalez <Ignacio.MorenoGonzalez@kuka.com>
---
Changes in v2:
- [Patch 1/2] Use '#ifdef' instead of '#if defined(...)'
- [Patch 1/2] Add 'Fixes: c4608d1bf7c6...'
- Create [Patch 2/2]

- Link to v1: https://lore.kernel.org/r/20250502-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-v1-1-113cc634cd51@kuka.com

---
Ignacio Moreno Gonzalez (2):
      mm: mmap: map MAP_STACK to VM_NOHUGEPAGE only if THP is enabled
      mm: madvise: no-op for MADV_NOHUGEPAGE if THP is disabled

 include/linux/huge_mm.h | 6 ++++++
 include/linux/mman.h    | 2 ++
 2 files changed, 8 insertions(+)
---
base-commit: fc96b232f8e7c0a6c282f47726b2ff6a5fb341d2
change-id: 20250428-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-ce40a1de095d

Best regards,
-- 
Ignacio Moreno Gonzalez <Ignacio.MorenoGonzalez@kuka.com>



