Return-Path: <stable+bounces-157816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D39AE55C3
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2BB4179D9B
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3823B225A3D;
	Mon, 23 Jun 2025 22:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S1yaLRBW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E612D223DD0;
	Mon, 23 Jun 2025 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716789; cv=none; b=BpUhdnuFDTvIiseH1N0qRnIzQeRT6n4dW/3orOOyOaH22KgUJPRNXp6ghbCvyaM8QoMRHe8xCSCrdeZhbEgXhbQqkRFnr1R9ExydgnQJsTESak4pMv9QraKaPcpRdEyayVljQuLA8ne3RXHgiscElGC8/5NPf0w+ZfLbqPQ6+k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716789; c=relaxed/simple;
	bh=JISWc2iP6RfjEsdv8yI8b81OIDdLC6M1JnN4WCtn+f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rpPuoqlJkGgz8kyTH/nQU8wR2+Sf5cqTfvfFOt59d77k64Fp/99wr0NXNrEbxSjmz7YMdeq0NbVnbakJC+oOziILLpjk9ZQKYOI2cMCgD1TZbQr8W2+iFQ0v4vecawQ6qSlzFX7uvBehqk17FXQhNu6VUcDBqCmpg2SYmxct8sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S1yaLRBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75763C4CEEA;
	Mon, 23 Jun 2025 22:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750716788;
	bh=JISWc2iP6RfjEsdv8yI8b81OIDdLC6M1JnN4WCtn+f0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S1yaLRBWzKOq3e9z+9PstRyYLXr0eSIlkQPBnACC4o7/ASLPCyPwioxs9zK+6/mh0
	 dX+o9X/H6FftbMJwC1+BAjNULYR6DmJNSOdFcwyqGAAQpjtk19glaXQGYskYzbJ7Kp
	 Pe5tO+SpEjzdwqKLsPOrVzyHcFzySfLNS/qKOV7w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 532/592] bnxt_en: Fix double invocation of bnxt_ulp_stop()/bnxt_ulp_start()
Date: Mon, 23 Jun 2025 15:08:10 +0200
Message-ID: <20250623130713.086410138@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
References: <20250623130700.210182694@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

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
index 84c4812414fd4..2450a369b7920 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -231,10 +231,9 @@ void bnxt_ulp_stop(struct bnxt *bp)
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
@@ -250,6 +249,7 @@ void bnxt_ulp_stop(struct bnxt *bp)
 			adrv->suspend(adev, pm);
 		}
 	}
+ulp_stop_exit:
 	mutex_unlock(&edev->en_dev_lock);
 }
 
@@ -258,19 +258,13 @@ void bnxt_ulp_start(struct bnxt *bp, int err)
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
@@ -287,6 +281,8 @@ void bnxt_ulp_start(struct bnxt *bp, int err)
 			adrv->resume(adev);
 		}
 	}
+ulp_start_exit:
+	edev->flags &= ~BNXT_EN_FLAG_ULP_STOPPED;
 	mutex_unlock(&edev->en_dev_lock);
 }
 
-- 
2.39.5




