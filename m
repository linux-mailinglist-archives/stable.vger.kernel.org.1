Return-Path: <stable+bounces-375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAC97F7AD0
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95FD21F20F0E
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 17:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECF139FF2;
	Fri, 24 Nov 2023 17:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="umMdX3Lf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF1A39FE9;
	Fri, 24 Nov 2023 17:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF34C433C7;
	Fri, 24 Nov 2023 17:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700848735;
	bh=u3LgN/YJ8hgLC/Uk/E+gbv2+d/RhFfzIvRp8djNvFFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=umMdX3LfPx8OfG8z1P0FFe1roI8L1oLfuU3VEOZLy0VelF1xt6OqWy9h0sDpevHo8
	 4/hf8q7kLR1Wpo8QWPdhD0YlBvQAPxI1nWlCCGWO8nCs0maZIDFmmDj+H6klO4DuEa
	 gBdxLEeP4vOc0dmGqlScXPwNCmBjP7TVvc/lh940=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 4.19 60/97] parisc/power: Add power soft-off when running on qemu
Date: Fri, 24 Nov 2023 17:50:33 +0000
Message-ID: <20231124171936.385294100@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171934.122298957@linuxfoundation.org>
References: <20231124171934.122298957@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

commit d0c219472980d15f5cbc5c8aec736848bda3f235 upstream.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org # v6.0+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/parisc/power.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

--- a/drivers/parisc/power.c
+++ b/drivers/parisc/power.c
@@ -192,6 +192,14 @@ static struct notifier_block parisc_pani
 	.priority	= INT_MAX,
 };
 
+/* qemu soft power-off function */
+static int qemu_power_off(struct sys_off_data *data)
+{
+	/* this turns the system off via SeaBIOS */
+	*(int *)data->cb_data = 0;
+	pdc_soft_power_button(1);
+	return NOTIFY_DONE;
+}
 
 static int __init power_init(void)
 {
@@ -221,7 +229,13 @@ static int __init power_init(void)
 				soft_power_reg);
 	}
 
-	power_task = kthread_run(kpowerswd, (void*)soft_power_reg, KTHREAD_NAME);
+	power_task = NULL;
+	if (running_on_qemu && soft_power_reg)
+		register_sys_off_handler(SYS_OFF_MODE_POWER_OFF, SYS_OFF_PRIO_DEFAULT,
+					qemu_power_off, (void *)soft_power_reg);
+	else
+		power_task = kthread_run(kpowerswd, (void*)soft_power_reg,
+					KTHREAD_NAME);
 	if (IS_ERR(power_task)) {
 		printk(KERN_ERR DRIVER_NAME ": thread creation failed.  Driver not loaded.\n");
 		pdc_soft_power_button(0);



