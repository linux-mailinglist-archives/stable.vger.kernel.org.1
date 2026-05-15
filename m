Return-Path: <stable+bounces-247743-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HeeGiAUB2rgrQIAu9opvQ
	(envelope-from <stable+bounces-247743-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:40:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 181BD54FBD3
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F166D31340F6
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A3F47ECCE;
	Fri, 15 May 2026 12:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qXAP9eG8"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f201.google.com (mail-lj1-f201.google.com [209.85.208.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2DD47884D
	for <stable@vger.kernel.org>; Fri, 15 May 2026 12:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847476; cv=none; b=Nt8E+m3x4uGyMtH5neMgpaPjgv/+dg4d7pYJ/7GJBzi0mK7g1/W4reLaQNroPXaAcFTRb7c8Utx41soacheZBloCJ8RGmMcL9wafWg8tHVoyjC/XdtFBkQl+YPYcnB0t7eQRx3YqOx5tqDQ0UBi5aZvzw44vP68cM2kq0aKgKiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847476; c=relaxed/simple;
	bh=6Ef2CBZfCR2yn2K+QpFf+BsYWi9Mqgb8LjXQV7Uqz8M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oKYsp1Rc0a7go5N+woTGuoao4BXlbpHOUg39fVYoz580/Ftap5NZHLcHtSRMRFHC+3ez6BE9TO2hP3WNMWfkqNr2xDper85dzfplsvT6mAAEvgY6dfER2Yfiqo5bCjXLIGRY/Rp1diLJmi7awe47oZvdqM+CEInnT9s1RXPjV58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rnj.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qXAP9eG8; arc=none smtp.client-ip=209.85.208.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rnj.bounces.google.com
Received: by mail-lj1-f201.google.com with SMTP id 38308e7fff4ca-3939de90af6so10461051fa.3
        for <stable@vger.kernel.org>; Fri, 15 May 2026 05:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778847473; x=1779452273; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GZKonZOt8iemB50IPvFZn8F0iIu6czcIgS1NcKpIgzs=;
        b=qXAP9eG85iwGixu24AkAA9edumMJ8Gq+wcn4TrElsXrJTn5U8xOT0DjQaTUqx4Jbsa
         nOG2+hBgfH4bbBrfU9QGnmNynkdnT+xm8HkxS5Zg0dX8rVmIFQ56FDH4HMnsKqScpqRi
         Rja88lVQGhffmRXN/FTdzZckWylx59lQHAoMPgvq/dqioel4NYHEq2AomMTRYtNy0kBm
         qqra6Hdtt4LsyGHQhpq6lqDT74gm4/mv7Bvq4nxhHDYKhSMvL0NcWO9XhRFGhHcqpDjz
         +/CoczS32AmgYF480uItIzMzeiRQnskcoCV1QjoCjzLVixTLE24qct2jPumTRmjgfY/g
         BIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778847473; x=1779452273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GZKonZOt8iemB50IPvFZn8F0iIu6czcIgS1NcKpIgzs=;
        b=bDXu+tMdsFDUSipAwD1OssSLnGsPzCGCgm66xZt5FHmEFYxab2unA60gIC81v3rtuc
         BBlVLfqjyhdMvPx77LPcM3Q3t9suuDWk2C4h/1X+DJnTkWi29MFEPEFMqjmT35Ba2p7E
         iTSFVvKHT2Y5dgAEXRLWV5Kc+w5Wc/luiS8z0flERVX19dKVE4g+AxnZvukv0udpiyoL
         XrU/ykM88XBGdC25yqmX7HyEP6v3CoLrmXCx/vit9Y+fwjA5guqigaZ32up0Zrbfgpn6
         gMW61CdeEZ0BezT9VjTceHpATSmJVSCyEnLD6vloptNtmPQH3/GbyKg0ECnDUs6RMDIz
         Zltw==
X-Forwarded-Encrypted: i=1; AFNElJ/q4AE0aI1hkaKnXNOungZ7oGD7hKh81q9xlVYPg6ZV06fB16GVKUCZEi6E+KA+3hlv44G0JGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVpwh0xbmJRMGHkgq51lLqQ5EcE9aF+F8j5Mo7ftDeCTDXI49h
	NeV5W60HG508cEGMgtp0UHHArDL/gsukQB3Ac4nzvenog30mZXDjv26wLGhP/rMFgi0eeA==
X-Received: from ljco1.prod.google.com ([2002:a2e:7301:0:b0:393:bc09:3df])
 (user=rnj job=prod-delivery.src-stubby-dispatcher) by 2002:a2e:8a95:0:b0:38e:9ece:61e9
 with SMTP id 38308e7fff4ca-39561ed8c8emr10219591fa.25.1778847472704; Fri, 15
 May 2026 05:17:52 -0700 (PDT)
Date: Fri, 15 May 2026 12:15:39 +0000
In-Reply-To: <20260515-fortify_pm80-v1-0-2863187f6d4b@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515-fortify_pm80-v1-0-2863187f6d4b@google.com>
X-Developer-Key: i=rnj@google.com; a=ed25519; pk=QwUkB1OONd7dk9zV4pLRQRehoWHHsLcRZD2QcswqHTc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778847470; l=2964;
 i=rnj@google.com; s=20260515; h=from:subject:message-id; bh=6Ef2CBZfCR2yn2K+QpFf+BsYWi9Mqgb8LjXQV7Uqz8M=;
 b=nZUYmaIRoYQC9otHVeIHVnwbPxC6SEJ+UXvgsN6z9gQqKp3QhWLFEBYFUcazK2bsaJnyt934t AGoh7R9lqgPBd5+kv3iJ71kT1TYGUxu6a5s8SicN6XW2O3XJ0vDG/IY
X-Mailer: b4 0.14.3
Message-ID: <20260515-fortify_pm80-v1-1-2863187f6d4b@google.com>
Subject: [PATCH 1/2] scsi: pm8001: Redefine sas_identify_frame structure
From: Ronja Meyer <rnj@google.com>
To: Jack Wang <jinpu.wang@cloud.ionos.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Tom Peng <tom_peng@usish.com>, 
	Kevin Ao <aoqingyun@usish.com>, Lindar Liu <lindar_liu@usish.com>, 
	James Bottomley <James.Bottomley@suse.de>
Cc: jack wang <jack_wang@usish.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ronja Meyer <rnj@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 181BD54FBD3
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
	TAGGED_FROM(0.00)[bounces-247743-lists,stable=lfdr.de];
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
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

The sas_identify structure defined by pm8001 doesn't have a CRC field.
Add a new sas_identify_frame_local structure without the CRC field.
The equivalent change was already made to the pm80xx driver in:
commit 5990fd57ebea ("scsi: pm80xx: redefine sas_identify_frame structure")

Sending to stable, as this change is required for the fortify-panic fix
later in this chain to apply cleanly.

Cc: stable@vger.kernel.org
Fixes: dbf9bfe61571 ("[SCSI] pm8001: add SAS/SATA HBA driver")
Signed-off-by: Ronja Meyer <rnj@google.com>
---
 drivers/scsi/pm8001/pm8001_hwi.h | 101 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_hwi.h b/drivers/scsi/pm8001/pm8001_hwi.h
index f1ce8df082b0..14b162f93eb8 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.h
+++ b/drivers/scsi/pm8001/pm8001_hwi.h
@@ -133,6 +133,103 @@
 
 /* for new SPC controllers MEMBASE III is shared between BIOS and DATA */
 #define GSM_SM_BASE			0x4F0000
+
+#ifdef __LITTLE_ENDIAN_BITFIELD
+struct sas_identify_frame_local {
+	/* Byte 0 */
+	u8  frame_type:4;
+	u8  dev_type:3;
+	u8  _un0:1;
+
+	/* Byte 1 */
+	u8  _un1;
+
+	/* Byte 2 */
+	union {
+		struct {
+			u8  _un20:1;
+			u8  smp_iport:1;
+			u8  stp_iport:1;
+			u8  ssp_iport:1;
+			u8  _un247:4;
+		};
+		u8 initiator_bits;
+	};
+
+	/* Byte 3 */
+	union {
+		struct {
+			u8  _un30:1;
+			u8 smp_tport:1;
+			u8 stp_tport:1;
+			u8 ssp_tport:1;
+			u8 _un347:4;
+		};
+		u8 target_bits;
+	};
+
+	/* Byte 4 - 11 */
+	u8 _un4_11[8];
+
+	/* Byte 12 - 19 */
+	u8 sas_addr[SAS_ADDR_SIZE];
+
+	/* Byte 20 */
+	u8 phy_id;
+
+	u8 _un21_27[7];
+
+} __packed;
+
+#elif defined(__BIG_ENDIAN_BITFIELD)
+struct sas_identify_frame_local {
+	/* Byte 0 */
+	u8  _un0:1;
+	u8  dev_type:3;
+	u8  frame_type:4;
+
+	/* Byte 1 */
+	u8  _un1;
+
+	/* Byte 2 */
+	union {
+		struct {
+			u8  _un247:4;
+			u8  ssp_iport:1;
+			u8  stp_iport:1;
+			u8  smp_iport:1;
+			u8  _un20:1;
+		};
+		u8 initiator_bits;
+	};
+
+	/* Byte 3 */
+	union {
+		struct {
+			u8 _un347:4;
+			u8 ssp_tport:1;
+			u8 stp_tport:1;
+			u8 smp_tport:1;
+			u8 _un30:1;
+		};
+		u8 target_bits;
+	};
+
+	/* Byte 4 - 11 */
+	u8 _un4_11[8];
+
+	/* Byte 12 - 19 */
+	u8 sas_addr[SAS_ADDR_SIZE];
+
+	/* Byte 20 */
+	u8 phy_id;
+
+	u8 _un21_27[7];
+} __packed;
+#else
+#error "Bitfield order not defined!"
+#endif
+
 struct mpi_msg_hdr{
 	__le32	header;	/* Bits [11:0]  - Message operation code */
 	/* Bits [15:12] - Message Category */
@@ -153,8 +250,8 @@ struct mpi_msg_hdr{
 struct phy_start_req {
 	__le32	tag;
 	__le32	ase_sh_lm_slr_phyid;
-	struct sas_identify_frame sas_identify;
-	u32	reserved[5];
+	struct	sas_identify_frame_local sas_identify;	/* _local to omit CRC field */
+	u32	reserved[6];
 } __attribute__((packed, aligned(4)));
 
 

-- 
2.54.0.563.g4f69b47b94-goog


