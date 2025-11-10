Return-Path: <stable+bounces-192940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC08C466F9
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 13:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 939333BF63F
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 12:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF9B30DEB1;
	Mon, 10 Nov 2025 11:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/O/zHEE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A17830DEAF
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 11:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775938; cv=none; b=Lj2HkT/fYEhJzn4BCmlOI3TuKxrKQ9i/sBOBbdvZrWi2w8n2qalB9YhC8DTx7fDIIj1zPY3mtOOOl+ljHeVYyFTl47/kN55x1ZDnf2LIrZNoQ3ZFZ7+tIxX1bYBcKONVbbtqBiwiawjs17trxTSmJ+kFiGBPQ6LzzeNarbORGIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775938; c=relaxed/simple;
	bh=C4DXR9jctCLJUYxa4Z5E0VxHBspsG7Y9Yrc6Ni81tWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtjyNUwMT5oge/HVqh/XYuw5JlzfitKqILa+I590WTcsgJoWwW3bl6Rva6iq3CtOtccPwomFDeLaRBH+SvS2Ne2Gc7SubVLpg9Wy9wH9MajLfbR/iOEKi0y+8fI+mJshZGhSgiPAxKbZJCCbLuGnU+jKqdMwL6kg3q/YogdUEx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/O/zHEE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B34C19421;
	Mon, 10 Nov 2025 11:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762775937;
	bh=C4DXR9jctCLJUYxa4Z5E0VxHBspsG7Y9Yrc6Ni81tWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l/O/zHEE+GSAxG+2ZkjxfBK9GTTsc0dE00HwfsN1MYlvvcBFBjSZfljTbGSPiFflI
	 xd0ahEBnlSjD1bZilWNhEiKr2U+xuZeqTbpfA6Rr0Dq6xjbJE67Q14aecSebB12XX5
	 ZiOOcGHJ5wwyOUza2JJOgnHqQY62sp1o/kOYP3tMRmvoDrbUJ7x37IGXEOoieqRdK2
	 44puZBLG1a95OYurvteWlVS+S75n4owrgd8HZsCfeyiongkv3ba7oYM33oFZmuXMFf
	 1d5UiiZbNfzujRVj7zaO5sK+W7WBuiujb1+RKJ54K1SHxDKTVahxTg9EmnLtyuxhch
	 q91Ujk4i0Nzqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 7/7] scsi: ufs: core: Add a quirk to suppress link_startup_again
Date: Mon, 10 Nov 2025 06:58:48 -0500
Message-ID: <20251110115848.651076-7-sashal@kernel.org>
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


