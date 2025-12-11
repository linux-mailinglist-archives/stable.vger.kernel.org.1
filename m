Return-Path: <stable+bounces-200739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 83113CB3D25
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 20:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F5313008320
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 19:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EC222B8CB;
	Wed, 10 Dec 2025 19:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dOVR9coe"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D4442AA9
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765393617; cv=none; b=CQUa7SsBTb5lPw9ExmYbf+2Bd3c/q7WTwEQSjcI/7VgNTaArH05y8cPsiw3GVPu2UpcwbQKMvrv3Fa6KRN6EAGu9pBTfKuxCPLG9kFc4+yfhk9Nq1FVX2zKuIG5LpmWmhRn9rmfEZ15+3IKK8dlV86VnAykM3DwPR5MYb2a2AjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765393617; c=relaxed/simple;
	bh=M910zPYCc8Xj/Y4kIrtPF4owFsRLDo2SrbCALfoImwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nXf8gsPLNAyWal8RyMnniKQMJ+zDKwKAIKaZP0qewV0jR4U3FgpKNc+AyGuEzkyle9vpnSKkjlWhH/GGVU89A9L1BxicIAMKCmFUBObq1VGxS+FkpkAYWd/imYvfV3VtLjdCYSuvVQT1Pre/DG6aS7UfemYFrB1OXmhd/+H1Bw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dOVR9coe; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-340e525487eso138652a91.3
        for <stable@vger.kernel.org>; Wed, 10 Dec 2025 11:06:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765393615; x=1765998415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kF0ZTPTh6C8GEz16r9dHrE7VVMeg5FEEbJe17ZjuCwQ=;
        b=bHzcdHipTpE26tJyqm/JOOOp6RwefSItcIK6RITV10tVGIl/lLgYAyl2qV9S245iuV
         NMxQ5mWgr/wDxRd+6row2AR98qElGGq3FVjfJrgvnpfafmWXg7lQ6ITLGK92/JBSM7Yt
         ymCIf8rKPZZ5NefuRe10B9D6GYRZe9YLvAV/DiamXnF19kFTqh6NJ1z8W/NmDLu1u/Y2
         L8BWxb/RvNz4brVb6XgeYvin77mb0WsFaYEzNp27WXRyv3+soQxhfpNyj5JWqiiM3jOQ
         euWyMACcGb9Z2W4/uK1OMRqT2wo3fWSPRgLUD65i/KtkeNYPT5AhaqrBRMhkX9i4aIWV
         7JrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvjHXvkC7fRXYbO7ohAZRWXOMFUmZEHcqqoJS/wYaz8WrM5/ly5xL3Hn6C0A1Goz3lo2xGN8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH4jJPnnKSu7wNA0Zorjr6cR6UrMtgd0CQIQYjSG83GAgfoKUj
	nHKanJ1SnNAxLyHt9V6ny6GdSOhFcWvb5nlLJDjMG1LDay7lkXUqQ3Nbm2um0dqzA03ZzWfTPsS
	/8NmjOqexOUUPhY698fQ+2nBYVF5giN+OvL8WRrLPw/K7Z/bImyxZc8tJuL1IAggCxoDKJIgqey
	Hf/sfrXvZT9E+YVqoSgMgWqqvStsbWei9AD+Qfig+TZ/UbihdgnTmHx3Q4HOJQTt7rbEWc7FZ3T
	rRy6Si6lpaVOkXML78=
X-Gm-Gg: AY/fxX7BnoT6dYsAejK4Toa16loAA3qXLbv+6FeIGZsNAjZcLw1md+4SL9bgf7wUeaJ
	RbCzf8hVp26oh7Yy2vpOhlXhcTW6Y72ZdL2uAt9MHk5cvjOvY35ne0/SMWb2bzVzYKiF7AFnZp1
	tcx/Ke2yGrvXtFjYfZNIp35om7pt83GYsDjx109PKWsfcBKsdwg5lNUuu2mcHs6IqN3BM8CdITU
	8TSmTh1odUfYnyYuUtFFUOD75Hhkp4wwMmV18+f/e50omZpZMS5854ArUrpfp0HF1VcZynTLJNg
	xXPzC6PVu7D8mh+UECSsFu5F9AZPovsSHhdFVIXAzKoeTSvJehrC9wuci1xOK/6ScQKBwuadVtd
	7xm/4FINqH6i59XHYTbVNA3+3bHbfFqxnVEItZ/77n8LrDJv0/C6S1knz2swZL18tYsNj3UFeEN
	uZP6qVfd5Cr5kIEAL/hA6ZUMX8uYxrJ6pXDc+wZkimc56fEWNJH+VcIeM=
