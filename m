Return-Path: <stable+bounces-192917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC83C45593
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 09:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B3F2346D24
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 08:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7EC2512FF;
	Mon, 10 Nov 2025 08:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyJc7oSB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CBE1397;
	Mon, 10 Nov 2025 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762762831; cv=none; b=batnMeXZSmX90uOZB5E+oYa9i0j3TO9k4ZwZohks6hB3Rmxk3te+kK9OLSsLczD3/E4b9Ys/7uYzlqKWr+k8AiObomOzAnXbP4D2fL/tBW2lDByvO8phV7Mk2SM4EzD8hYe21grp0XkACMPqdOFFOjVZ77aQHJ9qK5Q19TCDxdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762762831; c=relaxed/simple;
	bh=eGXt6P/y0wwvJIZIqWpY30+BNIH6CXI8dwctYt3EQno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pt/rtjLpqdB3va7Y5v9cBATIO42pW1t8ajcYOY1NQCevm7uDWKIa3wMaHmnZlykGhT3ngbvYNKba+x0Wac42YgVkAEevOyhEli64oXtzW2hqa1kNwBba8SVJv1hhTkO07oLAKbjRhyAOkWpU/O7tg8cVqz2GU9GqXKDCY5IxsOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyJc7oSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CF0C16AAE;
	Mon, 10 Nov 2025 08:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762762830;
	bh=eGXt6P/y0wwvJIZIqWpY30+BNIH6CXI8dwctYt3EQno=;
	h=From:To:Cc:Subject:Date:From;
	b=OyJc7oSB+5H0S5vs3/U6LPnDEPYX6kVhICQeFbATNZB4pKnWiLEC5C42o3z+VaOeg
	 GLjxN9GLgZgS9h3BvAcdJ8IXupU1I9G1LUeWAteAbRkzTD1oydRMRGmuArz/CoZf0B
	 2nP2EAM1XpKHhn6esIU7OjQyclLfj3o3H143gF7kL7EKTrfuMGJt1JZj+odtEnwHN9
	 H0O4/9c5ja+8vGA2Zb2A5/2Vwn4nT3Bl6sPH9VLm92NYFDiI7aLRyC/RshQNF1Cfmy
	 otTTGvASIKJR1lY9PEwvUcpenYWE6dw8Waim9A472ZGR02taaoH28oV9Giovw+vY6l
	 fJ2IeoAt6NmLQ==
From: Philipp Stanner <phasta@kernel.org>
To: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Alex Deucher <alexander.deucher@amd.com>,
	Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	dakr@kernel.org,
	Matthew Brost <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] drm/sched: Fix UB in spsc_queue
Date: Mon, 10 Nov 2025 09:19:04 +0100
Message-ID: <20251110081903.11539-2-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The spsc_queue is an unlocked, highly asynchronous piece of
infrastructure. Its inline function spsc_queue_peek() obtains the head
entry of the queue.

This access is performed without READ_ONCE() and is, therefore,
undefined behavior. In order to prevent the compiler from ever
reordering that access, or even optimizing it away, a READ_ONCE() is
strictly necessary. This is easily proven by the fact that
spsc_queue_pop() uses this very pattern to access the head.

Add READ_ONCE() to spsc_queue_peek().

Cc: stable@vger.kernel.org # v4.16+
Fixes: 27105db6c63a ("drm/amdgpu: Add SPSC queue to scheduler.")
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
I think this makes it less broken, but I'm not even sure if it's enough
or more memory barriers or an rcu_dereference() would be correct. The
spsc_queue is, of course, not documented and the existing barrier
comments are either false or not telling.

If someone has an idea, shoot us the info. Otherwise I think this is the
right thing to do for now.

P.
---
 include/drm/spsc_queue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/spsc_queue.h b/include/drm/spsc_queue.h
index ee9df8cc67b7..39bada748ffc 100644
--- a/include/drm/spsc_queue.h
+++ b/include/drm/spsc_queue.h
@@ -54,7 +54,7 @@ static inline void spsc_queue_init(struct spsc_queue *queue)
 
 static inline struct spsc_node *spsc_queue_peek(struct spsc_queue *queue)
 {
-	return queue->head;
+	return READ_ONCE(queue->head);
 }
 
 static inline int spsc_queue_count(struct spsc_queue *queue)
-- 
2.49.0


