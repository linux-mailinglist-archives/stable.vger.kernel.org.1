Return-Path: <stable+bounces-195403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F82FC76177
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 20:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 9601B28B97
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BEF2E6CC2;
	Thu, 20 Nov 2025 19:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKd9tRz+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6583F221F2F
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 19:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763667268; cv=none; b=sIDcnP4GmCf+uDjNGqkeShygfnu9f0s3EFM7j/CdRYgWnTFMAnei+7PcMgtN7EmgnQX32jBX+mIrpex+9uSL2jd9xbhorg8WAeCzdHjK8B1iB/hEA5iRwiezimxjkJUR9FgxhzpsWTUrNL3E7vadHXG78FbJVY4CihCQMTMI4Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763667268; c=relaxed/simple;
	bh=fV4Ju2vnCd24p0jzufHRllAirFNUm+0d/VPKghKHj/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLrhVLLMM5uCxYOb7oMiPvnN3Pcs8J+rm6j+77bAwXgxWRHnXvyw8p9Hug9XXd2HS5ou0NOoEWa86DU2Saq2bDj8ZHz4ghyyBDbDPAHlIGjOWxq7wwMN0sNCx+qlLAgD6GBnBk+SBTDjbYUN7RVkUv3aMIATeEtkuJ2UC3NzoOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKd9tRz+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9B5C4CEF1;
	Thu, 20 Nov 2025 19:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763667268;
	bh=fV4Ju2vnCd24p0jzufHRllAirFNUm+0d/VPKghKHj/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XKd9tRz+WvipibgGmPJU47Glg1Aw+BjFCo/na3hmFzV9bkInuJ5q4E9GzP6RUwlo/
	 Ulg9Ub1/YFx/uIn6IyhWowMF7p5hSyFGR3Xncr7AVkY35Kmnf32Ond/X+OfySVCSQY
	 SHrQQTkA1c0xQ0SAeI7CTX2Exl0nQGD7Mb+cygJOw11qcXHUG2N1b09wWSYaAg3EFf
	 b3wds/maN8ngKd9jR4xQHYJwSWRSkqpEL/eAN2i/slU/au9V27ryLZ9wR8n/Jkazuy
	 N0QCp9t6Pcz0PAAOMa5bEY/6mqL1nOvPG5PSXZ+nGjHxQ93k5sgP4drmNZaPqEkJdb
	 eAYME4k2KSyeg==
From: Mike Rapoport <rppt@kernel.org>
To: stable@vger.kernel.org
Cc: "Isaac J. Manjarres" <isaacmanjarres@google.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.4.y] mm/page_alloc: fix hash table order logging in alloc_large_system_hash()
Date: Thu, 20 Nov 2025 21:34:22 +0200
Message-ID: <20251120193422.2347150-1-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025112034-decrease-sardine-8989@gregkh>
References: <2025112034-decrease-sardine-8989@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Isaac J. Manjarres" <isaacmanjarres@google.com>

When emitting the order of the allocation for a hash table,
alloc_large_system_hash() unconditionally subtracts PAGE_SHIFT from log
base 2 of the allocation size.  This is not correct if the allocation size
is smaller than a page, and yields a negative value for the order as seen
below:

TCP established hash table entries: 32 (order: -4, 256 bytes, linear) TCP
bind hash table entries: 32 (order: -2, 1024 bytes, linear)

Use get_order() to compute the order when emitting the hash table
information to correctly handle cases where the allocation size is smaller
than a page:

TCP established hash table entries: 32 (order: 0, 256 bytes, linear) TCP
bind hash table entries: 32 (order: 0, 1024 bytes, linear)

Link: https://lkml.kernel.org/r/20251028191020.413002-1-isaacmanjarres@google.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 0d6c356dd6547adac2b06b461528e3573f52d953)
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 66e4b78786a9..111f50054fc1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8275,7 +8275,7 @@ void *__init alloc_large_system_hash(const char *tablename,
 		panic("Failed to allocate %s hash table\n", tablename);
 
 	pr_info("%s hash table entries: %ld (order: %d, %lu bytes, %s)\n",
-		tablename, 1UL << log2qty, ilog2(size) - PAGE_SHIFT, size,
+		tablename, 1UL << log2qty, get_order(size), size,
 		virt ? "vmalloc" : "linear");
 
 	if (_hash_shift)
-- 
2.50.1


