Return-Path: <stable+bounces-206444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B860D08983
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 11:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED36D3049E1C
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 10:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7173396E6;
	Fri,  9 Jan 2026 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YonAn+K/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28F73385AA
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767954849; cv=none; b=ABWTCKtREv+XQsspEDHA9jl8y6jSaqk/YP/kIpkmJREIRYVkqHEorKc8b+Y3SZcjJbOWggw1dw8XVfGnVxmRe80OkJHE1VOo9YKjZmfRgPugRtICEcjiw0nnYxbMSviz1F0VJcjsHo4QA2mSs2IhsNwcA6Te93u9KsID7LXiA+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767954849; c=relaxed/simple;
	bh=qyAIaazdwIw49PPuAk/0GEIkpgkeLChWeD2e081LVRc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ee5KfOAOWi3G8iL61pYUOYk6rAkeHEJb2gpYd1lzsmhKi4Fw6GoHpHbbg06AhokUohFOe+k/GW2BVLPEp1wLlqaMCpa7mEbUX0v5Y020/RPzwDyRt/rOvh49RJbqc/yR3Ovv/AdeTkUZ2NjdYgMXF0C3orFaaCZLlj80AaNpnjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YonAn+K/; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2a110548cdeso31171145ad.0
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 02:34:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767954847; x=1768559647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCeTL5DyL4OpVceWW2dtJZK2fvnfNct2KD6UucHZ0lo=;
        b=OALWetSJKVVYRR0JoY5z3/U9KSiuJLrl1sBUC4G3lEfGIz2AGRKsNr2AmuHKL9nEPE
         kjdBdtcX+pl0A64QRLq9yUERfwTbEaPi9VYXskYHXY1qFYD50aZBTHzv5cVt/opC317v
         wpi0PCRwuylM3eGSrIoJBzeW0P71Q+e+x0C/7vI52m8ZB95bDf6NKxC5UovPDT40wbT2
         2UkHQR4l7xmYE2y+sl6XboRHI9WhBD69j+Ca/pTnt+oxGr27ik8DhPAEbCNaWrKJz9Xq
         SIVq4FcmR47vGyOLHfWffSiHHiVIzxdUQLl++hRUbs+jUxmbYqTaDw3P8DotpYjg3G0y
         +yeA==
X-Gm-Message-State: AOJu0YwnnYvIZV4C2t/1Rk25VMQ3xeHswJHVS/qFeLHH3W8/H46H4G7u
	JulmfelPseyJtyr8GUqrF3wmYM6ykoxa+VLMHh5tr1mrkdwmReWnNc53CBue4Txi+t2jtIRXzLO
	vRf7OVGtigsYmvsULBn2q6aG+blewovG1RPXNMk6vaDUZKCYh44/v4ERU1QrAcgsS6RofTunDRs
	YkHiI0KSC2uYfZx6sqQ5bsNS3gwZRkGbPMXjdQe4Yb78tssozQuoC7EjsEjbzIUME8fcrn+Kc0W
	RdPheBYeAf+tn1vgQ==
X-Gm-Gg: AY/fxX40eX0wnzjVJunTsHedUnwzaH6sL4VevIjmKyB+ZvBT+VKa1i/QltpI2zF/E/7
	/HMg5Ikh7I+Cs1Jz8F4SXI81an4Uz5+Uwd2MpU/vFCdvqyXkCAa7AGK2JCqk9ELXghDgttx6dWn
	50RIoTo/bSwIy3KEIPDujY1U7MC5iczMThaZMlV6PVTtcWQ13ZODVx5sJ+LmfPUKvo9gpuRUiYI
	n941Bss42K4B6GTDoO0ckU2vu/VUz5XxPiWbSUl83Nzl4QCw75GzB3PnSVRHN/HGsu74ADbS74Q
	tQZ6Eb6jotCL6CQi3HoiVG1l30vkk1Q0/OgkCoupjiCHx9wEnGDhoZHebISV8yJGV4QD5X1ZUSK
	fFQMKL6eoL/IYg6Ri2r4t27ZKKiKPx76AtPK0yjQf6htrUdNCyQvOM3e3GIX9WXR+kP2F5S0XZm
	gtJw1pZ65akqnxR51esiMhT2JHFF2mmY4cBoVB0oqkXEUWQYvR0lU=
