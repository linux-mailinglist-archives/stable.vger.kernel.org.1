Return-Path: <stable+bounces-81606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E63994858
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A62B21C24F62
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1B91DE2A5;
	Tue,  8 Oct 2024 12:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kMWBmY/v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4543318CC12;
	Tue,  8 Oct 2024 12:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389522; cv=none; b=Ierbt1UEtMLX0mKhRXEz4ueJt0HVeCTlWveHtmIM5yX5GhlcD9dmAALtZfj2L9N6fbPPCm9YwVXrrIXSdu96qNdKkGPjfCZicv2u7D5ZhlcLSf0nQVhfvzUS4H5jbRq4mdkwMvEI+xgWxutLDiJZdLjNDFuneXZB50gWarDszJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389522; c=relaxed/simple;
	bh=iL0b5uCd9p/xecy/gz2xIF+fYNVwGgjYRABodzD8nCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acsVXxLqJZMtNW8EFdfbhPChae5zfSflYE1f4l1fLsF0P8Qj9KGKIFClmjk0AOMyyzFpk3oiy/z12h+uZs+MbcJvNqMDTjaMhKP/BEDO0dEIDin5Tsa8TJdQ72Xi55nH9m9o1fabiQmT+dSRPGLLSZ8/8cX8LXjIbT2OuWC7I9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kMWBmY/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE70CC4CEC7;
	Tue,  8 Oct 2024 12:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728389522;
	bh=iL0b5uCd9p/xecy/gz2xIF+fYNVwGgjYRABodzD8nCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kMWBmY/vSncqFUQlKBlzpFJEGBkc7P2ucn2gAUSKzCkFf17Cz3TmHACTykh4G0Y89
	 S9LBX99gyfyjNLCBu8hTBBeC+YkwYh5718zFOYnFe2mgv5YcP/wHkg5hWW2ZByDa/q
	 M6QWLU1osaGi1LxRPQIHuM8tfy5iDf5zSqzFALPk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 003/482] jump_label: Simplify and clarify static_key_fast_inc_cpus_locked()
Date: Tue,  8 Oct 2024 14:01:06 +0200
Message-ID: <20241008115648.427868307@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 9bc2ff871f00437ad2f10c1eceff51aaa72b478f ]

Make the code more obvious and add proper comments to avoid future head
scratching.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20240610124406.548322963@linutronix.de
Stable-dep-of: 1d7f856c2ca4 ("jump_label: Fix static_key_slow_dec() yet again")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/jump_label.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index c6ac0d0377d72..781a1298ce2c2 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -159,22 +159,24 @@ bool static_key_slow_inc_cpuslocked(struct static_key *key)
 	if (static_key_fast_inc_not_disabled(key))
 		return true;
 
-	jump_label_lock();
-	if (atomic_read(&key->enabled) == 0) {
-		atomic_set(&key->enabled, -1);
+	guard(mutex)(&jump_label_mutex);
+	/* Try to mark it as 'enabling in progress. */
+	if (!atomic_cmpxchg(&key->enabled, 0, -1)) {
 		jump_label_update(key);
 		/*
-		 * Ensure that if the above cmpxchg loop observes our positive
-		 * value, it must also observe all the text changes.
+		 * Ensure that when static_key_fast_inc_not_disabled() or
+		 * static_key_slow_try_dec() observe the positive value,
+		 * they must also observe all the text changes.
 		 */
 		atomic_set_release(&key->enabled, 1);
 	} else {
-		if (WARN_ON_ONCE(!static_key_fast_inc_not_disabled(key))) {
-			jump_label_unlock();
+		/*
+		 * While holding the mutex this should never observe
+		 * anything else than a value >= 1 and succeed
+		 */
+		if (WARN_ON_ONCE(!static_key_fast_inc_not_disabled(key)))
 			return false;
-		}
 	}
-	jump_label_unlock();
 	return true;
 }
 
-- 
2.43.0




