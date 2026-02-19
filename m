Return-Path: <stable+bounces-217441-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPAsNzscl2ktuwIAu9opvQ
	(envelope-from <stable+bounces-217441-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 15:20:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC0115F6B9
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 15:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 888503021E5E
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 14:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AB41DE3A4;
	Thu, 19 Feb 2026 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="wyO1xh1b"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F472FE074
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771510824; cv=none; b=WI4n/jxKhVZBwnpLkIPesWzIzxt3SgAEIUEKj0HYxcI7/kyc76eWMWrTbb8ykuAXiDDxP1TvFz4jt7oJ6TY5amxRlYjveIOaWO7iCiKZXghTtLo0/LXwGfCZDjnVrIZdnERovO9PCeff4bZbri0B1RG/vZY7g+grHWquwmlZa5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771510824; c=relaxed/simple;
	bh=sCDkI7ENHQnXmpAh3KuSLSxg0XzvGEd48fbJO0pMl7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aERB0JYOTSVItHZftYPu5Q8MKmdSGjEebLBkVBEnZCm4qDEktulv+HALYk3h3lAtGzTtFij5NZcBvwP7AcI4WkU+rinB2WPZM6jXXGHmfVqJbVhsHpzBakyJC36c1EN88oyNUPkkTXtcKZmB+Uu+0ThkQcvF7LOgynpNMzML2Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=wyO1xh1b; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4376de3f128so682061f8f.0
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 06:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1771510821; x=1772115621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5WPV5zc+4pTYNW/WHh9z0i95W/Lb1GJgH88opLKR1Gc=;
        b=wyO1xh1bbqeqBY+KIqukgTEM6kchR+ZVBd/FALdRv5m7+YXXQnkMDM5o2cHAZTgKCC
         RDmAgDO4zOSW/QxhgW4GxHF1J7TCG2aFQRm0/+0DRwrtagY52KqtNcteEk8ypTy4clb+
         X3/b9tNZk754jVwBMRsna3iB7+s4XgZRD2pZW4yilyNDkCC5uAAx1xro1ownVuXoNMJo
         BtQAeYCQk94NeA0pjzsCuLXuGw5q/TJ+HQhCJQIZbmcKUd0H1iTcrZoF+GgGU6AzuYYx
         qPBD9cqZ0LSbsnIljmVLJpdTWocjKKz9HWqcqeHfF9TbyEnfCxxUchmp+PvLWP3B4Ot3
         xepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771510821; x=1772115621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WPV5zc+4pTYNW/WHh9z0i95W/Lb1GJgH88opLKR1Gc=;
        b=EM/SOJ3eNtr9OB+teb7ZygsbrUPmBwDJ4R15yXbZJDAPm61d8viaqjuGjDTKmYcBot
         k0xzGmbSf3p4O+UvY+3OXdLim0n2NkTySUlw3Xsd4Lfzr7mFvm7GWX9Hi/lwKNAcl99N
         SyyLk90q6QHM78Jgo21YxsgCkumOXCQs2ot41AI9w60Oedi3fOSnj7gEDbsaxm18PbVI
         JKpuWpKLN57czW8E9MT9k/VFaIA7//BELGrex+oFefpr236tkiy548hD1K8ulMnXbNOe
         aRU7p6WoxU8XWuHRTo7PBNuqR0VIDHTUN1Gr01IMCXyG5gOL1eijTQ5y62qH8L9VqOGU
         jpEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhE7BfX0x0ZtJR+zRDt5jE9urWH975IiVIqbN/xw8szF5+O/frWLWbNIzVEYtID5W0MMm3M6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/yQLa5OA59t++eCmlm/KxSY2ZABSXIaJELTgaD3Gna7o33cTI
	yvtoCgbaeljSCJfBoLj6vBjJ/NjCMWi8KGn6MZF/IiQPFSS99x9ZnvGnkTuGKRNHaM0=
X-Gm-Gg: AZuq6aL19RxleuJsk5jkM87flftfmjDahjbXN6TENDysu/W8ptpmgscLm67aARaQRhb
	hrVEPUPg1S9oAPCnZQIk3jJg1TyVLeXHN20YLbMhfXVXYBl9+JUQXwLZh66ITU0oKf1bQ+3LMYn
	Ikga7hilVVVMZ4YMN6An3iLEhrUh9w4bzVSMAZ+MjlodGfD5PB+itUQpSFOfC7bWRmeK4kocPzF
	bv/G1EW45mDzO5QzQxdfVKo8TT1V1Fmf28fAVwciSyzoGdIslNoNY9Ee2Wpf9WlstSqQphdTM8I
	uVuA/vcs4FNQk6QvdqArDDBFW6TI/5eCHWKw1JXAgukv/lbfd0sEjvWt365C5iOsR74KKcLYSLh
	Ho9sSdn8S6lg+WJ4ATT3UE76MpDk0wWzYgETOIBks+fo1Q4v9PLNywi+UObmvziLRGMQ/1HYOOn
	oAyOzkkSeK17Jm5pUFKXT2XAQZc5fgbYkapC6ak3Ri8LCKz4xjZovfQ2Arij8hkrvx0fA1tLguN
	+guhD7VzVRA7oxlJXbyeLJlu5oex9sx+N4=
X-Received: by 2002:a5d:5d83:0:b0:437:6b6e:d114 with SMTP id ffacd0b85a97d-4379db9800dmr29808717f8f.30.1771510820603;
        Thu, 19 Feb 2026 06:20:20 -0800 (PST)
Received: from localhost.localdomain.com (62-99-137-214.static.upcbusiness.at. [62.99.137.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a5ac7csm47122906f8f.7.2026.02.19.06.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 06:20:20 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars@linbit.com>,
	drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH] drbd: fix "LOGIC BUG" in drbd_al_begin_io_nonblock()
Date: Thu, 19 Feb 2026 15:20:12 +0100
Message-ID: <20260219142012.97756-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linbit-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[linbit.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217441-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linbit-com.20230601.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christoph.boehmwalder@linbit.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linbit-com.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4AC0115F6B9
X-Rspamd-Action: no action

From: Lars Ellenberg <lars.ellenberg@linbit.com>

Even though we check that we "should" be able to do lc_get_cumulative()
while holding the device->al_lock spinlock, it may still fail,
if some other code path decided to do lc_try_lock() with bad timing.

If that happened, we logged "LOGIC BUG for enr=...",
but still did not return an error.

The rest of the code now assumed that this request has references
for the relevant activity log extents.

The implcations are that during an active resync, mutual exclusivity of
resync versus application IO is not guaranteed. And a potential crash
at this point may not realizs that these extents could have been target
of in-flight IO and would need to be resynced just in case.

Also, once the request completes, it will give up activity log references it
does not even hold, which will trigger a BUG_ON(refcnt == 0) in lc_put().

Fix:

Do not crash the kernel for a condition that is harmless during normal
operation: also catch "e->refcnt == 0", not only "e == NULL"
when being noisy about "al_complete_io() called on inactive extent %u\n".

And do not try to be smart and "guess" whether something will work, then
be surprised when it does not.
Deal with the fact that it may or may not work.  If it does not, remember a
possible "partially in activity log" state (only possible for requests that
cross extent boundaries), and return an error code from
drbd_al_begin_io_nonblock().

A latter call for the same request will then resume from where we left off.

Cc: stable@vger.kernel.org
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_actlog.c   | 53 +++++++++++++-----------------
 drivers/block/drbd/drbd_interval.h |  5 ++-
 2 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 742b2908ff68..b3dbf6c76e98 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -483,38 +483,20 @@ void drbd_al_begin_io(struct drbd_device *device, struct drbd_interval *i)
 
 int drbd_al_begin_io_nonblock(struct drbd_device *device, struct drbd_interval *i)
 {
-	struct lru_cache *al = device->act_log;
 	/* for bios crossing activity log extent boundaries,
 	 * we may need to activate two extents in one go */
 	unsigned first = i->sector >> (AL_EXTENT_SHIFT-9);
 	unsigned last = i->size == 0 ? first : (i->sector + (i->size >> 9) - 1) >> (AL_EXTENT_SHIFT-9);
-	unsigned nr_al_extents;
-	unsigned available_update_slots;
 	unsigned enr;
 
-	D_ASSERT(device, first <= last);
-
-	nr_al_extents = 1 + last - first; /* worst case: all touched extends are cold. */
-	available_update_slots = min(al->nr_elements - al->used,
-				al->max_pending_changes - al->pending_changes);
-
-	/* We want all necessary updates for a given request within the same transaction
-	 * We could first check how many updates are *actually* needed,
-	 * and use that instead of the worst-case nr_al_extents */
-	if (available_update_slots < nr_al_extents) {
-		/* Too many activity log extents are currently "hot".
-		 *
-		 * If we have accumulated pending changes already,
-		 * we made progress.
-		 *
-		 * If we cannot get even a single pending change through,
-		 * stop the fast path until we made some progress,
-		 * or requests to "cold" extents could be starved. */
-		if (!al->pending_changes)
-			__set_bit(__LC_STARVING, &device->act_log->flags);
-		return -ENOBUFS;
+	if (i->partially_in_al_next_enr) {
+		D_ASSERT(device, first < i->partially_in_al_next_enr);
+		D_ASSERT(device, last >= i->partially_in_al_next_enr);
+		first = i->partially_in_al_next_enr;
 	}
 
+	D_ASSERT(device, first <= last);
+
 	/* Is resync active in this area? */
 	for (enr = first; enr <= last; enr++) {
 		struct lc_element *tmp;
@@ -529,14 +511,21 @@ int drbd_al_begin_io_nonblock(struct drbd_device *device, struct drbd_interval *
 		}
 	}
 
-	/* Checkout the refcounts.
-	 * Given that we checked for available elements and update slots above,
-	 * this has to be successful. */
+	/* Try to checkout the refcounts. */
 	for (enr = first; enr <= last; enr++) {
 		struct lc_element *al_ext;
 		al_ext = lc_get_cumulative(device->act_log, enr);
-		if (!al_ext)
-			drbd_info(device, "LOGIC BUG for enr=%u\n", enr);
+
+		if (!al_ext) {
+			/* Did not work. We may have exhausted the possible
+			 * changes per transaction. Or raced with someone
+			 * "locking" it against changes.
+			 * Remember where to continue from.
+			 */
+			if (enr > first)
+				i->partially_in_al_next_enr = enr;
+			return -ENOBUFS;
+		}
 	}
 	return 0;
 }
@@ -556,7 +545,11 @@ void drbd_al_complete_io(struct drbd_device *device, struct drbd_interval *i)
 
 	for (enr = first; enr <= last; enr++) {
 		extent = lc_find(device->act_log, enr);
-		if (!extent) {
+		/* Yes, this masks a bug elsewhere.  However, during normal
+		 * operation this is harmless, so no need to crash the kernel
+		 * by the BUG_ON(refcount == 0) in lc_put().
+		 */
+		if (!extent || extent->refcnt == 0) {
 			drbd_err(device, "al_complete_io() called on inactive extent %u\n", enr);
 			continue;
 		}
diff --git a/drivers/block/drbd/drbd_interval.h b/drivers/block/drbd/drbd_interval.h
index 366489b72fe9..5d3213b81eed 100644
--- a/drivers/block/drbd/drbd_interval.h
+++ b/drivers/block/drbd/drbd_interval.h
@@ -8,12 +8,15 @@
 struct drbd_interval {
 	struct rb_node rb;
 	sector_t sector;		/* start sector of the interval */
-	unsigned int size;		/* size in bytes */
 	sector_t end;			/* highest interval end in subtree */
+	unsigned int size;		/* size in bytes */
 	unsigned int local:1		/* local or remote request? */;
 	unsigned int waiting:1;		/* someone is waiting for completion */
 	unsigned int completed:1;	/* this has been completed already;
 					 * ignore for conflict detection */
+
+	/* to resume a partially successful drbd_al_begin_io_nonblock(); */
+	unsigned int partially_in_al_next_enr;
 };
 
 static inline void drbd_clear_interval(struct drbd_interval *i)

base-commit: 72f4d6fca699a1e35b39c5e5dacac2926d254135
-- 
2.52.0


