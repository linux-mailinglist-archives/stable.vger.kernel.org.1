Return-Path: <stable+bounces-258744-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sD9aEK0rG2r//ggAu9opvQ
	(envelope-from <stable+bounces-258744-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:25:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F18611B43
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA4F23088CA3
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0DD21B191;
	Sat, 30 May 2026 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qftBosh8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC2217555;
	Sat, 30 May 2026 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165393; cv=none; b=lLnJDizVM14YqXNclpFFfFcE+nHTj8nEelja4kEEIH8zYyiy074o6padTgzNYcQNXFpa10PkRdJjX4niXToYUTQ0F8H6woYCCEiY7c6QBRBQsVGXO9NOUPkU2ogpkJJg+KSucXYlrNHQN9BZJaC7KD9a2MNRJUZsYhblokJgUXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165393; c=relaxed/simple;
	bh=nVIFzcIOWR84q1siXK/a/D5VU1gVBoQqylF7jg3FifQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdjWhbYLvefJoiXfh+h0+JXtM8PCsfdS0qp3EbA1OtZj1OGwMhQ9kvL5vdxWD2WtWb3Q72ITkcwoQI1DjZmK/cOLToMp4J2r8/+8kYZ2I1n3q2V1PTk+aOFSWsHfidBo6Te0D5iyuGYiaNMhMPb3EcjTYbTF2EgnkXnDlMwWBRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qftBosh8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3D11F00893;
	Sat, 30 May 2026 18:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780165391;
	bh=mUhNpJPNBNRnUszO5HTDcN9Y9ZBqG2b2Idgn1ceZzeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qftBosh8PoTi0KFh/Lsu9hViq8V7qAYw0QMMf70pzvJ8ANML8LyztwDcrdI3+yEtC
	 npR7h9r/GQQHh9wD0/U6SR/cLWSvunXxRNYYRuzIPXQph2QJhSoa+Zdawy8Xec9e7u
	 DwNb0+/l4WK9rvIQW+X7pQu8/cXkaqxXorr+8mxA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
	Krzysztof Karas <krzysztof.karas@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 035/589] drm/i915/gt: fix refcount underflow in intel_engine_park_heartbeat
Date: Sat, 30 May 2026 17:58:36 +0200
Message-ID: <20260530160225.509476941@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258744-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: B1F18611B43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Brzezinka <sebastian.brzezinka@intel.com>

[ Upstream commit 4c71fd099513bfa8acab529b626e1f0097b76061 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/i915/gt/intel_engine_heartbeat.c  | 26 +++++++++++++------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c b/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
index 5067d0524d4b5..780e29fa4aeeb 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
@@ -70,10 +70,12 @@ static void heartbeat(struct work_struct *wrk)
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
@@ -153,8 +155,11 @@ static void heartbeat(struct work_struct *wrk)
 unlock:
 	mutex_unlock(&ce->timeline->mutex);
 out:
-	if (!next_heartbeat(engine))
-		i915_request_put(fetch_and_zero(&engine->heartbeat.systole));
+	if (!next_heartbeat(engine)) {
+		rq = xchg(&engine->heartbeat.systole, NULL);
+		if (rq)
+			i915_request_put(rq);
+	}
 	intel_engine_pm_put(engine);
 }
 
@@ -168,8 +173,13 @@ void intel_engine_unpark_heartbeat(struct intel_engine_cs *engine)
 
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
 
 void intel_engine_init_heartbeat(struct intel_engine_cs *engine)
-- 
2.53.0




