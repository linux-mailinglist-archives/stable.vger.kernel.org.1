Return-Path: <stable+bounces-227630-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPksIzzCvWmEBQMAu9opvQ
	(envelope-from <stable+bounces-227630-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 22:55:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1374C2E183F
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 22:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89E333022067
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB6B3B38A7;
	Fri, 20 Mar 2026 21:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOhIDu3c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B058835C1BD
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 21:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774043687; cv=none; b=Z+DmIAIZm7Epn1z24x7iw7WZxBj9bto2QXfzncwNxi4tC43eWo3SnjCMIzg2OJgc9Xk0jHPGiAp06Li0L67pvIhpZn4dHfKA54k7nf/ht1RyR1cYiHbKC46jv418xFLuZ21uy+BLfAdFc17q7O7wlWVnlnftztWZs8/U/Mrv0rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774043687; c=relaxed/simple;
	bh=4D+510PbRhokkw09bzk49Dn36yjF9iLoBXfP7QecEpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1hSRF/AVdJoY4iyS63sYRX5NSWTOjs9GcJ/dgPm0f4KqrQdl7UgYhm7aBVRrGCJLmZgGqizcXWkN1afMf2rC4b7KsmLuz5NU49NF+91d4UMzBDxTeesvZ9fAApq08iUzCeuBIh6UD9TljzpzDEzO9fRjPYo5upJthiA6CEufg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOhIDu3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E42C4CEF7;
	Fri, 20 Mar 2026 21:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774043687;
	bh=4D+510PbRhokkw09bzk49Dn36yjF9iLoBXfP7QecEpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XOhIDu3coBkmpEb3vA4c+RoFGm4jvC976q42wz7HrGNuGq3DvOdFckPZtoKQxPaEO
	 gOEqHZANLEtWykK54AmY58nSlgHpk3Wzv8hSENpxKtiE0BVmlaaGyVJSt/siWbi6Ke
	 lDR0BeL+xIi4N5KHES4qBw4sdXrHLtQiCRwCgWzblN3Ib6QTVFEeE5Fut/o0n/OYyk
	 Iuw431LLs5R6LAlnXchwuPW1OWSPjkAmBMpm1MLRSCdP4DHkTB+xf+l2Qf2SBDylxb
	 weCLwKTxtQUhiz2ZEifkjXI1kV5edIs+Kx2LkYwFvo+5yte8+P1FndZHQFMGsxtTJg
	 nbzdBRpDur3+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] ata: libata-scsi: Return residual for emulated SCSI commands
Date: Fri, 20 Mar 2026 17:54:44 -0400
Message-ID: <20260320215445.132838-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026032032-sludge-profanity-a10a@gregkh>
References: <2026032032-sludge-profanity-a10a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227630-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1374C2E183F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit 5251ae224d8d3caa21b28d12408062b6e75cffad ]

The function ata_scsi_rbuf_fill() used to fill the reply buffer of
emulated SCSI commands always copies the ATA reply buffer
(ata_scsi_rbuf) up to the size of the SCSI command buffer (the transfer
length for the command), even if the reply is shorter than the SCSI
command buffer. This leads to issuers of the SCSI command to always get
a result without any residual (resid is always 0) despite the
potentially shorter reply for the command.

