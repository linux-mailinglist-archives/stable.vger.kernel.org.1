Return-Path: <stable+bounces-242238-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPiVHt0q9GlA+wEAu9opvQ
	(envelope-from <stable+bounces-242238-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 06:23:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F274AA4D4
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 06:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48E0630D3FF4
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 04:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768C5315D50;
	Fri,  1 May 2026 04:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1gqS1Bh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181DC3148D0
	for <stable@vger.kernel.org>; Fri,  1 May 2026 04:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777608759; cv=none; b=bhbn4r7Pe+qXJGNmwf5ittF6riqCvZT2/A2ouSgeUV5aw+VskzutTHRnYefCQRA05jfb3rBY+3xMC4Z3RaHAguhV8ZUxsVn2JHaCo22PuPj8Z7t/8bCK0Fw6d6s9r73ZUfsxRO7DkTx0j/329rNEgB1hEbWrYmplzz8IdveHgXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777608759; c=relaxed/simple;
	bh=dGazrhGlx+ydSCQdjAg++FU0k6A9TxsgZxMaz61j+IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDxAB9h4dsS7WOaChWmRIq4tusYHdugIOyLNBttrdiLj/9auzq0MLk81dDCduEYF4NCufLW02h+Q4OGTp7zVPUXd3QRwkb/sqQip+TQvMriAbdEyWEcenl9uHfLa/M38WCa/2/FYrEqo6emrb1YbCqdwiooqZzqJanavGBd0VIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1gqS1Bh; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35fc2b18363so1780896a91.0
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 21:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777608757; x=1778213557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzTwWKu4/OMgogLdvJRN18BQXd8VP1+UN2ymsqFSQ28=;
        b=e1gqS1BhjFPU1sGe/Ua51tWqHWZnsQNVURwaukN4QbrFPKaO3UvkebTDwBhiFJWmIV
         nOVSmYUPfm5SCzrcpSe/hzJIkTjNKlBtWWqDhvvx8Wa1SjUlcdkWnPWHMbQQL6wuIGra
         UYIgRZKGwrATVqQ/Gr2aiWxHDF6l/4Xeld1ztZCZYbzkcK6lkDjXMZinmry9/B5KCzVA
         iXEejjqAf2eEu198pi1/WqLSlaH8K3u7MFXpZTMjVNC/K1ai+TZfqk9U8skVH6miY8B3
         CiCvByGwRrSubIl/5d6ErJC4CIzvCJn4d4fzqm0RcicMjqYwR2fD7bniLoBfR6BpWNal
         caRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777608757; x=1778213557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GzTwWKu4/OMgogLdvJRN18BQXd8VP1+UN2ymsqFSQ28=;
        b=ErVLsDfiY+azjrGQcPERvnNNFjhJZlvrGpLA3QEyDNRptx9t5GvabnNMswHyHqcP30
         MlzDk4y+YK2GtbXaOFCe8cRDxeZOB/ujijBAbyEHTPM5r1iPWpTfAjtsEknZGQ58Qqd1
         /VGnhN79tKsxGa/ddL2HNy4sj7w87ubBJ39OPwhPSXiYs4y883/aKuWR0iqdGzT+HeNX
         Zk/WU90459ZiRxfHemfreaAUL1sPoS4ZPlUUVNC4KRzOv9c0see0Byhl4MQnVPOh5qIX
         fb70SruolZaFzR2BIUgqdv9eTBGMxszrOqCvtaL0PSX8MJ9SnHNRDejKlzKFGiCn4px3
         6CVw==
X-Forwarded-Encrypted: i=1; AFNElJ/ZpM+b2zCfD0z54XNjnsvjT19oxUaVh+/12IbTZgjlv1SdKkelhKxiAtIODwbEGnGWfbY0sTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhQw3un/aIAS1R9UHTYPfndfzNWexRlPKvdXjj7dQfqB59OmvN
	SplDpAFZYGEgNeSD+YwILpgPj4HHr9EFtoZl1duxe42PNkpPw8ZTpFTi
X-Gm-Gg: AeBDieu/ThwN/fopK6KJ9VFumB36U+5jDpu3nvrJKXNSA1kPmcYEEg4AuXrNeXN8i3d
	X+MYEjjSZrDQBPtsSEhuf/ipXR4IWwBuokEExaJoNPwXcbijJSLb/W59rZyJeSLU+KYyV/plS1L
	9aeVqfY9gmIqWMwZyUjMo0NKxTVeACIgNVPkBmbtBpwKdFP3puypEMLSLXYoYb7ftZV2WTQJALc
	L66/ZX4co7oCHP1S29pCpdk2ZtwnyBLQcBNtyHBBosCOchNW0k/MYsTKB/b7olNYfLcuzPuhSyT
	Z9U0ZW5iWvyVV52X3o8fePQS8OTIIXNVupAvtNwkkaR+f5HgqVcPlcGqa11jWyPwnNpPvRmRcDa
	/F3PMiEcrlXGg/cM1x45N7rY54vp+phAoV9Yu6ibgWUmBVCHVycmToa7BsiCAn6gaG+pgd/qdu0
	cqN89aCy41OY1n/VT9Eyg42OLGYvgELVNSoZPs6cfiVVO9I4xk11GWQ4RADl9EVnQ=
X-Received: by 2002:a05:6a20:2444:b0:39f:a42:9247 with SMTP id adf61e73a8af0-3a45fe026bbmr1846152637.37.1777608757090;
        Thu, 30 Apr 2026 21:12:37 -0700 (PDT)
Received: from localhost.localdomain ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b485eesm1159428b3a.48.2026.04.30.21.12.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Apr 2026 21:12:36 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 5/9] pseries/papr-hvpipe: Fix the usage of copy_to_user()
Date: Fri,  1 May 2026 09:41:44 +0530
Message-ID: <8fda3212a1ad48879c174e92f67472d9b9f1c3b7.1777606826.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1777606826.git.ritesh.list@gmail.com>
References: <cover.1777606826.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 10F274AA4D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-242238-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.ibm.com,kernel.org,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riteshlist@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