X-Google-Smtp-Source: AGHT+IHwDAx0XKKuF66Bv3Ox3JOQQkX4Rynb9H/PklOZiM3ND4LJMjes6ElEaEQNTFCvEBDeVPNcjd/hty1T
X-Received: by 2002:a17:903:1984:b0:29e:9387:f2b0 with SMTP id d9443c01a7336-2a3ee4c0109mr82979555ad.39.1767954847058;
        Fri, 09 Jan 2026 02:34:07 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3cc4f38sm11249825ad.53.2026.01.09.02.34.06
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jan 2026 02:34:07 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b259f0da04so1025985385a.0
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 02:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767954845; x=1768559645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kCeTL5DyL4OpVceWW2dtJZK2fvnfNct2KD6UucHZ0lo=;
        b=YonAn+K/hNeju/vfUTGrTh4VewE3Le5mRf0/z+xVZYuUcI2+VHhAH4xuI8bGn+rVSx
         N6zrdIQV/JSoWHX+gq7/EZOSqgzccg3IjtjC6XvULRNQc8/stHqj0ZGHyBPuzTdPB6jH
         UL/fKQ6SQE2i96pdu/35JNpo98Ebux2mzjh/o=
X-Received: by 2002:a05:620a:7088:b0:8c3:87eb:f with SMTP id af79cd13be357-8c3893ef6d0mr1155259185a.53.1767954845343;
        Fri, 09 Jan 2026 02:34:05 -0800 (PST)
X-Received: by 2002:a05:620a:7088:b0:8c3:87eb:f with SMTP id af79cd13be357-8c3893ef6d0mr1155254585a.53.1767954844715;
        Fri, 09 Jan 2026 02:34:04 -0800 (PST)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770cc73dsm73691156d6.7.2026.01.09.02.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 02:34:04 -0800 (PST)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	sthumma@codeaurora.org,
	JBottomley@Parallels.com,
	santoshsy@gmail.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Sanjeev Yadav <sanjeev.y@mediatek.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Peter Wang <peter.wang@mediatek.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10] scsi: core: ufs: Fix a hang in the error handler
Date: Fri,  9 Jan 2026 02:13:02 -0800
Message-Id: <20260109101302.676694-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Sanjeev Yadav <sanjeev.y@mediatek.com>

[ Upstream commit 8a3514d348de87a9d5e2ac00fbac4faae0b97996 ]

ufshcd_err_handling_prepare() calls ufshcd_rpm_get_sync(). The latter
function can only succeed if UFSHCD_EH_IN_PROGRESS is not set because
resuming involves submitting a SCSI command and ufshcd_queuecommand()
returns SCSI_MLQUEUE_HOST_BUSY if UFSHCD_EH_IN_PROGRESS is set. Fix this
hang by setting UFSHCD_EH_IN_PROGRESS after ufshcd_rpm_get_sync() has
been called instead of before.

Backtrace:
__switch_to+0x174/0x338
__schedule+0x600/0x9e4
schedule+0x7c/0xe8
schedule_timeout+0xa4/0x1c8
io_schedule_timeout+0x48/0x70
wait_for_common_io+0xa8/0x160 //waiting on START_STOP
wait_for_completion_io_timeout+0x10/0x20
blk_execute_rq+0xe4/0x1e4
scsi_execute_cmd+0x108/0x244
ufshcd_set_dev_pwr_mode+0xe8/0x250
__ufshcd_wl_resume+0x94/0x354
ufshcd_wl_runtime_resume+0x3c/0x174
scsi_runtime_resume+0x64/0xa4
rpm_resume+0x15c/0xa1c
__pm_runtime_resume+0x4c/0x90 // Runtime resume ongoing
ufshcd_err_handler+0x1a0/0xd08
process_one_work+0x174/0x808
worker_thread+0x15c/0x490
kthread+0xf4/0x1ec
ret_from_fork+0x10/0x20

Signed-off-by: Sanjeev Yadav <sanjeev.y@mediatek.com>
[ bvanassche: rewrote patch description ]
Fixes: 62694735ca95 ("[SCSI] ufs: Add runtime PM support for UFS host controller driver")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20250523201409.1676055-1-bvanassche@acm.org
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Shivani: Modified to apply on 5.10.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/scsi/ufs/ufshcd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 54e7d96bf..c1f232472 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -5766,10 +5766,12 @@ static void ufshcd_err_handler(struct work_struct *work)
 		spin_unlock_irqrestore(hba->host->host_lock, flags);
 		return;
 	}
-	ufshcd_set_eh_in_progress(hba);
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
+
 	ufshcd_err_handling_prepare(hba);
+
 	spin_lock_irqsave(hba->host->host_lock, flags);
+	ufshcd_set_eh_in_progress(hba);
 	ufshcd_scsi_block_requests(hba);
 	/*
 	 * A full reset and restore might have happened after preparation
-- 
2.40.4


