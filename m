Return-Path: <stable+bounces-214423-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N0yGUBVhGkx2gMAu9opvQ
	(envelope-from <stable+bounces-214423-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 09:30:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE38EFE7F
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 09:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3505A3005323
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 08:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1D8363C4D;
	Thu,  5 Feb 2026 08:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="odK4S9yX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854D4346FC3
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 08:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770280248; cv=none; b=ITwhDEtnQAN5f2SLddkvSs4GIBJVlBktOq3h91B+p0qkfHz1YJc7xlSzgSFuAfvUOt9FzFljLKgx3axIRO96aYZwQuAZ3l4iRpu5p1ULycT8UTg8RK4U1CRmy/MoZO1QqJN+HGFLm/DWbPfIgxo02fEiJ087bzMt+nDUehgj1jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770280248; c=relaxed/simple;
	bh=8TkSK1/eLLlEVbEUY1UAY3c1MAi4HPwAonjpncHyMTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=V7Ro+tfvcUZRemsNdgmPJ5DRJDiAt9Ktr2rTrYdUtWD1NyUPLsE6QI3PFNvUW8qW7rQNfUSMWqFnC7cOejoyzGDKVNjXAvK5I096x3s79Ckkq6mhb5fX8QKqLCY3fJQyGuoXSMKHBbI7l7rDoTTumbXwCCz9VHuqIEFZ0f7WyP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=odK4S9yX; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48068127f00so5852295e9.3
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 00:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1770280247; x=1770885047; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sLD8F90NSsK4m8gb1uKCwFT9oVIxctOBS6noDdmTvjE=;
        b=odK4S9yXCtu6j0iZkKLkQynTMAgNTwHIsH+pYiLgW+sD2EpRliwr2Bl3HnYFmKrjt3
         mUpZLOqWTjPiogH0bqc581esAs2pdZzI03+Cko/rYVMff1BvT0nbev3rqMZ96VBnFrZR
         lMVQ9Ctze97Jb5a+xQSHX2YxbivvtCr0+U98grTSBw4KFrESKPTiTP4KS+eMGB19mSUc
         rf2dVSda0kyhY9VMUd5Q7m2o0nsyvTeFO4835GrEpFnk/C17EIBsbuQPnJS56vu9rERD
         tay1AiU+rXki4EH9/L9oczNIR1i3OIIn99uk7xh2Gdi8ziIry+4okpJ6UD/JbLwp0qCZ
         l4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770280247; x=1770885047;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLD8F90NSsK4m8gb1uKCwFT9oVIxctOBS6noDdmTvjE=;
        b=U4uAZCXJiS0sqVwRqN141/ZqjNJZORNScFZtYVohWrlIWNTPVxFQdsbKtUazl0pD9h
         YEPqK0vtIacF9G9rdKuIJ4Qj1k00tTozKUcTukoxxuKDY6QpFhENsflyBnYtkZblJvsB
         N5XbLDmJL3+89XIWei9lFpQPHeDNMlAkNeR0UbDLuVQRpQ1Ykxm3HYwexiT0kzXd5cI1
         NIe+QiyMtu32m6Y4eya7RPqW7jn3UTzwqa8gpeHol4nLUEJy2xGms/XeVyUuUaRzVYoi
         nSPVt+0MgSuheH8UB13tBlFDksM0RGtcTeJ5MNIk1qitkZHHz67qxwlZ+BAOkbTG+tUj
         /Nvw==
X-Forwarded-Encrypted: i=1; AJvYcCVhm+Uw+oyYSnGI2lKKKRtCt8lXjOcUegFNItI6PkbPAeODQySWwIhpUVMoTKoMkEdh409RAvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdL17CMV/oWdrDVjoKXDi0naQzNwKnmJmhANcM93b//UNh0IzB
	Pnhip6phcD/Fpes72ssldXKk3jzzfURLUVTf6UIftD71Ggf2m8frS4bRedNoo0LnhEs=
X-Gm-Gg: AZuq6aKXNhdczu6ka80T2wZFTJe2JbNKr9gJBEQN4ngrkfHSaSXPbsLfSTUBsIU94Wf
	wJJtOhLSG5IcCYvywvoAGDDiMKv08v7P3Hvn9mZ4VUyRIvEPBWnUn1OvrCI+pITu1pjRKBc3DKN
	zaJJM8wEEmVCoPHRsy2fbCZG2SOb4ywmw/p9pKb90QzKsS3H0COWmfkhjLIgPF/x7c7uKM+XiKU
	tIAXwxXiGpUxIAWwzUdfnTcBK7GRusLrYhEuGJYrYUH6f3CHZopPOAWIf16UuFopzPJ6yOpdMdu
	QAyiqHZPg5VFlSlNMuAWNZh5rT3PQPPrB51xIUd/YD3RtGMjUnr4d0/U3yY/57jF6nQPJUN/xKt
	GxtDvvz0R277xgK6ad/Gw+t9OSnc+dqctQlZ0XxqU8desho0eDdrSswVs2tlKUmbLeW3x+3KkEY
	1XgrnF/BL/C+9rMIjtu+t5u45RqlHNW6QysgFbQOVKPHZJg0HCT5XQZ7lq8RCRyXs=
X-Received: by 2002:a05:600c:6383:b0:477:54cd:200e with SMTP id 5b1f17b1804b1-4830e92293dmr71737305e9.1.1770280246826;
        Thu, 05 Feb 2026 00:30:46 -0800 (PST)
Received: from alchark-surface.localdomain (bba-94-59-44-101.alshamil.net.ae. [94.59.44.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d35684sm41516915e9.7.2026.02.05.00.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 00:30:46 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 05 Feb 2026 12:30:23 +0400
Subject: [PATCH v2] scsi: ufs: core: Fix RPMB region size detection for UFS
 2.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-ufs-rpmb-v2-1-5e1572ee52bf@flipper.net>
X-B4-Tracking: v=1; b=H4sIAB5VhGkC/23MQQ7CIBCF4as0sxYDtKK48h6mCyqDnURbMlSia
 bi72LXL/+XlWyEhEyY4NyswZko0TzX0roHb6KY7CvK1QUttpNJWvEISHJ+D8MqenLHWddJDvUf
 GQO+Nuva1R0rLzJ9Nzuq3/kGyEkoYqw5t54ajbsMlPChG5P2EC/SllC9W8524ogAAAA==
X-Change-ID: 20260129-ufs-rpmb-d198a699a40d
To: Alim Akhtar <alim.akhtar@samsung.com>, 
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Bean Huo <beanhuo@micron.com>, Can Guo <can.guo@oss.qualcomm.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2586; i=alchark@flipper.net;
 h=from:subject:message-id; bh=8TkSK1/eLLlEVbEUY1UAY3c1MAi4HPwAonjpncHyMTA=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWS2hJp8PTdJ+ducVMnvS8uYVBdJ7DFwv3BfyrSFXf6aR
 nzFTDPPjoksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0FDHWMeIgYtTAKb64COGv9K/l35jkl/4OejOy5sbXf77heVpn9l2mn2HqNG7b17RpQaMDL/69xw
 6yyQxI078adSENTG2E7MzgtKPd+Tqma3LyWg15QUA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214423-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DKIM_TRACE(0.00)[flipper.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8DE38EFE7F
X-Rspamd-Action: no action

Older UFS spec devices (2.2 and earlier) do not expose per-region RPMB
sizes, as only one RPMB region is supported. In such cases, the size of
the single RPMB region can be deduced from the Logical Block Count and
Logical Block Size fields in the RPMB Unit Descriptor.

Add a fallback mechanism to calculate the RPMB region size from these
fields if the device implements an older spec, so that the RPMB driver
can work with such devices - otherwise it silently skips the whole RPMB.

        Section 14.1.4.6 (RPMB Unit Descriptor)

Link: https://www.jedec.org/system/files/docs/JESD220C-2_2.pdf
Cc: stable@vger.kernel.org
Fixes: b06b8c421485 ("scsi: ufs: core: Add OP-TEE based RPMB driver for UFS devices")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Changes in v2:
- Comment on the expected size of the RPMB partition on UFS 2.2 (thanks Bean)
- Use a standard define for size instead of a magic number (thanks Bean)
- Link to v1: https://lore.kernel.org/r/20260129-ufs-rpmb-v1-1-691534ab723f@flipper.net
---
 drivers/ufs/core/ufshcd.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 52ffd0c3aa4c..32da8ecdba72 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -24,6 +24,7 @@
 #include <linux/pm_opp.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sched/clock.h>
+#include <linux/sizes.h>
 #include <linux/iopoll.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_dbg.h>
@@ -5249,6 +5250,20 @@ static void ufshcd_lu_init(struct ufs_hba *hba, struct scsi_device *sdev)
 		hba->dev_info.rpmb_region_size[1] = desc_buf[RPMB_UNIT_DESC_PARAM_REGION1_SIZE];
 		hba->dev_info.rpmb_region_size[2] = desc_buf[RPMB_UNIT_DESC_PARAM_REGION2_SIZE];
 		hba->dev_info.rpmb_region_size[3] = desc_buf[RPMB_UNIT_DESC_PARAM_REGION3_SIZE];
+
+		if (hba->dev_info.wspecversion <= 0x0220) {
+			/* These older spec chips have only one RPMB region,
+			 * sized between 128 kB minimum and 16 MB maximum.
+			 * No per region size fields are provided, so get it
+			 * from the logical block count and size fields for
+			 * compatibility
+			 */
+			hba->dev_info.rpmb_region_size[0] =
+				(get_unaligned_be64(desc_buf
+					+ RPMB_UNIT_DESC_PARAM_LOGICAL_BLK_COUNT)
+				<< desc_buf[RPMB_UNIT_DESC_PARAM_LOGICAL_BLK_SIZE])
+				/ SZ_128K;
+		}
 	}
 
 

---
base-commit: 5c009020744fe129e4728e71c44a6c7816c9105e
change-id: 20260129-ufs-rpmb-d198a699a40d

Best regards,
-- 
Alexey Charkov <alchark@flipper.net>


