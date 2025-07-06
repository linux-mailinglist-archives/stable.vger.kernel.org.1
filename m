Return-Path: <stable+bounces-160296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395CCAFA4E8
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 13:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43EA91655D8
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 11:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE24D20E6EB;
	Sun,  6 Jul 2025 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V8DBHORX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD9120B807
	for <stable@vger.kernel.org>; Sun,  6 Jul 2025 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751802445; cv=none; b=OxrderKeke+q3FUmZPwlp6pR57YOZ4iYL47htd0+9uEITA/PFM6pPos708MoXZJ4VGv0U4vvXm6hXd7PX/QoBB0lPhHj2Y8fr5aB3ton03g90Sx+nZQIOHHwCEzx5OCFT8bUOKg9EphsZdGnZ9Nsx0Yv0FbUlYk9DF84KPOAS0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751802445; c=relaxed/simple;
	bh=uedznRaGJT8PMTJ9H9McKq9BwCAVIwC9mgEPnZhgjGo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ga6MCtKo2ATD4UR0Pl/n0ysJAxkNklzRvxDAxyn1usxT1OLIxS+eec5ruW1juspG3I0M2+qR8BjDZxwCfUrJKETqg/medW0SIMCIkPNwAO3FjkX0kAxSp6I2H1dJiECJed5yMGZzeh/+5v8VoReI5GHlB6BP1vSR/w5URWy5PoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V8DBHORX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF7BC4CEED;
	Sun,  6 Jul 2025 11:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751802445;
	bh=uedznRaGJT8PMTJ9H9McKq9BwCAVIwC9mgEPnZhgjGo=;
	h=Subject:To:Cc:From:Date:From;
	b=V8DBHORX+kJq4dQSF70P3OrnS12ON62VcEZszESfQu1+3xv7rl7ijsOY2FdHbH3vt
	 hZphQ+fhVsphLhTQDyv0acqAqQJiVGLnos7rL36GZIMyGK3Bqwf2m7AQgJh1hPIWfa
	 qSIQL220UgnJXYhlgovq0RWQh8J0F3cQDq/o0ki8=
Subject: FAILED: patch "[PATCH] s390/pci: Fix stale function handles in error handling" failed to apply to 6.6-stable tree
To: schnelle@linux.ibm.com,agordeev@linux.ibm.com,alifm@linux.ibm.com,gbayer@linux.ibm.com,julianr@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 06 Jul 2025 13:47:22 +0200
Message-ID: <2025070622-clay-crimp-7cf6@gregkh>
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
git cherry-pick -x 45537926dd2aaa9190ac0fac5a0fbeefcadfea95
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025070622-clay-crimp-7cf6@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 45537926dd2aaa9190ac0fac5a0fbeefcadfea95 Mon Sep 17 00:00:00 2001
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Wed, 25 Jun 2025 11:28:28 +0200
Subject: [PATCH] s390/pci: Fix stale function handles in error handling

The error event information for PCI error events contains a function
handle for the respective function. This handle is generally captured at
the time the error event was recorded. Due to delays in processing or
cascading issues, it may happen that during firmware recovery multiple
events are generated. When processing these events in order Linux may
already have recovered an affected function making the event information
stale. Fix this by doing an unconditional CLP List PCI function
retrieving the current function handle with the zdev->state_lock held
and ignoring the event if its function handle is stale.

Cc: stable@vger.kernel.org
Fixes: 4cdf2f4e24ff ("s390/pci: implement minimal PCI error recovery")
Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index 2fbee3887d13..82ee2578279a 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -273,6 +273,8 @@ static void __zpci_event_error(struct zpci_ccdf_err *ccdf)
 	struct zpci_dev *zdev = get_zdev_by_fid(ccdf->fid);
 	struct pci_dev *pdev = NULL;
 	pci_ers_result_t ers_res;
+	u32 fh = 0;
+	int rc;
 
 	zpci_dbg(3, "err fid:%x, fh:%x, pec:%x\n",
 		 ccdf->fid, ccdf->fh, ccdf->pec);
@@ -281,6 +283,15 @@ static void __zpci_event_error(struct zpci_ccdf_err *ccdf)
 
 	if (zdev) {
 		mutex_lock(&zdev->state_lock);
+		rc = clp_refresh_fh(zdev->fid, &fh);
+		if (rc)
+			goto no_pdev;
+		if (!fh || ccdf->fh != fh) {
+			/* Ignore events with stale handles */
+			zpci_dbg(3, "err fid:%x, fh:%x (stale %x)\n",
+				 ccdf->fid, fh, ccdf->fh);
+			goto no_pdev;
+		}
 		zpci_update_fh(zdev, ccdf->fh);
 		if (zdev->zbus->bus)
 			pdev = pci_get_slot(zdev->zbus->bus, zdev->devfn);


