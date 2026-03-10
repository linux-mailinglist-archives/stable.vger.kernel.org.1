Return-Path: <stable+bounces-223788-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKLBKqPTr2kfcgIAu9opvQ
	(envelope-from <stable+bounces-223788-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:17:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6A02472A2
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6D2B3021BA5
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 08:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AEB3D7D79;
	Tue, 10 Mar 2026 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7UJfx4B"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8B9285CB4
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 08:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773130655; cv=none; b=K8YmGsAKy+IJr1ftQ2LojohdVEVnXaxzJaR1RFBy6Ku0NrRYgEH+6frphE9CgGyOxxSLyDlT62nN+90JxiS8QiPiZagZ61JzoFUz5SD6aG0v0Wqw3PnMcQuz4YKk5452PrciMRIxoC0j/mJdcgEyY4Ygr5yVKTHdLigA4sgNOuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773130655; c=relaxed/simple;
	bh=/D/qOvBY8V7Pb4JsqtZ+y2EJY5cGHgmFaYtqSaQeLIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lZEZGAKKTK3AV2pEc6q1zH9DcI7QHLnm8X0AfTLStKOI1vIW7/QdEgteqcA5rptzm9K7B9xn/6jpfOV6Y6xkvGGazKihR1mcICOGc14brKpK3AnlSWts7psGg1hnxDd4LUjePPbtpwsacbs2bODzFg8zLlkjr1R1megfWTr2GGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7UJfx4B; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-829afe24fb5so2304409b3a.0
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 01:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773130653; x=1773735453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NSX2/KunvfJmTIm/YDzKXoDaJ8O0AYEhpCELONSClG8=;
        b=X7UJfx4BfRH9Vq2IkCNHxIZHgRJnGALnkDkhr0bKj3Rm0IpPAWJZP7xY8880pC27Es
         ErUFFSEGyeIus+OaV6vNaShM95fUJfRmkRMg86+VkAusw3HqtwEtzNOuuAnSl+P1vkm1
         ldCO0+j2gBRubDnxsJCdZBMxqL3x8vlQOjRpe08Z/OiVQstba6BQLhWuyObZ2//SoKMr
         Src281gMoA1tQwxTiPovPPRiYCpg8SnbKAIS6VKq7tzf6y/P1ZtAwTtIZVuKwkT8PycY
         ax4f1bE+095aJ/vzjPjboQ5gjvX3lzFzly+UuLytWhB1QJnviWEgJVjAh+dQDyAKRql0
         cfzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773130653; x=1773735453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSX2/KunvfJmTIm/YDzKXoDaJ8O0AYEhpCELONSClG8=;
        b=K4CasKYJTA4jAfhjBvksAnTNm4KAfCj37GcthnRdS9sZN1/EDvv9/EM/XJE48Kj1vf
         IPzrIiMaJepXgjk/5pmIRNYttQA870M1cwtvya+AFx5NXCH9w38dnLhbYZDTEhhD2EGw
         GRe61QOqq9wEQr5BhiY0J0LAn7n19orbyje1/fnL0LEtjSfVbYnlrA2uJGd5bhBBYwvm
         MjqFC7RIZh1BVAerh9D/4OB2rVt89TV328GKQNA2+Kt6nGMDs9jWDveoQbCp/qvMNa0n
         G4WDDqCD6KpMS1/IdKTY4g5uB8tzVBrLbr28nHG9JgUFop9sY+WeB5yEes21Ek7DoIXE
         K+qA==
X-Forwarded-Encrypted: i=1; AJvYcCXpRul0GLUYscE8qtAWmr8cT0aneo3QR5K5piq6vNGhjdLfLooiPiCjkits6tfnEbQoTzoVi3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdzorioVrFhdAYkckmw9pRKTq60I6xhJRtJ3vy/W2kLoOYMNkY
	+48rsAihXx/QRFNihSGTIYMsc1ZXMEj9Tcv7VjZcMC4tAreTkGsurqAcUz+KWbyE
X-Gm-Gg: ATEYQzwiv7c7nd8+kFPLcuH6WAX3SoFcE1YKMjZJgQeQb2d1+QG5jgTAFo5LItJFOHB
	ZVPnBbaxl82nNOZDdIqYFyXViQ1gAdV2JwXqBEc6hLpEEuGUM0wHs/rWn3gZGQzXavVH2qzaEl9
	PR2MylGLbKSml4F9rA01/221JE4xF7dDIJlkTErWk1Dl1CwQnPWOUOu+uIj1RXir53Xcusg4PI6
	SU4RZT5VVQjvPPQSilrtEjTBmgTjHWKRbvn7VLs/2hltf9X38LXdaMqvG7oBLlSB4qA9dMls5an
	f2y0eohe8XH+AIc959E1y21M8IijhR2X0JCrLLUfJgkFpkoAT29ZDX+CE6PK0LLMf9wzP9vpraM
	6PvxgEGU2F9yR25qB5nPcE8FSpII/8LscZJX19rAHbuNSLC1fO2RWNCpT6UxTGpi9bSBoxxIka7
	9Z/i7mlgcY/N7NJyCzODbFniSS75tyXsSbfWVmpWDN
X-Received: by 2002:a05:6a00:1a8c:b0:829:810e:8af8 with SMTP id d2e1a72fcca58-829a2dc4f99mr13412167b3a.22.1773130653357;
        Tue, 10 Mar 2026 01:17:33 -0700 (PDT)
Received: from DESKTOP-SF55S0Q.localdomain ([110.76.74.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a465b6f7sm15455650b3a.23.2026.03.10.01.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 01:17:32 -0700 (PDT)
From: Seohyeon Maeng <bioloidgp@gmail.com>
To: Jan Kara <jack@suse.com>
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] udf: fix partition descriptor append bookkeeping
Date: Tue, 10 Mar 2026 17:16:52 +0900
Message-ID: <20260310081652.21220-1-bioloidgp@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4F6A02472A2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223788-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bioloidgp@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Mounting a crafted UDF image with repeated partition descriptors can
trigger a heap out-of-bounds write in part_descs_loc[].

handle_partition_descriptor() deduplicates entries by partition number,
but appended slots never record partnum. As a result duplicate
Partition Descriptors are appended repeatedly and num_part_descs keeps
growing.

Once the table is full, the growth path still sizes the allocation from
partnum even though inserts are indexed by num_part_descs. If partnum is
already aligned to PART_DESC_ALLOC_STEP, ALIGN(partnum, step) can keep
the old capacity and the next append writes past the end of the table.

Store partnum in the appended slot and size growth from the next append
count so deduplication and capacity tracking follow the same model.

Fixes: ee4af50ca94f ("udf: Fix mounting of Win7 created UDF filesystems")
Cc: stable@vger.kernel.org
Signed-off-by: Seohyeon Maeng <bioloidgp@gmail.com>
---
 fs/udf/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 27f463fd1d89..3c3c645de0bc 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1694,7 +1694,8 @@ static struct udf_vds_record *handle_partition_descriptor(
 			return &(data->part_descs_loc[i].rec);
 	if (data->num_part_descs >= data->size_part_descs) {
 		struct part_desc_seq_scan_data *new_loc;
-		unsigned int new_size = ALIGN(partnum, PART_DESC_ALLOC_STEP);
+		unsigned int need = data->num_part_descs + 1;
+		unsigned int new_size = ALIGN(need, PART_DESC_ALLOC_STEP);
 
 		new_loc = kzalloc_objs(*new_loc, new_size);
 		if (!new_loc)
@@ -1705,6 +1706,7 @@ static struct udf_vds_record *handle_partition_descriptor(
 		data->part_descs_loc = new_loc;
 		data->size_part_descs = new_size;
 	}
+	data->part_descs_loc[data->num_part_descs].partnum = partnum;
 	return &(data->part_descs_loc[data->num_part_descs++].rec);
 }
 

base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
-- 
2.43.0


