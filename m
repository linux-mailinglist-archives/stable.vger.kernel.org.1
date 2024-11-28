Return-Path: <stable+bounces-95718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2775C9DB907
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 14:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1EBF2817DE
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 13:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE2D1A9B4D;
	Thu, 28 Nov 2024 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBpvkOEA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8A319CD01
	for <stable@vger.kernel.org>; Thu, 28 Nov 2024 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732801391; cv=none; b=eIYuq50/Y6c3Arucp9/buwWloXBMFafzd8DRaY/VoyI8s6tauTBc4MHK6jTWB4cK5q+AesrlP5HxRZb5nAdxOeo7NjKlrI6b5GcoFWev1HQu8umY/divz9yWsQDcjR410zhqV5/suQeS5iuKHMihrf5zd99/NZkNMZ3SDpOra7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732801391; c=relaxed/simple;
	bh=bLctp6YBIyy6vETpTuXwfqlOH3gxh0Fs8ZuQcJ9quSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJwzpfozObL3zv/IwC8aENC+ZRB4+64GnI2QC5gSoC6Qn1D0nWV8l658QV+/PeD3661F6s5zFc/OPZhw54zWptrWFvuzhckKAh+hLRgNzjf9gWOHdte0A7v0Y5oJcp1S8HrBpoWWYulwJH2SJoprCWiHV0qXgKbgvYSAeWGTyAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBpvkOEA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77B2C4CECE;
	Thu, 28 Nov 2024 13:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732801391;
	bh=bLctp6YBIyy6vETpTuXwfqlOH3gxh0Fs8ZuQcJ9quSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WBpvkOEABiePudpcvw6MsKcnZLXaKtvhdpqLsbJqu2DcfOhbtH82KeQis6Do1G+bL
	 aI345tpa9/fp1t31OanWAdeJgedMD+zpyEPIZeBoAL8VdUxvUGiK1rkNEOodz3KeAC
	 kKMrdxW5PaANI1K+c+IZVnes+7dHiRnybqC6S2japviZff8ZY6WI71WRrTC/X1n3kQ
	 iOrrKVB2CkeXS78NreZFyXh/h+lo9Es2hJGt7Prh/1jz64fTbJDk4T7TMDkqymGlE5
	 twTwsTrN8HWi26cBHgCyypdUAs8J6zqzWcpzuoaFNG+9guyqBhz9xJVJlas1o4XtZY
	 oxO+vTcromIaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: mingli.yu@eng.windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15] tty: n_gsm: Fix use-after-free in gsm_cleanup_mux
Date: Thu, 28 Nov 2024 07:56:59 -0500
Message-ID: <20241128061326-47e8e79154cd01a2@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241128080104.195641-1-mingli.yu@eng.windriver.com>
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
--- -	2024-11-28 06:08:35.250028823 -0500
+++ /tmp/tmp.0bKgeyF8zy	2024-11-28 06:08:35.245548384 -0500
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

