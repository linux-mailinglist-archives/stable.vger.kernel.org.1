Return-Path: <stable+bounces-172452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CCDB31DCA
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 17:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EE47643BE4
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 15:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3958E345747;
	Fri, 22 Aug 2025 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeM7n8eD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC65834573B
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 14:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874785; cv=none; b=GyZTLwB1YhFGqh2oH0R1LisujnRasJOo6bR8JvJIYs4SJmNmbEmtwwtj2IZ03bR3cOyShqFYqILIgHqc797Uu9C1lUhIazv56ye6kvHlJDk7V2LIBsSUzLxIQWRyMQvL502Y3LvXnQAxzW/LIGa98LJyOYmY1Oc08LzJwbgun/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874785; c=relaxed/simple;
	bh=wRn52gUw16H5P8Dlo2WdAg0jKw8gW3Kt5Ks7P++7coE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrHxboW2VTxB5Zpf2/34xK5XtB1f70L8yZPbnzlQ6jkFZvBh+TFv4fNu4u2tvtVKJUbTHd808pH+W1vhwE6yjKqDfKq+dtRiehn8jA/9KZ9jzwIx4HLw2mfJbRe1r+iMD8xkOeqYcO4fYUAdbW/xLUhwqkdDERKPWbwMFE8ks6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeM7n8eD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6063C4CEED;
	Fri, 22 Aug 2025 14:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755874785;
	bh=wRn52gUw16H5P8Dlo2WdAg0jKw8gW3Kt5Ks7P++7coE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EeM7n8eDBn5fCXSn+nZ+Qcfsf8xyOZbW3zaxwHgcmvTvNtNsaYyVZ3N+ktr/S3430
	 k02lYc4JNycWB6J1yCU29YsjA4ZuXh9Jh+n+khea0Jjq91ESHX4+9SHRo4N8MBBhsG
	 UrcQs67uX/x4DdCQAyw9nJS0v/jRiIv9aEY72MlS4mbaKHrG5DHTFcA0XLWFYkQaGw
	 dpYtZRV6SpY7SdpE7CRd/P203pNqgE4ZajfKJLcNtEYUDuz93s/NTFxwhkHiI9vbRi
	 imuJ4lfFGzoBeZANcIe4Xvne2hQEqvuU5o30wA09YQajysDyvYq02U3NCoJkXrqAv5
	 SgEj8N/QXaGZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ranjan Kumar <ranjan.kumar@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] scsi: mpi3mr: Drop unnecessary volatile from __iomem pointers
Date: Fri, 22 Aug 2025 10:59:41 -0400
Message-ID: <20250822145943.1276044-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082105-fit-porridge-a9dc@gregkh>
References: <2025082105-fit-porridge-a9dc@gregkh>
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
index ae98d15c30b1..9a896ff66e9f 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -1055,7 +1055,7 @@ struct mpi3mr_ioc {
 	char name[MPI3MR_NAME_LENGTH];
 	char driver_name[MPI3MR_NAME_LENGTH];
 
-	volatile struct mpi3_sysif_registers __iomem *sysif_regs;
+	struct mpi3_sysif_registers __iomem *sysif_regs;
 	resource_size_t sysif_regs_phys;
 	int bars;
 	u64 dma_mask;
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 60714a6c2637..bd3d22a07147 100644
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


