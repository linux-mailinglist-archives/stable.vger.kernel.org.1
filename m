Return-Path: <stable+bounces-114598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F81A2EF10
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 203127A2491
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1988D230998;
	Mon, 10 Feb 2025 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XW8VDl+Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE11114B08C
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195904; cv=none; b=sVTc/s7kKVyqBFGcD57ZSdI6pg5sWLhvBwgiHF/zW3d+QhUHWj0/8PDmctbbGyzA19KMxBnTrb4Q9VKITVDlusT0vAfCw6YYpDdKluICfUKrS2b1f/9JEmf7grzv9fBW9T8OJ19BSLii7UpFg8/fkEVUBR/kQ148wVzON2tSNEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195904; c=relaxed/simple;
	bh=bwbR0SRy/m2AAYFxJZ4NSu6Cz9dZhlVRhcrBZmrMinQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ipfEnZGrGFo0AGY99RMTfUxYjVguOoe/5LiDN4o/4rOcQR18BHwxocMNqa6Ie6hWsZ8LkwBpWrOsj/umeMKpJXSQ8S4awWni4e2PN43onWp/rcqvig8i2j3g2MWCNneJiwTAqNJYzvUcyrwBkveKDlh/DYwZ1cQ/D2PEcu3zTbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XW8VDl+Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CE4C4CEDF;
	Mon, 10 Feb 2025 13:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739195904;
	bh=bwbR0SRy/m2AAYFxJZ4NSu6Cz9dZhlVRhcrBZmrMinQ=;
	h=Subject:To:Cc:From:Date:From;
	b=XW8VDl+YKvDpboH3fD4sQLG4Rdwhx1NlzZU9h+CVK7sfTTom7xx/ZwdYtSUQ2AXz8
	 K4wqv7JFPwG7r4Xn0W0O53KJuamSaC5YVVxx64YF0rgIjfZ17bpLEAC6qFgUSij8NB
	 KGgS8x6DmzgPzNJVwRuCu4hHpOGRogii1ZQrO5U0=
Subject: FAILED: patch "[PATCH] scsi: core: Do not retry I/Os during depopulation" failed to apply to 5.15-stable tree
To: ipylypiv@google.com,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 14:58:13 +0100
Message-ID: <2025021013-spendable-stranger-885b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9ff7c383b8ac0c482a1da7989f703406d78445c6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021013-spendable-stranger-885b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9ff7c383b8ac0c482a1da7989f703406d78445c6 Mon Sep 17 00:00:00 2001
From: Igor Pylypiv <ipylypiv@google.com>
Date: Fri, 31 Jan 2025 10:44:07 -0800
Subject: [PATCH] scsi: core: Do not retry I/Os during depopulation

Fail I/Os instead of retry to prevent user space processes from being
blocked on the I/O completion for several minutes.

Retrying I/Os during "depopulation in progress" or "depopulation restore in
progress" results in a continuous retry loop until the depopulation
completes or until the I/O retry loop is aborted due to a timeout by the
scsi_cmd_runtime_exceeced().

Depopulation is slow and can take 24+ hours to complete on 20+ TB HDDs.
Most I/Os in the depopulation retry loop end up taking several minutes
before returning the failure to user space.

Cc: stable@vger.kernel.org # 4.18.x: 2bbeb8d scsi: core: Handle depopulation and restoration in progress
Cc: stable@vger.kernel.org # 4.18.x
Fixes: e37c7d9a0341 ("scsi: core: sanitize++ in progress")
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
Link: https://lore.kernel.org/r/20250131184408.859579-1-ipylypiv@google.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index d776f13cd160..be0890e4e706 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -872,13 +872,18 @@ static void scsi_io_completion_action(struct scsi_cmnd *cmd, int result)
 				case 0x1a: /* start stop unit in progress */
 				case 0x1b: /* sanitize in progress */
 				case 0x1d: /* configuration in progress */
-				case 0x24: /* depopulation in progress */
-				case 0x25: /* depopulation restore in progress */
 					action = ACTION_DELAYED_RETRY;
 					break;
 				case 0x0a: /* ALUA state transition */
 					action = ACTION_DELAYED_REPREP;
 					break;
+				/*
+				 * Depopulation might take many hours,
+				 * thus it is not worthwhile to retry.
+				 */
+				case 0x24: /* depopulation in progress */
+				case 0x25: /* depopulation restore in progress */
+					fallthrough;
 				default:
 					action = ACTION_FAIL;
 					break;


