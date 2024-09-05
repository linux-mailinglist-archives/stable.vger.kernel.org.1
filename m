Return-Path: <stable+bounces-73135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC5B96D047
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA50D282367
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 07:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708281925BE;
	Thu,  5 Sep 2024 07:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LrfNhqfL"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406DB1925BD
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 07:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725520760; cv=none; b=VMcHexAkKrZynuVHTRUPoefFZXFPYeFH/nTNsatbsThgzzaaeZVavjrLugAOFVYB3vdvF9knOJyhilaJpAwtouUqcGe+Y2v4CkAmBE36VpG7dlzwdBkyMvHYfbf5i63v36CwdqUBaWUmOxmrXMWTQWtfANeH/o3LQCzPCAZ0NIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725520760; c=relaxed/simple;
	bh=R6KAC8kDSWsTZ+6oJ/IJ2UnK9rRkAEQMnoBYuWb3Kkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L1g1C5LTs1xd5PwhP7ZqUCC+GqSgt4sSspDvLzv+S692PL9ElBz83VeAxzRqVjucY+Gq9xuqzBvekBJahxuzMybkhVCIDfDrqNAsg9ldCcmLlSHCARCWimaUI8QbWZrxKhUcTDkPynzOlot3gYDW8s1nu7sVenEd39Z1e+gZftM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LrfNhqfL; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725520756;
	bh=R6KAC8kDSWsTZ+6oJ/IJ2UnK9rRkAEQMnoBYuWb3Kkc=;
	h=From:To:Cc:Subject:Date:From;
	b=LrfNhqfLCcqKRzR/n1YuFfrtXMSuNihOiRoQx4Pe5ZFXuXZitQziMKHQNpANQM5LV
	 7Oew6UKHCKDrv796KuT9wuTdUl+c6TrhcpjnoG0EQYz91BsBbuAZUy3ZWMYxYlprp9
	 npS+nX5XeaC+qfsgFeXV71hFcuM9ShyHojmnAo7anaHefRVFWiM1kGmmA3d6XuofcB
	 XamMGFgVPj5ufBI3YM52/0WUbmy7XZdhV+46pRTQ+/LhbvmjAIXQgX/NGVVTLiJFp1
	 BmPDQiIOOrCY4k9nIacFvTLk1TLgbYammKsbeCyAgwT3pgYTD7kef4tXegzaVexJlr
	 9oZyrbLWGgqXg==
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E979917E0F8F;
	Thu,  5 Sep 2024 09:19:15 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org,
	kernel@collabora.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/panthor: Don't declare a queue blocked if deferred operations are pending
Date: Thu,  5 Sep 2024 09:19:14 +0200
Message-ID: <20240905071914.3278599-1-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If deferred operations are pending, we want to wait for those to
land before declaring the queue blocked on a SYNC_WAIT. We need
this to deal with the case where the sync object is signalled through
a deferred SYNC_{ADD,SET} from the same queue. If we don't do that
and the group gets scheduled out before the deferred SYNC_{SET,ADD}
is executed, we'll end up with a timeout, because no external
SYNC_{SET,ADD} will make the scheduler reconsider the group for
execution.

Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
Cc: <stable@vger.kernel.org>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 41260cf4beb8..201d5e7a921e 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -1103,7 +1103,13 @@ cs_slot_sync_queue_state_locked(struct panthor_device *ptdev, u32 csg_id, u32 cs
 			list_move_tail(&group->wait_node,
 				       &group->ptdev->scheduler->groups.waiting);
 		}
-		group->blocked_queues |= BIT(cs_id);
+
+		/* The queue is only blocked if there's no deferred operation
+		 * pending, which can be checked through the scoreboard status.
+		 */
+		if (!cs_iface->output->status_scoreboards)
+			group->blocked_queues |= BIT(cs_id);
+
 		queue->syncwait.gpu_va = cs_iface->output->status_wait_sync_ptr;
 		queue->syncwait.ref = cs_iface->output->status_wait_sync_value;
 		status_wait_cond = cs_iface->output->status_wait & CS_STATUS_WAIT_SYNC_COND_MASK;
-- 
2.46.0