Modify all fill actors used by ata_scsi_rbuf_fill() to return the number
of bytes filled for the reply and 0 in case of error. Using this value,
add a call to scsi_set_resid() in ata_scsi_rbuf_fill() to set the
correct residual for the SCSI command when the reply length is shorter
than the command buffer.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Link: https://lore.kernel.org/r/20241022024537.251905-7-dlemoal@kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Stable-dep-of: e6d7eba23b66 ("ata: libata-scsi: report correct sense field pointer in ata_scsiop_maint_in()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-scsi.c | 81 +++++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 34 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d7c88a111ea3d..bfabf27adfce5 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1920,17 +1920,19 @@ static void ata_scsi_rbuf_fill(struct ata_device *dev, struct scsi_cmnd *cmd,
 		unsigned int (*actor)(struct ata_device *dev,
 				      struct scsi_cmnd *cmd, u8 *rbuf))
 {
-	unsigned int rc;
 	unsigned long flags;
+	unsigned int len;
 
 	spin_lock_irqsave(&ata_scsi_rbuf_lock, flags);
 
 	memset(ata_scsi_rbuf, 0, ATA_SCSI_RBUF_SIZE);
-	rc = actor(dev, cmd, ata_scsi_rbuf);
-	if (rc == 0) {
+	len = actor(dev, cmd, ata_scsi_rbuf);
+	if (len) {
 		sg_copy_from_buffer(scsi_sglist(cmd), scsi_sg_count(cmd),
 				    ata_scsi_rbuf, ATA_SCSI_RBUF_SIZE);
 		cmd->result = SAM_STAT_GOOD;
+		if (scsi_bufflen(cmd) > len)
+			scsi_set_resid(cmd, scsi_bufflen(cmd) - len);
 	}
 
 	spin_unlock_irqrestore(&ata_scsi_rbuf_lock, flags);
@@ -2018,7 +2020,11 @@ static unsigned int ata_scsiop_inq_std(struct ata_device *dev,
 	else
 		memcpy(rbuf + 58, versions, sizeof(versions));
 
-	return 0;
+	/*
+	 * Include all 8 possible version descriptors, even if not all of
+	 * them are popoulated.
+	 */
+	return 96;
 }
 
 /**
@@ -2055,7 +2061,8 @@ static unsigned int ata_scsiop_inq_00(struct ata_device *dev,
 		num_pages++;
 	}
 	rbuf[3] = num_pages;	/* number of supported VPD pages */
-	return 0;
+
+	return get_unaligned_be16(&rbuf[2]) + 4;
 }
 
 /**
@@ -2082,7 +2089,8 @@ static unsigned int ata_scsiop_inq_80(struct ata_device *dev,
 	memcpy(rbuf, hdr, sizeof(hdr));
 	ata_id_string(dev->id, (unsigned char *) &rbuf[4],
 		      ATA_ID_SERNO, ATA_ID_SERNO_LEN);
-	return 0;
+
+	return get_unaligned_be16(&rbuf[2]) + 4;
 }
 
 /**
@@ -2143,7 +2151,8 @@ static unsigned int ata_scsiop_inq_83(struct ata_device *dev,
 		num += ATA_ID_WWN_LEN;
 	}
 	rbuf[3] = num - 4;    /* page len (assume less than 256 bytes) */
-	return 0;
+
+	return get_unaligned_be16(&rbuf[2]) + 4;
 }
 
 /**
@@ -2180,7 +2189,8 @@ static unsigned int ata_scsiop_inq_89(struct ata_device *dev,
 	rbuf[56] = ATA_CMD_ID_ATA;
 
 	memcpy(&rbuf[60], &dev->id[0], 512);
-	return 0;
+
+	return get_unaligned_be16(&rbuf[2]) + 4;
 }
 
 /**
@@ -2231,7 +2241,7 @@ static unsigned int ata_scsiop_inq_b0(struct ata_device *dev,
 		put_unaligned_be32(1, &rbuf[28]);
 	}
 
-	return 0;
+	return get_unaligned_be16(&rbuf[2]) + 4;
 }
 
 /**
@@ -2261,7 +2271,7 @@ static unsigned int ata_scsiop_inq_b1(struct ata_device *dev,
 	if (zoned)
 		rbuf[8] = (zoned << 4);
 
-	return 0;
+	return get_unaligned_be16(&rbuf[2]) + 4;
 }
 
 /**
@@ -2284,7 +2294,7 @@ static unsigned int ata_scsiop_inq_b2(struct ata_device *dev,
 	rbuf[3] = 0x4;
 	rbuf[5] = 1 << 6;	/* TPWS */
 
-	return 0;
+	return get_unaligned_be16(&rbuf[2]) + 4;
 }
 
 /**
@@ -2304,7 +2314,7 @@ static unsigned int ata_scsiop_inq_b6(struct ata_device *dev,
 {
 	if (!ata_dev_is_zac(dev)) {
 		ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
-		return 1;
+		return 0;
 	}
 
 	/*
@@ -2322,7 +2332,7 @@ static unsigned int ata_scsiop_inq_b6(struct ata_device *dev,
 	put_unaligned_be32(dev->zac_zones_optimal_nonseq, &rbuf[12]);
 	put_unaligned_be32(dev->zac_zones_max_open, &rbuf[16]);
 
-	return 0;
+	return get_unaligned_be16(&rbuf[2]) + 4;
 }
 
 /**
@@ -2346,7 +2356,7 @@ static unsigned int ata_scsiop_inq_b9(struct ata_device *dev,
 
 	if (!cpr_log) {
 		ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
-		return 1;
+		return 0;
 	}
 
 	/* SCSI Concurrent Positioning Ranges VPD page: SBC-5 rev 1 or later */
