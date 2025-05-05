Return-Path: <stable+bounces-140996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BA2AAAD27
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53311A879B4
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AB83E3E9C;
	Mon,  5 May 2025 23:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BH3CH+7N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ACE3ACFF4;
	Mon,  5 May 2025 23:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487158; cv=none; b=RelvxelOuc/+CRVUH/U3eH6iJhAzDFRZ42F/EBC3GhQVF2A20/xW2b4RhCGYcXYCrZBzfjNC1HwjUyTlrw76NgkA9hjh3sE+h2xsmpaQv1Ak0WKa/fAO4pmuVUsSK5H06dUOh/Lx/IojVXBOOiNzNqTBcVSpavoYjy5f8ozwNlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487158; c=relaxed/simple;
	bh=oV15o+gNwdtz8+mIe9nEr8gBfkSeqc4DoeCrsBC+qg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AKOl3mcjiHhgGGrZ638Q+/jyFRci68M/X9pFfPz/5n+hHk22VORSWeSy9K1a8vbqVjrMJb/wmHWIlVZC/gx/D6XcbgjLJ0e7Jcdhu/tmH+po+hnqn0bCaICNCiLb61EBzQr3NK3FRDL1cdl0RTSbLXtuU2MwqS6Gw8mBhV9iC78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BH3CH+7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D96C4CEEF;
	Mon,  5 May 2025 23:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487157;
	bh=oV15o+gNwdtz8+mIe9nEr8gBfkSeqc4DoeCrsBC+qg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BH3CH+7NZbtYh6QKlUHWNIva31ALhsqQThUAYqvrnMdbj8NgWHDAFwDWGkl6B9ynG
	 3hqp4wbE4FbeKguVD/wfMAKKMVkyHltBek56oSHDH9bM4ts3X/6oRMdc9mSXr1S2RZ
	 Q7y1piXFZNSEkZCRw52cFJXhKGcAVQP2D5DMXhUVMLW3pBAEcEA6MYelwCKT3a9HcW
	 DoMPjmMLuOIjyEUEVK0v6a/1pt+63ICoje33AfgHZzUYF/Qqx6U5iW2dkjBm6qfEFT
	 iQvZX9+l2ltuyQC/9LQ//cF7+/D/Z2k0eN+TYR1A8ak/iCevIWKQ5dZZEi50qrg65a
	 5vQ3tQWHeUVwg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	anna-maria@linutronix.de
Subject: [PATCH AUTOSEL 5.10 032/114] posix-timers: Add cond_resched() to posix_timer_add() search loop
Date: Mon,  5 May 2025 19:16:55 -0400
Message-Id: <20250505231817.2697367-32-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 5f2909c6cd13564a07ae692a95457f52295c4f22 ]

With a large number of POSIX timers the search for a valid ID might cause a
soft lockup on PREEMPT_NONE/VOLUNTARY kernels.

Add cond_resched() to the loop to prevent that.

[ tglx: Split out from Eric's series ]

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20250214135911.2037402-2-edumazet@google.com
Link: https://lore.kernel.org/all/20250308155623.635612865@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/posix-timers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 29569b1c3d8c8..3a68c650ff2a3 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -161,6 +161,7 @@ static int posix_timer_add(struct k_itimer *timer)
 			return id;
 		}
 		spin_unlock(&hash_lock);
+		cond_resched();
 	}
 	/* POSIX return code when no timer ID could be allocated */
 	return -EAGAIN;
-- 
2.39.5


