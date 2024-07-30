Return-Path: <stable+bounces-63969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C98A941B7E
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218961F225B4
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04901898F8;
	Tue, 30 Jul 2024 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PyRv7jYT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5672C1A6195;
	Tue, 30 Jul 2024 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358544; cv=none; b=SKUi3zcBfa6IMgSz6zoqIDFvYjWs2tA7B0SiADfaHgDFHXxNK9FJs7jk1E1EfR8YVPBlRJvKpP+LsSL9kb/aTL6C+EJxOEVun1MPDdHYsOrOLKpfvYCPsmwdQk6UtqKYp9eyDTyCZw5BYhJds3Wimx7Rl8cGqN26otOF4RARW+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358544; c=relaxed/simple;
	bh=mAddqH/W5sexrSWnAtR2YNlFv7kXjziZRkM2cQJ4a7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ei6IflfocfFGhVlNxEVVrMA6Bqpet3GhAgY1V/U2tpqvdOvtpqfKtTmttxEPG52uSG6w94Y3DE1VjX4p23lI96VR47TzbuacUQNbiBgoXlKVY+cgWqI0puB5D2Yw2P4qNH/bUM1FFaGzPhP5MJabQacGleZ/c7LPl/4iLkSEImU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PyRv7jYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929E3C32782;
	Tue, 30 Jul 2024 16:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722358544;
	bh=mAddqH/W5sexrSWnAtR2YNlFv7kXjziZRkM2cQJ4a7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PyRv7jYTP+75Z+K4nvVbPixaYhDspJdCB+VAFQOqbP89WbzN3PJepYn5GCVHIPge/
	 wrhwgVlufLpBeAySacxNkZuNpXNxTgxx9GBoM24qlDnKcTnkJZTlAr+2jOf6JlDCLD
	 XLSvZS+k/uBJn++XHK75W2fceVBGVKPLK4DV2Rok=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ilya Dryomov <idryomov@gmail.com>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: [PATCH 6.1 381/440] rbd: rename RBD_LOCK_STATE_RELEASING and releasing_wait
Date: Tue, 30 Jul 2024 17:50:14 +0200
Message-ID: <20240730151630.690135953@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
References: <20240730151615.753688326@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Dryomov <idryomov@gmail.com>

commit f5c466a0fdb2d9f3650d2e3911b0735f17ba00cf upstream.

... to RBD_LOCK_STATE_QUIESCING and quiescing_wait to recognize that
this state and the associated completion are backing rbd_quiesce_lock(),
which isn't specific to releasing the lock.

While exclusive lock does get quiesced before it's released, it also
gets quiesced before an attempt to update the cookie is made and there
the lock is not released as long as ceph_cls_set_cookie() succeeds.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/rbd.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -362,7 +362,7 @@ enum rbd_watch_state {
 enum rbd_lock_state {
 	RBD_LOCK_STATE_UNLOCKED,
 	RBD_LOCK_STATE_LOCKED,
-	RBD_LOCK_STATE_RELEASING,
+	RBD_LOCK_STATE_QUIESCING,
 };
 
 /* WatchNotify::ClientId */
@@ -422,7 +422,7 @@ struct rbd_device {
 	struct list_head	running_list;
 	struct completion	acquire_wait;
 	int			acquire_err;
-	struct completion	releasing_wait;
+	struct completion	quiescing_wait;
 
 	spinlock_t		object_map_lock;
 	u8			*object_map;
@@ -525,7 +525,7 @@ static bool __rbd_is_lock_owner(struct r
 	lockdep_assert_held(&rbd_dev->lock_rwsem);
 
 	return rbd_dev->lock_state == RBD_LOCK_STATE_LOCKED ||
-	       rbd_dev->lock_state == RBD_LOCK_STATE_RELEASING;
+	       rbd_dev->lock_state == RBD_LOCK_STATE_QUIESCING;
 }
 
 static bool rbd_is_lock_owner(struct rbd_device *rbd_dev)
@@ -3459,12 +3459,12 @@ static void rbd_lock_del_request(struct
 	spin_lock(&rbd_dev->lock_lists_lock);
 	if (!list_empty(&img_req->lock_item)) {
 		list_del_init(&img_req->lock_item);
-		need_wakeup = (rbd_dev->lock_state == RBD_LOCK_STATE_RELEASING &&
+		need_wakeup = (rbd_dev->lock_state == RBD_LOCK_STATE_QUIESCING &&
 			       list_empty(&rbd_dev->running_list));
 	}
 	spin_unlock(&rbd_dev->lock_lists_lock);
 	if (need_wakeup)
-		complete(&rbd_dev->releasing_wait);
+		complete(&rbd_dev->quiescing_wait);
 }
 
 static int rbd_img_exclusive_lock(struct rbd_img_request *img_req)
@@ -4182,16 +4182,16 @@ static bool rbd_quiesce_lock(struct rbd_
 	/*
 	 * Ensure that all in-flight IO is flushed.
 	 */
-	rbd_dev->lock_state = RBD_LOCK_STATE_RELEASING;
-	rbd_assert(!completion_done(&rbd_dev->releasing_wait));
+	rbd_dev->lock_state = RBD_LOCK_STATE_QUIESCING;
+	rbd_assert(!completion_done(&rbd_dev->quiescing_wait));
 	if (list_empty(&rbd_dev->running_list))
 		return true;
 
 	up_write(&rbd_dev->lock_rwsem);
-	wait_for_completion(&rbd_dev->releasing_wait);
+	wait_for_completion(&rbd_dev->quiescing_wait);
 
 	down_write(&rbd_dev->lock_rwsem);
-	if (rbd_dev->lock_state != RBD_LOCK_STATE_RELEASING)
+	if (rbd_dev->lock_state != RBD_LOCK_STATE_QUIESCING)
 		return false;
 
 	rbd_assert(list_empty(&rbd_dev->running_list));
@@ -5383,7 +5383,7 @@ static struct rbd_device *__rbd_dev_crea
 	INIT_LIST_HEAD(&rbd_dev->acquiring_list);
 	INIT_LIST_HEAD(&rbd_dev->running_list);
 	init_completion(&rbd_dev->acquire_wait);
-	init_completion(&rbd_dev->releasing_wait);
+	init_completion(&rbd_dev->quiescing_wait);
 
 	spin_lock_init(&rbd_dev->object_map_lock);
 



