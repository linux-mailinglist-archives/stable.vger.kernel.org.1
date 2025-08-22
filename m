Return-Path: <stable+bounces-172455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F543B31DFA
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 17:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43C3D58750C
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 15:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82521DE2A0;
	Fri, 22 Aug 2025 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h48IGlFr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682441DE2BD
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755875416; cv=none; b=rLwOn2o0oDFCqLSa3TU3YR5KKLjrvjtS6+lyM5EjIUOxXdg13lngxbDcGaGYVnTWkYS37OYzKWc4MRW6DHw45n/XMVE5fzjQkVun0wzSyM4FZyohAhHd+a+FP4ZbAHK/So7wO3hLUDoJee2+Fa6913Ta1JM1u84ThZhEO0acW5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755875416; c=relaxed/simple;
	bh=yUbdXKI8shrUADkl10HuNxlahNr9lsvPzwqaEL/WjYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScHTYQmS+/Akz4wM4wwa8+ozS6uAc8X5nSnJYDPQJ65Vc7jSAHNHiK4e/YsCAcpkrS/C1Rty+NyTKIjteM1siTZzNYhTQBOELuALQbtVrko3Z6gCZsLPpbyaQadI/0jNXj9FkqDTFZhVaMI4Itj6l/SlIKW87MbRHbTIe2W4n8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h48IGlFr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9404EC116C6;
	Fri, 22 Aug 2025 15:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755875416;
	bh=yUbdXKI8shrUADkl10HuNxlahNr9lsvPzwqaEL/WjYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h48IGlFrCY6ZrmOM8XVvtK50wBq1yDUmfvdIAH1b4MtMQV/fwUbif5csNrZRhykJ3
	 zFzAVkre1SH/10G3n7jaeE7PvXxy/AO6gnOY1jhociVuJoFVN/+Edqx235xfuiF0QT
	 bdnbifXEhsGhpH8hQsPJfKArfWFE0s2ShLFhZB9+AyzF5JUdbJVPcg2HJNBwjL9lOL
	 tc9kjNKIfivlpG476yuYhAa7amquHc0ztuqJ/5Zpoy2Bk2s7o4aKV3skzaU91HiZFQ
	 SMl+6wOVp8hUO/1GIEEIzYbFnP2+1T/5x/MQ8CzFJ1ITVVU5gxm8DGsor9w1o6JuUW
	 vlr2i0F0zdPIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ranjan Kumar <ranjan.kumar@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] scsi: mpi3mr: Drop unnecessary volatile from __iomem pointers
Date: Fri, 22 Aug 2025 11:10:12 -0400
Message-ID: <20250822151013.1280211-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082105-penalize-quadrant-9ad9@gregkh>
References: <2025082105-penalize-quadrant-9ad9@gregkh>
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
index de6914d57402..90c9a539768d 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -1035,7 +1035,7 @@ struct mpi3mr_ioc {
 	char name[MPI3MR_NAME_LENGTH];
 	char driver_name[MPI3MR_NAME_LENGTH];
 
-	volatile struct mpi3_sysif_registers __iomem *sysif_regs;
+	struct mpi3_sysif_registers __iomem *sysif_regs;
 	resource_size_t sysif_regs_phys;
 	int bars;
 	u64 dma_mask;
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 015a875a46a1..d2fcecf94eaf 100644
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


