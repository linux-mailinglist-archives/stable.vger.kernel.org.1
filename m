Return-Path: <stable+bounces-150141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4ADACB715
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031683B3F85
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F216D228CB8;
	Mon,  2 Jun 2025 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cl65YSl/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF19227EBB;
	Mon,  2 Jun 2025 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876164; cv=none; b=cf5IGc1k4TyTqwiU4+upIDvkDmsbd7GNDsNX/SJL/IHQ9K7D8Bx2X15qiqltCroPFEfl0c82ocDf2ZOkqN0zaLakzQOJbhh5dR4PRy/LwRxShxFdyVgaMThSLzW9CQCz5Lx0U/zlR/BKCQZf06i9mDPODRbqBdgX1BZZZnupcYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876164; c=relaxed/simple;
	bh=VAlFCRKEbsV6AVW3UgesydSNHALLmXCgSlSS5qG/inI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SlKgU2lYPAAAQqssaDVB/lEn6cS19ziolGAzFQLlL9Dnm6rqZISGfWn6uutgY507Ufd3cVMI24ltzYxv7WftaIrcVwqZqW/ssf7QQvsfD5dVxP7sULXSojLmxZBLZvqz7KVFyK31cu0yvHhdXGiinh4xqUAwGR/7VWh5NYHV7qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cl65YSl/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378F7C4CEEB;
	Mon,  2 Jun 2025 14:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748876164;
	bh=VAlFCRKEbsV6AVW3UgesydSNHALLmXCgSlSS5qG/inI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cl65YSl/CVLAbNbzJuI/yN2gCxDcFYv66PFs7yDHfrcgVMQ+e1/xwzEoAt77X3+L4
	 aZIOXa0nJ9pAAaaEJTrdRZDVftFEIuDH1N2fovLC9YyRMx9k7tIg7J80fUxcYuFXRT
	 3F2/ELQ/O6eGjZfCEsLSS84T7z/WpqsFJohxfhQo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 051/207] posix-timers: Add cond_resched() to posix_timer_add() search loop
Date: Mon,  2 Jun 2025 15:47:03 +0200
Message-ID: <20250602134300.753011939@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134258.769974467@linuxfoundation.org>
References: <20250602134258.769974467@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

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