X-Google-Smtp-Source: AGHT+IEPPJfyQAqCVUzD1cRJtM5lgIV+QZ4ljhQPCelIDC3bEMdd1BsjjWlNxoR5EguIU4+//WcX4sFtndun
X-Received: by 2002:a17:90b:57e6:b0:343:e461:9022 with SMTP id 98e67ed59e1d1-34a7287a489mr2961262a91.24.1765393615531;
        Wed, 10 Dec 2025 11:06:55 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c0c33ff3467sm27014a12.12.2025.12.10.11.06.55
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Dec 2025 11:06:55 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7b9090d9f2eso236977b3a.0
        for <stable@vger.kernel.org>; Wed, 10 Dec 2025 11:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1765393614; x=1765998414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kF0ZTPTh6C8GEz16r9dHrE7VVMeg5FEEbJe17ZjuCwQ=;
        b=dOVR9coewYVjoADpQ1WVWYWMhssvEgX2TvDZbSyoJqJPOzDxrZVyAE3g7EGQ+N282b
         KVpCbzrv73MsLwjcmRVi22Phisk/MRs/bDx0YTCvO/ULEbpbvwylmNSrzAakZTCqo9Fb
         IRjzfr7SPg+80JXYD99ng8vnB2/nFlwAtfyfg=
X-Forwarded-Encrypted: i=1; AJvYcCXSR+7ei1Phn2OMrm/H6a72mZSYTeKl9CcEUp5BDxPBlvDRgHO6j3Df+AhEVjnP3REBSSGOhoE=@vger.kernel.org
X-Received: by 2002:a05:6a20:94c7:b0:34a:f63:59dd with SMTP id adf61e73a8af0-366e2b8df78mr3542719637.51.1765393613945;
        Wed, 10 Dec 2025 11:06:53 -0800 (PST)
X-Received: by 2002:a05:6a20:94c7:b0:34a:f63:59dd with SMTP id adf61e73a8af0-366e2b8df78mr3542697637.51.1765393613541;
        Wed, 10 Dec 2025 11:06:53 -0800 (PST)
Received: from dhcp-10-123-98-253.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c22842dasm277337b3a.12.2025.12.10.11.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 11:06:53 -0800 (PST)
From: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To: linux-scsi@vger.kernel.org
Cc: sathya.prakash@broadcom.com,
	ranjan.kumar@broadcom.com,
	Chandrakanth Patil <chandrakanth.patil@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH] mpi3mr: Read missing IOCFacts flag for reply queue full overflow
Date: Thu, 11 Dec 2025 05:59:29 +0530
Message-ID: <20251211002929.22071-1-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The driver was not reading the MAX_REQ_PER_REPLY_QUEUE_LIMIT
IOCFacts flag, so the reply-queue-full handling was never enabled
even on firmware that supports it. Reading this flag enables the
feature and prevents reply queue overflow

Fixes: f08b24d82749 ("scsi: mpi3mr: Avoid reply queue full condition")
Cc: stable@vger.kernel.org
Signed-off-by: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
---
 drivers/scsi/mpi3mr/mpi/mpi30_ioc.h | 1 +
 drivers/scsi/mpi3mr/mpi3mr_fw.c     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/scsi/mpi3mr/mpi/mpi30_ioc.h b/drivers/scsi/mpi3mr/mpi/mpi30_ioc.h
index b42933fcd423..6561f98c3cb2 100644
--- a/drivers/scsi/mpi3mr/mpi/mpi30_ioc.h
+++ b/drivers/scsi/mpi3mr/mpi/mpi30_ioc.h
@@ -166,6 +166,7 @@ struct mpi3_ioc_facts_data {
 #define MPI3_IOCFACTS_FLAGS_SIGNED_NVDATA_REQUIRED            (0x00010000)
 #define MPI3_IOCFACTS_FLAGS_DMA_ADDRESS_WIDTH_MASK            (0x0000ff00)
 #define MPI3_IOCFACTS_FLAGS_DMA_ADDRESS_WIDTH_SHIFT           (8)
+#define MPI3_IOCFACTS_FLAGS_MAX_REQ_PER_REPLY_QUEUE_LIMIT     (0x00000040)
 #define MPI3_IOCFACTS_FLAGS_INITIAL_PORT_ENABLE_MASK          (0x00000030)
 #define MPI3_IOCFACTS_FLAGS_INITIAL_PORT_ENABLE_SHIFT		(4)
 #define MPI3_IOCFACTS_FLAGS_INITIAL_PORT_ENABLE_NOT_STARTED   (0x00000000)
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 8fe6e0bf342e..8c4bb7169a87 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -3158,6 +3158,8 @@ static void mpi3mr_process_factsdata(struct mpi3mr_ioc *mrioc,
 	mrioc->facts.dma_mask = (facts_flags &
 	    MPI3_IOCFACTS_FLAGS_DMA_ADDRESS_WIDTH_MASK) >>
 	    MPI3_IOCFACTS_FLAGS_DMA_ADDRESS_WIDTH_SHIFT;
+	mrioc->facts.max_req_limit = (facts_flags &
+			MPI3_IOCFACTS_FLAGS_MAX_REQ_PER_REPLY_QUEUE_LIMIT);
 	mrioc->facts.protocol_flags = facts_data->protocol_flags;
 	mrioc->facts.mpi_version = le32_to_cpu(facts_data->mpi_version.word);
 	mrioc->facts.max_reqs = le16_to_cpu(facts_data->max_outstanding_requests);
-- 
2.47.1


