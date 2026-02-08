Return-Path: <stable+bounces-214866-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INrmN1/RiGlnwgQAu9opvQ
	(envelope-from <stable+bounces-214866-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 19:09:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 872C4109B16
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 19:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4BA130215B7
	for <lists+stable@lfdr.de>; Sun,  8 Feb 2026 18:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FC22F6927;
	Sun,  8 Feb 2026 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjSsftZa"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7112F5A36
	for <stable@vger.kernel.org>; Sun,  8 Feb 2026 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770574120; cv=none; b=RyWNOIfLOF0Ke+Y9CDMFVg4d5dHfhCsydCjt8+NPXoUYZa3W+KtTNbzPrCGxduBUVoEJtYFYxzuKuuopBm8C5vA9rr6/OjbM5424i1wNgZEocDr9twvTkj4FFHVfL8Y2UtyT67MDjhLp7KYPA23T9c80W8PQcCthY3HtZ3SHRYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770574120; c=relaxed/simple;
	bh=z2nZIn/lKd9/xiLIoQoYgj5ASvUun5JZ/MR0z9Iq9XM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OM3hP5wY5fovAwEjVYZOgQfcjhArDWNeW1mx4+Po+Edg0RXOf3hnBvIvxPsllFnJgLI2jDQ9RZ7iO5mmvrVwTPOmpvbxSizUmwze8CUexB8d+fN0ZQN13TUD0SXfbxj/gZtsL941GFnmLuuBlnpdDp7V+tgHVg9fsuVB8xODUX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjSsftZa; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4806fbc6bf3so26471235e9.2
        for <stable@vger.kernel.org>; Sun, 08 Feb 2026 10:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770574118; x=1771178918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cWY3Id1ZHVwSpLqfM0mispwmQOKUmeewbvlv34YZKKc=;
        b=FjSsftZaYb1jRkJretrvVMGpBi6EhawOe6tJqZfAe9PxL0U3bonxAUlvuDlU1thB5I
         O46u2135LSpOa9GBink5mpsJI1rrJGu6wPdAea1v5uIpsVl8ZOOBI1+iXW0TBpOlxklL
         AZ7zhO8RVObQbN9UtqBVjqmn6nHGg0taFIG2iEyPFClJ2LP839cwCWg4H0VRfNJBn/n5
         zLzNaBtZsAGfzpqpLyxWfW7xsXISLBFwUOApJTXcGFjxvanaH3MJ0IJyVc7EBxzY36oA
         I/qxdxRdW9Q7sucLkCyEZiiB/IjofxaxnD2GLQwMjqXYiCwKkLVUFd/U4eNwl6gGQgdK
         mAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770574118; x=1771178918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWY3Id1ZHVwSpLqfM0mispwmQOKUmeewbvlv34YZKKc=;
        b=coFXhOQdaIkeT5Xdbcltv5ZTWRw/xFMO4afOflN7uLq3QvWqnYznertqQw1KOhTERP
         SnnSrNVQskkRAnucJmfCSXpOSq9MSz4GPiwSoIxafT5T0wz6VbK4wu60/Mpa/yFSyAzb
         nSJSyB6xg3IsQrWWJl32MlcoiVafybomtUogWj0VCdUlsMlCuSvVJB7j/tHDh+AMx44I
         AObmznQU5LniAuGPi3FYQEM7ljdnVH/x+Qv+KeKtlfYwnp75tfWg0CJ3yCirNY1xPlBT
         ufLbE+WS0mSswQIBRVpWS1pS08OlpJdcSkq2D4Ziy/qJCkILr7ukH9I91ZhDPYMYwn7O
         AkeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtJuAXmQgorwTsfIigFLJDWf0+/1AXCcyeCll2DfwzUrlvbrB1q+8/EHUgD2/Nsb0wudzdsYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtOypBaw75t+jYhYrcPDTAaFr33PJA7eMEHbI/BtJ6amrIu4tR
	30Ktkq8LmSwBSxAJCpp5MyfrlDwtCo1vyX3Oq6e5XuL/0eXu1HQsfdn4
X-Gm-Gg: AZuq6aL+f/BEIj43aKeC+D/bcLubofMGkpPA2PLEL4iPMLSMihJw0xIk3GPWfE+EggS
	Ct735ZJunj1D5eE03LUKvX3aitjd2onZCV8TbX8LX2CNTZ8FGp8c6csQxnWzGPlN3QeNRoEM2Q6
	M51fiVUJWx9gtERe2wPJP475Vb397vtzTCNOdHxuNnp4fLTtsWvI9BywRlvq54wK0bf52z+mZ+y
	7+ib+df0EJTeBDOaolZDoVKuUZAbtnzkxnntbQ3FTgLR5NK/qPwFAMy/WdFcZeZTGDgcux/S7Ng
	Xp5mndpTcQwJ0iDrAJthISO/dFrSuWuBDVWKNqv4RNfrjpjUDiw+90iNpTm/ZVELBM/dAKY7bEo
	cez4LMBsoCsyQvoARuz0v1VmKE9jWSoA3T1bwahujrVFCs+t3+laOtQWi1x56SZ/iZ4zh2GmtvC
	5Hj5tbwEx8ZUL/QLxcedE7DRLQq9oKI5GcpVMPtk1JOBfNfO0aww==
X-Received: by 2002:a05:600c:6094:b0:483:a21:7744 with SMTP id 5b1f17b1804b1-4832021e967mr135337885e9.26.1770574118339;
        Sun, 08 Feb 2026 10:08:38 -0800 (PST)
Received: from ionutnechita-arz2022.local ([2a02:2f0e:c504:f100:6cf3:85b2:823f:2bff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d2bab2sm469877835e9.3.2026.02.08.10.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 10:08:37 -0800 (PST)
From: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
To: Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Chandrakanth patil <chandrakanth.patil@broadcom.com>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ionut Nechita <ionut_n2001@yahoo.com>,
	Ionut Nechita <ionut.nechita@windriver.com>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: megaraid_sas: return DID_SOFT_ERROR on zero-byte DONE_WITH_ERROR
Date: Sun,  8 Feb 2026 20:06:04 +0200
Message-ID: <20260208180603.568353-2-sunlightlinux@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[HansenPartnership.com,oracle.com,broadcom.com,vger.kernel.org,yahoo.com,windriver.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-214866-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunlightlinux@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 872C4109B16
X-Rspamd-Action: no action

From: Ionut Nechita <ionut_n2001@yahoo.com>

When the MegaRAID firmware returns MFI_STAT_SCSI_DONE_WITH_ERROR (0x2d)
with zero bytes transferred on a data-bearing command, the driver
currently returns DID_OK to the SCSI midlayer. This causes the I/O to
appear complete with no data, leading to hung tasks that block
indefinitely.

Production systems show the following repeated pattern:

  sd 0:0:9:0: [sdb] tag#24 BRCM Debug mfi stat 0x2d, data len
      requested/completed 0x1000/0x0

  INFO: task systemd-udevd:267 blocked for more than 245 seconds.
  INFO: task modprobe:296 blocked for more than 246 seconds.

When the firmware reports DONE_WITH_ERROR with no data transferred and
no CHECK_CONDITION sense data, return DID_SOFT_ERROR instead of DID_OK.
This causes the SCSI midlayer to retry the command up to cmd->allowed
times (default 5), matching the established pattern used by mpt3sas and
smartpqi for similar conditions.

Commands with CHECK_CONDITION sense data are not affected -- they
continue to be completed immediately with the sense data intact.

Fixes: 9c915a8c99bc ("[SCSI] megaraid_sas: Add 9565/9285 specific code")
Cc: stable@vger.kernel.org
Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c   | 16 ++++++++++++++++
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 14 +++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index abbbc4b36cd1d..de35b7d5094d7 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3682,6 +3682,22 @@ megasas_complete_cmd(struct megasas_instance *instance, struct megasas_cmd *cmd,
 				       hdr->sense_len);
 			}
 
+			/*
+			 * MFI firmware does not report actual bytes
+			 * transferred, so we cannot compute residuals.
+			 * If data was expected and no CHECK_CONDITION,
+			 * retry via DID_SOFT_ERROR. The SCSI midlayer
+			 * retries up to cmd->allowed times (default 5).
+			 */
+			if (hdr->scsi_status != SAM_STAT_CHECK_CONDITION &&
+			    scsi_bufflen(cmd->scmd) > 0) {
+				cmd->scmd->result = DID_SOFT_ERROR << 16;
+				dev_warn(&instance->pdev->dev,
+					"megaraid_sas: DONE_WITH_ERROR (stat 0x%x) on cmd 0x%x to tgt %d, retrying\n",
+					hdr->cmd_status, hdr->cmd,
+					hdr->target_id);
+			}
+
 			break;
 
 		case MFI_STAT_LD_OFFLINE:
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index a6794f49e9fae..6021f1363ef4c 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -2066,7 +2066,19 @@ map_cmd_status(struct fusion_context *fusion,
 		resid = (scsi_bufflen(scmd) - data_length);
 		scsi_set_resid(scmd, resid);
 
-		if (resid &&
+		/*
+		 * If data was expected but zero bytes were transferred
+		 * and there is no CHECK_CONDITION sense data, retry via
+		 * DID_SOFT_ERROR. The SCSI midlayer retries up to
+		 * cmd->allowed times (default 5).
+		 */
+		if (data_length == 0 && scsi_bufflen(scmd) > 0 &&
+		    ext_status != SAM_STAT_CHECK_CONDITION) {
+			scmd->result = DID_SOFT_ERROR << 16;
+			scmd_printk(KERN_WARNING, scmd,
+				"megaraid_sas: zero data on DONE_WITH_ERROR (stat 0x%x, bufflen 0x%x), retrying\n",
+				status, scsi_bufflen(scmd));
+		} else if (resid &&
 			((cmd_type == READ_WRITE_LDIO) ||
 			(cmd_type == READ_WRITE_SYSPDIO)))
 			scmd_printk(KERN_INFO, scmd, "BRCM Debug mfi stat 0x%x, data len"
-- 
2.52.0


