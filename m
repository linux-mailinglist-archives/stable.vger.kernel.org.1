Return-Path: <stable+bounces-158189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F04FAE575E
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8C0117D977
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF19223DCC;
	Mon, 23 Jun 2025 22:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wj2QdNu2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1F4B676;
	Mon, 23 Jun 2025 22:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717703; cv=none; b=DUMkmGwYHoi1vldI4AXXTOxlngtWH4yccWYHc9ObLxwG3rJczmMt3dtvN1L1tcIwrK8igNsFtKkUvLWZ1KxjmIR9krSdyDfcX8hmZihlU+Yt0GVplOiyzZqK4aXa5YpPNLYcuiC0JHMI1mYmuQfs7otf/28tNBgoNYcATuTrCew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717703; c=relaxed/simple;
	bh=LEgIlMOEuRZA0OZj5eqPKrJu86rHRIX+pczG32fYgkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1c59zmOxKWYhvKjyOhn7xAIo6SBS9tE3cI/ByfHyRwn2JV5CEbCQrhhr/U6D6KEcYz9zfT+utcZh11IW0q9HOVkbOJjIu0hRMxIl7FE90PJqyz0C76trSsbNBAD2WgQTc5V4fSRlxe1V3rjT1skswyBh3yKR+yPPxPKxiNnKHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wj2QdNu2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E52C4CEEA;
	Mon, 23 Jun 2025 22:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717703;
	bh=LEgIlMOEuRZA0OZj5eqPKrJu86rHRIX+pczG32fYgkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wj2QdNu2CfUV+09z/ZK2gC375ogsi+jbgf3MQ3CWZHT4Z65WCBphVR86rV10uL4/5
	 32/sJ/N2Cltu8jJnafVOfiYa0i3nwA1a0X8CHbxZkzotLTmuOO2N5OkwPBriL231nT
	 lhG3q97/rg6tIdmoLIOrSvWaXTE1ZJIcoWHTeJsw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 479/508] ptp: fix breakage after ptp_vclock_in_use() rework
Date: Mon, 23 Jun 2025 15:08:44 +0200
Message-ID: <20250623130656.858819077@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 5ab73b010cad294851e558f1d4714a85c6f206c7 ]

What is broken
--------------

ptp4l, and any other application which calls clock_adjtime() on a
physical clock, is greeted with error -EBUSY after commit 87f7ce260a3c
("ptp: remove ptp->n_vclocks check logic in ptp_vclock_in_use()").

Explanation for the breakage
----------------------------

The blamed commit was based on the false assumption that
ptp_vclock_in_use() callers already test for n_vclocks prior to calling
this function.

This is notably incorrect for the code path below, in which there is, in
fact, no n_vclocks test:

ptp_clock_adjtime()
-> ptp_clock_freerun()
   -> ptp_vclock_in_use()

The result is that any clock adjustment on any physical clock is now
impossible. This is _despite_ there not being any vclock over this
physical clock.

$ ptp4l -i eno0 -2 -P -m
ptp4l[58.425]: selected /dev/ptp0 as PTP clock
[   58.429749] ptp: physical clock is free running
ptp4l[58.431]: Failed to open /dev/ptp0: Device or resource busy
failed to create a clock
$ cat /sys/class/ptp/ptp0/n_vclocks
0

The patch makes the ptp_vclock_in_use() function say "if it's not a
virtual clock, then this physical clock does have virtual clocks on
top".

Then ptp_clock_freerun() uses this information to say "this physical
clock has virtual clocks on top, so it must stay free-running".

Then ptp_clock_adjtime() uses this information to say "well, if this
physical clock has to be free-running, I can't do it, return -EBUSY".

Simply put, ptp_vclock_in_use() cannot be simplified so as to remove the
test whether vclocks are in use.

What did the blamed commit intend to fix
----------------------------------------

The blamed commit presents a lockdep warning stating "possible recursive
locking detected", with the n_vclocks_store() and ptp_clock_unregister()
functions involved.

