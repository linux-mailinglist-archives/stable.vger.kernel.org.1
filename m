Return-Path: <stable+bounces-22630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7863B85DCF5
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44D21F2236F
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F262C7C6E9;
	Wed, 21 Feb 2024 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v8+WV2zF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBE57BAFB;
	Wed, 21 Feb 2024 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523984; cv=none; b=FJF0Gg3lcwlMQIABMv66Px3S4gaSKelwkjHO5Jul8iRX4+Mg+LaES7AYmeXCkhH05gZTCeUvsQYLKF5uMrfUuAZUqmPqxzSR6+7642N1blDN0ESqGMXDxZkyOamth+wAU18Kh0La1QDeEIj+bVWpOHMOUQ9xt5P94GzsNX6l3HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523984; c=relaxed/simple;
	bh=4ghuNAdt8H+7Bfz2LZttxZxycRRllULt1c6yQ/CljJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3RQPQlnvqyyy8eALWVXz3rH61F5xdOsEv7K9Vw0goNe/nXFbn/+QZTNq8XM01X2cA+zbcYC3qO5G/QtIb8ReLQzrhDgPn2MjtRY4pjLbqfxr4FwqZu23ujq3s+Ft8DuJ7HqjR/xEiBCc7TqxUfT81OPrTY6qIPjjAgV+zlGEfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v8+WV2zF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25428C433F1;
	Wed, 21 Feb 2024 13:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708523984;
	bh=4ghuNAdt8H+7Bfz2LZttxZxycRRllULt1c6yQ/CljJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v8+WV2zFQSZ7lYcaYxQdt6p34Pg1fpo+Q6bb9tSV0nVqPdaxFcRXDmGSrmfIrUKWH
	 1nmonSrH9ME8LP5gkv2+OUVRpY9an5kXfwQVrtVe/ihtB9XH9hxohOpyVRS7YS7467
	 aWEEuOreC9rgc348/OAp8RVwq7Y3ZGRA1dx99jU4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 110/379] debugobjects: Stop accessing objects after releasing hash bucket lock
Date: Wed, 21 Feb 2024 14:04:49 +0100
Message-ID: <20240221125958.174577111@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125954.917878865@linuxfoundation.org>
References: <20240221125954.917878865@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrzej Hajda <andrzej.hajda@intel.com>

[ Upstream commit 9bb6362652f3f4d74a87d572a91ee1b38e673ef6 ]

After release of the hashbucket lock the tracking object can be modified or
freed by a concurrent thread.  Using it in such a case is error prone, even
for printing the object state:

    1. T1 tries to deactivate destroyed object, debugobjects detects it,
       hash bucket lock is released.

    2. T2 preempts T1 and frees the tracking object.

    3. The freed tracking object is allocated and initialized for a
       different to be tracked kernel object.

    4. T1 resumes and reports error for wrong kernel object.

Create a local copy of the tracking object before releasing the hash bucket
lock and use the local copy for reporting and fixups to prevent this.

Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20231025-debugobjects_fix-v3-1-2bc3bf7084c2@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/debugobjects.c | 200 ++++++++++++++++++---------------------------
 1 file changed, 78 insertions(+), 122 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 4dd9283f6fea..b055741a5a4d 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -612,9 +612,8 @@ static void debug_objects_fill_pool(void)
 static void
 __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack)
 {
-	enum debug_obj_state state;
+	struct debug_obj *obj, o;
 	struct debug_bucket *db;
-	struct debug_obj *obj;
 	unsigned long flags;
 
 	debug_objects_fill_pool();
@@ -635,24 +634,18 @@ __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack
 	case ODEBUG_STATE_INIT:
 	case ODEBUG_STATE_INACTIVE:
 		obj->state = ODEBUG_STATE_INIT;
-		break;
-
-	case ODEBUG_STATE_ACTIVE:
-		state = obj->state;
-		raw_spin_unlock_irqrestore(&db->lock, flags);
-		debug_print_object(obj, "init");
-		debug_object_fixup(descr->fixup_init, addr, state);
-		return;
-
-	case ODEBUG_STATE_DESTROYED:
 		raw_spin_unlock_irqrestore(&db->lock, flags);
-		debug_print_object(obj, "init");
 		return;
 	default:
 		break;
 	}
 
