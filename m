Return-Path: <stable+bounces-1841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B87FB7F819D
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C792B21BA0
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B801B35F1A;
	Fri, 24 Nov 2023 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jwDE1oUB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F33B3173F;
	Fri, 24 Nov 2023 19:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE9DC433C7;
	Fri, 24 Nov 2023 19:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852404;
	bh=Iu87LDloXmwFNhB/AHL1WwmkJ5grUVoEsa5uXHK9WJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jwDE1oUBSrgy4Og0s5EtJrLTZOPUCYplZ8ctCbY46eKUe8PCebJiCtjr8OZ7Jj/yu
	 XDm8MHfKgeicN4PPQulTfEq66wOOjxMfhvMDgKsF05siMIx3VGpRWCV1gV/4nbvpUG
	 TJ8UV+jMJ9tJKPkLAExJXP3oWQdwktix6wyn6+/k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bryan ODonoghue <bryan.odonoghue@linaro.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 6.1 343/372] media: qcom: camss: Fix VFE-17x vfe_disable_output()
Date: Fri, 24 Nov 2023 17:52:10 +0000
Message-ID: <20231124172021.802460254@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

commit 3143ad282fc08bf995ee73e32a9e40c527bf265d upstream.

There are two problems with the current vfe_disable_output() routine.

Firstly we rightly use a spinlock to protect output->gen2.active_num
everywhere except for in the IDLE timeout path of vfe_disable_output().
Even if that is not racy "in practice" somehow it is by happenstance not
by design.

Secondly we do not get consistent behaviour from this routine. On
sc8280xp 50% of the time I get "VFE idle timeout - resetting". In this
case the subsequent capture will succeed. The other 50% of the time, we
don't hit the idle timeout, never do the VFE reset and subsequent
captures stall indefinitely.

Rewrite the vfe_disable_output() routine to

- Quiesce write masters with vfe_wm_stop()
- Set active_num = 0

remembering to hold the spinlock when we do so followed by

- Reset the VFE

Testing on sc8280xp and sdm845 shows this to be a valid fix.

Fixes: 7319cdf189bb ("media: camss: Add support for VFE hardware version Titan 170")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/qcom/camss/camss-vfe-170.c |   22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

--- a/drivers/media/platform/qcom/camss/camss-vfe-170.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-170.c
@@ -7,7 +7,6 @@
  * Copyright (C) 2020-2021 Linaro Ltd.
  */
 
-#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -494,35 +493,20 @@ static int vfe_enable_output(struct vfe_
 	return 0;
 }
 
-static int vfe_disable_output(struct vfe_line *line)
+static void vfe_disable_output(struct vfe_line *line)
 {
 	struct vfe_device *vfe = to_vfe(line);
 	struct vfe_output *output = &line->output;
 	unsigned long flags;
 	unsigned int i;
-	bool done;
-	int timeout = 0;
-
-	do {
-		spin_lock_irqsave(&vfe->output_lock, flags);
-		done = !output->gen2.active_num;
-		spin_unlock_irqrestore(&vfe->output_lock, flags);
-		usleep_range(10000, 20000);
-
-		if (timeout++ == 100) {
-			dev_err(vfe->camss->dev, "VFE idle timeout - resetting\n");
-			vfe_reset(vfe);
-			output->gen2.active_num = 0;
-			return 0;
-		}
-	} while (!done);
 
 	spin_lock_irqsave(&vfe->output_lock, flags);
 	for (i = 0; i < output->wm_num; i++)
 		vfe_wm_stop(vfe, output->wm_idx[i]);
+	output->gen2.active_num = 0;
 	spin_unlock_irqrestore(&vfe->output_lock, flags);
 
-	return 0;
+	vfe_reset(vfe);
 }
 
 /*



