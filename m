Return-Path: <stable+bounces-140510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D7EAAADF9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49831885DE1
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDA63628D3;
	Mon,  5 May 2025 22:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmNKQGOg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB7829A3C8;
	Mon,  5 May 2025 22:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485025; cv=none; b=lBqc2RXj1HNaCaVpBTWMpwrITKVR5vILH271to0KJfzkH5X51xe9rQQ1SBXay0UWM3CQytoJFX+QPXSJWOIlEkGOujW8Tab/3uscyM3XlEyXdlORAnliA3z+YaAcaQQsIx/wUFRshDyI7RWqAbsTBWIq2lU0KO2kJeZxQK9WyYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485025; c=relaxed/simple;
	bh=ZD7rDBrLE+YDGNuwAVcCT5/6aiwJAyvJL7pKhhsbqqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=stQhf236qs4wskRr2w/fFmU9lpDRmnhj4FG61TYF43oDJoYHi9docdHKeaciCvvqS3qN3HcNdcqKk8d6ESX7yOFLyFHY4bQGYzGaHXZgW5jL9uTnAA/OwGQ6LcLPMDS9qZs6mzBNluXjjKwGXrJfNkAKPKxQ2ng2PHUDn+PsuEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmNKQGOg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B777C4CEF1;
	Mon,  5 May 2025 22:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485024;
	bh=ZD7rDBrLE+YDGNuwAVcCT5/6aiwJAyvJL7pKhhsbqqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qmNKQGOgjIUk5vTv1PsWZGDM1wHfDlIPOdQMfolHBNJsxqSQfUV1enFncx3DneylJ
	 A0AaT1v8Ql/RgZZJ1Vht0RKsTOEQZwVLloWajg41Ga5FPNhQHSAzLXHZ0tPvG89ZDW
	 IeLjp3597wp1s/m6+R3aomnOmNSu3fEBpE0MS289kA3NBVKaEoFJekUqodfwqpVE6g
	 7061+VoonLIsl1u9bTLoR8Uu30eY+fRWiqMxUqGEDN/dOJ03bGtq9yLNrEdwrboKpH
	 h3cPtjKhbKyaXVKwwmW/fZHnRzYk/B11hiwp8KmOSFZxwmBklTKpXZLwlrj59GVGeu
	 lOK1RWk6YZyKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	anna-maria@linutronix.de
Subject: [PATCH AUTOSEL 6.12 129/486] posix-timers: Add cond_resched() to posix_timer_add() search loop
Date: Mon,  5 May 2025 18:33:25 -0400
Message-Id: <20250505223922.2682012-129-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 4576aaed13b23..896ff735034ce 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -118,6 +118,7 @@ static int posix_timer_add(struct k_itimer *timer)
 			return id;
 		}
 		spin_unlock(&hash_lock);
+		cond_resched();
 	}
 	/* POSIX return code when no timer ID could be allocated */
 	return -EAGAIN;
-- 
2.39.5