copy_to_user() return bytes_not_copied to the user buffer. If there was
an error writing bytes into the user buffer, i.e. if copy_to_user
returns a non-zero value, then we should simply return -EFAULT from the
->read() call.

Otherwise, in the non-patched version, we may end up mixing
"bytes_not_copied + bytes_copied (HVPIPE_HDR_LEN)" as the return value
to the user in ->read() call

Also let's make sure we clear the hvpipe_status flag, if we have
consumed the hvpipe msg by making the rtas call. ret = -EFAULT means
copy_to_user has failed but that still means that the msg was read from
the hvpipe, hence for both cases, success & -EFAULT, we should clear the
HVPIPE_MSG_AVAILABLE flag in hvpipe_status.

Cc: stable@vger.kernel.org
Fixes: cebdb522fd3edd1 ("powerpc/pseries: Receive payload with ibm,receive-hvpipe-msg RTAS")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 23 ++++++++++++--------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index 800649f309a5..c007560d2d8c 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -206,10 +206,11 @@ static int hvpipe_rtas_recv_msg(char __user *buf, int size)
 					bytes_written, size);
 				bytes_written = size;
 			}
-			ret = copy_to_user(buf,
+			if (copy_to_user(buf,
 					rtas_work_area_raw_buf(work_area),
-					bytes_written);
-			if (!ret)
+					bytes_written))
+				ret = -EFAULT;
+			else
 				ret = bytes_written;
 		}
 	} else {
@@ -328,7 +329,7 @@ static ssize_t papr_hvpipe_handle_read(struct file *file,
 
 	struct hvpipe_source_info *src_info = file->private_data;
 	struct papr_hvpipe_hdr hdr = {};
-	long ret;
+	ssize_t ret = 0;
 
 	/*
 	 * Return -ENXIO during migration
@@ -376,7 +377,7 @@ static ssize_t papr_hvpipe_handle_read(struct file *file,
 
 	ret = copy_to_user(buf, &hdr, HVPIPE_HDR_LEN);
 	if (ret)
-		return ret;
+		return -EFAULT;
 
 	/*
 	 * Message event has payload, so get the payload with
@@ -385,19 +386,23 @@ static ssize_t papr_hvpipe_handle_read(struct file *file,
 	if (hdr.flags & HVPIPE_MSG_AVAILABLE) {
 		ret = hvpipe_rtas_recv_msg(buf + HVPIPE_HDR_LEN,
 				size - HVPIPE_HDR_LEN);
-		if (ret > 0) {
+		/*
+		 * Always clear MSG_AVAILABLE once the RTAS call has drained
+		 * the message, regardless of whether copy_to_user succeeded.
+		 */
+		if (ret >= 0 || ret == -EFAULT)
 			src_info->hvpipe_status &= ~HVPIPE_MSG_AVAILABLE;
-			ret += HVPIPE_HDR_LEN;
-		}
 	} else if (hdr.flags & HVPIPE_LOST_CONNECTION) {
 		/*
 		 * Hypervisor is closing the pipe for the specific
 		 * source. So notify user space.
 		 */
 		src_info->hvpipe_status &= ~HVPIPE_LOST_CONNECTION;
-		ret = HVPIPE_HDR_LEN;
 	}
 
+	if (ret >= 0)
+		ret += HVPIPE_HDR_LEN;
+
 	return ret;
 }
 
-- 
2.39.5


