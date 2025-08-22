Return-Path: <stable+bounces-172472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8A5B320F7
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 19:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAA926404B3
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 17:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9BD285074;
	Fri, 22 Aug 2025 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I96DTUJx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFDEC2D1
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755882161; cv=none; b=SvL1r9O9YpKZLGv8infga7VNviPlzjK3RjawRAkX4e0CH89exDkDydyMVM6mrLHXUQF5sh2GAb48xyQOmTwJTdfWz7ZAh53d0pjt5W5INX9TabehR0i3HE7FOqb04T4KWin6D92esr0nfSYJWF0vgBf3W/T1FQERkHhV6Snzp94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755882161; c=relaxed/simple;
	bh=D9t2Mot2ybgK/gN56unRwvjV//HNZOQONuJfTKuevwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhWaikHePPzhdYquJjyQU/9YNbE0ZLpuH3bnJs3uWA7X0FYTJjdHaE/iPvZWh0Bc7xjvfWRgDAfTb4mH3UuTzvcIEgkdwvP+r0NEdSGb8RW7JBIr/nMj1Ckh5iTG01VB9gW0JjroX3HYoqmSnuUGTH1OGwQvqAortLeWP8eMoOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I96DTUJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CC2C4CEED;
	Fri, 22 Aug 2025 17:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755882160;
	bh=D9t2Mot2ybgK/gN56unRwvjV//HNZOQONuJfTKuevwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I96DTUJxc3X1fLnBwzfgSjxy+H1gywSxErAz6FxCuwK786PZx409scx5kZhGbGfNF
	 w+yN/qsJlIefoJHa99W+BwAEbH5p25+jRxL5p4guTJuVwjvdXymeITllGOUDlxmcs4
	 aD9K32s4NCu0aHpoVdd+AY0mxa7BbXRvma0LUrLTenV55+P+XRMRQTiRdPx+9EcrgU
	 KixO2F8yY8bmcHfex5tEbqDV6EkiG27mt81M9knwXKve4+QMkTXNOw4/p7QxsKZ/Na
	 t05Hh0vGMC6wX8jMH53MrUMu/VSOHiGhAiXHxtyuVOYc4LAxexFcbytEl4WriFyvyO
	 p+JAolXXyqQqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ranjan Kumar <ranjan.kumar@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] scsi: mpi3mr: Drop unnecessary volatile from __iomem pointers
Date: Fri, 22 Aug 2025 13:02:37 -0400
Message-ID: <20250822170238.1319698-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082106-padding-nucleus-d747@gregkh>
References: <2025082106-padding-nucleus-d747@gregkh>
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
index 26043e05ca30..b51f8911a630 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -714,7 +714,7 @@ struct mpi3mr_ioc {
 	char name[MPI3MR_NAME_LENGTH];
 	char driver_name[MPI3MR_NAME_LENGTH];
 
-	volatile struct mpi3_sysif_registers __iomem *sysif_regs;
+	struct mpi3_sysif_registers __iomem *sysif_regs;
 	resource_size_t sysif_regs_phys;
 	int bars;
 	u64 dma_mask;
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 3ef6b6edef46..3177953480a1 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -11,12 +11,12 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 
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


