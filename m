Return-Path: <stable+bounces-192820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19035C43826
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 04:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0914E4E4565
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 03:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282B01FE47C;
	Sun,  9 Nov 2025 03:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Subm2KhF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CF11FA15E
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 03:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762658682; cv=none; b=kYlZ/AH1mWbv9bxOwb+8HxMuA0CItqEd15Ig7rI8AV/v1azK90wPu19KzXvyZgCOGX2qZEVl0pmhzD75mBVqs4r6iT2FEQ/0d29XIiHiSWSan8Rl91sl3P/rp1QxHX80ohej69iH7g8NXGF8G1Xd9sp+y2hYc+BtC6YAUtB1wG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762658682; c=relaxed/simple;
	bh=5ICEMieUquU3IhL18AVQHp0HlLuAI+kl0PEaYnICG3M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CyKXUvxXQELtjBn9VD6BnNoVOEtGDre6IjY+Bcw67YJ64h2c7t1lTz/y45rfdGgOefjJiiCpljN7JjUzh5eHTrzgAcKFAxopdJIg4gIuXZL7M7FeS2nUxu6A7vU71jqUi3sbwz7LZNLc/6Tu29MDoxrc5q+jwsdu8gRMrumgK0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Subm2KhF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AC1C116D0;
	Sun,  9 Nov 2025 03:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762658682;
	bh=5ICEMieUquU3IhL18AVQHp0HlLuAI+kl0PEaYnICG3M=;
	h=Subject:To:Cc:From:Date:From;
	b=Subm2KhFP3oXjsLDnva/zrX9sj2ROm8eq5bBzlKnFBA4GDUa2GQVQZoSYSuhspQQH
	 77mlXRE08joUIHKSriDgJGndEpyHULj1heqwjdu9g2Mxi6IlFCzTUCW+ZpE/xUzO8/
	 nNUEznBzqJY14/mp7GBpGEo/InreJ1/7MnBnYjmc=
Subject: FAILED: patch "[PATCH] scsi: ufs: ufs-pci: Set" failed to apply to 6.6-stable tree
To: adrian.hunter@intel.com,bvanassche@acm.org,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 09 Nov 2025 12:24:40 +0900
Message-ID: <2025110940-control-hence-f9a8@gregkh>
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
git cherry-pick -x d968e99488c4b08259a324a89e4ed17bf36561a4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110940-control-hence-f9a8@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d968e99488c4b08259a324a89e4ed17bf36561a4 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@intel.com>
Date: Fri, 24 Oct 2025 11:59:17 +0300
Subject: [PATCH] scsi: ufs: ufs-pci: Set
 UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE for Intel ADL

Link startup becomes unreliable for Intel Alder Lake based host
controllers when a 2nd DME_LINKSTARTUP is issued unnecessarily.  Employ
UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE to suppress that from happening.

Fixes: 7dc9fb47bc9a ("scsi: ufs: ufs-pci: Add support for Intel ADL")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20251024085918.31825-4-adrian.hunter@intel.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/ufs/host/ufshcd-pci.c b/drivers/ufs/host/ufshcd-pci.c
index 89f88b693850..5f65dfad1a71 100644
--- a/drivers/ufs/host/ufshcd-pci.c
+++ b/drivers/ufs/host/ufshcd-pci.c
@@ -428,7 +428,8 @@ static int ufs_intel_lkf_init(struct ufs_hba *hba)
 static int ufs_intel_adl_init(struct ufs_hba *hba)
 {
 	hba->nop_out_timeout = 200;
-	hba->quirks |= UFSHCD_QUIRK_BROKEN_AUTO_HIBERN8;
+	hba->quirks |= UFSHCD_QUIRK_BROKEN_AUTO_HIBERN8 |
+		       UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE;
 	hba->caps |= UFSHCD_CAP_WB_EN;
 	return ufs_intel_common_init(hba);
 }