+	o = *obj;
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+	debug_print_object(&o, "init");
+
+	if (o.state == ODEBUG_STATE_ACTIVE)
+		debug_object_fixup(descr->fixup_init, addr, o.state);
 }
 
 /**
@@ -693,11 +686,9 @@ EXPORT_SYMBOL_GPL(debug_object_init_on_stack);
 int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
 {
 	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };
-	enum debug_obj_state state;
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
-	int ret;
 
 	if (!debug_objects_enabled)
 		return 0;
@@ -709,49 +700,38 @@ int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
 	raw_spin_lock_irqsave(&db->lock, flags);
 
 	obj = lookup_object_or_alloc(addr, db, descr, false, true);
-	if (likely(!IS_ERR_OR_NULL(obj))) {
-		bool print_object = false;
-
+	if (unlikely(!obj)) {
+		raw_spin_unlock_irqrestore(&db->lock, flags);
+		debug_objects_oom();
+		return 0;
+	} else if (likely(!IS_ERR(obj))) {
 		switch (obj->state) {
-		case ODEBUG_STATE_INIT:
-		case ODEBUG_STATE_INACTIVE:
-			obj->state = ODEBUG_STATE_ACTIVE;
-			ret = 0;
-			break;
-
 		case ODEBUG_STATE_ACTIVE:
-			state = obj->state;
-			raw_spin_unlock_irqrestore(&db->lock, flags);
-			debug_print_object(obj, "activate");
-			ret = debug_object_fixup(descr->fixup_activate, addr, state);
-			return ret ? 0 : -EINVAL;
-
 		case ODEBUG_STATE_DESTROYED:
-			print_object = true;
-			ret = -EINVAL;
+			o = *obj;
 			break;
+		case ODEBUG_STATE_INIT:
+		case ODEBUG_STATE_INACTIVE:
+			obj->state = ODEBUG_STATE_ACTIVE;
+			fallthrough;
 		default:
-			ret = 0;
-			break;
+			raw_spin_unlock_irqrestore(&db->lock, flags);
+			return 0;
 		}
-		raw_spin_unlock_irqrestore(&db->lock, flags);
-		if (print_object)
-			debug_print_object(obj, "activate");
-		return ret;
 	}
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+	debug_print_object(&o, "activate");
 
-	/* If NULL the allocation has hit OOM */
-	if (!obj) {
-		debug_objects_oom();
-		return 0;
+	switch (o.state) {
+	case ODEBUG_STATE_ACTIVE:
+	case ODEBUG_STATE_NOTAVAILABLE:
+		if (debug_object_fixup(descr->fixup_activate, addr, o.state))
+			return 0;
+		fallthrough;
+	default:
+		return -EINVAL;
 	}
-
-	/* Object is neither static nor tracked. It's not initialized */
-	debug_print_object(&o, "activate");
-	ret = debug_object_fixup(descr->fixup_activate, addr, ODEBUG_STATE_NOTAVAILABLE);
-	return ret ? 0 : -EINVAL;
 }
 EXPORT_SYMBOL_GPL(debug_object_activate);
 
@@ -762,10 +742,10 @@ EXPORT_SYMBOL_GPL(debug_object_activate);
  */
 void debug_object_deactivate(void *addr, const struct debug_obj_descr *descr)
 {
+	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
-	bool print_object = false;
 
 	if (!debug_objects_enabled)
 		return;
@@ -777,33 +757,24 @@ void debug_object_deactivate(void *addr, const struct debug_obj_descr *descr)
 	obj = lookup_object(addr, db);
 	if (obj) {
 		switch (obj->state) {
+		case ODEBUG_STATE_DESTROYED:
+			break;
 		case ODEBUG_STATE_INIT:
 		case ODEBUG_STATE_INACTIVE:
 		case ODEBUG_STATE_ACTIVE:
-			if (!obj->astate)
-				obj->state = ODEBUG_STATE_INACTIVE;
-			else
-				print_object = true;
-			break;
-
-		case ODEBUG_STATE_DESTROYED:
-			print_object = true;
-			break;
+			if (obj->astate)
+				break;
+			obj->state = ODEBUG_STATE_INACTIVE;
+			fallthrough;
 		default:
-			break;
+			raw_spin_unlock_irqrestore(&db->lock, flags);
+			return;
 		}
+		o = *obj;
 	}
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
-	if (!obj) {
-		struct debug_obj o = { .object = addr,
-				       .state = ODEBUG_STATE_NOTAVAILABLE,
-				       .descr = descr };
-
-		debug_print_object(&o, "deactivate");
-	} else if (print_object) {
-		debug_print_object(obj, "deactivate");
-	}
+	debug_print_object(&o, "deactivate");
 }
 EXPORT_SYMBOL_GPL(debug_object_deactivate);
 
@@ -814,11 +785,9 @@ EXPORT_SYMBOL_GPL(debug_object_deactivate);
  */
 void debug_object_destroy(void *addr, const struct debug_obj_descr *descr)
 {
-	enum debug_obj_state state;
+	struct debug_obj *obj, o;
 	struct debug_bucket *db;
-	struct debug_obj *obj;
 	unsigned long flags;
-	bool print_object = false;
 
 	if (!debug_objects_enabled)
 		return;
@@ -828,32 +797,31 @@ void debug_object_destroy(void *addr, const struct debug_obj_descr *descr)
 	raw_spin_lock_irqsave(&db->lock, flags);
 
 	obj = lookup_object(addr, db);
-	if (!obj)
-		goto out_unlock;
+	if (!obj) {
+		raw_spin_unlock_irqrestore(&db->lock, flags);
+		return;
+	}
 
 	switch (obj->state) {
+	case ODEBUG_STATE_ACTIVE:
+	case ODEBUG_STATE_DESTROYED:
+		break;
 	case ODEBUG_STATE_NONE:
 	case ODEBUG_STATE_INIT:
 	case ODEBUG_STATE_INACTIVE:
 		obj->state = ODEBUG_STATE_DESTROYED;
-		break;
-	case ODEBUG_STATE_ACTIVE:
-		state = obj->state;
+		fallthrough;
+	default:
 		raw_spin_unlock_irqrestore(&db->lock, flags);
-		debug_print_object(obj, "destroy");
-		debug_object_fixup(descr->fixup_destroy, addr, state);
 		return;
-
-	case ODEBUG_STATE_DESTROYED:
-		print_object = true;
-		break;
-	default:
-		break;
 	}
-out_unlock:
+
+	o = *obj;
 	raw_spin_unlock_irqrestore(&db->lock, flags);
-	if (print_object)
-		debug_print_object(obj, "destroy");
+	debug_print_object(&o, "destroy");
+
+	if (o.state == ODEBUG_STATE_ACTIVE)
+		debug_object_fixup(descr->fixup_destroy, addr, o.state);
 }
 EXPORT_SYMBOL_GPL(debug_object_destroy);
 
