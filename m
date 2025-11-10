Return-Path: <stable+bounces-192941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CCEC46714
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 13:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 333271885252
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 12:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC70313292;
	Mon, 10 Nov 2025 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3UYCpWZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB01E31327E
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775941; cv=none; b=CWfcfB9pXSNTPE2sRBenLxHttx6dlY22C7qXs2Xt5tdTI6sxzSKYf3zphzobDcG9jwnNf7mpbSCPtyrbNBGYT3S+EK0OCHH+s5zArxWTYxW4c6YPAMDzyjak74n9SNUsTzu9hGqJkGFQo1q8RF3nM6vsUCqM6lX6sczrXJCSc2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775941; c=relaxed/simple;
	bh=dGJNvQL3TFoMlsPMrbeM0XeJypWz+E4kpcXzocCRsik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0wjHI074zqCFyf6MIEpRzp617HdilyXIgFz94VuyotTGhWQAVJTwpidH9xm/SBWmQ8pScnMrBSRIbKi9z9uL4TAg96i7dkr+yd7fIcTLyNoW0XxLfKBuLlHU92sCr5Ld9tX0xhrvUKdfKIr3rLU6vCXrGZAXDPssLQJ1RAm1MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3UYCpWZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE50CC116D0;
	Mon, 10 Nov 2025 11:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762775941;
	bh=dGJNvQL3TFoMlsPMrbeM0XeJypWz+E4kpcXzocCRsik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G3UYCpWZeWsWClFhs10VFn8Bj4iUW0B8oFQglijqfLk7vA7M1CMteeCpALkJnV7BW
	 vHpSwBZ1mXhsj3Zba2xdM6X6t7UqgbfAFsq1BLrt2RzLBsIuGaPo/tigz/qpKuIWwx
	 HZoxqdLIQFVEBQmKWsJ3fjUQlZHo+HH5HdQrKS8dvjFosrO92niIEac+O4V+bwdjIX
	 l607rBLzdr2OwJi/f5bVHiwG7EJOsDoesKq2GlH+aXmjkKaOEYvRfT2IaL7sZps6bw
	 T3qtJLlFwvhI81YaoqqNYUxwgYJr0h+hdLduC0i0rJG86oxvpF2GX9GcyoTx9UGy4K
	 As+mWO6dOLelQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.1.y 1/3] scsi: ufs: core: Add a quirk to suppress link_startup_again
Date: Mon, 10 Nov 2025 06:58:57 -0500
Message-ID: <20251110115859.651217-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110916-yummy-cane-0741@gregkh>
References: <2025110916-yummy-cane-0741@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Hunter <adrian.hunter@intel.com>

ufshcd_link_startup() has a facility (link_startup_again) to issue
DME_LINKSTARTUP a 2nd time even though the 1st time was successful.

Some older hardware benefits from that, however the behaviour is
non-standard, and has been found to cause link startup to be unreliable
for some Intel Alder Lake based host controllers.

Add UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE to suppress
link_startup_again, in preparation for setting the quirk for affected
controllers.

Fixes: 7dc9fb47bc9a ("scsi: ufs: ufs-pci: Add support for Intel ADL")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20251024085918.31825-3-adrian.hunter@intel.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/ufs/core/ufshcd.c | 3 ++-
 include/ufs/ufshcd.h      | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index f9adb11067470..acdad8a79cc10 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4778,7 +4778,8 @@ static int ufshcd_link_startup(struct ufs_hba *hba)
 	 * If UFS device isn't active then we will have to issue link startup
 	 * 2 times to make sure the device state move to active.
 	 */
-	if (!ufshcd_is_ufs_dev_active(hba))
+	if (!(hba->quirks & UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE) &&
+	    !ufshcd_is_ufs_dev_active(hba))
 		link_startup_again = true;
 
 link_startup:
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 0a56374064856..54bcbfe66163e 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -592,6 +592,13 @@ enum ufshcd_quirks {
 	 * auto-hibernate capability but it's FASTAUTO only.
 	 */
 	UFSHCD_QUIRK_HIBERN_FASTAUTO			= 1 << 18,
+
+	/*
+	 * This quirk indicates that DME_LINKSTARTUP should not be issued a 2nd
+	 * time (refer link_startup_again) after the 1st time was successful,
+	 * because it causes link startup to become unreliable.
+	 */
+	UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE		= 1 << 19,
 };
 
 enum ufshcd_caps {
-- 
2.51.0


