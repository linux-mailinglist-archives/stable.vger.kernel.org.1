Return-Path: <stable+bounces-114599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C23A2EF0F
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44BBF3A37BF
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3A52309A5;
	Mon, 10 Feb 2025 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IZ8I1x6e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0E014B08C
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 13:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195908; cv=none; b=pHR/TnspNmWcuGCufwdNJ6/YH0DmOPyoZbFrv708imu1BM8TA6CT8qPlhNBWPGYlV4SvO96FcXFQSFdHCENRWkymwxUIz2YxeXo1mJAde6SWt/+1QycArW0aizCFOZbE6/7pfOyfQnglZzRZeWu/bF6eBkHjPOY5uQv/eQfaXQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195908; c=relaxed/simple;
	bh=ftfQCsLI5fQvBVyppRZUA71Uep9FEtkxcsUn6lymcwg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Pl0mJo7Iy0by6ILY4LlAyGV/LGATewqvQf5PUbIQrGGRVx12CTKCZ/qXEklxIOeEYTK6o+PEnYIdPpKQZigFGK+PCmrpE/zmX2YWzbqyPTjqpje2SY/B+gFEXHLOykwzlLtzKw1CUBvL6V3MvqxGI7gDhsqg4FMtU3xLU6BGCfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IZ8I1x6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD6FC4CED1;
	Mon, 10 Feb 2025 13:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739195907;
	bh=ftfQCsLI5fQvBVyppRZUA71Uep9FEtkxcsUn6lymcwg=;
	h=Subject:To:Cc:From:Date:From;
	b=IZ8I1x6evnaMmMKgUlCAWfQcSBbu5xFR2vx/ciAgJl2vx2asKGt1sHNED9047MMQ9
	 DJY0k1U0+hLwffjM5XYbYI5OCdrCSciKg6MSDhsDqtFNHw+lIEOe7ptCviLYwYNu0M
	 j6neoIDUATqmxEZAR3J3R29a/BeDKN25nq7Olcmg=
Subject: FAILED: patch "[PATCH] scsi: core: Do not retry I/Os during depopulation" failed to apply to 6.1-stable tree
To: ipylypiv@google.com,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 14:58:13 +0100
Message-ID: <2025021013-krypton-salutary-f084@gregkh>
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
git cherry-pick -x 9ff7c383b8ac0c482a1da7989f703406d78445c6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021013-krypton-salutary-f084@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