@@ -2360,7 +2370,7 @@ static unsigned int ata_scsiop_inq_b9(struct ata_device *dev,
 		put_unaligned_be64(cpr_log->cpr[i].num_lbas, &desc[16]);
 	}
 
-	return 0;
+	return get_unaligned_be16(&rbuf[2]) + 4;
 }
 
 /**
@@ -2382,7 +2392,7 @@ static unsigned int ata_scsiop_inquiry(struct ata_device *dev,
 	/* is CmdDt set?  */
 	if (scsicmd[1] & 2) {
 		ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
-		return 1;
+		return 0;
 	}
 
 	/* Is EVPD clear? */
@@ -2410,7 +2420,7 @@ static unsigned int ata_scsiop_inquiry(struct ata_device *dev,
 		return ata_scsiop_inq_b9(dev, cmd, rbuf);
 	default:
 		ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
-		return 1;
+		return 0;
 	}
 }
 
@@ -2741,24 +2751,27 @@ static unsigned int ata_scsiop_mode_sense(struct ata_device *dev,
 			rbuf[3] = sizeof(sat_blk_desc);
 			memcpy(rbuf + 4, sat_blk_desc, sizeof(sat_blk_desc));
 		}
-	} else {
-		put_unaligned_be16(p - rbuf - 2, &rbuf[0]);
-		rbuf[3] |= dpofua;
-		if (ebd) {
-			rbuf[7] = sizeof(sat_blk_desc);
-			memcpy(rbuf + 8, sat_blk_desc, sizeof(sat_blk_desc));
-		}
+
+		return rbuf[0] + 1;
+	}
+
+	put_unaligned_be16(p - rbuf - 2, &rbuf[0]);
+	rbuf[3] |= dpofua;
+	if (ebd) {
+		rbuf[7] = sizeof(sat_blk_desc);
+		memcpy(rbuf + 8, sat_blk_desc, sizeof(sat_blk_desc));
 	}
-	return 0;
+
+	return get_unaligned_be16(&rbuf[0]) + 2;
 
 invalid_fld:
 	ata_scsi_set_invalid_field(dev, cmd, fp, bp);
-	return 1;
+	return 0;
 
 saving_not_supp:
 	ata_scsi_set_sense(dev, cmd, ILLEGAL_REQUEST, 0x39, 0x0);
 	 /* "Saving parameters not supported" */
-	return 1;
+	return 0;
 }
 
 /**
@@ -2801,7 +2814,7 @@ static unsigned int ata_scsiop_read_cap(struct ata_device *dev,
 		rbuf[6] = sector_size >> (8 * 1);
 		rbuf[7] = sector_size;
 
-		return 0;
+		return 8;
 	}
 
 	/*
@@ -2811,7 +2824,7 @@ static unsigned int ata_scsiop_read_cap(struct ata_device *dev,
 	if (scsicmd[0] != SERVICE_ACTION_IN_16 ||
 	    (scsicmd[1] & 0x1f) != SAI_READ_CAPACITY_16) {
 		ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
-		return 1;
+		return 0;
 	}
 
 	/* sector count, 64-bit */
@@ -2846,7 +2859,7 @@ static unsigned int ata_scsiop_read_cap(struct ata_device *dev,
 		}
 	}
 
-	return 0;
+	return 16;
 }
 
 /**
@@ -2865,7 +2878,7 @@ static unsigned int ata_scsiop_report_luns(struct ata_device *dev,
 {
 	rbuf[3] = 8;	/* just one lun, LUN 0, size 8 bytes */
 
-	return 0;
+	return 16;
 }
 
 /*
@@ -3593,13 +3606,13 @@ static unsigned int ata_scsiop_maint_in(struct ata_device *dev,
 
 	if ((cdb[1] & 0x1f) != MI_REPORT_SUPPORTED_OPERATION_CODES) {
 		ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
-		return 1;
+		return 0;
 	}
 
 	if (cdb[2] != 1 && cdb[2] != 3) {
 		ata_dev_warn(dev, "invalid command format %d\n", cdb[2]);
 		ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
-		return 1;
+		return 0;
 	}
 
 	switch (cdb[3]) {
@@ -3672,7 +3685,7 @@ static unsigned int ata_scsiop_maint_in(struct ata_device *dev,
 	rbuf[0] = rwcdlp;
 	rbuf[1] = cdlp | supported;
 
-	return 0;
+	return 4;
 }
 
 /**
-- 
2.51.0


