Return-Path: <stable+bounces-168538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190A2B23539
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAD927B9C8F
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AB52CA9;
	Tue, 12 Aug 2025 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l8uMvSRf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2166A2EB5D2;
	Tue, 12 Aug 2025 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024506; cv=none; b=sWE8TJXn6tempJSJFMfVNSc1OVLzchHoROdirJHZEu+sjTe01CbBpdhCkzPL5PK3n6iSEiJN+ttnMo8bU9S3bWehWqhHO249bHBHcTgNVp3Ou9r6yymCl3uCE/cx0VpByc0W56M0FReQMa3uBK3YuNsrrLuN9EOjBmJDC2qSx30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024506; c=relaxed/simple;
	bh=bH/Qw99+CoZdl4UzrnG/m1PFeygRWrZIcIqh/IEBFpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxLC16FW7OTJ6TA9ayydd/eHEFGY5ZvQxr9dshBbeZCpxwiGbRWiSSxV6aK5Ke6iFj96cPvzBsMgGgPygaS6DVn7gHVW//4YHO8nzcMQkza6u3SKCPkp1Y8z/27XmoTbjEvqko1WRD/mGmcfLGeYfiZgmKKqrY1YnjekxMHoVkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l8uMvSRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C7BC4CEF0;
	Tue, 12 Aug 2025 18:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755024506;
	bh=bH/Qw99+CoZdl4UzrnG/m1PFeygRWrZIcIqh/IEBFpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l8uMvSRfE+YrheN5k9TwIJwaNPdxXOH2UAKGpDSFJqoVuRybY+/iIaTx7jpBx2p6j
	 +xZQXDB7bygpBpkjZJepT7hs13IcPXLO6vYhNt6fjwDuQSiPEKDGQfO/6Dl9+3KFSM
	 KO4tjVl6jXyVP96CHMWw5VygFTHg5NZk4B+wP43I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Fourier <fourier.thomas@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 394/627] scsi: isci: Fix dma_unmap_sg() nents value
Date: Tue, 12 Aug 2025 19:31:29 +0200
Message-ID: <20250812173434.284274507@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Fourier <fourier.thomas@gmail.com>

[ Upstream commit 063bec4444d54e5f35d11949c5c90eaa1ff84c11 ]

The dma_unmap_sg() functions should be called with the same nents as the
dma_map_sg(), not the value the map function returned.

Fixes: ddcc7e347a89 ("isci: fix dma_unmap_sg usage")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Link: https://lore.kernel.org/r/20250627142451.241713-2-fourier.thomas@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/isci/request.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/isci/request.c b/drivers/scsi/isci/request.c
index 355a0bc0828e..bb89a2e33eb4 100644
--- a/drivers/scsi/isci/request.c
+++ b/drivers/scsi/isci/request.c
@@ -2904,7 +2904,7 @@ static void isci_request_io_request_complete(struct isci_host *ihost,
 					 task->total_xfer_len, task->data_dir);
 		else  /* unmap the sgl dma addresses */
 			dma_unmap_sg(&ihost->pdev->dev, task->scatter,
-				     request->num_sg_entries, task->data_dir);
+				     task->num_scatter, task->data_dir);
 		break;
 	case SAS_PROTOCOL_SMP: {
 		struct scatterlist *sg = &task->smp_task.smp_req;
-- 
2.39.5




