Return-Path: <stable+bounces-175079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968A0B3659E
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A38E47BF2AF
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6621350852;
	Tue, 26 Aug 2025 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1fN9WZaw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731AD34A30B;
	Tue, 26 Aug 2025 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216085; cv=none; b=qzkFiz3vxwOFDV98raiDavUU33IGtdPBvfbqagXUugXms00aAzKkmAsQQhbGtC71HaoeiVH9Gw+le1bsNddUHDb8nMCwu4EmuOZC4LH6N7vtY7FBLgbO46OdVSQ5xgNeqomdQ3oX4znpoPIb0ASHVzA3ZLJSaCOpX2ppiHNhyz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216085; c=relaxed/simple;
	bh=nKhzkzZg/xjqd167xH4zG85+RWFf+cAuVK5bVGh8H1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hG/3A8mL99LeIvnSta2okz+NO0AiIGOCzZtmPcMkm5mEWiJrtSdVtrpruyZ9+ulDzcAzMb9VKL851txm8ZSYct+4LlHapOBPjPDxrvH5KlJlK9Q3/hGXW/L4jrdRnXUU5XdwfdJqq8S5mSZr9ts8hsUlKvRqB1iZrKDvEEI5Al8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1fN9WZaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB84C113CF;
	Tue, 26 Aug 2025 13:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216085;
	bh=nKhzkzZg/xjqd167xH4zG85+RWFf+cAuVK5bVGh8H1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1fN9WZawc0X0vyhXYaLSpCMHbbmY7Gqb1uNn+lFt4e2PJVDu+AiAerxPFD9d8UJ9S
	 uwCjHiDFYTTSCwUtHbU6d/bmVaF2yIW1MyuXghTdtyh8G4rBhhDHFa2bdOVua8INWz
	 mhWf40bX55c5J86UlE9rg8GV+K5djH+1HBtXQjis=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+7cfb66a237c4a5fb22ad@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 279/644] ptp: prevent possible ABBA deadlock in ptp_clock_freerun()
Date: Tue, 26 Aug 2025 13:06:10 +0200
Message-ID: <20250826110953.288242613@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

From: Jeongjun Park <aha310510@gmail.com>

[ Upstream commit 2efe41234dbd0a83fdb7cd38226c2f70039a2cd3 ]

syzbot reported the following ABBA deadlock:

       CPU0                           CPU1
       ----                           ----
  n_vclocks_store()
    lock(&ptp->n_vclocks_mux) [1]
        (physical clock)
                                     pc_clock_adjtime()
                                       lock(&clk->rwsem) [2]
                                        (physical clock)
                                       ...
                                       ptp_clock_freerun()
                                         ptp_vclock_in_use()
                                           lock(&ptp->n_vclocks_mux) [3]
                                              (physical clock)
    ptp_clock_unregister()
      posix_clock_unregister()
        lock(&clk->rwsem) [4]
          (virtual clock)

Since ptp virtual clock is registered only under ptp physical clock, both
ptp_clock and posix_clock must be physical clocks for ptp_vclock_in_use()
to lock &ptp->n_vclocks_mux and check ptp->n_vclocks.

However, when unregistering vclocks in n_vclocks_store(), the locking
ptp->n_vclocks_mux is a physical clock lock, but clk->rwsem of
ptp_clock_unregister() called through device_for_each_child_reverse()
is a virtual clock lock.

Therefore, clk->rwsem used in CPU0 and clk->rwsem used in CPU1 are
different locks, but in lockdep, a false positive occurs because the
possibility of deadlock is determined through lock-class.

To solve this, lock subclass annotation must be added to the posix_clock
rwsem of the vclock.

Reported-by: syzbot+7cfb66a237c4a5fb22ad@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7cfb66a237c4a5fb22ad
Fixes: 73f37068d540 ("ptp: support ptp physical/virtual clocks conversion")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
Acked-by: Richard Cochran <richardcochran@gmail.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://patch.msgid.link/20250728062649.469882-1-aha310510@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ptp/ptp_private.h | 5 +++++
 drivers/ptp/ptp_vclock.c  | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index b8d3df8a393a..bf823b8c3c8f 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -20,6 +20,11 @@
 #define PTP_BUF_TIMESTAMPS 30
 #define PTP_DEFAULT_MAX_VCLOCKS 20
 
+enum {
+	PTP_LOCK_PHYSICAL = 0,
+	PTP_LOCK_VIRTUAL,
+};
+
 struct timestamp_event_queue {
 	struct ptp_extts_event buf[PTP_MAX_TIMESTAMPS];
 	int head;
diff --git a/drivers/ptp/ptp_vclock.c b/drivers/ptp/ptp_vclock.c
index ab1d233173e1..6a14c39c4508 100644
--- a/drivers/ptp/ptp_vclock.c
+++ b/drivers/ptp/ptp_vclock.c
@@ -81,6 +81,11 @@ static long ptp_vclock_refresh(struct ptp_clock_info *ptp)
 	return PTP_VCLOCK_REFRESH_INTERVAL;
 }
 
+static void ptp_vclock_set_subclass(struct ptp_clock *ptp)
+{
+	lockdep_set_subclass(&ptp->clock.rwsem, PTP_LOCK_VIRTUAL);
+}
+
 static const struct ptp_clock_info ptp_vclock_info = {
 	.owner		= THIS_MODULE,
 	.name		= "ptp virtual clock",
@@ -137,6 +142,8 @@ struct ptp_vclock *ptp_vclock_register(struct ptp_clock *pclock)
 		return NULL;
 	}
 
+	ptp_vclock_set_subclass(vclock->clock);
+
 	timecounter_init(&vclock->tc, &vclock->cc, 0);
 	ptp_schedule_worker(vclock->clock, PTP_VCLOCK_REFRESH_INTERVAL);
 
-- 
2.50.1




