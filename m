Return-Path: <stable+bounces-220956-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UE0XN3VYo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220956-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:04:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 312F61C8C1E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 900F63117FFD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5D04A340B;
	Sat, 28 Feb 2026 17:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDIab6RW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFDE47CC68;
	Sat, 28 Feb 2026 17:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301302; cv=none; b=Pb51WC5aPVayIqE9rCOUMEvcqcSzQ7UctGlPcEMgPu4flDFw+VHs4HwR2Az8pfQQNKnQ5bd0y3yXp+a3oTx9eqUgSWPAXRyk5SJFzi++vKd/jMv8MtpWX7dAVIWqy4V9ndCSMX482byDAZRbBohyX8RgvsIPzp/GF0rSbZy1tEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301302; c=relaxed/simple;
	bh=pRAkqO8gN4BpI84SWXWE6HO6Q2oIxqqA0dQ28+mYDoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOa5NLS7vRQZnJ4HRy9YVKDCSDWRt27o01+j0uEfURrAUgcVLXUM/bG/J5mUXXAdLHQ4ujrMc6Z8RwmkjwVWzed7ZSCs/Y5AUz9dVWmzNXenxLINA6cZsOyX+uTBCAUxCBmenF3v6xZ3E6W4wn7xJ3zui9PMqk2lIkoTLOJGOl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDIab6RW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CC9C116D0;
	Sat, 28 Feb 2026 17:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301302;
	bh=pRAkqO8gN4BpI84SWXWE6HO6Q2oIxqqA0dQ28+mYDoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KDIab6RWF7/cIS+8IlUPbwgIz0sYS2eA3TV5ndzUbd972PvfuxneP4B03GctdPYDO
	 eETqTn2e1shi0gATwqgpAB1kKaj/ZnsNJ2VZPEYjLvLAlpMABPrKN3sQDpbTAvJ7n/
	 S5TmDncByXcoX+pkxpvK1cI57JEVTrdnAMe87DxebMXM/XuBoo4TGH0UA0seMwLOdT
	 t9RuIhuR7hj6ysfKm9gPbgopUtBGlLCSQ5z8JmJX40F3t/ZzvK3t0Z8PKZSQ2MEqAQ
	 X+iyW4bc0lrM+rNgFAqthNKryNzFUMFOKayKvpIhShl4BLtNksQWZqbgDKV0taJsH9
	 VufxpkxWWBysw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Xulin Sun <xulin.sun@windriver.com>,
	stable@vger.kernel.org,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 487/752] media: chips-media: wave5: Fix device cleanup order to prevent kernel panic
Date: Sat, 28 Feb 2026 12:43:18 -0500
Message-ID: <20260228174750.1542406-487-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-220956-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 312F61C8C1E
X-Rspamd-Action: no action

From: Xulin Sun <xulin.sun@windriver.com>

[ Upstream commit b74cedac643b02aefa7da881b58a3792859d9748 ]

Move video device unregistration to the beginning of the remove function
to ensure all video operations are stopped before cleaning up the worker
thread and disabling PM runtime. This prevents hardware register access
after the device has been powered down.

In polling mode, the hrtimer periodically triggers
wave5_vpu_timer_callback() which queues work to the kthread worker.
The worker executes wave5_vpu_irq_work_fn() which reads hardware
registers via wave5_vdi_read_register().

The original cleanup order disabled PM runtime and powered down hardware
before unregistering video devices. When autosuspend triggers and powers
off the hardware, the video devices are still registered and the worker
thread can still be triggered by the hrtimer, causing it to attempt
reading registers from powered-off hardware. This results in a bus error
(synchronous external abort) and kernel panic.

This causes random kernel panics during encoding operations:

  Internal error: synchronous external abort: 0000000096000010
    [#1] PREEMPT SMP
  Modules linked in: wave5 rpmsg_ctrl rpmsg_char ...
  CPU: 0 UID: 0 PID: 1520 Comm: vpu_irq_thread
    Tainted: G   M    W
  pc : wave5_vdi_read_register+0x10/0x38 [wave5]
  lr : wave5_vpu_irq_work_fn+0x28/0x60 [wave5]
  Call trace:
   wave5_vdi_read_register+0x10/0x38 [wave5]
   kthread_worker_fn+0xd8/0x238
   kthread+0x104/0x120
   ret_from_fork+0x10/0x20
  Code: aa1e03e9 d503201f f9416800 8b214000 (b9400000)
  ---[ end trace 0000000000000000 ]---
  Kernel panic - not syncing: synchronous external abort:
    Fatal exception

Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
Cc: stable@vger.kernel.org
Signed-off-by: Xulin Sun <xulin.sun@windriver.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/chips-media/wave5/wave5-vpu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
index 0bcd48df49d0f..77d6c934d0b9d 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
@@ -351,6 +351,10 @@ static void wave5_vpu_remove(struct platform_device *pdev)
 {
 	struct vpu_device *dev = dev_get_drvdata(&pdev->dev);
 
+	wave5_vpu_enc_unregister_device(dev);
+	wave5_vpu_dec_unregister_device(dev);
+	v4l2_device_unregister(&dev->v4l2_dev);
+
 	if (dev->irq < 0) {
 		hrtimer_cancel(&dev->hrtimer);
 		kthread_cancel_work_sync(&dev->work);
@@ -364,9 +368,6 @@ static void wave5_vpu_remove(struct platform_device *pdev)
 	mutex_destroy(&dev->hw_lock);
 	reset_control_assert(dev->resets);
 	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
-	wave5_vpu_enc_unregister_device(dev);
-	wave5_vpu_dec_unregister_device(dev);
-	v4l2_device_unregister(&dev->v4l2_dev);
 	wave5_vdi_release(&pdev->dev);
 	ida_destroy(&dev->inst_ida);
 }
-- 
2.51.0


