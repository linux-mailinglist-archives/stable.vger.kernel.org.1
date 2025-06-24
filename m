Return-Path: <stable+bounces-158051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DB9AE56BF
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0939F1C22AD0
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E368223DE8;
	Mon, 23 Jun 2025 22:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IiQw4VMU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0826615ADB4;
	Mon, 23 Jun 2025 22:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717363; cv=none; b=hNQ0JsWeN5YbblRjgbBMl9kEpd4VjRy4coTy64gJFa4CuHbY7A7r4UbHD0DAYNnqiL8LpTJ28DC/h4hRMOJEZ0dBYDdkGyfSzcpEE6rVm5lGzsKAhrBhe8jwfvbjDdBCRkwQI0fC2SBgMrpdGWeEJPMUAVpCaVox4OyC6OJ+KaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717363; c=relaxed/simple;
	bh=4Wkn3sETFbzRRSJYRvmV3iEH1avXOKGGs82h8x8I80Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJ6V3QdghLEt0GYpm2J3ZEdoT+haGkQjl5VsXiUnmnTicrzyN5hAJnmbZzygWHyZTPDejQHLxqBASMvDG1+95NoNks0Rpu04wP+xFJwswPgIJHB20Sqyc7i7Z9zt5nEJwRfa7wi4wqL4AvHGb3QrvF4eYexHj3kGkfPpBefqq/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IiQw4VMU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA8AC4CEEA;
	Mon, 23 Jun 2025 22:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717362;
	bh=4Wkn3sETFbzRRSJYRvmV3iEH1avXOKGGs82h8x8I80Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IiQw4VMUcamgS5AVcbxwnauL/IEWIMojvmdPcaZBgo3PCX9w6Iu52kOyp+cSDG5+Z
	 IuVJgJKJ8vUkRXADUJeyDhXEWQpw2sqv/wNXeNuOGeBqMvnqBqnW9WidKoZ+BzUPdD
	 bQWm4BZq3+5pxVbEkoiudOhhrlQmwyk6y/tl7W8c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 373/414] bnxt_en: Fix double invocation of bnxt_ulp_stop()/bnxt_ulp_start()
Date: Mon, 23 Jun 2025 15:08:30 +0200
Message-ID: <20250623130651.279682317@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

[ Upstream commit 1e9ac33fa271be0d2480fd732f9642d81542500b ]

Before the commit under the Fixes tag below, bnxt_ulp_stop() and
bnxt_ulp_start() were always invoked in pairs.  After that commit,
the new bnxt_ulp_restart() can be invoked after bnxt_ulp_stop()
has been called.  This may result in the RoCE driver's aux driver
.suspend() method being invoked twice.  The 2nd bnxt_re_suspend()
call will crash when it dereferences a NULL pointer:

