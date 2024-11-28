Return-Path: <stable+bounces-95722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7219DB90B
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 14:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F60162349
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 13:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C571A9B30;
	Thu, 28 Nov 2024 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlvebd7H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6556E19CD01
	for <stable@vger.kernel.org>; Thu, 28 Nov 2024 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732801399; cv=none; b=jNMOSqszkc4XARKt3rV76Xw4Pm/L/5GK0d7UT/x1YLCbUi1+Zzf5aNSYbjtY9oigctxzqD21qbWEFDYeWo/3foKleOGPffuatqytmNoJ+PpwXrl466ZZE5Um4jE6Udxakle3xR3+6mZS4ofNxKOXR0Hu0vrD/oH6R8I8ipaMOHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732801399; c=relaxed/simple;
	bh=HnIuiVCD9KtlGRlWEy+0LWXncWVL8Ug2PiKshizjGk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZAWFY47fiKcIcgVvjV9s0c2MI64sUWtifKg0CgtsQ8HWUFTIqGc9JsTT3YZPcoQ7zorgTsj+G/0yqc8nrTNNr58+Uy+VWhNZ4QfHlRqa35SMVcM2r8KyG5wQk0m+l7ZCIwTLqGQGSStoi9nKgTuoHFjbc8XitV5MJGnut5eLV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlvebd7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8F7C4CED2;
	Thu, 28 Nov 2024 13:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732801399;
	bh=HnIuiVCD9KtlGRlWEy+0LWXncWVL8Ug2PiKshizjGk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hlvebd7Ho1pp69NaPi84mIXHRQrTekBh4KbF7y1oOPcxDu+kT9VbQjTbUyL4mN5S4
	 5Ac8IPANjLWIscp9zuJaxgo2364WFIcBc9NKAGEqkRTi0UwyDFjmJeeoPO55raLOco
	 QAK5qZ+WuG3LcNZzDDciQXENB7KBFjAS7bdyE0yVm3M8KXvZJXy9fhf+WwksSWzwOb
	 zHSScVJH9+7SBA6tfUFwMkpcTq48A0Ws2GaOdqaNaovZyKK2IU1o1ooVRBy7fYZRPl
	 0O/be6yUTCM68BHdaqJ+3yQ8i3SvCeySt9IrVsI221f7h8i9ucAej6mwPWwFCa5lKM
	 xI0GQVFjeGp2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: mingli.yu@eng.windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 5.15] tty: n_gsm: Fix use-after-free in gsm_cleanup_mux
Date: Thu, 28 Nov 2024 07:57:07 -0500
Message-ID: <20241128062100-628f67dc6f369895@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241128084730.430060-1-mingli.yu@eng.windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 9462f4ca56e7d2430fdb6dcc8498244acbfc4489

WARNING: Author mismatch between patch and upstream commit:
Backport author: <mingli.yu@eng.windriver.com>
Commit author: Longlong Xia <xialonglong@kylinos.cn>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: 0eec592c6a74)
6.6.y | Present (different SHA1: c29f192e0d44)
6.1.y | Present (different SHA1: bf171b5e86e4)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-28 06:15:22.075748655 -0500
+++ /tmp/tmp.vWxXusWqkZ	2024-11-28 06:15:22.068138702 -0500
@@ -1,3 +1,5 @@
+commit 9462f4ca56e7d2430fdb6dcc8498244acbfc4489 upstream.
+
 BUG: KASAN: slab-use-after-free in gsm_cleanup_mux+0x77b/0x7b0
 drivers/tty/n_gsm.c:3160 [n_gsm]
 Read of size 8 at addr ffff88815fe99c00 by task poc/3379
@@ -51,20 +53,37 @@
 Suggested-by: Jiri Slaby <jirislaby@kernel.org>
 Link: https://lore.kernel.org/r/20240926130213.531959-1-xialonglong@kylinos.cn
 Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+[Mingli: Backport to fix CVE-2024-50073, no guard macro defined resolution]
+Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
 ---
- drivers/tty/n_gsm.c | 2 ++
- 1 file changed, 2 insertions(+)
+ drivers/tty/n_gsm.c | 4 ++++
+ 1 file changed, 4 insertions(+)
 
 diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
-index 5d37a09849163..252849910588f 100644
+index aae9f73585bd..1becbdf7c470 100644
 --- a/drivers/tty/n_gsm.c
 +++ b/drivers/tty/n_gsm.c
-@@ -3157,6 +3157,8 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
+@@ -2443,6 +2443,7 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
+ 	int i;
+ 	struct gsm_dlci *dlci;
+ 	struct gsm_msg *txq, *ntxq;
++	unsigned long flags;
+ 
+ 	gsm->dead = true;
+ 	mutex_lock(&gsm->mutex);
+@@ -2471,9 +2472,12 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
  	mutex_unlock(&gsm->mutex);
  	/* Now wipe the queues */
  	tty_ldisc_flush(gsm->tty);
 +
-+	guard(spinlock_irqsave)(&gsm->tx_lock);
- 	list_for_each_entry_safe(txq, ntxq, &gsm->tx_ctrl_list, list)
++	spin_lock_irqsave(&gsm->tx_lock, flags);
+ 	list_for_each_entry_safe(txq, ntxq, &gsm->tx_list, list)
  		kfree(txq);
- 	INIT_LIST_HEAD(&gsm->tx_ctrl_list);
+ 	INIT_LIST_HEAD(&gsm->tx_list);
++	spin_unlock_irqrestore(&gsm->tx_lock, flags);
+ }
+ 
+ /**
+-- 
+2.34.1
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

