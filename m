Return-Path: <stable+bounces-192819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63300C43823
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 04:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19FA33B2B6B
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 03:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C951FF1C4;
	Sun,  9 Nov 2025 03:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Blhu384G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B139F1FE47C
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 03:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762658659; cv=none; b=EL1qpRT+6YSlgj5UFcxCRn+ABZKOAXywmbvoI7k4jLog+Bnz9ctZLHMRN4hQBPp54bfhoWKseze1wEEX4/X3YJMS7eyRCmk713FsUHRzmSbsIgB58mS87g1nDoy4MuhqidmhDNEcMQ0eLDo6Fi8D3a0XXcAPR+aFXFsNqFzj144=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762658659; c=relaxed/simple;
	bh=18BXFivG+D1La4o4cf+kpCr1Mh6Hayietgu6+S9dEUQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Wv+3w2lKa0+Ys0sCRIUTZXEKCze3uJ05XuQK0gEk2tzjL4rA3L/8ABJXH/Z/K13wOvDqLW4ClG/D34G9O3SxzXMtYvzPOIli7AcKE09XlwYBlAsx7eLskHyYQ+Bw7r+kTnevhSY8YOZlaW2GaQ83ii/3zZfdNYQVUXBEkZy5lCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Blhu384G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8BFC4CEF5;
	Sun,  9 Nov 2025 03:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762658659;
	bh=18BXFivG+D1La4o4cf+kpCr1Mh6Hayietgu6+S9dEUQ=;
	h=Subject:To:Cc:From:Date:From;
	b=Blhu384G/+kdg9cITbaTAyQUtYX6IQ/PvBfS2YgfkRf+t2MjCLPtOJyIZoj66JoO9
	 /gyCxyfRup1KLF/G9PFF0I9pVUXJp5r9C6JxEnuT1JmH3XSxiF+1DSvZpwpKmqTBxC
	 orDHaccROFQu++e7eLs+l0rHyBp5Qhd/93spRIRs=
Subject: FAILED: patch "[PATCH] scsi: ufs: ufs-pci: Set" failed to apply to 6.1-stable tree
To: adrian.hunter@intel.com,bvanassche@acm.org,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 09 Nov 2025 12:24:16 +0900
Message-ID: <2025110916-yummy-cane-0741@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d968e99488c4b08259a324a89e4ed17bf36561a4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110916-yummy-cane-0741@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


