Return-Path: <stable+bounces-43878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336998C5003
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 12:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C321C2127A
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 10:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102781E4B0;
	Tue, 14 May 2024 10:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QKIknc66"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C154A2D60A;
	Tue, 14 May 2024 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715682847; cv=none; b=j++e+EYF+mM4fYQG0gHR47HThTNvwWxtJm2rhJ+JgVl4BxKBlNI49k7TpzoxqsjIFaeR/vZjL/kXDno561yfo3+Pn72eZve5nAKXR/T0CBFyEKTUFpU3IYjhajxrNI+lQhYDlVFPN0fGhQsPMSNYCSz9Bt81SNW1JV+Cg+JxTkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715682847; c=relaxed/simple;
	bh=Xoa5dJpMnQNe9OtzCkCaZqqqWOS/CmJFi8/q2+6O0HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KM0b6jyGK4OkUxxjcsth+RcsYSu9TMXworNcbSshKbWd/CjMEipaPHFReVs/Xeh+kbyzTWk8ieB/c9dDI5DOAr7QzoTxTKgvmOLQsrIFoI5dCjNqEsTfepHGeIS3nLyXl8hlGnUV4YbDNMG8kyFIU+GdR0eh1TJEDzP1uAnDmw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QKIknc66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA0FC2BD10;
	Tue, 14 May 2024 10:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715682847;
	bh=Xoa5dJpMnQNe9OtzCkCaZqqqWOS/CmJFi8/q2+6O0HQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QKIknc66Xteq2tWBxet8qfrih2atZ/q4l3ykVY9zrTMqJEHP7JLOH7Yaztxtyazdr
	 y6tYRNKh0AhgItrMFlG30YBlH3eoLBpMcRowQvj9NXBlVMWGlOHceJ3U7QCGIpRPtZ
	 jcml+zHP6iDK3117sW9iF2nHky5k4SoyJS8uQBuw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Wang <peter.wang@mediatek.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 123/336] scsi: ufs: core: WLUN suspend dev/link state error recovery
Date: Tue, 14 May 2024 12:15:27 +0200
Message-ID: <20240514101043.246886746@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Wang <peter.wang@mediatek.com>

[ Upstream commit 6bc5e70b1c792b31b497e48b4668a9a2909aca0d ]

When wl suspend error occurs, for example BKOP or SSU timeout, the host
triggers an error handler and returns -EBUSY to break the wl suspend
process.  However, it is possible for the runtime PM to enter wl suspend
again before the error handler has finished, and return -EINVAL because the
device is in an error state. To address this, ensure that the rumtime PM
waits for the error handler to finish, or trigger the error handler in such
cases, because returning -EINVAL can cause the I/O to hang.

Signed-off-by: Peter Wang <peter.wang@mediatek.com>
Link: https://lore.kernel.org/r/20240329015036.15707-1-peter.wang@mediatek.com
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 3b89c9d4aa404..14a6a100fcdb0 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -9745,7 +9745,10 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 
 	/* UFS device & link must be active before we enter in this function */
 	if (!ufshcd_is_ufs_dev_active(hba) || !ufshcd_is_link_active(hba)) {
-		ret = -EINVAL;
+		/*  Wait err handler finish or trigger err recovery */
+		if (!ufshcd_eh_in_progress(hba))
+			ufshcd_force_error_recovery(hba);
+		ret = -EBUSY;
 		goto enable_scaling;
 	}
 
-- 
2.43.0




