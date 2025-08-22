Return-Path: <stable+bounces-172443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8741B31CBB
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB27D5A33FF
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59792ECD23;
	Fri, 22 Aug 2025 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpJdmK1R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C51302747
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874005; cv=none; b=DKsMjrvjUSbTSiPpuhDf3YB4tuYtgLlwhIVs1gtzWIbZ3aDWpLP0fRGzw9DKqUc+oMTbIj7P/rYETYkg5Bqwh1Jj3FT82oodC5tWF2LYJzPoAgA7kjbmo5sckRAz1MjG24StEE8gHxmbgbNb5F4vyg4AbFTe2GflRlWjTRZ5tN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874005; c=relaxed/simple;
	bh=BmOhHpCiqGiLgBLyZDt+l/C8BBUbQ85O5ig/J2ZGAC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+jGbfyAUPJDWf0cMN7t+WxK8dIgxA7BWeVnFKbpilBcQPmJQttJFIAjHckQtEDrE7+arlglVK+xHeWdtxD/6k4i6l+oIoyxLj94fvG88NdpoEJu3djVVrmq4lELmbUcF2KtLYLFQD5qRYJ//XaiqYA0cOTolH4nipAVKfCAzx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpJdmK1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F51BC4CEED;
	Fri, 22 Aug 2025 14:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755874005;
	bh=BmOhHpCiqGiLgBLyZDt+l/C8BBUbQ85O5ig/J2ZGAC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mpJdmK1Rgi+lcLkRgq9trYm0399UHTcsbMI5xuSdOi/a2FgWDn3yBxxjUNmbMlXes
	 SXUp/64C3tEbiym1Bk1X8Tc83XFYXCg84OK9MWJvk2bD5PxB37QmU/tvLIZEsm325F
	 b5EI9sNEzFg75prcXNUUZZzpVtsV5kL9XCDAu8HWgTnUT7K/ewe/b5sa4GOQMZE0Dv
	 GlBzjK0SpPiz0ZFOM4aZimTb8MzWxJ49NkrI1R3yi/f9F572Wz7avhy58GHkZf/O68
	 EcFteIQ63y2BH99bZ1M5FkC6q5dl0zelco8PL0Y6hGQqfSpArX5arWFaB1spoTgWLE
	 7+RWDkiaTzpUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ranjan Kumar <ranjan.kumar@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] scsi: mpi3mr: Drop unnecessary volatile from __iomem pointers
Date: Fri, 22 Aug 2025 10:46:41 -0400
Message-ID: <20250822144642.1269932-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082104-negative-wildcat-59ac@gregkh>
References: <2025082104-negative-wildcat-59ac@gregkh>
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
index ab7c5f1fc041..162925a838b4 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -1175,7 +1175,7 @@ struct mpi3mr_ioc {
 	char name[MPI3MR_NAME_LENGTH];
 	char driver_name[MPI3MR_NAME_LENGTH];
 
-	volatile struct mpi3_sysif_registers __iomem *sysif_regs;
+	struct mpi3_sysif_registers __iomem *sysif_regs;
 	resource_size_t sysif_regs_phys;
 	int bars;
 	u64 dma_mask;
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 604f37e5c0c3..934f879fbbeb 100644
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


