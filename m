Return-Path: <stable+bounces-62400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2097293EF1B
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8731F2153C
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 07:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0C712C530;
	Mon, 29 Jul 2024 07:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I+Ub9tGD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BA11EB2C
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 07:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239654; cv=none; b=q4p+EF17ucg0EQNiTB5QDW0vmz67AlFKM0JideZMqb5FKSOBdQr0TM0us6ymJJWYPvR2FyypMgUSaIYTQEnfjrAxGzTarSMnnZ9DFz+RFQ6X2jSZHw94JOsrBzAaCA86NYP5pM1kd9C4nZUrcKmI8fCNhY3nqjdzgrZEDiuyIrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239654; c=relaxed/simple;
	bh=VEsvSSJz7rH5omq0Sm0v+JHnV3eeZECrm6h+Fb1A88E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fcw+SA1CTZ09fYxO5jDiZj/3uweamJ8A5fvvxSeoXIsvyOdRQYkCHkyGQxRVbDY08tGdPgVXp/X3fJxEy5jUfTjl7SnDWqHpvO7vAwwXc5PyIlX1tGMfExaTIqa4XjaWbx4EW+88GRwQlaq0g+KtvR5J5erx+9Y1UfYTwdWSsCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I+Ub9tGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C90FC32786;
	Mon, 29 Jul 2024 07:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722239654;
	bh=VEsvSSJz7rH5omq0Sm0v+JHnV3eeZECrm6h+Fb1A88E=;
	h=Subject:To:Cc:From:Date:From;
	b=I+Ub9tGDKE6cMYzuboXMAwKvjeTxFcnx2uLoCBEXsuM5hL2btt5GzSpgRTGSc55/m
	 aklrsUDblyYo87S58ecmEskvVwGRcKT9JR3cFL+NgdHcYNemPqcMiGMa1sGpkKSbww
	 WXFhouZiSsbhz7OkS7jCCxT/rHoP2lK1i1kQ1dR4=
Subject: FAILED: patch "[PATCH] ata: libata-scsi: Honor the D_SENSE bit for CK_COND=1 and no" failed to apply to 5.4-stable tree
To: ipylypiv@google.com,cassel@kernel.org,hare@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 09:54:07 +0200
Message-ID: <2024072907-pronounce-drop-down-3db9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 28ab9769117ca944cb6eb537af5599aa436287a4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072907-pronounce-drop-down-3db9@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

28ab9769117c ("ata: libata-scsi: Honor the D_SENSE bit for CK_COND=1 and no error")
f2b1e9c6f867 ("scsi: core: Introduce scsi_build_sense()")
8148dfba29e7 ("scsi: 3w-xxxx: Whitespace cleanup")
96e209be6ecb ("scsi: lpfc: Convert SCSI I/O completions to SLI-3 and SLI-4 handlers")
da255e2e7cc8 ("scsi: lpfc: Convert SCSI path to use common I/O submission path")
47ff4c510f02 ("scsi: lpfc: Enable common send_io interface for SCSI and NVMe")
307e338097dc ("scsi: lpfc: Rework remote port ref counting and node freeing")
7af29d455362 ("scsi: lpfc: Fix-up around 120 documentation issues")
372c187b8a70 ("scsi: lpfc: Add an internal trace log buffer")
317aeb83c92b ("scsi: lpfc: Add blk_io_poll support for latency improvment")
f0020e428af7 ("scsi: lpfc: Add support to display if adapter dumps are available")
86ee57a97a17 ("scsi: lpfc: Fix kdump hang on PPC")
818dbde78e0f ("Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 28ab9769117ca944cb6eb537af5599aa436287a4 Mon Sep 17 00:00:00 2001
From: Igor Pylypiv <ipylypiv@google.com>
Date: Tue, 2 Jul 2024 02:47:31 +0000
Subject: [PATCH] ata: libata-scsi: Honor the D_SENSE bit for CK_COND=1 and no
 error

SAT-5 revision 8 specification removed the text about the ANSI INCITS
431-2007 compliance which was requiring SCSI/ATA Translation (SAT) to
return descriptor format sense data for the ATA PASS-THROUGH commands
regardless of the setting of the D_SENSE bit.

Let's honor the D_SENSE bit for ATA PASS-THROUGH commands while
generating the "ATA PASS-THROUGH INFORMATION AVAILABLE" sense data.

SAT-5 revision 7
================

12.2.2.8 Fixed format sense data

Table 212 shows the fields returned in the fixed format sense data
(see SPC-5) for ATA PASS-THROUGH commands. SATLs compliant with ANSI
INCITS 431-2007, SCSI/ATA Translation (SAT) return descriptor format
sense data for the ATA PASS-THROUGH commands regardless of the setting
of the D_SENSE bit.

SAT-5 revision 8
================

12.2.2.8 Fixed format sense data

Table 211 shows the fields returned in the fixed format sense data
(see SPC-5) for ATA PASS-THROUGH commands.

Cc: stable@vger.kernel.org # 4.19+
Reported-by: Niklas Cassel <cassel@kernel.org>
Closes: https://lore.kernel.org/linux-ide/Zn1WUhmLglM4iais@ryzen.lan
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Link: https://lore.kernel.org/r/20240702024735.1152293-4-ipylypiv@google.com
Signed-off-by: Niklas Cassel <cassel@kernel.org>

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a9d2a1cf4c3d..fdc2a3b59fc1 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -941,11 +941,8 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 				   &sense_key, &asc, &ascq);
 		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
 	} else {
-		/*
-		 * ATA PASS-THROUGH INFORMATION AVAILABLE
-		 * Always in descriptor format sense.
-		 */
-		scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
+		/* ATA PASS-THROUGH INFORMATION AVAILABLE */
+		ata_scsi_set_sense(qc->dev, cmd, RECOVERED_ERROR, 0, 0x1D);
 	}
 }
 


