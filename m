Return-Path: <stable+bounces-174638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CA9B36368
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B1C07A126A
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9429C2BF019;
	Tue, 26 Aug 2025 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LoQNmYWJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D8534CF9;
	Tue, 26 Aug 2025 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214919; cv=none; b=HhQAa+8/R3kdhi6I+kvDi6iPkPe55lzHWiCRw57W9eibTpyHEYV9Imcd7v0EYt6FkcOLZSF94hl9KkdQhGYNnVyUf3lTfzaPdAEAkN4IVxklwodUZ7FTYqyNocjgAMETfvQ5svKGwzVIBpfSrYSUqFWuL9XIX7m6+FJgx7W/48s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214919; c=relaxed/simple;
	bh=7qEJMRp7BBpmxA6T1/7Pe9gHEU3YEDORuIorzNsniWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQg2YhQDmb9I9DsewnQTobZfIx7fLAqyz7/lnOQE4zSE5OaBWWKMob+wdafm8FHMHfW8bwq3vIH3nz+LRLHs6MkJ69BH1YprSSDvuW6EUBHzVhGLOg93ShP+TdAJyFJOw+ladtpZoblDkqYyt27SJH7EROPvBSWzJkQmGy+Pz2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LoQNmYWJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6598C4CEF1;
	Tue, 26 Aug 2025 13:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756214919;
	bh=7qEJMRp7BBpmxA6T1/7Pe9gHEU3YEDORuIorzNsniWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LoQNmYWJXQ8n5RDFs0qeAuwSbohYFymbB8aJgcBN/XnoqywPQINsPZuHoPV715S9n
	 BunPWpLYCFDgi94TLFsijVEiuFWs8WRqkMvvFnalRFvjLah8cqug//iHkLmnMvjUFM
	 j4I0fQZUWmqvf9B9j2PAU8Qc2rOj3UGj8pfop9uk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chandrakanth Patil <chandrakanth.patil@broadcom.com>,
	Ranjan Kumar <ranjan.kumar@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.1 288/482] scsi: mpi3mr: Fix race between config read submit and interrupt completion
Date: Tue, 26 Aug 2025 13:09:01 +0200
Message-ID: <20250826110937.903761098@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
References: <20250826110930.769259449@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ranjan Kumar <ranjan.kumar@broadcom.com>

commit e6327c4acf925bb6d6d387d76fc3bd94471e10d8 upstream.

The "is_waiting" flag was updated after calling complete(), which could
lead to a race where the waiting thread wakes up before the flag is
cleared. This may cause a missed wakeup or stale state check.

Reorder the operations to update "is_waiting" before signaling completion
to ensure consistent state.

Fixes: 824a156633df ("scsi: mpi3mr: Base driver code")
Cc: stable@vger.kernel.org
Co-developed-by: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Signed-off-by: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
Link: https://lore.kernel.org/r/20250627194539.48851-2-ranjan.kumar@broadcom.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/mpi3mr/mpi3mr_fw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -411,8 +411,8 @@ static void mpi3mr_process_admin_reply_d
 				       MPI3MR_SENSE_BUF_SZ);
 			}
 			if (cmdptr->is_waiting) {
-				complete(&cmdptr->done);
 				cmdptr->is_waiting = 0;
+				complete(&cmdptr->done);
 			} else if (cmdptr->callback)
 				cmdptr->callback(mrioc, cmdptr);
 		}



