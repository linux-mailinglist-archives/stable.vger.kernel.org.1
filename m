Return-Path: <stable+bounces-254373-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJBQAQyyFWpxYAcAu9opvQ
	(envelope-from <stable+bounces-254373-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 16:45:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC595D7DAF
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 16:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF87A30813A3
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 14:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1DD400E15;
	Tue, 26 May 2026 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UNlHhNZz"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25090400DF5
	for <stable@vger.kernel.org>; Tue, 26 May 2026 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805791; cv=none; b=r/SIkaRnME5OWiG/Wft/LaXSdsLtZtDPygMknr6pcb7dyl7znKvyefi9J5nlhzYz9fkuAHn8FtWObnrg7+kmMFHSVbhq/KI+GW60E+ASCWZic/cgkRM26tIDiaOO66n+5sGYcp8Tm4BKtq+wGld3zPBozB9oKktAnppjF/FOajA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805791; c=relaxed/simple;
	bh=2DSBhxHo6ohfJ1agRy9QlK58xQlyhvZcVHLLoZrDDSA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i/Z7fgLgHNwwxThue/rG+uAYeeyRWEi3C3AovKTFQxM4P3QqD7xACO8VuadhkkK36OzXsdL5UIgKNarQFFOrMuzyxsIoe5sWXB2BoKY91Mxi7hAMFZoQSRxElU/kN+IurRNpFThdsMKsFUmcGBG7dbGBxv85dCixiYJR2wINt5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rnj.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UNlHhNZz; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rnj.bounces.google.com
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-5aa24835bfcso4938971e87.1
        for <stable@vger.kernel.org>; Tue, 26 May 2026 07:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779805788; x=1780410588; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T4UbM0pmtE8rclzkFOKgkg1jhZu8iQJeEXlQMwnCTfg=;
        b=UNlHhNZzBBa10yuCt0vtf+E2Z1M2KUXZnXGV9948d0Mvy6yxPklHi8/ZswzbNKJxug
         nH7y6kYASt+A2XAkjjCKWdgROqL89tnoEGqoy4ZYa/6avSb/xdHNC96dQaxd78qMdd9L
         5lxfRCHqN+rtxknPpXUFhfwgKNRfyDkf2zhdZOPZpQHFGVuU+xg41KEK5cIni0igi+y7
         kQ9U2It7z7kjYqoxVaeW9No6TsTVHTN+AN5x6skQ3FedC2Gf3kWOxAVd0B46yLfSrGo/
         8uQHBEshlqOOJZ6dWcpRX4TJFkDERgykuLrfyWhwq2qQvDVTf8gLrKNbvHl1ztzWgxGB
         X2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779805788; x=1780410588;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T4UbM0pmtE8rclzkFOKgkg1jhZu8iQJeEXlQMwnCTfg=;
        b=id2Hq6IiGCyQryU9GQQ0C1EN3vpZ08SxbZPnONcXSEsfRqleRTJGu7fEOjkL+Lset8
         JkO6a2rIp+hH5+0zk+5g8usxrDtJe9LcU3r30RJzEyc34IFf9Za51t5u2FeV4TB4FEvg
         F+dVMSooqLfEsvWLSoc46J0LAoIkXovJdDFr7PwqyGz0uf7o5HTCVzGNzdztdggkI1+W
         hMpY7nV9mnGjx+S6amG5NwDBmasbyG9EvfcNm0sFNBVzDYoLztXphZVaN2dnlr2NqV6J
         n5+OsE5T+nS86jiimLwAjKaB7SRT7XjLlxphYBgGdl+sCsbaKJplkb8h11BJ/veFEDsH
         RQBw==
X-Forwarded-Encrypted: i=1; AFNElJ++VNTs3V09PjVWP1NRqrys7/OnLPV2/LnShvptU89AR+KzB0sR8nZDLbxCO0oZfRBqmYGjPA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB25NZE+6BqlXD9hYNybCgR1G8H+wBvp6Bi3WYgUbnseJcN/7T
	qLmFIa+Qvo7OfXnHfhDFcx7bMzbJkf33H++jQ3bbKazKvJgPMpD6uoj6uOPWacY32WYI1A==
X-Received: from ljxb4.prod.google.com ([2002:a05:651c:a084:b0:394:4549:7323])
 (user=rnj job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6512:3408:b0:5a8:74ac:cf7e
 with SMTP id 2adb3069b0e04-5aa32373293mr6233942e87.24.1779805787628; Tue, 26
 May 2026 07:29:47 -0700 (PDT)
Date: Tue, 26 May 2026 14:29:43 +0000
In-Reply-To: <20260526-fortify_pm80-v2-0-359b743eb97a@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526-fortify_pm80-v2-0-359b743eb97a@google.com>
X-Developer-Key: i=rnj@google.com; a=ed25519; pk=QwUkB1OONd7dk9zV4pLRQRehoWHHsLcRZD2QcswqHTc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779805783; l=6025;
 i=rnj@google.com; s=20260515; h=from:subject:message-id; bh=2DSBhxHo6ohfJ1agRy9QlK58xQlyhvZcVHLLoZrDDSA=;
 b=+ZHcfB7RAQSUDax4PveJEUhJ1V0FJhzw7Zh6xd4eb16O4bW8krB3GpHqXsskdwZoq3V1ik+4i 9FPpMC3GSBFCEiizrxOlbEyREmhozxQg0sXAD43pHOBjfPETgC/n7KX
X-Mailer: b4 0.14.3
Message-ID: <20260526-fortify_pm80-v2-1-359b743eb97a@google.com>
Subject: [PATCH v2 1/2] scsi: libsas: Define sas_identify_frame_local via struct_group
From: Ronja Meyer <rnj@google.com>
To: Jack Wang <jinpu.wang@cloud.ionos.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Tom Peng <tom_peng@usish.com>, 
	Kevin Ao <aoqingyun@usish.com>, Lindar Liu <lindar_liu@usish.com>, 
	James Bottomley <James.Bottomley@suse.de>
Cc: jack wang <jack_wang@usish.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ronja Meyer <rnj@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254373-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rnj@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.992];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0DC595D7DAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The pm80 drivers both need a variant of the sas_identify_frame struct
without the CRC struct member. The pm80xx driver previously duplicated
the struct, omitting this field, to sas_identify_frame_local in:
commit 5990fd57ebea ("scsi: pm80xx: redefine sas_identify_frame structure")

The pm8001 driver also needs the _local variant. Instead of duplicating
the struct again, let's define it as a struct group inside the main
sas_identify_frame struct and remove the duplicate in the pm80xx driver.

Sending to stable, as this change is required for the fortify-panic fix
later in this chain to apply cleanly.

Cc: stable@vger.kernel.org
Fixes: dbf9bfe61571 ("[SCSI] pm8001: add SAS/SATA HBA driver")
Signed-off-by: Ronja Meyer <rnj@google.com>
---
 drivers/scsi/pm8001/pm80xx_hwi.h |  96 --------------------------
 include/scsi/sas.h               | 144 ++++++++++++++++++++-------------------
 2 files changed, 74 insertions(+), 166 deletions(-)

diff --git a/drivers/scsi/pm8001/pm80xx_hwi.h b/drivers/scsi/pm8001/pm80xx_hwi.h
index d8a63b7fed6a..2fa54b901a2e 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.h
+++ b/drivers/scsi/pm8001/pm80xx_hwi.h
@@ -236,102 +236,6 @@
 /* Port recovery timeout, 10000 ms for PM8006 controller */
 #define CHIP_8006_PORT_RECOVERY_TIMEOUT 0x640000
 
-#ifdef __LITTLE_ENDIAN_BITFIELD
-struct sas_identify_frame_local {
-	/* Byte 0 */
-	u8  frame_type:4;
-	u8  dev_type:3;
-	u8  _un0:1;
-
-	/* Byte 1 */
-	u8  _un1;
-
-	/* Byte 2 */
-	union {
-		struct {
-			u8  _un20:1;
-			u8  smp_iport:1;
-			u8  stp_iport:1;
-			u8  ssp_iport:1;
-			u8  _un247:4;
-		};
-		u8 initiator_bits;
-	};
-
-	/* Byte 3 */
-	union {
-		struct {
-			u8  _un30:1;
-			u8 smp_tport:1;
-			u8 stp_tport:1;
-			u8 ssp_tport:1;
-			u8 _un347:4;
-		};
-		u8 target_bits;
-	};
-
-	/* Byte 4 - 11 */
-	u8 _un4_11[8];
-
-	/* Byte 12 - 19 */
-	u8 sas_addr[SAS_ADDR_SIZE];
-
-	/* Byte 20 */
-	u8 phy_id;
-
-	u8 _un21_27[7];
-
-} __packed;
-
-#elif defined(__BIG_ENDIAN_BITFIELD)
-struct sas_identify_frame_local {
-	/* Byte 0 */
-	u8  _un0:1;
-	u8  dev_type:3;
-	u8  frame_type:4;
-
-	/* Byte 1 */
-	u8  _un1;
-
-	/* Byte 2 */
-	union {
-		struct {
-			u8  _un247:4;
-			u8  ssp_iport:1;
-			u8  stp_iport:1;
-			u8  smp_iport:1;
-			u8  _un20:1;
-		};
-		u8 initiator_bits;
-	};
-
-	/* Byte 3 */
-	union {
-		struct {
-			u8 _un347:4;
-			u8 ssp_tport:1;
-			u8 stp_tport:1;
-			u8 smp_tport:1;
-			u8 _un30:1;
-		};
-		u8 target_bits;
-	};
-
-	/* Byte 4 - 11 */
-	u8 _un4_11[8];
-
-	/* Byte 12 - 19 */
-	u8 sas_addr[SAS_ADDR_SIZE];
-
-	/* Byte 20 */
-	u8 phy_id;
-
-	u8 _un21_27[7];
-} __packed;
-#else
-#error "Bitfield order not defined!"
-#endif
-
 struct mpi_msg_hdr {
 	__le32	header;	/* Bits [11:0] - Message operation code */
 	/* Bits [15:12] - Message Category */
diff --git a/include/scsi/sas.h b/include/scsi/sas.h
index 71b749bed3b0..90f3081a3270 100644
--- a/include/scsi/sas.h
+++ b/include/scsi/sas.h
@@ -252,48 +252,50 @@ struct host_to_dev_fis {
  */
 #ifdef __LITTLE_ENDIAN_BITFIELD
 struct sas_identify_frame {
-	/* Byte 0 */
-	u8  frame_type:4;
-	u8  dev_type:3;
-	u8  _un0:1;
-
-	/* Byte 1 */
-	u8  _un1;
-
-	/* Byte 2 */
-	union {
-		struct {
-			u8  _un20:1;
-			u8  smp_iport:1;
-			u8  stp_iport:1;
-			u8  ssp_iport:1;
-			u8  _un247:4;
+	__struct_group(sas_identify_frame_local, payload, __packed,
+		/* Byte 0 */
+		u8  frame_type:4;
+		u8  dev_type:3;
+		u8  _un0:1;
+
+		/* Byte 1 */
+		u8  _un1;
+
+		/* Byte 2 */
+		union {
+			struct {
+				u8  _un20:1;
+				u8  smp_iport:1;
+				u8  stp_iport:1;
+				u8  ssp_iport:1;
+				u8  _un247:4;
+			};
+			u8 initiator_bits;
 		};
-		u8 initiator_bits;
-	};
 
-	/* Byte 3 */
-	union {
-		struct {
-			u8  _un30:1;
-			u8 smp_tport:1;
-			u8 stp_tport:1;
-			u8 ssp_tport:1;
-			u8 _un347:4;
+		/* Byte 3 */
+		union {
+			struct {
+				u8  _un30:1;
+				u8 smp_tport:1;
+				u8 stp_tport:1;
+				u8 ssp_tport:1;
+				u8 _un347:4;
+			};
+			u8 target_bits;
 		};
-		u8 target_bits;
-	};
 
-	/* Byte 4 - 11 */
-	u8 _un4_11[8];
+		/* Byte 4 - 11 */
+		u8 _un4_11[8];
 
-	/* Byte 12 - 19 */
-	u8 sas_addr[SAS_ADDR_SIZE];
+		/* Byte 12 - 19 */
+		u8 sas_addr[SAS_ADDR_SIZE];
 
-	/* Byte 20 */
-	u8 phy_id;
+		/* Byte 20 */
+		u8 phy_id;
 
-	u8 _un21_27[7];
+		u8 _un21_27[7];
+	);
 
 	__be32 crc;
 } __attribute__ ((packed));
@@ -473,48 +475,50 @@ struct report_phy_sata_resp {
 
 #elif defined(__BIG_ENDIAN_BITFIELD)
 struct sas_identify_frame {
-	/* Byte 0 */
-	u8  _un0:1;
-	u8  dev_type:3;
-	u8  frame_type:4;
-
-	/* Byte 1 */
-	u8  _un1;
-
-	/* Byte 2 */
-	union {
-		struct {
-			u8  _un247:4;
-			u8  ssp_iport:1;
-			u8  stp_iport:1;
-			u8  smp_iport:1;
-			u8  _un20:1;
+	__struct_group(sas_identify_frame_local, payload, __packed,
+		/* Byte 0 */
+		u8  _un0:1;
+		u8  dev_type:3;
+		u8  frame_type:4;
+
+		/* Byte 1 */
+		u8  _un1;
+
+		/* Byte 2 */
+		union {
+			struct {
+				u8  _un247:4;
+				u8  ssp_iport:1;
+				u8  stp_iport:1;
+				u8  smp_iport:1;
+				u8  _un20:1;
+			};
+			u8 initiator_bits;
 		};
-		u8 initiator_bits;
-	};
 
-	/* Byte 3 */
-	union {
-		struct {
-			u8 _un347:4;
-			u8 ssp_tport:1;
-			u8 stp_tport:1;
-			u8 smp_tport:1;
-			u8 _un30:1;
+		/* Byte 3 */
+		union {
+			struct {
+				u8 _un347:4;
+				u8 ssp_tport:1;
+				u8 stp_tport:1;
+				u8 smp_tport:1;
+				u8 _un30:1;
+			};
+			u8 target_bits;
 		};
-		u8 target_bits;
-	};
 
-	/* Byte 4 - 11 */
-	u8 _un4_11[8];
+		/* Byte 4 - 11 */
+		u8 _un4_11[8];
 
-	/* Byte 12 - 19 */
-	u8 sas_addr[SAS_ADDR_SIZE];
+		/* Byte 12 - 19 */
+		u8 sas_addr[SAS_ADDR_SIZE];
 
-	/* Byte 20 */
-	u8 phy_id;
+		/* Byte 20 */
+		u8 phy_id;
 
-	u8 _un21_27[7];
+		u8 _un21_27[7];
+	);
 
 	__be32 crc;
 } __attribute__ ((packed));

-- 
2.54.0.746.g67dd491aae-goog


