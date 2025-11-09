Return-Path: <stable+bounces-192816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B55C437D1
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 04:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FB2C4E22B3
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 03:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7894D1E32B9;
	Sun,  9 Nov 2025 03:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NTMNrkKx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF3113FEE
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 03:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762658111; cv=none; b=pQg5rFvYoFQ3d6RlgJ0esFipIrNAJ8qI+aoeoVFrx0ru+zSS/iy8VgW4sqp/Zenp41O+ng/AmEBiFyksfoSG9AGxceKpRMGL+btXVwgOuJfaRq4WRbH2DUWovgkwN2c/Lan62uCn8er7HStC7GNOEDwKdIbFbSxv53H48KGlXQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762658111; c=relaxed/simple;
	bh=rU0CbacuNSyPSX/De/2QLjPnJmsN3NxcKeQSzRYyueY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Z8PTU8QdWmFQUSdyHWOa+9JC6K0J7WATs0pO2w2BavGdKbTfBFfpt5thdbIdym0GZkESPtFW8h+Y2PBwdvTlNPAaxNFEccbbaxHCMZQ06yZ2qcitdhTmizu7UdFmwleb0w94ZOBjP8y0TyUHAxxETuZad3WB+rykV2TdpBSqFBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NTMNrkKx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE6DC16AAE;
	Sun,  9 Nov 2025 03:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762658108;
	bh=rU0CbacuNSyPSX/De/2QLjPnJmsN3NxcKeQSzRYyueY=;
	h=Subject:To:Cc:From:Date:From;
	b=NTMNrkKxmbfO4JhuUyrv0bnFJAc6reBkCJTDZlpOshWHAH+pdokbgZ2TtGW6BQ/PP
	 jLFBSOdlZKzxbQJXRH2YBnLwLvhDhRWOHCNFYMp5Tkqxsl3GWi6W/BoqKjKXZJXjUr
	 LWt5wgOYQvxUV+besXdr935Nr4lckLsN1TzQxzY8=
Subject: FAILED: patch "[PATCH] scsi: ufs: core: Add a quirk to suppress link_startup_again" failed to apply to 6.6-stable tree
To: adrian.hunter@intel.com,bvanassche@acm.org,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 09 Nov 2025 12:15:06 +0900
Message-ID: <2025110906-retrieval-daunting-5fa7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d34caa89a132cd69efc48361d4772251546fdb88
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110906-retrieval-daunting-5fa7@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d34caa89a132cd69efc48361d4772251546fdb88 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@intel.com>
Date: Fri, 24 Oct 2025 11:59:16 +0300
Subject: [PATCH] scsi: ufs: core: Add a quirk to suppress link_startup_again

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

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 2b76f543d072..453a99ec6282 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5066,7 +5066,8 @@ static int ufshcd_link_startup(struct ufs_hba *hba)
 	 * If UFS device isn't active then we will have to issue link startup
 	 * 2 times to make sure the device state move to active.
 	 */
-	if (!ufshcd_is_ufs_dev_active(hba))
+	if (!(hba->quirks & UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE) &&
+	    !ufshcd_is_ufs_dev_active(hba))
 		link_startup_again = true;
 
 link_startup:
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 9425cfd9d00e..0f95576bf1f6 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -688,6 +688,13 @@ enum ufshcd_quirks {
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


