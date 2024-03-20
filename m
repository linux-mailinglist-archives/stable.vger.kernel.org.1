Return-Path: <stable+bounces-28511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F20881921
	for <lists+stable@lfdr.de>; Wed, 20 Mar 2024 22:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C191C20EB4
	for <lists+stable@lfdr.de>; Wed, 20 Mar 2024 21:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA62185C76;
	Wed, 20 Mar 2024 21:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="vv1HalPj"
X-Original-To: stable@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744B585C4E;
	Wed, 20 Mar 2024 21:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970310; cv=none; b=GMbkHzXK0XZhhsc/xXZKQuKbqUQhdExbNgvAoFZMew9td0MyjzcPsDGoUCtXUdTSUjCSY3HyAjbE8hQ0yxMb7D8uVrGk4fZGmP3q0ufWbADw1Iht5B269ZDb5BM8dRS1vCT4kpavWtJbjSzsrZVpurjc1G4r8sDdcOwCZXT9ISM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970310; c=relaxed/simple;
	bh=NDSi49coxZRxdskul8Gc8KVSDnjMOncHAEdPKeyZEs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2gYAxg42DQS/5WiI0mHOXKUIV7JydfVucGZ4yRoR05hVhC2BgWqvWIKGTghDLXp5DkFkR5u7lxGlaWhZbgfctYOIWjRbhdzgCEuYfwKoJ8SSBwRM97jqbi1REuqyVp71RAGGfzRuuVXNpMfcka01LGV59f0vX86whnq4GVDemQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=vv1HalPj; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1710970303;
	bh=NDSi49coxZRxdskul8Gc8KVSDnjMOncHAEdPKeyZEs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vv1HalPj4Y/YKdkqgiNbpxXx+p/6b7sWOhuH22X37l/movhbmO7tfh+8eFnIKdLu8
	 WZq5kjxQGpSVzyRTrL8ghqGNpEFgclx5eAxueHh8E6G4BlA0lQQOs1CGe1AVPtvh/B
	 q9B6X84UTKWClp2t0X2+VtUA2eBm+EcuAHvYW3Fo=
To: dgilbert@interlog.com
Cc: linux-scsi@vger.kernel.org,
	bvanassche@acm.org,
	gregkh@linuxfoundation.org,
	Alexander Wetzel <Alexander@wetzel-home.de>,
	stable@vger.kernel.org
Subject: [PATCH v3] scsi: sg: Avoid sg device teardown race
Date: Wed, 20 Mar 2024 22:30:32 +0100
Message-ID: <20240320213032.18221-1-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320110809.12901-1-Alexander@wetzel-home.de>
References: <20240320110809.12901-1-Alexander@wetzel-home.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sg_remove_sfp_usercontext() must not use sg_device_destroy() after
calling scsi_device_put().

sg_device_destroy() is accessing the parent scsi device request_queue.
Which will already be set to NULL when the preceding call to
scsi_device_put() removed the last reference to the parent scsi device.

The resulting NULL pointer exception will then crash the kernel.

Link: https://lore.kernel.org/r/20240305150509.23896-1-Alexander@wetzel-home.de
Fixes: db59133e9279 ("scsi: sg: fix blktrace debugfs entries leakage")
Cc: <stable@vger.kernel.org>
Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
---
Changes compared to V2:
- Fixed the use-after-free pointed out by Bart
- Added the WARN_ON_ONCE() requested by Bart
- added the Fixes tag pointed out by Greg

This patch has now been tested with KASAN enabled. I also  verified,
that db59133e9279 ("scsi: sg: fix blktrace debugfs entries leakage")
introduced the issue.

Thanks for all your help!

Alexander
---
 drivers/scsi/sg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 86210e4dd0d3..ff6894ce5404 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -2207,6 +2207,7 @@ sg_remove_sfp_usercontext(struct work_struct *work)
 {
 	struct sg_fd *sfp = container_of(work, struct sg_fd, ew.work);
 	struct sg_device *sdp = sfp->parentdp;
+	struct scsi_device *device = sdp->device;
 	Sg_request *srp;
 	unsigned long iflags;
 
@@ -2232,8 +2233,9 @@ sg_remove_sfp_usercontext(struct work_struct *work)
 			"sg_remove_sfp: sfp=0x%p\n", sfp));
 	kfree(sfp);
 
-	scsi_device_put(sdp->device);
+	WARN_ON_ONCE(kref_read(&sdp->d_ref) != 1);
 	kref_put(&sdp->d_ref, sg_device_destroy);
+	scsi_device_put(device);
 	module_put(THIS_MODULE);
 }
 
-- 
2.44.0


