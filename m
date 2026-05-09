Return-Path: <stable+bounces-244933-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hUfoOAb+/mnm0wAAu9opvQ
	(envelope-from <stable+bounces-244933-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 11:27:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E63F4FEFAF
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 11:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F33523016017
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 09:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8C439280C;
	Sat,  9 May 2026 09:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlPK6OuL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D45A38E124
	for <stable@vger.kernel.org>; Sat,  9 May 2026 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778318851; cv=none; b=jBVQ952BVgkOyrno7Ehzh7+97cqFeD9KY8g/gVquGuYCAsp447xLvNtx+/+fl9KWMom/1ekkMukQLEOp/X1+1qPGTu/iAnLrYOeh70WnJqejaiqShgG7NUHGtWBlaw4IV6Rb8Yqyw2GEWDiivOdfPhPYVBGbpLTWGDx43E1/oI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778318851; c=relaxed/simple;
	bh=lHIfUfoYldIKXo/UX6z7lcvZXFL6uzec1GWs/aBId0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=niLj2CzM6CHGg8348SC8q2OrIPeNhIOErZhfk+RCpD6Ea2DMEJEBu2UN/1PD3PCySqtWkSl5vXLl7WiD4//xmtG6zh6KuFMpvHWOnNnzuf9EWlq4Sp4RLyLqEEBj12/pm8rBD+FapqjHNpmSqzHdGj8UOlDZh+V1AfxkKw0O1+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlPK6OuL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b788a98557so20888995ad.2
        for <stable@vger.kernel.org>; Sat, 09 May 2026 02:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778318850; x=1778923650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fNKru4wcaLCJfeGMBIRpabwgz5gQjSTUlQZOu9/T4s=;
        b=MlPK6OuL7pkqOOYwku48kD5qw5TX9ME0NSqUvqt3LmVWwU1UQVbJVUAjUaOlct8QgU
         828c9m7cWzJr1E6ylMJKtxIfh36r6Q1kU+qDhTRMVzZWW97qJWQB9bTDPnHxOd/7u/Fu
         6YpuIWZG01097jPL8ZV3v5snpU7wGsWpayEAy33YY2H2CBMPFTKmmtGqWaNU2nZQ0dal
         QzAy++G+wW+C0HrHKu7ZkYTW24uV2qLx5R/8CTBxcXlnOALNHWIcqs99g/ofXXWySz+/
         jifFi26/fiok6DbUTACO4TUPOpE3rE3Dlb/szPU8yby3Dwzuvb0EChMe6+AZ0LVntH6V
         ZdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778318850; x=1778923650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/fNKru4wcaLCJfeGMBIRpabwgz5gQjSTUlQZOu9/T4s=;
        b=Lm05N4jAwvvDxSWYhqldaJeQM6rJFEPcE3igsFyF586TEL5/lg4TnkdeVzWcAtA0dC
         UHnuAV+2AmzK/DGzEsZ+0TxnzcI5TdEttMSI3z6hUGvDUbAqRP8b7oBVJsSZEqVAbkHk
         MoquD+kRAx9DmYUvhQgd26azhQ04VBozz1ieuS4ocpJlhfX7olnvsJ/qGS1BNnN7OV0H
         UMzulMeBD91O0X2Shp4HUGorgvfPrIR/D7xSexikxNiES7OHtio67KZRZVJ82Q6S79jo
         3xN5uXDmPn73/NYsYQ5WlIxwB9DfllXF3YXNBuGqyl5qz/2d0gnXQYyuc9LaKmh7x6ao
         5V1w==
X-Forwarded-Encrypted: i=1; AFNElJ/vnnkPwYwLHCkWI+6q5r6990REkjWQhSCbdL3V3Md1kJ1IO6JSQBljZxSzoKSp0s81uzW+pcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjNc6BYYKqp8doP1z6RMLVJysq/qHYWrp3Atl3UuJv9ZAdj7fC
	vnEdOeSmzlytLJKtg18JXIR9exY9AqrOrRamUMnEZrgSOXhpli28mLlH
X-Gm-Gg: Acq92OH8SGfX9xGALU1yjbwW454rw96FGbSCkZCReQc/GS9mlTALatbFrPp+En2UKeF
	gP11ggJcp58XbQ8VMtvjV96/2khcijluNnlpxLGgkPtuESXvAZNvTrxGk5c2WkB5eLS7AUbmVYp
	1gf+Q3kXzBviDKkrV7m+w9SE7qOpxJvY1M9K7+badKySRV58JFkDgrr2h/Nk33iOBmp/y/XX/26
	xtjgSyBeReagHz3TXylaHnLwQVgq7rtsDwqS4KmT8vbOkSL/BPbHi/1bNwBvb0t0JC1pF+8I9ot
	/xWOrCrap7ql9Zv86KU4u2KzGoWlLfkhSTgsbifDQ3FqQFzWYluSf8NDGx7K+rWph1QOxxuTfpq
	ve49ecYGu+T5gBpaWVcJFVwSlUCu2GXn7N0MCFQN0yfnpURJ9HHVG1h3NF4+UO+jbyT77oRIdzW
	krJvhzr+lTPDsJR+pkoJdRdun0uPqzCNRaW1tBn35A5+sRDnDG6rFhC/3Z9yQlGQ==
X-Received: by 2002:a17:903:284:b0:2ba:6ca2:be0 with SMTP id d9443c01a7336-2baf0cf3149mr70808065ad.4.1778318849521;
        Sat, 09 May 2026 02:27:29 -0700 (PDT)
Received: from PC.localdomain (softbank060090219114.bbtec.net. [60.90.219.114])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e36596sm47463105ad.48.2026.05.09.02.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 02:27:29 -0700 (PDT)
From: Rion Kiguchi <kiguchi.r.sec@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	Rion Kiguchi <kiguchi.r.sec@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] staging: vme_user: validate slave window size against buffer size
Date: Sat,  9 May 2026 18:26:27 +0900
Message-ID: <20260509092627.1136357-1-kiguchi.r.sec@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026050935-designing-glancing-2e16@gregkh>
References: <2026050935-designing-glancing-2e16@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3E63F4FEFAF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244933-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kiguchirsec@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The VME_SET_SLAVE ioctl in drivers/staging/vme_user/vme_user.c accepts
a user-controlled slave.size and forwards it to vme_slave_set() without
comparing it against image[minor].size_buf. The slave-image kernel
buffer is allocated at probe time with a fixed size of PCI_BUF_SIZE
(0x20000 / 128 KiB), but the configured VME window size can be made
much larger via the ioctl.

