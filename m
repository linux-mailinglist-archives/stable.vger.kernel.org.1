Return-Path: <stable+bounces-139909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2ECAAA216
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8259C1892A26
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC73E2D5CED;
	Mon,  5 May 2025 22:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6OaTWol"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D442D5CE7;
	Mon,  5 May 2025 22:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483652; cv=none; b=hrvHpLC7bT2wShp70fmg3qM1aq26/6eM8C0jtQ+6k++oPBs2p4I5nQXqtjKS4kM9bNQAElH/mmEEZ3C53Sr4ThAAWAvd7TUahjQ4ka0HG0wXrbM5kdc+rF03yDO71dMoGOt6v5/jieodOXkisqPZbX3eaL6Xdc5LIQo7gA2O2jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483652; c=relaxed/simple;
	bh=Y2lIswP846yCmP7PzBnewNLP0DbVkvOFt7Ago3FSv4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fIU8K2w5g90IVz6/Kd22JoI3/csIttK6Ja2OuQkeuzPsAPTlqBKOUAe/uzz2xueQFZTK/qOQ3twHKtBADASXcN4U5o+8RKiTUK2JOExU3cWb10ZEqzEw2BUHHI38X4QJtbNZWCMz9fBTgIiz0Z8ChNRdsaGe9GOpzWV5KM8PDto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6OaTWol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9DAC4CEEF;
	Mon,  5 May 2025 22:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483652;
	bh=Y2lIswP846yCmP7PzBnewNLP0DbVkvOFt7Ago3FSv4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e6OaTWolXnAukSNUtuJ2Ic1We9EsyqMFnC2Yu7kwfYo1nN3UfQyQZLkwAA8CUqjj7
	 8vPviHJRKbw3rjqz0ZpipwsiPV+36J8JGsP11vqBCvbcai6bpBEm5SZfb/TaOekubR
	 iXLN0aW/QuE0ZRWJNsyH4iB31qpCYNp1DUr6Fol4QSB/vFiZ1atUphXcWxbkMaw90t
	 71z86qUavD8Bye2ZabjryZkv6XUD1rKX1T/g15h5SVfooPkqojBHLKkM7wCVX5p6cd
	 4yomNCv9Zwd74n2zJV9gj9AaMnXe53Pn1orwqPo062Y4O7GE1bLdEtzCd6SqxydfSS
	 C6M10g2DnvyKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	anna-maria@linutronix.de
Subject: [PATCH AUTOSEL 6.14 162/642] posix-timers: Add cond_resched() to posix_timer_add() search loop
Date: Mon,  5 May 2025 18:06:18 -0400
Message-Id: <20250505221419.2672473-162-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index 1b675aee99a98..7f8644e047558 100644
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