(NULL ib_device): Handle device suspend call
BUG: kernel NULL pointer dereference, address: 0000000000000b78
PGD 0 P4D 0
Oops: Oops: 0000 [#1] SMP PTI
CPU: 20 UID: 0 PID: 181 Comm: kworker/u96:5 Tainted: G S                  6.15.0-rc1 #4 PREEMPT(voluntary)
Tainted: [S]=CPU_OUT_OF_SPEC
Hardware name: Dell Inc. PowerEdge R730/072T6D, BIOS 2.4.3 01/17/2017
Workqueue: bnxt_pf_wq bnxt_sp_task [bnxt_en]
RIP: 0010:bnxt_re_suspend+0x45/0x1f0 [bnxt_re]
Code: 8b 05 a7 3c 5b f5 48 89 44 24 18 31 c0 49 8b 5c 24 08 4d 8b 2c 24 e8 ea 06 0a f4 48 c7 c6 04 60 52 c0 48 89 df e8 1b ce f9 ff <48> 8b 83 78 0b 00 00 48 8b 80 38 03 00 00 a8 40 0f 85 b5 00 00 00
RSP: 0018:ffffa2e84084fd88 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffffb4b6b934 RDI: 00000000ffffffff
RBP: ffffa1760954c9c0 R08: 0000000000000000 R09: c0000000ffffdfff
R10: 0000000000000001 R11: ffffa2e84084fb50 R12: ffffa176031ef070
R13: ffffa17609775000 R14: ffffa17603adc180 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffa17daa397000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000b78 CR3: 00000004aaa30003 CR4: 00000000003706f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
bnxt_ulp_stop+0x69/0x90 [bnxt_en]
bnxt_sp_task+0x678/0x920 [bnxt_en]
? __schedule+0x514/0xf50
process_scheduled_works+0x9d/0x400
worker_thread+0x11c/0x260
? __pfx_worker_thread+0x10/0x10
kthread+0xfe/0x1e0
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2b/0x40
? __pfx_kthread+0x10/0x10
ret_from_fork_asm+0x1a/0x30

Check the BNXT_EN_FLAG_ULP_STOPPED flag and do not proceed if the flag
is already set.  This will preserve the original symmetrical
bnxt_ulp_stop() and bnxt_ulp_start().

Also, inside bnxt_ulp_start(), clear the BNXT_EN_FLAG_ULP_STOPPED
flag after taking the mutex to avoid any race condition.  And for
symmetry, only proceed in bnxt_ulp_start() if the
BNXT_EN_FLAG_ULP_STOPPED is set.

Fixes: 3c163f35bd50 ("bnxt_en: Optimize recovery path ULP locking in the driver")
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Co-developed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250613231841.377988-2-michael.chan@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 24 ++++++++-----------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index b33c29fdf8fd3..1867552a8bdbe 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -230,10 +230,9 @@ void bnxt_ulp_stop(struct bnxt *bp)
 		return;
 
 	mutex_lock(&edev->en_dev_lock);
-	if (!bnxt_ulp_registered(edev)) {
-		mutex_unlock(&edev->en_dev_lock);
-		return;
-	}
+	if (!bnxt_ulp_registered(edev) ||
+	    (edev->flags & BNXT_EN_FLAG_ULP_STOPPED))
+		goto ulp_stop_exit;
 
 	edev->flags |= BNXT_EN_FLAG_ULP_STOPPED;
 	if (aux_priv) {
@@ -249,6 +248,7 @@ void bnxt_ulp_stop(struct bnxt *bp)
 			adrv->suspend(adev, pm);
 		}
 	}
+ulp_stop_exit:
 	mutex_unlock(&edev->en_dev_lock);
 }
 
@@ -257,19 +257,13 @@ void bnxt_ulp_start(struct bnxt *bp, int err)
 	struct bnxt_aux_priv *aux_priv = bp->aux_priv;
 	struct bnxt_en_dev *edev = bp->edev;
 
-	if (!edev)
-		return;
-
-	edev->flags &= ~BNXT_EN_FLAG_ULP_STOPPED;
-
-	if (err)
+	if (!edev || err)
 		return;
 
 	mutex_lock(&edev->en_dev_lock);
-	if (!bnxt_ulp_registered(edev)) {
-		mutex_unlock(&edev->en_dev_lock);
-		return;
-	}
+	if (!bnxt_ulp_registered(edev) ||
+	    !(edev->flags & BNXT_EN_FLAG_ULP_STOPPED))
+		goto ulp_start_exit;
 
 	if (edev->ulp_tbl->msix_requested)
 		bnxt_fill_msix_vecs(bp, edev->msix_entries);
@@ -286,6 +280,8 @@ void bnxt_ulp_start(struct bnxt *bp, int err)
 			adrv->resume(adev);
 		}
 	}
+ulp_start_exit:
+	edev->flags &= ~BNXT_EN_FLAG_ULP_STOPPED;
 	mutex_unlock(&edev->en_dev_lock);
 }
 
-- 
2.39.5