The subsequent read() / write() handlers (vme_user_read /
vme_user_write) clamp the I/O range against vme_get_size(), which
returns the size the bridge driver has programmed for the window
(i.e. the attacker-supplied slave.size). vme_get_size() does not
consult size_buf, so an oversized window passes the existing bounds
checks, and buffer_to_user() / buffer_from_user() then index
image[minor].kern_buf with offsets beyond the actual allocation.

Result: a local user with read/write access to /dev/bus/vme/s* can
trigger out-of-bounds read and write of the kernel slab adjacent to
the slave-image buffer.

Fix: reject slave.size > size_buf in the VME_SET_SLAVE handler.
With this check in place, the existing bounds checks in
vme_user_read() / vme_user_write() against vme_get_size() are
sufficient to prevent OOB access; no additional checks in
buffer_to_user() / buffer_from_user() are needed.

Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Rion Kiguchi <kiguchi.r.sec@gmail.com>
---
Changes in v3:
 - Drop redundant checks in buffer_to_user() / buffer_from_user();
   the existing vme_get_size()-based bounds checks in vme_user_read()
   / vme_user_write() are sufficient once VME_SET_SLAVE rejects
   oversized windows (Greg's review feedback)
 - Reword commit message to explain why vme_get_size() does not
   already catch this

Changes in v2:
 - Use git send-email instead of Gmail web compose (v1 corrupted
   the diff)
 - Drop redundant Reported-by tag (author == reporter)
 - Add Assisted-by tag per Documentation/process/coding-assistants.rst

 drivers/staging/vme_user/vme_user.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme_user.c b/drivers/staging/vme_user/vme_user.c
index 11e25c2f6..64e95b026 100644
--- a/drivers/staging/vme_user/vme_user.c
+++ b/drivers/staging/vme_user/vme_user.c
@@ -394,6 +394,14 @@ static int vme_user_ioctl(struct inode *inode, struct file *file,
 				return -EFAULT;
 			}
 
+			/*
+			 * Reject window sizes larger than the kernel buffer
+			 * allocated at probe time, otherwise subsequent
+			 * read/write would access memory beyond kern_buf.
+			 */
+			if (slave.size > image[minor].size_buf)
+				return -EINVAL;
+
 			/* XXX	We do not want to push aspace, cycle and width
 			 *	to userspace as they are
 			 */
@@ -401,7 +409,7 @@ static int vme_user_ioctl(struct inode *inode, struct file *file,
 				slave.enable, slave.vme_addr, slave.size,
 				image[minor].pci_buf, slave.aspace,
 				slave.cycle);
-
+				
 			break;
 		}
 		break;
-- 
2.43.0


