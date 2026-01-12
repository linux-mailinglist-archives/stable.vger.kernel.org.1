Return-Path: <stable+bounces-208034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE231D108B4
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 05:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 006A4300E8F8
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 04:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B030F30C350;
	Mon, 12 Jan 2026 04:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFrgrbOt"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460EE29B8C7
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 04:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768191151; cv=none; b=PCJ023hfg25NiG9P7xThM/R5CQzaefHHj441755ncAknTxL6q6jW6eP9db7rdHfENwd3yrwDDfx/NornOsZ0JXNfmvq5KSkAYzYs4QBk3IhNsV00N8/Vn1+mIo8UgdELFrPsrfVlJginwN/v6cGsRgDdOWDzFnkYDGBCdbIi2Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768191151; c=relaxed/simple;
	bh=Oq1Pr4T4b+WXt+rB5MqKn1xMsYMXgarQjPV4CrTX5jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJCFMeYPwp9kRwb2IOz3qbMmCty/rsMFJxvLG7XkSCJVT0VohDoiGDnH/mgR8cDd83pWBfeq/70+XICs5bqEOEDW0c6xGTbIC9Rb95KbsoUF3WmX+DjVFoaqFGFvEhw1zqPvFJ7PSs11eDzn2hfbXU48mXdRYGc5LFM3/Z7q1HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AFrgrbOt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768191149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ki5LAdbCUswaW7FiwU90Fk/bvZ3aM5gwOm8hIXma9jE=;
	b=AFrgrbOtyWCWSlibgjeny8hB5HF5N96xHqJCfNgwEqw94foZ5fJV57BHunbwyalBInLJRV
	euyoe29H9itspU0cVI+mz/IOicafD+9uPh4XaAa611bQxoWtf/vhSCT79F2laa1TWCsvQf
	BJAiyAflUiMiH+y+Nidn6pwl7OHUS9A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-nIP0-2dJN-OPhm4of-NWIA-1; Sun,
 11 Jan 2026 23:12:26 -0500
X-MC-Unique: nIP0-2dJN-OPhm4of-NWIA-1
X-Mimecast-MFC-AGG-ID: nIP0-2dJN-OPhm4of-NWIA_1768191145
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 04B8C19560AA;
	Mon, 12 Jan 2026 04:12:25 +0000 (UTC)
Received: from localhost (unknown [10.72.116.42])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EDEFB19560BA;
	Mon, 12 Jan 2026 04:12:23 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Seamus Connor <sconnor@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ublk: cancel device on START_DEV failure
Date: Mon, 12 Jan 2026 12:12:05 +0800
Message-ID: <20260112041209.79445-2-ming.lei@redhat.com>
In-Reply-To: <20260112041209.79445-1-ming.lei@redhat.com>
References: <20260112041209.79445-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

When ublk_ctrl_start_dev() fails after waiting for completion, the
device needs to be properly cancelled to prevent leaving it in an
inconsistent state. Without this, pending I/O commands may remain
uncompleted and the device cannot be cleanly removed.

Add ublk_cancel_dev() call in the error path to ensure proper cleanup
when START_DEV fails.

Cc: <stable@vger.kernel.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index f6e5a0766721..2d6250d61a7b 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2953,8 +2953,10 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 	if (wait_for_completion_interruptible(&ub->completion) != 0)
 		return -EINTR;
 
-	if (ub->ublksrv_tgid != ublksrv_pid)
-		return -EINVAL;
+	if (ub->ublksrv_tgid != ublksrv_pid) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	mutex_lock(&ub->mutex);
 	if (ub->dev_info.state == UBLK_S_DEV_LIVE ||
@@ -3017,6 +3019,9 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 		put_disk(disk);
 out_unlock:
 	mutex_unlock(&ub->mutex);
+out:
+	if (ret)
+		ublk_cancel_dev(ub);
 	return ret;
 }
 
-- 
2.47.0


