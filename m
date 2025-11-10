Return-Path: <stable+bounces-192878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F29C44AE0
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 01:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 212784E1A2F
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 00:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA43E1A704B;
	Mon, 10 Nov 2025 00:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDWamk3O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ABB2AD1F
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 00:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762735679; cv=none; b=QRZzTEL08iOQr7Y1i6Lo9VjzjAJhnOIX6P5uNoxDWFOoeBruLF9k/vSMxRpr2BQcn83MY/F3mcf0iCTj82PcTzjRkLnV3+o2KHA+/gtlNerUnsNvFCYG9mDy+X8LxshGz1wzepcicTKewldXYpOBaKbI85kJhot9bvkrRlbGbtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762735679; c=relaxed/simple;
	bh=OLFIlifsLWvlB71NgUvJKEJ2dVJWPX0Qawv1vuf28WM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zu2FnmOKJTMbW1rVa+SdGooOJqb7SC3ZtPuys/b/yuC5i9wbJ17ftP0L7Q6XmUJWrnlhUgU5LxncNJR5l44MfNItjqbdcRllX2jtRAeBTYoEfKGPJ4jzmGRIGQtKaYfXrf6+cBL9aBgZrt+4JcaYS1zm3y/+3CO3p2QWXO2uLR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDWamk3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99986C4CEF7;
	Mon, 10 Nov 2025 00:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762735679;
	bh=OLFIlifsLWvlB71NgUvJKEJ2dVJWPX0Qawv1vuf28WM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tDWamk3OoeblPdsjsy2JBh3zI20rc9oj0jtb5L/GU/hZ6JBEmM8usQkZME0Q3ZOF4
	 /aEfnMIWZDQXgeg/tKjw+ta7O6F3cDEU6wVGtnj9OK5YJGLk6Ca3XAUYCdh7fbiuz8
	 rmnpWL7xNp0U2fD79/rIars0DzX2z54sg5kPaL7HshRZ6tKkoHVkmshrJiFPjmXhFq
	 J0Mg+Sw3w6e7p7Ypy1oivDzun4MshrpOMn8inNBrVOOqtFtnj+YZ0qjv7m4hsniPMB
	 +cOXxTeMAScKHyg1lfuwrzHeBWRXJEALrimO9SpBmgZThEXw7kXhSJQRlvp2tFE7CX
	 uF822s3kcdOOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 7/8] scsi: ufs: core: Add a quirk to suppress link_startup_again
Date: Sun,  9 Nov 2025 19:47:49 -0500
Message-ID: <20251110004750.555028-7-sashal@kernel.org>
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

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit d34caa89a132cd69efc48361d4772251546fdb88 ]

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
Stable-dep-of: d968e99488c4 ("scsi: ufs: ufs-pci: Set UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE for Intel ADL")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 3 ++-
 include/ufs/ufshcd.h      | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 8e24cdc8a29b9..fcaf4b9c950e4 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4977,7 +4977,8 @@ static int ufshcd_link_startup(struct ufs_hba *hba)
 	 * If UFS device isn't active then we will have to issue link startup
 	 * 2 times to make sure the device state move to active.
 	 */
-	if (!ufshcd_is_ufs_dev_active(hba))
+	if (!(hba->quirks & UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE) &&
+	    !ufshcd_is_ufs_dev_active(hba))
 		link_startup_again = true;
 
 link_startup:
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index dac568503e905..3e81a2168d704 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -678,6 +678,13 @@ enum ufshcd_quirks {
 	 * single doorbell mode.
 	 */
 	UFSHCD_QUIRK_BROKEN_LSDBS_CAP			= 1 << 25,
+
+	/*
+	 * This quirk indicates that DME_LINKSTARTUP should not be issued a 2nd
+	 * time (refer link_startup_again) after the 1st time was successful,
+	 * because it causes link startup to become unreliable.
+	 */
+	UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE		= 1 << 26,
 };
 
 enum ufshcd_caps {
-- 
2.51.0


