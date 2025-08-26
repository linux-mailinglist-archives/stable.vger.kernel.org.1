Return-Path: <stable+bounces-173598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA74B35E31
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120A21BA323D
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5B229BD98;
	Tue, 26 Aug 2025 11:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VrUDvePn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3557D341AD9;
	Tue, 26 Aug 2025 11:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208666; cv=none; b=G3M7wQ9FWoPQYRcqDKUQ/Lf0LAlAZzm0E8ARl2qylrjmx1ogPzIFvt680GqyEAsOUxQ+Qi9ZBCeTLjB5YJUH1aekyMn+OsDIs7SCGSefJE5IMd7Cl2A+ha3PAa+2/WUEKbU4seOlF6dz8zjyrk/W99n0dqKLhIwy/6775l+Samo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208666; c=relaxed/simple;
	bh=C8lzl70f0ZPi8eVStHUP/FHx6Q5KwgTvps/MOjf9nvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQTN8MssSe4luZSbkQTchlOo4TB7MjjVUyRVuni2FHoJXFShJnXappTH2PoZypS9nsMkxne9SbZ1CzPxaFo6AjFNKOdKz9aDbeHIRjVToZclSlXI5yBBdVAWAOS9o69Lt5Z99EG66itp6m6Px5WEFcPNYU67yxsd7EOPg7Z//rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VrUDvePn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8296DC4CEF4;
	Tue, 26 Aug 2025 11:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208665;
	bh=C8lzl70f0ZPi8eVStHUP/FHx6Q5KwgTvps/MOjf9nvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VrUDvePnGwtMy9P7uFUkIqVxUWneH18e8OBbBkcpszIF3GFF+FKZFjoAN6AszctLb
	 Kc4VHIhvDHWCe1PLvb8oa2BoO4VzDlK5d+iSyQbPOGr3314L98Gaq3IXj3S+xBJ9gR
	 pFtDVJSSC1AcvXZp63ozY1fgv+3+zKIkI7nTYrQg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ranjan Kumar <ranjan.kumar@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 198/322] scsi: mpi3mr: Drop unnecessary volatile from __iomem pointers
Date: Tue, 26 Aug 2025 13:10:13 +0200
Message-ID: <20250826110920.756093437@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
References: <20250826110915.169062587@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/mpi3mr/mpi3mr.h    |    2 +-
 drivers/scsi/mpi3mr/mpi3mr_fw.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

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
 



