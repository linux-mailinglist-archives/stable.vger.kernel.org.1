Return-Path: <stable+bounces-247744-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPF0MxcUB2ourgIAu9opvQ
	(envelope-from <stable+bounces-247744-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:39:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC1E54FBBC
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63A2431E883A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CAB47ECC3;
	Fri, 15 May 2026 12:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qjH8aBH8"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B429038F254
	for <stable@vger.kernel.org>; Fri, 15 May 2026 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847478; cv=none; b=gV6amtSDEQjNGl5jYkMq2iP9feI6tshCa1kBryeSFInOL2qAlaMWBrKa8kKuaMwlsKjPa/G+sP8oXTgEMBLVD3OSuuV1A0SS4X2w2sGzxMmGRAc1Vl6hoQSa3RJ32abDhXwUqnW3p3gL7SqeJz6H6n6GV/wCVftodURmfE9NYfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847478; c=relaxed/simple;
	bh=F3u/QH/ZhYfqyIB9F98+uK1QXh9jLK2lRsp6iEp0P04=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lpi8x+knEuDNNm6Pti9l3q19n8UWM0cupoCznLuD9IqmdZPdrUIpa2Ns3RXNqNOUg8YAyPaDDgRpGsT4aezkP5TJ2FAzybNXImQuOv3ec3wU57eobQhY++qt09LKmqWB9tqnqTPaNbuCejlFzXw4ShUrRyqVmwYsvvkteUMWTUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rnj.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qjH8aBH8; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rnj.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-38e936cabf2so76996011fa.1
        for <stable@vger.kernel.org>; Fri, 15 May 2026 05:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778847474; x=1779452274; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=//Plx+YvoT4buEKO1lurHogNmkZC/8PnjF1rYPj5af0=;
        b=qjH8aBH8IpMtyZbyCmIRjkKwmyCVSXRjcynlFGqAXrDDD+jbyXjh0TqH3C+UnhaSRM
         FM6O90drlmgClqhce7a82EELHY1WThBk6JYqjAYKEEH3dB0hK/YYfU2ctoi7nV7hMBL6
         MTNnv8obxHrknGJ3TKZt5/TdjNyfZh+tOrceDQcEpG5eQpHsImTTlvu15IpVfGtDFCIl
         eMhKWCHUqdWyNfZiFdeXCtScaD31dFNEJWubJxeTi8VoKFUxqbdh0uPirx6pry5+Tkec
         Qfau5NX3sWNb8XG4PRuc+KtMv1KJhXqHXHku4IXg54rywllhFhxYWuKP/JXXbZ7v2gd4
         VTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778847474; x=1779452274;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=//Plx+YvoT4buEKO1lurHogNmkZC/8PnjF1rYPj5af0=;
        b=E/1nV0QdNeawfZ1nCX/GA+a57BvO0LYboXMmjir+Jr9IPdCjOnuCfPO/zXRRkLic+i
         eXvrUoyBNHNKhLm38bEF7fOgfWiBxgorumgPIsuG6Bv90c5DYBR4OjCymUF9bDBK0Sd6
         eOOZuCPzEke1JAbddHvMydlOXpPI78UC64xV2ZiwScL/UI4jIoCDWOswbD6aX1QjAmXQ
         zABPPn40GGcyh9TKp6JInDAKzIbIhyGvKFRQbPFNJaOtMLG7S+iFfOUPMCTEfbII9bJL
         0Z7TQ7YnRpIAeDAHo2qfKidptSdRfdYse+YAvA2YfLgcTe/R7L6Rf3D9+VlsrSMeLBnB
         HSHg==
X-Forwarded-Encrypted: i=1; AFNElJ+RyVddQ/4GXul3nBWGGmSMF7WWe58EGllkD32ToKoYCI/ZVTIyH/KdXpWAn+uR+w8AzmRiUTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVPzVOKSnB86/E5Bb8CrDaQYQk0KgHwMexXq+ZAIbyVhqf1nZ5
	/inEivvIl4bPOToKiIJZUcOm/RSOmRz07Mq4nkA8HFfFdwFhzteeghjoNglDbGFqJuYotw==
X-Received: from ljmk24.prod.google.com ([2002:a2e:a278:0:b0:393:7fb2:6b5a])
 (user=rnj job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6512:1241:b0:5aa:b6a:7a8c
 with SMTP id 2adb3069b0e04-5aa0e7755fbmr993792e87.43.1778847473713; Fri, 15
 May 2026 05:17:53 -0700 (PDT)
Date: Fri, 15 May 2026 12:15:40 +0000
In-Reply-To: <20260515-fortify_pm80-v1-0-2863187f6d4b@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515-fortify_pm80-v1-0-2863187f6d4b@google.com>
X-Developer-Key: i=rnj@google.com; a=ed25519; pk=QwUkB1OONd7dk9zV4pLRQRehoWHHsLcRZD2QcswqHTc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778847470; l=7156;
 i=rnj@google.com; s=20260515; h=from:subject:message-id; bh=F3u/QH/ZhYfqyIB9F98+uK1QXh9jLK2lRsp6iEp0P04=;
 b=6fmA6McFYcRaDItPhb+fZmQtDIdYKJC3l0wEIBdMC3GU+PulntNIaqMzfJBNuLEiE+BUiOyaF LgexaHhaWuMBtF2+HgskDlz/4jUbUk6vMJzW/BTl8XBm7Mf4vn1oGfQ
X-Mailer: b4 0.14.3
Message-ID: <20260515-fortify_pm80-v1-2-2863187f6d4b@google.com>
Subject: [PATCH 2/2] scsi: pm8001: Match hw_event_resp to HBA data layout
From: Ronja Meyer <rnj@google.com>
To: Jack Wang <jinpu.wang@cloud.ionos.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Tom Peng <tom_peng@usish.com>, 
	Kevin Ao <aoqingyun@usish.com>, Lindar Liu <lindar_liu@usish.com>, 
	James Bottomley <James.Bottomley@suse.de>
Cc: jack wang <jack_wang@usish.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ronja Meyer <rnj@google.com>, stable@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 4BC1E54FBBC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247744-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rnj@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Correct the hw_event_resp struct definition to match the layout of data
sent by the HBA. Remove pointer arithmetics previously required to work
around incorrect struct definition.

Looking at the struct definition before this patch:
  struct hw_event_resp {
           [...]
           struct	sas_identify_frame sas_identify;
           struct dev_to_host_fis	sata_fis;
   } __attribute__((packed, aligned(4)));

Previously the memcpy() in hw_event_sata_phy_up() crossed reading
from the sas_identify struct over into the sata_fis struct. This was
necessary, because the hw_event_resp struct definition didn't align
properly with what the HBA actually sent. The member sas_identify right
before the member sata_fis was 4 bytes too long, causing the first
4 bytes of the sata_fis to be shifted into the last 4 bytes of
sas_identify. The code worked around this by subtracting 4 bytes from
both the sata_fis pointer, as well as sizeof(sas_identify), when they
were used.

FORTIFY_SOURCE detected this deliberate choice to cross struct member
boundaries as an out-of-bounds read, even though in this case it didn't
lead to a vulnerability. Hence the following fortify-panic was
triggered:

  kernel BUG at lib/string_helpers.c:1044!
  RIP: 0010:__fortify_panic+0x9/0x10
  hw_event_sata_phy_up+0xea/0x120 [pm80xx]
  process_one_iomb+0x634e/0x6360 [pm80xx]
  process_oq+0x391/0x430 [pm80xx]
  pm80xx_chip_isr+0x78/0x100 [pm80xx]
  tasklet_action_common+0x16a/0x2b0
  handle_softirqs+0xcd/0x2a0
  __irq_exit_rcu+0x50/0x100
  common_interrupt+0x89/0xa0

Furthermore hw_event_resp was 64 bytes before this patch, which is
4 bytes too long. Messages exchanged between the pm8001 and the host
kernel can be a maximum of 64 bytes, as defined in iomb_size. The
message structs defined in pm8001_hwi.h must have a size of 60 bytes,
in order to leave space for a 4 byte header that implicitly precedes
each message.

Luckily the code interacting with hw_event_resp doesn't ever seem to
read or write the last 4 bytes of the struct and doesn't seem to use
the incorrect size of the struct in a copy operation. Hence it doesn't
overflow in practice. Further the pm80xx driver was unaffected by this
bug. While the pm80xx struct was also 64 bytes, the message size on
pm80xx is 128 bytes. Hence it is able to fit the 68 byte header and
message without overflowing.

This is not security critical AFAICT.

Cc: stable@vger.kernel.org
Fixes: dbf9bfe61571 ("[SCSI] pm8001: add SAS/SATA HBA driver")
Co-developed-by: Igor Pylypiv <ipylypiv@google.com>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
Signed-off-by: Ronja Meyer <rnj@google.com>
---
 drivers/scsi/pm8001/pm8001_hwi.c | 6 +++---
 drivers/scsi/pm8001/pm8001_hwi.h | 2 +-
 drivers/scsi/pm8001/pm80xx_hwi.c | 6 +++---
 drivers/scsi/pm8001/pm80xx_hwi.h | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index fff8d877abb9..e90f2d98d8ed 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -3164,8 +3164,8 @@ hw_event_sas_phy_up(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	sas_notify_phy_event(&phy->sas_phy, PHYE_OOB_DONE, GFP_ATOMIC);
 	spin_lock_irqsave(&phy->sas_phy.frame_rcvd_lock, flags);
 	memcpy(phy->frame_rcvd, &pPayload->sas_identify,
-		sizeof(struct sas_identify_frame)-4);
-	phy->frame_rcvd_size = sizeof(struct sas_identify_frame) - 4;
+		sizeof(struct sas_identify_frame_local));
+	phy->frame_rcvd_size = sizeof(struct sas_identify_frame_local);
 	pm8001_get_attached_sas_addr(phy, phy->sas_phy.attached_sas_addr);
 	spin_unlock_irqrestore(&phy->sas_phy.frame_rcvd_lock, flags);
 	if (pm8001_ha->flags == PM8001F_RUN_TIME)
@@ -3208,7 +3208,7 @@ hw_event_sata_phy_up(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	phy->sas_phy.oob_mode = SATA_OOB_MODE;
 	sas_notify_phy_event(&phy->sas_phy, PHYE_OOB_DONE, GFP_ATOMIC);
 	spin_lock_irqsave(&phy->sas_phy.frame_rcvd_lock, flags);
-	memcpy(phy->frame_rcvd, ((u8 *)&pPayload->sata_fis - 4),
+	memcpy(phy->frame_rcvd, &pPayload->sata_fis,
 		sizeof(struct dev_to_host_fis));
 	phy->frame_rcvd_size = sizeof(struct dev_to_host_fis);
 	phy->identify.target_port_protocols = SAS_PROTOCOL_SATA;
diff --git a/drivers/scsi/pm8001/pm8001_hwi.h b/drivers/scsi/pm8001/pm8001_hwi.h
index 14b162f93eb8..2b5483989886 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.h
+++ b/drivers/scsi/pm8001/pm8001_hwi.h
@@ -326,7 +326,7 @@ struct hw_event_resp {
 	__le32	lr_evt_status_phyid_portid;
 	__le32	evt_param;
 	__le32	npip_portstate;
-	struct sas_identify_frame	sas_identify;
+	struct	sas_identify_frame_local sas_identify;	/* _local to omit CRC field */
 	struct dev_to_host_fis	sata_fis;
 } __attribute__((packed, aligned(4)));
 
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 954f307352e6..03293e9b84e6 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -3241,8 +3241,8 @@ hw_event_sas_phy_up(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	sas_notify_phy_event(&phy->sas_phy, PHYE_OOB_DONE, GFP_ATOMIC);
 	spin_lock_irqsave(&phy->sas_phy.frame_rcvd_lock, flags);
 	memcpy(phy->frame_rcvd, &pPayload->sas_identify,
-		sizeof(struct sas_identify_frame)-4);
-	phy->frame_rcvd_size = sizeof(struct sas_identify_frame) - 4;
+		sizeof(struct sas_identify_frame_local));
+	phy->frame_rcvd_size = sizeof(struct sas_identify_frame_local);
 	pm8001_get_attached_sas_addr(phy, phy->sas_phy.attached_sas_addr);
 	spin_unlock_irqrestore(&phy->sas_phy.frame_rcvd_lock, flags);
 	if (pm8001_ha->flags == PM8001F_RUN_TIME)
@@ -3289,7 +3289,7 @@ hw_event_sata_phy_up(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	phy->sas_phy.oob_mode = SATA_OOB_MODE;
 	sas_notify_phy_event(&phy->sas_phy, PHYE_OOB_DONE, GFP_ATOMIC);
 	spin_lock_irqsave(&phy->sas_phy.frame_rcvd_lock, flags);
-	memcpy(phy->frame_rcvd, ((u8 *)&pPayload->sata_fis - 4),
+	memcpy(phy->frame_rcvd, &pPayload->sata_fis,
 		sizeof(struct dev_to_host_fis));
 	phy->frame_rcvd_size = sizeof(struct dev_to_host_fis);
 	phy->identify.target_port_protocols = SAS_PROTOCOL_SATA;
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.h b/drivers/scsi/pm8001/pm80xx_hwi.h
index d8a63b7fed6a..5ccc010a2368 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.h
+++ b/drivers/scsi/pm8001/pm80xx_hwi.h
@@ -351,7 +351,7 @@ struct mpi_msg_hdr {
 struct phy_start_req {
 	__le32	tag;
 	__le32	ase_sh_lm_slr_phyid;
-	struct sas_identify_frame_local sas_identify; /* 28 Bytes */
+	struct	sas_identify_frame_local sas_identify;	/* _local to omit CRC field */
 	__le32 spasti;
 	u32	reserved[21];
 } __attribute__((packed, aligned(4)));
@@ -427,7 +427,7 @@ struct hw_event_resp {
 	__le32	lr_status_evt_portid;
 	__le32	evt_param;
 	__le32	phyid_npip_portstate;
-	struct sas_identify_frame	sas_identify;
+	struct	sas_identify_frame_local	sas_identify;	/* _local to omit CRC field */
 	struct dev_to_host_fis	sata_fis;
 } __attribute__((packed, aligned(4)));
 

-- 
2.54.0.563.g4f69b47b94-goog


