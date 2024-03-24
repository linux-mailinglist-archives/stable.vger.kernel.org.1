Return-Path: <stable+bounces-31566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8642B88979A
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 10:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B81711C30BC7
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 09:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86E936B9EE;
	Mon, 25 Mar 2024 03:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRIbn3pv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533D4145330;
	Sun, 24 Mar 2024 23:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321974; cv=none; b=R49+OBlXu1DkelOzy8XBzXiiviMO1GZGzeyJa4EFi363BX/J8oEx5i+VPJC++HTNhZfSpg+KhkgWPgSgrLCqnSHUe8qo1mGipVgZS6XlWe4xomWpk0wzZnvLmNWzse7ZcV6L3J+KNozlKYaBPeUO/4TGciiZvzFU3tjEbLbWjFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321974; c=relaxed/simple;
	bh=vko/+J46uPjjVxQ7eGm2PmvehHWRDiGajfhump5oooI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apk+dRUfSdzTNfSbd7ZRRV9UapbIvgA2qOoBnylyXLrtOU0Ivnej6bRD3eXC3mAkYmtwmtjPCiolHE3X8+wRKv876KqLmpzEmntmIJS7qTTZldE/FwwV9buERx9EqNTf3LT0/M1PtGillDp5bZiLK3/i/Nieknglgg8GN+/O6Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRIbn3pv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CD9C433F1;
	Sun, 24 Mar 2024 23:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321973;
	bh=vko/+J46uPjjVxQ7eGm2PmvehHWRDiGajfhump5oooI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dRIbn3pvzprtefFl93j9Nxeoofnyb+muYHmLMo1v2LmkUoqSZxPQTjyU1B5qDastA
	 oPVtNJ8Ts2aw60o76o+9K3xxLzuW+bocpCCPmGL2rxHANU4BWVSsisRTjIRFCmqleD
	 JBgr1LTVDKEVIvDToeBFGfwDN0CBrHehp8hIsbuo4bC3CTCvRukd/VXdBqOq5rIlea
	 lnZpd7bDKNxLx2b7mVOBHw+YbgK/2t//kYdg7arZxqpBthONyQbA5kdGYynU1vz8OD
	 LEi1XklTFA26Ah+SSGYxar85gyFgWrLgOMOEkBtVPyNYJ/vP9ahTBf08Czlob3R1XS
	 O2MU9u0MrFlWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ranjan Kumar <ranjan.kumar@broadcom.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 045/451] scsi: mpt3sas: Prevent sending diag_reset when the controller is ready
Date: Sun, 24 Mar 2024 19:05:21 -0400
Message-ID: <20240324231207.1351418-46-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ranjan Kumar <ranjan.kumar@broadcom.com>

[ Upstream commit ee0017c3ed8a8abfa4d40e42f908fb38c31e7515 ]

If the driver detects that the controller is not ready before sending the
first IOC facts command, it will wait for a maximum of 10 seconds for it to
become ready. However, even if the controller becomes ready within 10
seconds, the driver will still issue a diagnostic reset.

Modify the driver to avoid sending a diag reset if the controller becomes
ready within the 10-second wait time.

Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
Link: https://lore.kernel.org/r/20240221071724.14986-1-ranjan.kumar@broadcom.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 809be43f440dc..8e6ac08e553bb 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -7398,7 +7398,9 @@ _base_wait_for_iocstate(struct MPT3SAS_ADAPTER *ioc, int timeout)
 		return -EFAULT;
 	}
 
- issue_diag_reset:
+	return 0;
+
+issue_diag_reset:
 	rc = _base_diag_reset(ioc);
 	return rc;
 }
-- 
2.43.0


