Return-Path: <stable+bounces-236032-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNqJI4De3GnrXgkAu9opvQ
	(envelope-from <stable+bounces-236032-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:16:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EC83EBC55
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9460300A52F
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 12:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE693C3450;
	Mon, 13 Apr 2026 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A0cCJXnk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CAC3161BA
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776082557; cv=none; b=iPVTBiNOnC3gUFi2EFWQeri5TkX1Y3PfuTMj5JUoG94YtC7VGQEpwPrho0bnTNprk3YtSrkBw5dGhmKpWCBHS2K7gFbmNvwyTgmYseBA5W+rWNRiTFcGO2HfhYKvkT+yLak6YKrKPkJhms4Ul51jC0b+hy1OzRnI0WtYzPRDotY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776082557; c=relaxed/simple;
	bh=sgjyhk7ZoOH2pFCvLKf3kv/6Zx+JZ9gqBdmHLP4O1i4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=drg9MHxz8Wj/Wa30quzRKwLslR3/ni1ekNkkcbwGvutDzmfj84CGwyAsvN/2WJ/8++YblkfQ1U1cGSbfilrHEhMSK4WD/61fuh1aPWnkS6QOBxlB3T+W++7f+ttxiQl6cQ+YVqRcypMLCgVj1Stqzm8ZxkgQvqU8uq/Mx05nOJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A0cCJXnk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DABCC116C6;
	Mon, 13 Apr 2026 12:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776082557;
	bh=sgjyhk7ZoOH2pFCvLKf3kv/6Zx+JZ9gqBdmHLP4O1i4=;
	h=Subject:To:Cc:From:Date:From;
	b=A0cCJXnkvuwysOb8MY52A8h/hAw/F7CThZ92/hiW4+Pe1P9xhVyZ4dZViUbCguwPI
	 56/tZ+32pyehfYTTnNi3nDCYuSoQuQFbPkzC/fTT6DWU1mYfbvZqW5ADHb6n/vZ4fH
	 LrVzIEFj6A/5/GCKD9mGiIhf91fURJ2LEJ1hxcUw=
Subject: FAILED: patch "[PATCH] drm/i915/gt: fix refcount underflow in" failed to apply to 5.10-stable tree
To: sebastian.brzezinka@intel.com,andi.shyti@linux.intel.com,joonas.lahtinen@linux.intel.com,krzysztof.karas@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Apr 2026 14:15:55 +0200
Message-ID: <2026041355-police-panorama-d0e7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236032-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07EC83EBC55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 4c71fd099513bfa8acab529b626e1f0097b76061
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026041355-police-panorama-d0e7@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4c71fd099513bfa8acab529b626e1f0097b76061 Mon Sep 17 00:00:00 2001
From: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
Date: Wed, 1 Apr 2026 12:10:07 +0200
Subject: [PATCH] drm/i915/gt: fix refcount underflow in
 intel_engine_park_heartbeat

A use-after-free / refcount underflow is possible when the heartbeat
worker and intel_engine_park_heartbeat() race to release the same
engine->heartbeat.systole request.

The heartbeat worker reads engine->heartbeat.systole and calls
i915_request_put() on it when the request is complete, but clears
the pointer in a separate, non-atomic step. Concurrently, a request
retirement on another CPU can drop the engine wakeref to zero, triggering
__engine_park() -> intel_engine_park_heartbeat(). If the heartbeat
timer is pending at that point, cancel_delayed_work() returns true and
intel_engine_park_heartbeat() reads the stale non-NULL systole pointer
and calls i915_request_put() on it again, causing a refcount underflow:

```
<4> [487.221889] Workqueue: i915-unordered engine_retire [i915]
<4> [487.222640] RIP: 0010:refcount_warn_saturate+0x68/0xb0
...
<4> [487.222707] Call Trace:
<4> [487.222711]  <TASK>
<4> [487.222716]  intel_engine_park_heartbeat.part.0+0x6f/0x80 [i915]
<4> [487.223115]  intel_engine_park_heartbeat+0x25/0x40 [i915]
<4> [487.223566]  __engine_park+0xb9/0x650 [i915]
<4> [487.223973]  ____intel_wakeref_put_last+0x2e/0xb0 [i915]
<4> [487.224408]  __intel_wakeref_put_last+0x72/0x90 [i915]
<4> [487.224797]  intel_context_exit_engine+0x7c/0x80 [i915]
<4> [487.225238]  intel_context_exit+0xf1/0x1b0 [i915]
<4> [487.225695]  i915_request_retire.part.0+0x1b9/0x530 [i915]
<4> [487.226178]  i915_request_retire+0x1c/0x40 [i915]
<4> [487.226625]  engine_retire+0x122/0x180 [i915]
<4> [487.227037]  process_one_work+0x239/0x760
<4> [487.227060]  worker_thread+0x200/0x3f0
<4> [487.227068]  ? __pfx_worker_thread+0x10/0x10
<4> [487.227075]  kthread+0x10d/0x150
<4> [487.227083]  ? __pfx_kthread+0x10/0x10
<4> [487.227092]  ret_from_fork+0x3d4/0x480
<4> [487.227099]  ? __pfx_kthread+0x10/0x10
<4> [487.227107]  ret_from_fork_asm+0x1a/0x30
<4> [487.227141]  </TASK>
```

Fix this by replacing the non-atomic pointer read + separate clear with
xchg() in both racing paths. xchg() is a single indivisible hardware
instruction that atomically reads the old pointer and writes NULL. This
guarantees only one of the two concurrent callers obtains the non-NULL
pointer and performs the put, the other gets NULL and skips it.

Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/15880
Fixes: 058179e72e09 ("drm/i915/gt: Replace hangcheck by heartbeats")
Cc: <stable@vger.kernel.org> # v5.5+
Signed-off-by: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
Reviewed-by: Krzysztof Karas <krzysztof.karas@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Link: https://lore.kernel.org/r/d4c1c14255688dd07cc8044973c4f032a8d1559e.1775038106.git.sebastian.brzezinka@intel.com
(cherry picked from commit 13238dc0ee4f9ab8dafa2cca7295736191ae2f42)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

diff --git a/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c b/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
index b279878dca29..6424ecce8bcb 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
@@ -148,10 +148,12 @@ static void heartbeat(struct work_struct *wrk)
 	/* Just in case everything has gone horribly wrong, give it a kick */
 	intel_engine_flush_submission(engine);
 
-	rq = engine->heartbeat.systole;
-	if (rq && i915_request_completed(rq)) {
-		i915_request_put(rq);
-		engine->heartbeat.systole = NULL;
+	rq = xchg(&engine->heartbeat.systole, NULL);
+	if (rq) {
+		if (i915_request_completed(rq))
+			i915_request_put(rq);
+		else
+			engine->heartbeat.systole = rq;
 	}
 
 	if (!intel_engine_pm_get_if_awake(engine))
@@ -232,8 +234,11 @@ static void heartbeat(struct work_struct *wrk)
 unlock:
 	mutex_unlock(&ce->timeline->mutex);
 out:
-	if (!engine->i915->params.enable_hangcheck || !next_heartbeat(engine))
-		i915_request_put(fetch_and_zero(&engine->heartbeat.systole));
+	if (!engine->i915->params.enable_hangcheck || !next_heartbeat(engine)) {
+		rq = xchg(&engine->heartbeat.systole, NULL);
+		if (rq)
+			i915_request_put(rq);
+	}
 	intel_engine_pm_put(engine);
 }
 
@@ -247,8 +252,13 @@ void intel_engine_unpark_heartbeat(struct intel_engine_cs *engine)
 
 void intel_engine_park_heartbeat(struct intel_engine_cs *engine)
 {
-	if (cancel_delayed_work(&engine->heartbeat.work))
-		i915_request_put(fetch_and_zero(&engine->heartbeat.systole));
+	if (cancel_delayed_work(&engine->heartbeat.work)) {
+		struct i915_request *rq;
+
+		rq = xchg(&engine->heartbeat.systole, NULL);
+		if (rq)
+			i915_request_put(rq);
+	}
 }
 
 void intel_gt_unpark_heartbeats(struct intel_gt *gt)


