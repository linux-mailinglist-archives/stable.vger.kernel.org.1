Return-Path: <stable+bounces-11773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F1182FBD2
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 23:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78D38B29173
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 22:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D1516AF83;
	Tue, 16 Jan 2024 20:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhdhouRV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738CF4F883;
	Tue, 16 Jan 2024 20:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435490; cv=none; b=mHFI3lFZkUT14i7XFIT0R/h1FiKYomePXKJAyCSxG//H7XbDj0MnF01fGqd9Pou5iXQlg7KrsEP39hUfSN+dH6yd/CATDWtMst1N8zvKd/byBfBeLLPvFVwpokyKBumvAbEmUlNBqDMDEyVtIDhinoDQCeZ2uHnBwMfJQfulcs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435490; c=relaxed/simple;
	bh=BsNCB5s75Ia2nwYCOe4+Hd+1KH0th9BzZ7gx+esBGqk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=gKfScEjCJ3fqebxF9e0KDiVV9PUGa7tlclXkU80hHtki3rRDqf7PDnHQPa2/lW9/q/hmdkNdwik9ulNWDLMSz4eJffsjXJhROEShPo0mvXei9j+RIztpasx4v7fHOn1NldlURZlzopcnkml4H8Sfu48dcXGi7rJ8iy6jYwf6AZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhdhouRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E22AC433C7;
	Tue, 16 Jan 2024 20:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435490;
	bh=BsNCB5s75Ia2nwYCOe4+Hd+1KH0th9BzZ7gx+esBGqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lhdhouRVApVAva+tSnGH3yCNAQqL3i1qb5gYS7zf5T5/gwNpE6yq0nMpKFH9wcClR
	 85ztKG08/TjomAG1sW8sTcSGTsOaCAR/K6POsAuQx2etZKkguHavOfD0W4BGNQH6b9
	 R6tkLCEg1eFDu8Jd9pCmG7gpiQebnyKq+B4cegtwm2xkOifBU1+Oba+4Vj+2KcI2FK
	 pjLDhKEyM96fRdXXJG+AYjxSyTdyMqNuNgvATmtuO8xXYvxbyeT7XmpmVKSto1WV2Z
	 0WClLPXn5dOgrJ3X/XbOd6C0xUSF0JU74upP6fBPrPWwaD0pIIpidhmsCzCd0IDh2o
	 AXVxQNchBChKA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	jejb@linux.ibm.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 09/22] scsi: libfc: Fix up timeout error in fc_fcp_rec_error()
Date: Tue, 16 Jan 2024 15:04:03 -0500
Message-ID: <20240116200432.260016-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200432.260016-1-sashal@kernel.org>
References: <20240116200432.260016-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
Content-Transfer-Encoding: 8bit

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit 53122a49f49796beb2c4a1bb702303b66347e29f ]

We should set the status to FC_TIMED_OUT when a timeout error is passed to
fc_fcp_rec_error().

Signed-off-by: Hannes Reinecke <hare@suse.de>
Link: https://lore.kernel.org/r/20231129165832.224100-3-hare@kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/libfc/fc_fcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/libfc/fc_fcp.c b/drivers/scsi/libfc/fc_fcp.c
index 119117443496..faea7333c7e8 100644
--- a/drivers/scsi/libfc/fc_fcp.c
+++ b/drivers/scsi/libfc/fc_fcp.c
@@ -1697,7 +1697,7 @@ static void fc_fcp_rec_error(struct fc_fcp_pkt *fsp, struct fc_frame *fp)
 		if (fsp->recov_retry++ < FC_MAX_RECOV_RETRY)
 			fc_fcp_rec(fsp);
 		else
-			fc_fcp_recovery(fsp, FC_ERROR);
+			fc_fcp_recovery(fsp, FC_TIMED_OUT);
 		break;
 	}
 	fc_fcp_unlock_pkt(fsp);
-- 
2.43.0


