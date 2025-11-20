Return-Path: <stable+bounces-195408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC12C761AD
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 20:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 1A2902BFB6
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5048E2D8372;
	Thu, 20 Nov 2025 19:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKWXCyAB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9211A0BF3
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 19:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763667748; cv=none; b=LyatX6GpnKkMjSY6p8MXolXUgaZehDa00ZWyRWhXvQr7BpSpdQBv/4S5DjcnRz16kVNvpVkU2hfnTZQXCA/BlAvEjmdf/SZTjMgVL7GPMkPsaWjKrjh3bL61U8tgjr9CI/YWswEiZXtMzKTcJt6DlH69vUWa7XxO6gLfE05ROCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763667748; c=relaxed/simple;
	bh=c4VPauC5Re5ANoYhoVtGeMHJgiFik7V626+7X8w7VT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGfiND2n5iJ4VlozbwMpNic25OM/j8MsbE8tJ35uSuUecj/v68ajbI3dd2npPBd9wG1D5MIlzilr01tBFx8WHjH20djeWQvYj/De8O3oGTe+kz8m1Njlm8d7QjHwjTroYCbqxZE9P/F/5o9Mu2Yf1fE3DAQMIHyKIH0V75pIgJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKWXCyAB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0139CC4CEF1;
	Thu, 20 Nov 2025 19:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763667747;
	bh=c4VPauC5Re5ANoYhoVtGeMHJgiFik7V626+7X8w7VT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cKWXCyABNGdApKpkMjF8e8xxMCEqvK6fdyjB1skJRCxO5/GqQAy80HLd4xGtsC6M9
	 gQoVm7NYBMTQHZvBJbKOWVviVSgX9AFK+SctWo0sfp8UQKr9I21G/4Yl76swvpfc2t
	 xOZn2VlIzplcuxGAP56xshJwX5xJNErB87x+KPFcs+MC/oQzY0UFDXcMuaNXelSPLf
	 prXGor/T+4FaeY03JHYxOFJxhbZROvd4QHBY5xNY9iH3qKFVFvhA1dl/etfH/9aSjU
	 5ZpqBg1cn7rXYN6jCUkSJqWAtn0DTwciTmBiSx7IlGRoB206F0jL0lAtmoykAKVkCc
	 xUxqlCIjHRSKg==
From: Mike Rapoport <rppt@kernel.org>
To: stable@vger.kernel.org
Cc: "Isaac J. Manjarres" <isaacmanjarres@google.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/mm_init: fix hash table order logging in alloc_large_system_hash()
Date: Thu, 20 Nov 2025 21:42:22 +0200
Message-ID: <20251120194222.2365413-1-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025112032-parted-progeny-cd9e@gregkh>
References: <2025112032-parted-progeny-cd9e@gregkh>
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
index 86066a2cf258..d760b96604ec 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9225,7 +9225,7 @@ void *__init alloc_large_system_hash(const char *tablename,
 		panic("Failed to allocate %s hash table\n", tablename);
 
 	pr_info("%s hash table entries: %ld (order: %d, %lu bytes, %s)\n",
-		tablename, 1UL << log2qty, ilog2(size) - PAGE_SHIFT, size,
+		tablename, 1UL << log2qty, get_order(size), size,
 		virt ? (huge ? "vmalloc hugepage" : "vmalloc") : "linear");
 
 	if (_hash_shift)
-- 
2.50.1


