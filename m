Return-Path: <stable+bounces-192877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D748C44ADB
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 01:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234C2188BA6E
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 00:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA09518A6B0;
	Mon, 10 Nov 2025 00:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3FBOM1F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790692AD1F
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 00:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762735678; cv=none; b=grlTsXbs8dPCuZpQE2nP2Ub4L0/LCvPvN2v291q+JBqRQf/+bhNMWSab9TgbVvhwbko2WPv1Viir54Zu9JNtSrIiz/zNmbwLfPFWdL6DAX5pOJbYkuwyH0d02vcQxUb1I5W3C3m8b9vB/XiSQggFhqgwIQ+sRt3/k9g5t3ThZI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762735678; c=relaxed/simple;
	bh=W6c2UhKocdK/+0iKKLFi7KlFH6o6Ma7wfKJtmd3V4/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWfoyINSr/OwKYsdTTSSk8kB9S3HyzKyPsRM4SWgGiUidwyiyOnFdZtjeEWuE5ovros0qc2rJUEDj8u/cODr7srdO6zn/wGoD4aoeoyP+H2YcAwD6HQnVzyxe9O6+KeKnYSHzOpQ+bg0ifHqgUHbyBbP7FwkaEPeuHwT2VMPquw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3FBOM1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AF5C113D0;
	Mon, 10 Nov 2025 00:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762735678;
	bh=W6c2UhKocdK/+0iKKLFi7KlFH6o6Ma7wfKJtmd3V4/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B3FBOM1Fs6w77blJfZXHPXgrcILRAj4Ji05j/P88JourSYO02YxCrmm13+BUhh2ds
	 W1K9eqaVAsVVnOesmXcgNIqGo2wvWfg4Jq+5l6xmjNcVpjqC261PRCf8Np4jIXzXyA
	 2by3hjM9QYSTi2zLVFopDbHAMgJ0otsLZO9LiRo6Hht1xVOCsAPr+ET+R9pC9EbACB
	 nevCLSKupC24k4hk2XAWkAs+5n4vKjrXnleKkZGnkVo28I6fwNn5mmRMhBhLqkBnOd
	 Z/iREdOAsGhew6m9kchn17MUCiGIWmXHuqI+teblu5b+cmcQ4gIcfaEH/ZOD0bPjVi
	 7HKirnH9Ept/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Amit Pundir <amit.pundir@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 6/8] scsi: ufs: core: Add a quirk for handling broken LSDBS field in controller capabilities register
Date: Sun,  9 Nov 2025 19:47:48 -0500
Message-ID: <20251110004750.555028-6-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110004750.555028-1-sashal@kernel.org>
References: <2025110940-control-hence-f9a8@gregkh>
 <20251110004750.555028-1-sashal@kernel.org>
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
Stable-dep-of: d968e99488c4 ("scsi: ufs: ufs-pci: Set UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE for Intel ADL")
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


