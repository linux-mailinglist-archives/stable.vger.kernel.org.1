Return-Path: <stable+bounces-141722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7373FAAB5D1
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7A2189DFD4
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E86034CE78;
	Tue,  6 May 2025 00:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKiS70JX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5026A283682;
	Mon,  5 May 2025 23:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487353; cv=none; b=H4k4Hb7YtxL3sND3wQi1w4VgZXJB60WjDOB9zNFLFVsTv6JM091Qyd7oD71IVutNN9gtNRe5Fk1B3UPvHV34otceapGyfP1ebPyx91Y0xOgjZVt6kFYz6RdNAus0jABmxKm2Fwu+SClmAuIwBA0P8F+mUY1aqEFHZQ7DXVe87YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487353; c=relaxed/simple;
	bh=lDfndmTRz9NS0CQiVMjWt0i3Ue2Jtj5vonl4EvPa/N0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fgFztG8WxQYAuyE8qvNzAERRwTJHxRtGUlnyDDlh8LwPDFieAF7ZbR3CuWukIouA+m3EbeWzpeFpApXt5n9XKAeDbiw38NihEKg0pfn5BOz8Pzu5ZTVquKbbnmHQ7A6nsCgDkGQ/MpE5ZDAVtHVIShVBPAMgQ0I7jkI+g2zoFFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKiS70JX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48DA9C4CEEF;
	Mon,  5 May 2025 23:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487352;
	bh=lDfndmTRz9NS0CQiVMjWt0i3Ue2Jtj5vonl4EvPa/N0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eKiS70JXI2A2IDr0cOZEKHOtoGfy7OlGQvmQUTnlNZGzLS74nzTAyvQVbpAFISQjK
	 6DU6PqcRI+HK+58a8cKCOcG4G6FYBRLM5gFMJH2J06vkfddQowpMHBictBb3TzT2hN
	 vCS4/UBYDH4ocwGlsWnut8g6DxNpMc0P6uS8gYua7Q3RdXR9kAO2Xm0pnHtowdgU93
	 adW/BaRbL1l9brC6yq15uYW5tK3nS4fArsapgrRURvrG5JIARX2qAsN3V0LjJ4plu7
	 71wQx+ZBmXwz/ua+fZmL0A/iYI/rOU2Ww8FbnRsQsH+Zl+mtLq5cg+nhXxqp1EB64N
	 f6woiT+BNprkA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	anna-maria@linutronix.de
Subject: [PATCH AUTOSEL 5.4 24/79] posix-timers: Add cond_resched() to posix_timer_add() search loop
Date: Mon,  5 May 2025 19:20:56 -0400
Message-Id: <20250505232151.2698893-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
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
index f3b8313475acd..2a2e4f6622ae7 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -159,6 +159,7 @@ static int posix_timer_add(struct k_itimer *timer)
 			return id;
 		}
 		spin_unlock(&hash_lock);
+		cond_resched();
 	}
 	/* POSIX return code when no timer ID could be allocated */
 	return -EAGAIN;
-- 
2.39.5


