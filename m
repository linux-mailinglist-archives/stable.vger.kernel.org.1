Return-Path: <stable+bounces-70048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE1395CFA6
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CCB21C2401A
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F5D1AED2C;
	Fri, 23 Aug 2024 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liVGzIY6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F311AED21;
	Fri, 23 Aug 2024 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421987; cv=none; b=DNe0IqsP6IcvtKLTG4enGqs2ghwd2fYjbDmTbOcxL4cQ18fIHfsV1t/3vyKjjkBuO3frezsl6OnxAiI35Xm8hmnAX1Bkstxx5P9DjHQwSNQ5tW6/G5zfxt99k9SzPpN4H+dTzgh/pGEit2RJAAjJrwTlUy5bnvk4vQrkDbiuGmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421987; c=relaxed/simple;
	bh=s6a75ygW/XR1hPToCJ4pwziJfz1cgmCxHl4xM3zC+eM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKkvL80IxrOAWOHQ3gJlk27bBkKiYIp0urJqYznktaXl9I2qvBIJJo0aOFNX2mvjKAdeo27R+7NBoJa0zVSntb6OGGVkJRVjeWAVLUtUNV+CMmvMNGpvO4ev10qGDCKayh83JRa5G/QtRnUHuCQmxM8nUuLSCRL8fPRjDn2WtEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liVGzIY6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0377C32786;
	Fri, 23 Aug 2024 14:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421987;
	bh=s6a75ygW/XR1hPToCJ4pwziJfz1cgmCxHl4xM3zC+eM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=liVGzIY6pXWLvKBtiYXkoKSln3i1CqG7+GUPRTqMm9d8FwqY7VDwTfFX4cJmXjXYB
	 /8wo6CpVcSP8ZPMrNQJGDcFBVfos/U/dh9K/FWydcxNCMim6cyq/m8JQULD/HT0xL6
	 LIJje3lpa3SQkI0Btm7xEEa+URyJCaCVHl8Xy+1HYqGXxxJ7dPfi2NGJHhM3m+w5dl
	 NN4aG4GhjLSmG0SFdaULm4fBWT0XvpAgxInoEZvOTtshlhyLrfoJKiba/xsyE5mM7D
	 mp5VCiMkdGZxs/izYFAMadwmBq7rZ1o0BJgFeackbsjNMIU5NCUXo3CJihcf2RnxOf
	 HwyT4uEI1S6nw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 7/7] lib/generic-radix-tree.c: Fix rare race in __genradix_ptr_alloc()
Date: Fri, 23 Aug 2024 10:06:02 -0400
Message-ID: <20240823140611.1975950-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140611.1975950-1-sashal@kernel.org>
References: <20240823140611.1975950-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.282
Content-Transfer-Encoding: 8bit

From: Kent Overstreet <kent.overstreet@linux.dev>

[ Upstream commit b2f11c6f3e1fc60742673b8675c95b78447f3dae ]

If we need to increase the tree depth, allocate a new node, and then
race with another thread that increased the tree depth before us, we'll
still have a preallocated node that might be used later.

If we then use that node for a new non-root node, it'll still have a
pointer to the old root instead of being zeroed - fix this by zeroing it
in the cmpxchg failure path.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/generic-radix-tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/generic-radix-tree.c b/lib/generic-radix-tree.c
index f25eb111c0516..34d3ac52de894 100644
--- a/lib/generic-radix-tree.c
+++ b/lib/generic-radix-tree.c
@@ -131,6 +131,8 @@ void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset,
 		if ((v = cmpxchg_release(&radix->root, r, new_root)) == r) {
 			v = new_root;
 			new_node = NULL;
+		} else {
+			new_node->children[0] = NULL;
 		}
 	}
 
-- 
2.43.0