@@ -864,9 +832,8 @@ EXPORT_SYMBOL_GPL(debug_object_destroy);
  */
 void debug_object_free(void *addr, const struct debug_obj_descr *descr)
 {
-	enum debug_obj_state state;
+	struct debug_obj *obj, o;
 	struct debug_bucket *db;
-	struct debug_obj *obj;
 	unsigned long flags;
 
 	if (!debug_objects_enabled)
@@ -877,24 +844,26 @@ void debug_object_free(void *addr, const struct debug_obj_descr *descr)
 	raw_spin_lock_irqsave(&db->lock, flags);
 
 	obj = lookup_object(addr, db);
-	if (!obj)
-		goto out_unlock;
+	if (!obj) {
+		raw_spin_unlock_irqrestore(&db->lock, flags);
+		return;
+	}
 
 	switch (obj->state) {
 	case ODEBUG_STATE_ACTIVE:
-		state = obj->state;
-		raw_spin_unlock_irqrestore(&db->lock, flags);
-		debug_print_object(obj, "free");
-		debug_object_fixup(descr->fixup_free, addr, state);
-		return;
+		break;
 	default:
 		hlist_del(&obj->node);
 		raw_spin_unlock_irqrestore(&db->lock, flags);
 		free_object(obj);
 		return;
 	}
-out_unlock:
+
+	o = *obj;
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+	debug_print_object(&o, "free");
+
+	debug_object_fixup(descr->fixup_free, addr, o.state);
 }
 EXPORT_SYMBOL_GPL(debug_object_free);
 
@@ -946,10 +915,10 @@ void
 debug_object_active_state(void *addr, const struct debug_obj_descr *descr,
 			  unsigned int expect, unsigned int next)
 {
+	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
-	bool print_object = false;
 
 	if (!debug_objects_enabled)
 		return;
@@ -962,28 +931,19 @@ debug_object_active_state(void *addr, const struct debug_obj_descr *descr,
 	if (obj) {
 		switch (obj->state) {
 		case ODEBUG_STATE_ACTIVE:
-			if (obj->astate == expect)
-				obj->astate = next;
-			else
-				print_object = true;
-			break;
-
+			if (obj->astate != expect)
+				break;
+			obj->astate = next;
+			raw_spin_unlock_irqrestore(&db->lock, flags);
+			return;
 		default:
-			print_object = true;
 			break;
 		}
+		o = *obj;
 	}
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
-	if (!obj) {
-		struct debug_obj o = { .object = addr,
-				       .state = ODEBUG_STATE_NOTAVAILABLE,
-				       .descr = descr };
-
-		debug_print_object(&o, "active_state");
-	} else if (print_object) {
-		debug_print_object(obj, "active_state");
-	}
+	debug_print_object(&o, "active_state");
 }
 EXPORT_SYMBOL_GPL(debug_object_active_state);
 
@@ -991,12 +951,10 @@ EXPORT_SYMBOL_GPL(debug_object_active_state);
 static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 {
 	unsigned long flags, oaddr, saddr, eaddr, paddr, chunks;
-	const struct debug_obj_descr *descr;
-	enum debug_obj_state state;
+	int cnt, objs_checked = 0;
+	struct debug_obj *obj, o;
 	struct debug_bucket *db;
 	struct hlist_node *tmp;
-	struct debug_obj *obj;
-	int cnt, objs_checked = 0;
 
 	saddr = (unsigned long) address;
 	eaddr = saddr + size;
@@ -1018,12 +976,10 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 
 			switch (obj->state) {
 			case ODEBUG_STATE_ACTIVE:
-				descr = obj->descr;
-				state = obj->state;
+				o = *obj;
 				raw_spin_unlock_irqrestore(&db->lock, flags);
-				debug_print_object(obj, "free");
-				debug_object_fixup(descr->fixup_free,
-						   (void *) oaddr, state);
+				debug_print_object(&o, "free");
+				debug_object_fixup(o.descr->fixup_free, (void *)oaddr, o.state);
 				goto repeat;
 			default:
 				hlist_del(&obj->node);
-- 
2.43.0




