Return-Path: <stable+bounces-215508-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPefIpz6iWkiFQAAu9opvQ
	(envelope-from <stable+bounces-215508-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:17:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFAC111CE3
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7982C30074BE
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 15:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8DB23E23C;
	Mon,  9 Feb 2026 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="zpPkq9x7"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859C83793D2
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770650265; cv=none; b=GizQqQw5dVw0PCPkxaxP4Er13X7IamCQ5H0wIsLaos3Yut905ezovd1ULBR7i5oWnRdcRfMuRTat89nRWFK4MSoK6AUBtkpGus4v9S3lA0Q+sGZeXmKBmcvwv37sYAMgu8R24YLvIWyn1oBQ6wMKRgojjkwuLDFmVaUGzADfPkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770650265; c=relaxed/simple;
	bh=QwqwIAqr7xCkCr48dcuh5oHcGIGiBHbnt8H8Y164264=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iezO1m9ZhnK0mEvfEgu9D9b62q3Zsq2WDr1Rasf+CCRnQDg28RN6GBq+gXcReG4JCcm03Uu1X6p6b7eohEWyGIom9KU1yXp+Yblo4qUeALscJCwebiyzpigVzmJqeMuuImBy/Erig8pleovirUqtg/elbRq6rkjpv/cwzNDNsPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=zpPkq9x7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48327b8350dso25733395e9.1
        for <stable@vger.kernel.org>; Mon, 09 Feb 2026 07:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1770650264; x=1771255064; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FpIn1Ne0BBcoXFXd70KYLdqOHiEwYJ4NHcQ5bZXN32I=;
        b=zpPkq9x7yZhLChr2zjYKtdvhRXKHSEw/7tZHLGrn1xPhMTUJzbV5M2Y4PG8YFgOR/t
         NdkqsG3wt9KpLhzndAqCf1N2F5bv1gK9qBtrp22ZoAvAJAQxDgqBq799eMwLxvDXOrpZ
         d54R9b2OkWxAVGFfWdwAdu4c3L+uOZ7RfMHuAeHnFzvTGKCw/JaHx1oe0EKa6UxcilzF
         OoAbv8iw3XJyRuqWESaYNv9KTvYAvvHnTA++J8BwC6Q9ijZ33RhkFUbc9qCH8f68cfmN
         3Mq0rKsqYqNLniZK//8KtKRfcuqR9YXUkk/D/3bZ9pVdDkr4hdFrx1CF1ThwPxTKS5CT
         jBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770650264; x=1771255064;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpIn1Ne0BBcoXFXd70KYLdqOHiEwYJ4NHcQ5bZXN32I=;
        b=hSD5X6axupqYu2CTMBTGtcG6bXCVgDfYE707TV0+u2GN++05koAXImnR1bRltfsKcb
         Dj69AbeYW2Arvctkd4TPfhjFirkElulGcKVjtenjaxie4O5J/HCKr1BjloHba7gPdO9o
         X7p/6qOnXG+ge7uFNrqQCi2Qxb6Q/ftQf9z7vcuDeyBCeUoK9ac1B19EKKnR8gxJiSWm
         zzZlEsmjtnCDnfDaPs3Ziv1nv+W9KKZEaBI9WW4uvYqyuK21InDTziahMFQLkUNtWlgB
         Dzx15Y0QoghHTldm/sTZwzVIHlzn3sIklYJTGaqbhI58hrbsc8eps74j4euuvoWMPuOD
         Il1w==
X-Forwarded-Encrypted: i=1; AJvYcCURvoF6F4eSvhuQ1vTLRUvPMuz3aLDDpfRMuF0DtYa+GlXqKR+tZMRTgKe0LzB6xcTXtxUNGQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxANp9tn50GZJLsm6PNBKSl13Imc/ovfSQKu+Rq7CM7Rcx5BEVq
	ICkUeXGVqe6ZS4lcg7slemYId8YH4gWhzEe6OKUvwb496pwQ6lonLoHUmkWqtPNhbRo=
X-Gm-Gg: AZuq6aKD8/BEidef6Jm+2+lCHb6mqm+8EiEe5aWUqWAkHWKdIJ6XTtjCQ6j9UmxMWdP
	TdkD1yTS/tVkRX93NhRl3W5iaHYX4ITikBHRUEF9qCAAX9XxUQlYG+Z9N+lfgsPGHmblt8vEukP
	Qv64lNJeHv861wuNB5TFFUuTiroBADTR4aCuRZCQnJMFcxFB2ObglX+glYDNbquxopCiu6FomIl
	ZlL9LskEkQXZDdH7KDC6WPxGZ3KS1BVwPNwwrMQmbr4xlby/Uvtnt4iG4Pcdk3l04zTawB+q4uD
	CH7zaKkkMJw75MwA91clGl4zFEyLnjqHxZu506UBb4RhHb4WXQM6i8t7yaqHEFkiQHY67IQbJ4J
	+llfCXrLpLLmZM3HZ5a/dFLoyoCbtp4PTZYNcy7e8pwDMLbw4XW7jiPJafpnRBL3iJ/MYX1YWph
	nOvjVnEc0NELLiat+ZpPjWHOTrGn7bMrrcS3qchQGn0ULxeqelUycnw4+TVY8f8I4=
X-Received: by 2002:a05:600c:528b:b0:482:f12f:f35e with SMTP id 5b1f17b1804b1-483201e3759mr172093735e9.12.1770650263666;
        Mon, 09 Feb 2026 07:17:43 -0800 (PST)
Received: from alchark-surface.localdomain (bba-94-59-44-101.alshamil.net.ae. [94.59.44.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d8342dsm295925485e9.12.2026.02.09.07.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 07:17:43 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 09 Feb 2026 19:17:34 +0400
Subject: [PATCH v3] scsi: ufs: core: Fix RPMB region size detection for UFS
 2.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-ufs-rpmb-v3-1-b1804e71bd38@flipper.net>
X-B4-Tracking: v=1; b=H4sIAI36iWkC/22MQQ6CMBBFr2JmbU1noGBdeQ/joshUmig0LTYaw
 t0tbDTG5fv5700QOTiOcNhMEDi56IY+Q7HdwKUz/ZWFazMDSaokkhYPG0Xw90a0qPem0tqUsoV
 894Gte66p0zlz5+I4hNdaTrisfyIJBYpKoypK09RU2KO9Oe857HoeYckk+qgk1ZdKWVWMqiZmR
 c2POs/zG+DYVEfdAAAA
X-Change-ID: 20260129-ufs-rpmb-d198a699a40d
To: Alim Akhtar <alim.akhtar@samsung.com>, 
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Bean Huo <beanhuo@micron.com>, Can Guo <can.guo@oss.qualcomm.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3002; i=alchark@flipper.net;
 h=from:subject:message-id; bh=QwqwIAqr7xCkCr48dcuh5oHcGIGiBHbnt8H8Y164264=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWR2/pr6/pfwnP3+wm5zDx44fmeiVMLTUyynZ3/WOcrgd
 OjdPMXzTzsmsjCIcTFYiimyzP22xHaqEd+sXR4eX2HmsDKBDJEWaWAAAhYGvtzEvFIjHSM9U21D
 PUNDHWMdIwYuTgGY6mlMjAybTvnZSNbYJ1ku7DrZkDnRQED1kc0GK5WJu/kzL7g6n/zAyHAjKez
 kZlmji8tNoi0CvxxWS5y2T5FP+vRXsdOVYiVVp9gB
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[flipper.net:+];
	TAGGED_FROM(0.00)[bounces-215508-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,micron.com:email,jedec.org:url,flipper.net:mid,flipper.net:dkim,flipper.net:email]
X-Rspamd-Queue-Id: 1BFAC111CE3
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
Reviewed-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Changes in v3:
- Fix comment style, add note about respective fields being always zero (thanks Bart)
- Link to v2: https://lore.kernel.org/r/20260205-ufs-rpmb-v2-1-5e1572ee52bf@flipper.net

Changes in v2:
- Comment on the expected size of the RPMB partition on UFS 2.2 (thanks Bean)
- Use a standard define for size instead of a magic number (thanks Bean)
- Link to v1: https://lore.kernel.org/r/20260129-ufs-rpmb-v1-1-691534ab723f@flipper.net
---
 drivers/ufs/core/ufshcd.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 847b55789bb8..0d7b31620ea4 100644
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
@@ -5249,6 +5250,25 @@ static void ufshcd_lu_init(struct ufs_hba *hba, struct scsi_device *sdev)
 		hba->dev_info.rpmb_region_size[1] = desc_buf[RPMB_UNIT_DESC_PARAM_REGION1_SIZE];
 		hba->dev_info.rpmb_region_size[2] = desc_buf[RPMB_UNIT_DESC_PARAM_REGION2_SIZE];
 		hba->dev_info.rpmb_region_size[3] = desc_buf[RPMB_UNIT_DESC_PARAM_REGION3_SIZE];
+
+		if (hba->dev_info.wspecversion <= 0x0220) {
+			/*
+			 * These older spec chips have only one RPMB region,
+			 * sized between 128 kB minimum and 16 MB maximum.
+			 * No per region size fields are provided (respective
+			 * REGIONX_SIZE fields always contain zeros), so get
+			 * it from the logical block count and size fields for
+			 * compatibility
+			 *
+			 * (See JESD220C-2_2 Section 14.1.4.6
+			 * RPMB Unit Descriptor,* offset 13h, 4 bytes)
+			 */
+			hba->dev_info.rpmb_region_size[0] =
+				(get_unaligned_be64(desc_buf
+					+ RPMB_UNIT_DESC_PARAM_LOGICAL_BLK_COUNT)
+				<< desc_buf[RPMB_UNIT_DESC_PARAM_LOGICAL_BLK_SIZE])
+				/ SZ_128K;
+		}
 	}
 
 

---
base-commit: 9845cf73f7db6094c0d8419d6adb848028f4a921
change-id: 20260129-ufs-rpmb-d198a699a40d

Best regards,
-- 
Alexey Charkov <alchark@flipper.net>


