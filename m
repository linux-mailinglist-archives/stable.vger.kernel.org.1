Return-Path: <stable+bounces-172431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7621B31C85
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD17060703F
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F501305E19;
	Fri, 22 Aug 2025 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmG8sQKN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5DE305E33
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873576; cv=none; b=FGX5cOYMQIp8GBq2+vpCJk1LM+vqcvgulGXLR2pFz0WIby1m3/7poxLLQiVld9I9BgSQm9NxWdhJexuXypbzlzWie4YSnMwqgkwHWh1ysdK0m9qZ01Z1dOX3ZiNqhHyPcwB/gCOfFGIncmq3wkDorTaJ4FFU4nvLd8T8xlxkZEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873576; c=relaxed/simple;
	bh=UPKlnTxnBu0d5NdiMA5AtuZxXEjujc9i5kIsbeWU6Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6sMpOj+MEl5BzqLJryxzrDpGq8cfvrEJqP3l8KgZg0S434Moko+ujeSZqipgRevKNX3uu6coU0YH+9V6RCVpsnYyEOyabNdt9xk/HgBVRkkO2QKM0eNzBEcuTr9GihzyOYbQslDdUR+vxURR1UO4beGhpzcJGpHzhFiuKEwIAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmG8sQKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B480C4CEED;
	Fri, 22 Aug 2025 14:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755873575;
	bh=UPKlnTxnBu0d5NdiMA5AtuZxXEjujc9i5kIsbeWU6Y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jmG8sQKNr4mO7emN9re6xNHfb8wE9IkTNOoUHczjinKwlKtj9ELh3MVP9VwXJC+DB
	 lTKwp/dJwh7rKGL75fXyPzynDERMwouRxANQdV6+2wdScJxv43RBB7/DqPvd3NuqIr
	 Qp8NfYQEiJVxgI6kEMIXh1ZXcg0+gq92675OR5VzUJey4ANbOgoOOBRot/EkCGxTbn
	 RCFgcYPpR2AmPa2oVWrTbJSNEr1GX1BLF+Jh/4CAvRDVAd/jRhm/OweBOMlhuaNtNj
	 LtNSDjkXO0fFSd81X2BA+YOa6HZ2Cr3FlRc4cirRYkQsPeAJ41n8C3Fb9nqGH/2v6w
	 l/BweIL4c3oog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ranjan Kumar <ranjan.kumar@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 1/2] scsi: mpi3mr: Drop unnecessary volatile from __iomem pointers
Date: Fri, 22 Aug 2025 10:39:31 -0400
Message-ID: <20250822143932.1267223-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082104-chunk-scoring-a931@gregkh>
References: <2025082104-chunk-scoring-a931@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ranjan Kumar <ranjan.kumar@broadcom.com>

[ Upstream commit 6853885b21cb1d7157cc14c9d30cc17141565bae ]

The volatile qualifier is redundant for __iomem pointers.

Cleaned up usage in mpi3mr_writeq() and sysif_regs pointer as per
Upstream compliance.

Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
Link: https://lore.kernel.org/r/20250627194539.48851-3-ranjan.kumar@broadcom.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: c91e140c82eb ("scsi: mpi3mr: Serialize admin queue BAR writes on 32-bit systems")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/mpi3mr/mpi3mr.h    | 2 +-
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index 9bbc7cb98ca3..bf272dd69d23 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -1185,7 +1185,7 @@ struct mpi3mr_ioc {
 	char name[MPI3MR_NAME_LENGTH];
 	char driver_name[MPI3MR_NAME_LENGTH];
 
-	volatile struct mpi3_sysif_registers __iomem *sysif_regs;
+	struct mpi3_sysif_registers __iomem *sysif_regs;
 	resource_size_t sysif_regs_phys;
 	int bars;
 	u64 dma_mask;
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 1d7901a8f0e4..fad94f2cc905 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -23,12 +23,12 @@ module_param(poll_queues, int, 0444);
 MODULE_PARM_DESC(poll_queues, "Number of queues for io_uring poll mode. (Range 1 - 126)");
 
 #if defined(writeq) && defined(CONFIG_64BIT)
-static inline void mpi3mr_writeq(__u64 b, volatile void __iomem *addr)
+static inline void mpi3mr_writeq(__u64 b, void __iomem *addr)
 {
 	writeq(b, addr);
 }
 #else
-static inline void mpi3mr_writeq(__u64 b, volatile void __iomem *addr)
+static inline void mpi3mr_writeq(__u64 b, void __iomem *addr)
 {
 	__u64 data_out = b;
 
-- 
2.50.1


