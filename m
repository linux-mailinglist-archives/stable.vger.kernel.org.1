Return-Path: <stable+bounces-131326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FB9A8094C
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31AAB468123
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5F626B0A1;
	Tue,  8 Apr 2025 12:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z00bvvFe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED61268C72;
	Tue,  8 Apr 2025 12:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116095; cv=none; b=sHhX+6QFChWe8DKxhzWK53pLXGyI5saKYimJKQh+jZfQp/VIisQmox9q23XVFNr7N9pNCuNcTLJD0FWdrwX3zhGNHE95f+Ae53nRqWzeHnVmxFvB8ezErN7jPpzouS7njbRjQUgnoSO/8tbi+vuMmZ31FB7dtKpshID8ebvvomY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116095; c=relaxed/simple;
	bh=c4ae1/lzLHcN3kSemlPcpFr1DlWEDGmdc1SEE5Zp7Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czL8Ng7wNLBnFK+UzstrPmUlJo7aUY9OMIC+rQAO716TWFpMegZbHXz41eY3uo8DMGi+NX4HmG21fA0FFRfGDTn+cbV1KX6JVo43uxn4U18B9o10/lOlPv+HamUxji2jOT7D/apk3VmEWa7LNRV9byI9DtgaSybLfiFweN7iOGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z00bvvFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E076C4CEE5;
	Tue,  8 Apr 2025 12:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116094;
	bh=c4ae1/lzLHcN3kSemlPcpFr1DlWEDGmdc1SEE5Zp7Ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=z00bvvFeJu9pY0NMOJ4S2RpMf98mLYwwVdMKGluS6DL0bOXb6+3xaHN7EiHjWBRTm
	 BVZB/b0EW3f80h01aiz0W3zc8fId3iF5YXjWmXoySadBXuxcB1TGjQR3oLTH676gKS
	 5kZ7By/xF6jYqjHO55MXn752XPhWBZ9VktPk4XZM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 014/423] lockdep/mm: Fix might_fault() lockdep check of current->mm->mmap_lock
Date: Tue,  8 Apr 2025 12:45:40 +0200
Message-ID: <20250408104846.059063061@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit a1b65f3f7c6f7f0a08a7dba8be458c6415236487 ]

Turns out that this commit, about 10 years ago:

  9ec23531fd48 ("sched/preempt, mm/fault: Trigger might_sleep() in might_fault() with disabled pagefaults")

... accidentally (and unnessecarily) put the lockdep part of
__might_fault() under CONFIG_DEBUG_ATOMIC_SLEEP=y.

This is potentially notable because large distributions such as
Ubuntu are running with !CONFIG_DEBUG_ATOMIC_SLEEP.

Restore the debug check.

[ mingo: Update changelog. ]

Fixes: 9ec23531fd48 ("sched/preempt, mm/fault: Trigger might_sleep() in might_fault() with disabled pagefaults")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/r/20241104135517.536628371@infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 525f96ad65b8d..01c0b3a5a4d66 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6718,10 +6718,8 @@ void __might_fault(const char *file, int line)
 	if (pagefault_disabled())
 		return;
 	__might_sleep(file, line);
-#if defined(CONFIG_DEBUG_ATOMIC_SLEEP)
 	if (current->mm)
 		might_lock_read(&current->mm->mmap_lock);
-#endif
 }
 EXPORT_SYMBOL(__might_fault);
 #endif
-- 
2.39.5




