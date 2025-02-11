Return-Path: <stable+bounces-114758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4B2A3003C
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D081669D3
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 01:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6981E9B1A;
	Tue, 11 Feb 2025 01:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pa3fgOMZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B2D1E9B14;
	Tue, 11 Feb 2025 01:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237428; cv=none; b=qSg9VepGbZYP/5L15S8LjIENzII2QuwDrdoDHaEzdlcTbNgOsqONdS284r3Ikp4sbBdgnKhkToKUqU+8a7a3VFLlOT7dbJpvXJ29+g+g20ieuMSUuDYGge2jrBL1TXq3zJ3CI8kbPR8wH5c2mtQDCzi8ntOAFy39hVhLJYEfMik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237428; c=relaxed/simple;
	bh=2p3d9rcWhiRUyaYYBIzZpSMMGDD62ma37zHkTzTzjz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dlid4QBre0D+OH+PPWoQbfuisgclyEHSGxEnUVF4wgSJCfYdHfGke2m3LcM7CyZY7M6v5rQA6ziMlZMc0jS8ypxu9/+ZBgRaQbYklojvGvLyS9OB8w+5BKJXTufJcSaej++jWqvtCuFX4v+7ztMupOZX+yVJIxva0Z/1iZpZCFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pa3fgOMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098FBC4CED1;
	Tue, 11 Feb 2025 01:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237428;
	bh=2p3d9rcWhiRUyaYYBIzZpSMMGDD62ma37zHkTzTzjz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pa3fgOMZmFk/kiD27ROk2GIE1VhugF6l+2sL2za0rM5yCUQLMdymy476gcgXrciSb
	 z2WnwI/Jljh6JdbryPLXD2IuCDYzc2WFttx27DkYmqx2/AO1ptcx4gw3EMta9/9+Mc
	 DjUSYUXiR5xMxM9qHzugG+uoWhguooe5D/NR/YUzMJWqPIZef2dTD2EXMHw6tC5nTF
	 QFMD6msU/jzdiuSA4kMGwVc29LxDoH24rCH17wJTMUvpSzR5QIGY0bdDOIqxqK+pg1
	 tvLbkuSBrojpeHtbUGmhJ8jKU11D39rGOcPs9s6RbhSqKRI7ESZhODiqHx6wc65SsC
	 vLCESg81heLyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Magnus Lindholm <linmag7@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	mdr@sgi.com,
	James.Bottomley@HansenPartnership.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 14/21] scsi: qla1280: Fix kernel oops when debug level > 2
Date: Mon, 10 Feb 2025 20:29:47 -0500
Message-Id: <20250211012954.4096433-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211012954.4096433-1-sashal@kernel.org>
References: <20250211012954.4096433-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.2
Content-Transfer-Encoding: 8bit

From: Magnus Lindholm <linmag7@gmail.com>

[ Upstream commit 5233e3235dec3065ccc632729675575dbe3c6b8a ]

A null dereference or oops exception will eventually occur when qla1280.c
driver is compiled with DEBUG_QLA1280 enabled and ql_debug_level > 2.  I
think its clear from the code that the intention here is sg_dma_len(s) not
length of sg_next(s) when printing the debug info.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
Link: https://lore.kernel.org/r/20250125095033.26188-1-linmag7@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla1280.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index 8958547ac111a..fed07b1460702 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -2867,7 +2867,7 @@ qla1280_64bit_start_scsi(struct scsi_qla_host *ha, struct srb * sp)
 			dprintk(3, "S/G Segment phys_addr=%x %x, len=0x%x\n",
 				cpu_to_le32(upper_32_bits(dma_handle)),
 				cpu_to_le32(lower_32_bits(dma_handle)),
-				cpu_to_le32(sg_dma_len(sg_next(s))));
+				cpu_to_le32(sg_dma_len(s)));
 			remseg--;
 		}
 		dprintk(5, "qla1280_64bit_start_scsi: Scatter/gather "
-- 
2.39.5


