Return-Path: <stable+bounces-141508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D126AAB41C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A165C3A59BF
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897CB46F096;
	Tue,  6 May 2025 00:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+m0KR3q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB01D2ECFF6;
	Mon,  5 May 2025 23:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486506; cv=none; b=NrqKAmL9bTjVyOI9JTeN6tOK4m+xwMA7AeHO8pSva5hPZn8HhTnTyQEMotz4bJpg9Jw3WZkQCswisWtxlmh5avYGrBXZExW9qTtyMoAMZaFwxmhocg1rkjdc61jQisnqgNCoeSMTFuFNQo8Tn8KR+P2s3ZGY3RIlohoffbNfY9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486506; c=relaxed/simple;
	bh=8ONW94dM+NZTcEz/+rs4aAEOz/0Y7F+L1BCO5cWJ4U0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mxqaCHnx+EYYkBNYmOutNu5MMs0p3K0sYvXPcZgdy9fBg6vyIHJILQwbXHNGXBKM6d4Ujv0azU2j00a8DhO2vR/z22XMqNh0yJm3FXpd/1N7MLQVyZSnriaFPmzEFEO8Tca9qwzrdTfX5waC0p6zet3plKoHmE7lN8GT8Fjb2rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+m0KR3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6558AC4CEEF;
	Mon,  5 May 2025 23:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486506;
	bh=8ONW94dM+NZTcEz/+rs4aAEOz/0Y7F+L1BCO5cWJ4U0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M+m0KR3qc4NmOsrMk38k6z5uzPFonweaFERAcMT/Hd2svsmNL68vTiSPQkk0sfjgG
	 bsdnmvmHwcK1/SgyAp8jSvr+mKHOYh+KmTWZ9oYvkfVAGFuetj5xn62FF1n1KcXfDX
	 CFx7GQULMMt0y7kDMWAaeOX1kE9RYTUvRPgAaWqU62Le+iE2T7MgFHIuww4k1iZ1jY
	 yC3LUSOcQO84hvt4/OD38oEFBVq2qHYFEQRvcx4xBYGX/pS847OchXvtaDqDLrhbLi
	 XwQbG/qKdpjd1Ng/KTEUbegUVZLNwnAVnv0qHh2Dy/ZuHugPczOP0JWjG2n7gN49mW
	 tvFoq5r2BPFJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	anna-maria@linutronix.de
Subject: [PATCH AUTOSEL 6.1 065/212] posix-timers: Add cond_resched() to posix_timer_add() search loop
Date: Mon,  5 May 2025 19:03:57 -0400
Message-Id: <20250505230624.2692522-65-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index 2d6cf93ca370a..fc08d4ccdeeb9 100644
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