The recursive locking seems this:
n_vclocks_store()
-> mutex_lock_interruptible(&ptp->n_vclocks_mux) // 1
-> device_for_each_child_reverse(..., unregister_vclock)
   -> unregister_vclock()
      -> ptp_vclock_unregister()
         -> ptp_clock_unregister()
            -> ptp_vclock_in_use()
               -> mutex_lock_interruptible(&ptp->n_vclocks_mux) // 2

The issue can be triggered by creating and then deleting vclocks:
$ echo 2 > /sys/class/ptp/ptp0/n_vclocks
$ echo 0 > /sys/class/ptp/ptp0/n_vclocks

But note that in the original stack trace, the address of the first lock
is different from the address of the second lock. This is because at
step 1 marked above, &ptp->n_vclocks_mux is the lock of the parent
(physical) PTP clock, and at step 2, the lock is of the child (virtual)
PTP clock. They are different locks of different devices.

In this situation there is no real deadlock, the lockdep warning is
caused by the fact that the mutexes have the same lock class on both the
parent and the child. Functionally it is fine.

Proposed alternative solution
-----------------------------

We must reintroduce the body of ptp_vclock_in_use() mostly as it was
structured prior to the blamed commit, but avoid the lockdep warning.

Based on the fact that vclocks cannot be nested on top of one another
(ptp_is_attribute_visible() hides n_vclocks for virtual clocks), we
already know that ptp->n_vclocks is zero for a virtual clock. And
ptp->is_virtual_clock is a runtime invariant, established at
ptp_clock_register() time and never changed. There is no need to
serialize on any mutex in order to read ptp->is_virtual_clock, and we
take advantage of that by moving it outside the lock.

Thus, virtual clocks do not need to acquire &ptp->n_vclocks_mux at
all, and step 2 in the code walkthrough above can simply go away.
We can simply return false to the question "ptp_vclock_in_use(a virtual
clock)".

Other notes
-----------

Releasing &ptp->n_vclocks_mux before ptp_vclock_in_use() returns
execution seems racy, because the returned value can become stale as
soon as the function returns and before the return value is used (i.e.
n_vclocks_store() can run any time). The locking requirement should
somehow be transferred to the caller, to ensure a longer life time for
the returned value, but this seems out of scope for this severe bug fix.

Because we are also fixing up the logic from the original commit, there
is another Fixes: tag for that.

Fixes: 87f7ce260a3c ("ptp: remove ptp->n_vclocks check logic in ptp_vclock_in_use()")
Fixes: 73f37068d540 ("ptp: support ptp physical/virtual clocks conversion")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://patch.msgid.link/20250613174749.406826-2-vladimir.oltean@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ptp/ptp_private.h | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index d0eb4555720eb..a54124269c2f4 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -89,7 +89,27 @@ static inline int queue_cnt(const struct timestamp_event_queue *q)
 /* Check if ptp virtual clock is in use */
 static inline bool ptp_vclock_in_use(struct ptp_clock *ptp)
 {
-	return !ptp->is_virtual_clock;
+	bool in_use = false;
+
+	/* Virtual clocks can't be stacked on top of virtual clocks.
+	 * Avoid acquiring the n_vclocks_mux on virtual clocks, to allow this
+	 * function to be called from code paths where the n_vclocks_mux of the
+	 * parent physical clock is already held. Functionally that's not an
+	 * issue, but lockdep would complain, because they have the same lock
+	 * class.
+	 */
+	if (ptp->is_virtual_clock)
+		return false;
+
+	if (mutex_lock_interruptible(&ptp->n_vclocks_mux))
+		return true;
+
+	if (ptp->n_vclocks)
+		in_use = true;
+
+	mutex_unlock(&ptp->n_vclocks_mux);
+
+	return in_use;
 }
 
 /* Check if ptp clock shall be free running */
-- 
2.39.5




