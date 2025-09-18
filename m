Return-Path: <stable+bounces-165938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B26CEB1963C
	for <lists+stable@lfdr.de>; Sun,  3 Aug 2025 23:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B4D18947BB
	for <lists+stable@lfdr.de>; Sun,  3 Aug 2025 21:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2271FCF7C;
	Sun,  3 Aug 2025 21:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTQNQdpt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5652CCC0;
	Sun,  3 Aug 2025 21:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754256146; cv=none; b=AblKQCWcMJ/YuZIJW8Bvy/YD+Wncojn16jFtjIsgpD0YL5VjuIoMAGkTHRgOiFt7BSNI1ZLFoYcJ0TsTusrhLaAG3cNHZXk4Vs+nYhjT6hA3vD+2cAqq8WMi5TSq11yNjpQdAtjBi6Yns9lFe5gBimpdEMqFB5sVSUo3+PLvca4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754256146; c=relaxed/simple;
	bh=LyLD7JNETLUbYXSQcnnxmUAG/ge+ZgZ93StbLrWKdVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P+rmaiAl2jq90GbtBf1JDMEePTj+s5rRYBS0vnmwsiss7u0m6JTKikRay8JSXBQ+ettiQ2I3VSTGGFdgLUXCZ9K+GewUKccnOv1p6lOIZr5LcmrvzvKCnGqvNSSMuFseT1KZmH5lH1l+IL/ptmrEYq8E7E5NLDQSowdcEeiOolw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTQNQdpt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76073C4CEEB;
	Sun,  3 Aug 2025 21:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754256146;
	bh=LyLD7JNETLUbYXSQcnnxmUAG/ge+ZgZ93StbLrWKdVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RTQNQdpthqsHegGSODHRvhNQ7S/2m7gE5JeimXNE6O6g8yxCyrmCnUAva1R2uDw1a
	 eoERnEx6HEELzzu/GT+wR85g7MyFfePOXLQaPdFRMqX3To1D51C3J4Tsf+7oDhR197
	 lr0vBpEy39mY0SrTBnbwapoIRFcG/I5jNckzVTfyzAoHzgvQl65r4LIHo97YHRaZxz
	 OQK6Mb9OGHlJrvwjOCNjq9tPcf197WU0zzL48uwrvwC+fxWB3pjfR1TUun9hkxtqyG
	 dlUATEVl4Jls9rnIiC2ay13q1I2dMaXf0xsEZszi1SeI7/qfLHk1/MJFnGxY4/Bm8U
	 /FNGus27nXsCg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Sarah Newman <srn@prgmr.com>,
	Lars Ellenberg <lars@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com,
	drbd-dev@lists.linbit.com
Subject: [PATCH AUTOSEL 5.15 08/15] drbd: add missing kref_get in handle_write_conflicts
Date: Sun,  3 Aug 2025 17:21:58 -0400
Message-Id: <20250803212206.3548990-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250803212206.3548990-1-sashal@kernel.org>
References: <20250803212206.3548990-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.189
Content-Transfer-Encoding: 8bit

From: Sarah Newman <srn@prgmr.com>

[ Upstream commit 00c9c9628b49e368d140cfa61d7df9b8922ec2a8 ]

With `two-primaries` enabled, DRBD tries to detect "concurrent" writes
and handle write conflicts, so that even if you write to the same sector
simultaneously on both nodes, they end up with the identical data once
the writes are completed.

In handling "superseeded" writes, we forgot a kref_get,
resulting in a premature drbd_destroy_device and use after free,
and further to kernel crashes with symptoms.

Relevance: No one should use DRBD as a random data generator, and apparently
all users of "two-primaries" handle concurrent writes correctly on layer up.
That is cluster file systems use some distributed lock manager,
and live migration in virtualization environments stops writes on one node
before starting writes on the other node.

Which means that other than for "test cases",
this code path is never taken in real life.

FYI, in DRBD 9, things are handled differently nowadays.  We still detect
"write conflicts", but no longer try to be smart about them.
We decided to disconnect hard instead: upper layers must not submit concurrent
writes. If they do, that's their fault.

Signed-off-by: Sarah Newman <srn@prgmr.com>
Signed-off-by: Lars Ellenberg <lars@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Link: https://lore.kernel.org/r/20250627095728.800688-1-christoph.boehmwalder@linbit.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my analysis of the commit and the surrounding code context,
here is my assessment:

**YES** - This commit should be backported to stable kernel trees.

Here's my extensive explanation:

1. **Critical Bug Fix**: This commit fixes a missing `kref_get` that
   causes a use-after-free vulnerability. The code at
   drivers/block/drbd/drbd_receiver.c:2503-2507 shows the fix adds the
   missing reference count increment before queuing work that will later
   decrement the reference count in `drbd_send_acks_wf()`.

2. **Clear Use-After-Free Pattern**: Looking at the code pattern:
   - Before the fix: The code queues work (`queue_work`) that will call
     `drbd_send_acks_wf()`, which contains `kref_put(&device->kref,
     drbd_destroy_device)` at line 6119
   - Without the matching `kref_get`, this leads to premature
     destruction of the device structure
   - The commit message explicitly states this results in "premature
     drbd_destroy_device and use after free"

3. **Follows Established Pattern**: The fix follows the exact same
   pattern used elsewhere in the DRBD code. At
   drivers/block/drbd/drbd_worker.c:150-152, we see:
  ```c
  kref_get(&device->kref); /* put is in drbd_send_acks_wf() */
  if (!queue_work(connection->ack_sender, &peer_device->send_acks_work))
  kref_put(&device->kref, drbd_destroy_device);
  ```
  This shows the fix is correct and consistent with the codebase.

4. **Small and Contained Fix**: The change is minimal (adding 4 lines),
   well-understood, and doesn't introduce any architectural changes. It
   simply ensures proper reference counting.

5. **Real Security Issue**: Use-after-free bugs can lead to kernel
   crashes and potentially be exploited for privilege escalation. Even
   though the commit notes this code path is rarely taken in production
   ("two-primaries" mode with concurrent writes), when it is triggered,
   it causes kernel crashes.

6. **Meets Stable Criteria**: According to Documentation/process/stable-
   kernel-rules.rst:
   - It fixes "a real bug that bothers people" (kernel crashes)
   - It's "obviously correct and tested" (follows established pattern)
   - It's under 100 lines
   - It fixes "data corruption, a real security issue" (use-after-free)

7. **No Side Effects**: The fix only adds proper reference counting and
   doesn't change any logic or introduce new features. The only behavior
   change is preventing the use-after-free bug.

The fact that this affects a rarely-used code path ("two-primaries"
mode) doesn't diminish its importance for backporting, as users who do
use this feature would experience kernel crashes without this fix. The
fix is safe, minimal, and prevents a serious bug.

 drivers/block/drbd/drbd_receiver.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 0104e101b0d7..ea38dd43c6b0 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2532,7 +2532,11 @@ static int handle_write_conflicts(struct drbd_device *device,
 			peer_req->w.cb = superseded ? e_send_superseded :
 						   e_send_retry_write;
 			list_add_tail(&peer_req->w.list, &device->done_ee);
-			queue_work(connection->ack_sender, &peer_req->peer_device->send_acks_work);
+			/* put is in drbd_send_acks_wf() */
+			kref_get(&device->kref);
+			if (!queue_work(connection->ack_sender,
+					&peer_req->peer_device->send_acks_work))
+				kref_put(&device->kref, drbd_destroy_device);
 
 			err = -ENOENT;
 			goto out;
-- 
2.39.5


