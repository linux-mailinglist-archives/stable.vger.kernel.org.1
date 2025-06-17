Return-Path: <stable+bounces-154440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F941ADD9EF
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396A619E7DDD
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BFE239561;
	Tue, 17 Jun 2025 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hexqkJMs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CFA2E8DE4;
	Tue, 17 Jun 2025 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750179195; cv=none; b=E3rCNWateA/ExzAirR0N8UfD1mUho3hU3NLl5FItW2JA5aO+NeNPEEiDXDnSeFCWu/4OZmFvGpMsu0EBy/lFb7yq0mkBSJrrWvwbgrjBS7sg7t42AtHnapiFsu4ifYcV8XSqGqxusR5/lpUVGpUSLoMCGjsTe9oj1DHUGgDnXWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750179195; c=relaxed/simple;
	bh=pIU3N+r8Jrw1pO/qT2Gbrh23fCUZ6zYnZd4yxuQbqtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJP2SF/fB9S8wICn1qpjpVPj5AKEOpI8J5r/PwoOjZQnY7cHwWU3qLUHHjb96BCEpqGB09gbGEODMhjUGawlqtzakQNo+v3CFOTiwtdVsQ8B5jVZa7JpAptT51UYfnKlC2fc4+br0EnMfAMwpeM+X550Ctz6lkxRpGqCMsYAaPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hexqkJMs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DA9C4CEE3;
	Tue, 17 Jun 2025 16:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750179195;
	bh=pIU3N+r8Jrw1pO/qT2Gbrh23fCUZ6zYnZd4yxuQbqtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hexqkJMsRSQ+OyEFzH4c2Hc74Rnj35sANLYobTt9RisVwi1aP4msaYg9s8vLUtCdg
	 kVC8nxe0MnuVwAr5XcGgU/UdoVsRPR8DVSt2yUV6GcUJZIO9GAQzY89mkCGUq0DpsI
	 YzzI84ntN5XZwDofztRL0wnVy5BuZ0dMNr9rrEOg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeongjun Park <aha310510@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 670/780] ptp: remove ptp->n_vclocks check logic in ptp_vclock_in_use()
Date: Tue, 17 Jun 2025 17:26:18 +0200
Message-ID: <20250617152518.749820136@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeongjun Park <aha310510@gmail.com>

[ Upstream commit 87f7ce260a3c838b49e1dc1ceedf1006795157a2 ]

There is no disagreement that we should check both ptp->is_virtual_clock
and ptp->n_vclocks to check if the ptp virtual clock is in use.

However, when we acquire ptp->n_vclocks_mux to read ptp->n_vclocks in
ptp_vclock_in_use(), we observe a recursive lock in the call trace
starting from n_vclocks_store().

============================================
WARNING: possible recursive locking detected
6.15.0-rc6 #1 Not tainted
--------------------------------------------
syz.0.1540/13807 is trying to acquire lock:
ffff888035a24868 (&ptp->n_vclocks_mux){+.+.}-{4:4}, at:
 ptp_vclock_in_use drivers/ptp/ptp_private.h:103 [inline]
ffff888035a24868 (&ptp->n_vclocks_mux){+.+.}-{4:4}, at:
 ptp_clock_unregister+0x21/0x250 drivers/ptp/ptp_clock.c:415

but task is already holding lock:
ffff888030704868 (&ptp->n_vclocks_mux){+.+.}-{4:4}, at:
 n_vclocks_store+0xf1/0x6d0 drivers/ptp/ptp_sysfs.c:215

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&ptp->n_vclocks_mux);
  lock(&ptp->n_vclocks_mux);

 *** DEADLOCK ***
....
============================================

The best way to solve this is to remove the logic that checks
ptp->n_vclocks in ptp_vclock_in_use().

The reason why this is appropriate is that any path that uses
ptp->n_vclocks must unconditionally check if ptp->n_vclocks is greater
than 0 before unregistering vclocks, and all functions are already
written this way. And in the function that uses ptp->n_vclocks, we
already get ptp->n_vclocks_mux before unregistering vclocks.

Therefore, we need to remove the redundant check for ptp->n_vclocks in
ptp_vclock_in_use() to prevent recursive locking.

Fixes: 73f37068d540 ("ptp: support ptp physical/virtual clocks conversion")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
Acked-by: Richard Cochran <richardcochran@gmail.com>
Link: https://patch.msgid.link/20250520160717.7350-1-aha310510@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ptp/ptp_private.h | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 18934e28469ee..528d86a33f37d 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -98,17 +98,7 @@ static inline int queue_cnt(const struct timestamp_event_queue *q)
 /* Check if ptp virtual clock is in use */
 static inline bool ptp_vclock_in_use(struct ptp_clock *ptp)
 {
-	bool in_use = false;
-
-	if (mutex_lock_interruptible(&ptp->n_vclocks_mux))
-		return true;
-
-	if (!ptp->is_virtual_clock && ptp->n_vclocks)
-		in_use = true;
-
-	mutex_unlock(&ptp->n_vclocks_mux);
-
-	return in_use;
+	return !ptp->is_virtual_clock;
 }
 
 /* Check if ptp clock shall be free running */
-- 
2.39.5




