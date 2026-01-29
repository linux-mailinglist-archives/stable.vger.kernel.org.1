Return-Path: <stable+bounces-212746-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMn4EMYPe2nqAwIAu9opvQ
	(envelope-from <stable+bounces-212746-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 08:44:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D16ACE1C
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 08:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E0C62300BE01
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 07:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6931637A48D;
	Thu, 29 Jan 2026 07:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="4SQCfbk6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D40374170
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 07:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769672323; cv=none; b=IKZqipMruBKFa2DisDHeYiFHsOtHD05vpsA09R0o+Ma6T+rWqkNB8VxSgtX93Dpc8jzVS7CLOX4fb9kmZYfOgTz0MadJDEiFEc4woTmnUCDHVN2NhaXIM18EGXbhrTkphP2HTOYppJQajEeIroOoMZqXwVcH85jYZb088hXZkas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769672323; c=relaxed/simple;
	bh=PmaYDRNArfyuojBEcajPNrOJP8kPqJiIHREyZgI5rkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LCffMOvOGPF9QRvum1ICXmHJ6R+8vW3YfbvqY0isuIswv5naakSB03iVuLu0HRgad6gQkNylMvTr+a2g96Ip5JWX7823ZAKUfHxyLc0z2nVoe/imCbafcTpPmUBwr3Ff1QSzPKnCGPbUynzGd2g6ua6WP1LDY/08eokc4PNr+YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=4SQCfbk6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48068127f00so5274265e9.3
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 23:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1769672320; x=1770277120; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TbOIHVaOGbxzrvzjWHvUZsbmdUqai/LursAc/ajXxRQ=;
        b=4SQCfbk6twnMyuQmc1eO+9aU7/NDkhZpMal3+wp4gTBVvObIDyWBgMxjpStQQcYif+
         KBVUKGdceHCEVlpshmhP/ps9CqNy6c2mjyFyAXrOdK5ai4fwlnJAH94plz+yPDyUCZrH
         KX5qfr1SeY2wVKNE7e4lAypubZ1H4V3IwscJtKSIqmAEw3lYETS/cjbTBhsCm5wktX7Z
         NKlAVfV3aKMVD8pjz+gmaO8AoBUpQDUr3ipj/5myFbUManFi2IENXpaDVi5YfYniItFa
         Zsvs7yYRh5kLJiFS7RwXVcUFMeLdnOtbiKOEf/1YYA2UWckm5q/BjQXFNblIWYCGgWdQ
         pJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769672320; x=1770277120;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbOIHVaOGbxzrvzjWHvUZsbmdUqai/LursAc/ajXxRQ=;
        b=pNz8eHyAKPW7yqbRVefCRFAlFz2361FcSmmVqcOi3jF8QmK36r6C50BNC0ghhYm2hn
         VLBGHvm5xY9X+EpV0TjzVr5uk6G2VaKSUDDDo4rL/LYLsi/XcWMueiHOkUpyt1HC2aMb
         GpatOOqk95AlOg3bLfLITtRhkNZYxhBKqAMy2b6HnvEyOQm8YREK6aAYzqJHP51gI1/P
         BapTQ5pnkpwdGtDPUU9KRLyVamdYmy4qVMPYGtQ1+XsUamXnIR+LhRNWFKglBZiRD57m
         z+4Tzs2ZoUWOgdxvVwFR8IhVt/lK0mnmcOrUiuklmoguvf1ZzuB42HhqShS7+BwHaan+
         Uxdg==
X-Forwarded-Encrypted: i=1; AJvYcCXGwb5osizEGswQG1Ax+nf4syryYHNfBZ2TijMbbsMm4zSAO9XZgnCQ/qQZgIsqKTmV91tjhvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKq9kzjK+zA5KxIYuYbW1vCRB6OseLmgaiSPQms1MQvGO25dbC
	lmisAqXwlh4hikcj6pMkVbWO+N+Q0A/CvP7DPf/GBjJ1Phz9oErrZuv0/B0osFGVMdk=
X-Gm-Gg: AZuq6aKYdJJW+mKCfQcu4qdC5mFzge9MX50mDo1Gwbutzh8YKLzA633Q2Io9XpL29t7
	vkpVS3QgO6ot6t1/q6SpZFYXLfySUVZ4EjpwVS3FmzMhjEjjKf5NJZ4FFZlBceyoLrlBzrbDLR2
	VY6ceAx18q+At2HlJp198TvtfGlQjjqOzpaWXfVCT1lrbwI1n84uGYbukyw7BzV2wwsH2jWrU1u
	98db6zHDvKOOArS1aMjZrJovRewUwT6kWwqQk5t833VV1t5i6nLxmFnotXNJ+M47JJRF9hp7F9z
	ShN/TQMuLgqwCkp4hUFKtW6ibUsk1VaLMnUb2eg4T3+9NpGPHLmGvmlYryAeZDWPceAUB7yFF+d
	oER1Z+dbdrat/gjbnmIPQrO50P/ingW1IKfmkj5FuBTJ0+5/rJVl7XjOFe5Oy0iQ05EwtKGVB3p
	98H8wmdpPwF1hGjUvuY5/9PFQihaJ4uRNECakukS7cCuTdFe01r+neW3TmWA6LgFPs0w==
X-Received: by 2002:a05:6000:310f:b0:435:9ea8:8b83 with SMTP id ffacd0b85a97d-435dd074b85mr11666526f8f.19.1769672320024;
        Wed, 28 Jan 2026 23:38:40 -0800 (PST)
Received: from alchark-surface.localdomain (bba-83-110-134-52.alshamil.net.ae. [83.110.134.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10ee040sm12418751f8f.11.2026.01.28.23.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 23:38:39 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 29 Jan 2026 11:38:35 +0400
Subject: [PATCH] scsi: ufs: core: Fix RPMB region size detection for UFS
 2.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-ufs-rpmb-v1-1-691534ab723f@flipper.net>
X-B4-Tracking: v=1; b=H4sIAHoOe2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQyNL3dK0Yt2igtwk3RRDS4tEM0vLRBODFCWg8oKi1LTMCrBR0bG1tQD
 LvFbbWgAAAA==
X-Change-ID: 20260129-ufs-rpmb-d198a699a40d
To: Alim Akhtar <alim.akhtar@samsung.com>, 
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Bean Huo <beanhuo@micron.com>, Can Guo <can.guo@oss.qualcomm.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1922; i=alchark@flipper.net;
 h=from:subject:message-id; bh=PmaYDRNArfyuojBEcajPNrOJP8kPqJiIHREyZgI5rkY=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRW8zUEbZVzCQp6X+lUdITlx1/ZC64pZe5r9jExXvrPH
 /R68aHujoksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0FDHWMeIgYtTAKb62iGG/zGG3Keb73xiXBkaW7L+3tnpFs9SgrYXiU6a1vsgd29n9D6G32wp5of
 F731mSL2auMJjQfyGkrwJO2dWGd2pULxY9aZgHR8A
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[flipper.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212746-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,flipper.net:email,flipper.net:dkim,flipper.net:mid,jedec.org:url]
X-Rspamd-Queue-Id: B1D16ACE1C
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
 drivers/ufs/core/ufshcd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 52ffd0c3aa4c..80be7d0a0315 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5249,6 +5249,15 @@ static void ufshcd_lu_init(struct ufs_hba *hba, struct scsi_device *sdev)
 		hba->dev_info.rpmb_region_size[1] = desc_buf[RPMB_UNIT_DESC_PARAM_REGION1_SIZE];
 		hba->dev_info.rpmb_region_size[2] = desc_buf[RPMB_UNIT_DESC_PARAM_REGION2_SIZE];
 		hba->dev_info.rpmb_region_size[3] = desc_buf[RPMB_UNIT_DESC_PARAM_REGION3_SIZE];
+
+		if (hba->dev_info.wspecversion <= 0x0220) {
+			/* Only one RPMB region used, and no per-region size information */
+			hba->dev_info.rpmb_region_size[0] =
+				get_unaligned_be64(desc_buf
+					+ RPMB_UNIT_DESC_PARAM_LOGICAL_BLK_COUNT)
+				<< desc_buf[RPMB_UNIT_DESC_PARAM_LOGICAL_BLK_SIZE]
+				>> 17; /* convert to 128 kBytes units */
+		}
 	}
 
 

---
base-commit: 3f24e4edcd1b8981c6b448ea2680726dedd87279
change-id: 20260129-ufs-rpmb-d198a699a40d

Best regards,
-- 
Alexey Charkov <alchark@flipper.net>


