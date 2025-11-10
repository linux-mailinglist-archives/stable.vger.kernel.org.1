Return-Path: <stable+bounces-192939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27465C466F6
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 13:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2B63BF5DA
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 12:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF9330DEA9;
	Mon, 10 Nov 2025 11:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FR+i4fjH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0D330DD2C
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 11:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775937; cv=none; b=ursFSHlamX/EFq87dqhkFXlIXh4cuc/Za9tjXSb3k6mV217BNqvCKeUihB8WaPEWYZnfJ4yiBGHdxbgSQkOC7jlXtl/OwFHt/g+T6K9oyu40NcmV0SEMha7XK7Wk98CLM4cmVsaq9xg1yOSW9WBFHpBcSCNyb3ze1cLh7LSxOOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775937; c=relaxed/simple;
	bh=urzWP9HaUVShdAi2zyjCLbRkfrdpe71cZ/4ayv1H52M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qx70ihyXp++pEX4S2gQlA+MVn4jF8WvRs70cMH5173Veesldvw8oBM88kljZskaXwWPniOreohB6rCJZQXJxZGPkiR4L0kPnmId1SdxT9DSiX225eww5UsgXsYvIIXHpKWtQNrsT7O/A2EjpoJJ0Rd9/PDCAS3PXpPE29UWbzp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FR+i4fjH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36227C4CEF5;
	Mon, 10 Nov 2025 11:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762775936;
	bh=urzWP9HaUVShdAi2zyjCLbRkfrdpe71cZ/4ayv1H52M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FR+i4fjHia3zE+49T2ria2Iwo8tMoeXJFiJj3HPJ9Z8Bg7tFH4yMfimeVTFOIpsPh
	 7rJ3AfPDrZjiOupNu5ojL7I4hxc71ZsBHYi90hEVbo/UaIGi3fH0qJSmL6yVmGcnBE
	 O+sdQS6NGXVDcnI+O8wHq4StQMCrdzFRFlpsTYTVeuaWEBsX7WBk/qtarfJfe+G86H
	 o6WOACyMMfJTizBpdD1yl7YWFKMXQ0W5iVPCyR+EkTH6ZXd0U2d7T6tjpI6Rw7EJqH
	 OuIHgUhRP5h1lQwdE2gI4FMYUcRRO3dzBZDAJpw2PLua1VyqoUuKI5ktm+wRLGT9Er
	 MRUaWgOB7E3MQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Amit Pundir <amit.pundir@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 6/7] scsi: ufs: core: Add a quirk for handling broken LSDBS field in controller capabilities register
Date: Mon, 10 Nov 2025 06:58:47 -0500
Message-ID: <20251110115848.651076-6-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110115848.651076-1-sashal@kernel.org>
References: <2025110906-retrieval-daunting-5fa7@gregkh>
 <20251110115848.651076-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

[ Upstream commit cd06b713a6880997ca5aecac8e33d5f9c541749e ]

'Legacy Queue & Single Doorbell Support (LSDBS)' field in the controller
capabilities register is supposed to report whether the legacy single
doorbell mode is supported in the controller or not. But some controllers
report '1' in this field which corresponds to 'LSDB not supported', but
they indeed support LSDB. So let's add a quirk to handle those controllers.

If the quirk is enabled by the controller driver, then LSDBS register field
will be ignored and legacy single doorbell mode is assumed to be enabled
always.

Tested-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20240816-ufs-bug-fix-v3-1-e6fe0e18e2a3@linaro.org
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: d34caa89a132 ("scsi: ufs: core: Add a quirk to suppress link_startup_again")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 6 +++++-
 include/ufs/ufshcd.h      | 8 ++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 6990886a54c5d..8e24cdc8a29b9 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2365,7 +2365,11 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
 	 * 0h: legacy single doorbell support is available
 	 * 1h: indicate that legacy single doorbell support has been removed
 	 */
-	hba->lsdb_sup = !FIELD_GET(MASK_LSDB_SUPPORT, hba->capabilities);
+	if (!(hba->quirks & UFSHCD_QUIRK_BROKEN_LSDBS_CAP))
+		hba->lsdb_sup = !FIELD_GET(MASK_LSDB_SUPPORT, hba->capabilities);
+	else
+		hba->lsdb_sup = true;
+
 	if (!hba->mcq_sup)
 		return 0;
 
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 40b457b4c831e..dac568503e905 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -670,6 +670,14 @@ enum ufshcd_quirks {
 	 * the standard best practice for managing keys).
 	 */
 	UFSHCD_QUIRK_KEYS_IN_PRDT			= 1 << 24,
+
+	/*
+	 * This quirk indicates that the controller reports the value 1 (not
+	 * supported) in the Legacy Single DoorBell Support (LSDBS) bit of the
+	 * Controller Capabilities register although it supports the legacy
+	 * single doorbell mode.
+	 */
+	UFSHCD_QUIRK_BROKEN_LSDBS_CAP			= 1 << 25,
 };
 
 enum ufshcd_caps {
-- 
2.51.0


