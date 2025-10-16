Return-Path: <stable+bounces-186069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FBCBE37E8
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34E834F6FF6
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46ED3314B6;
	Thu, 16 Oct 2025 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rt+VtRAx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E3832D443
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619102; cv=none; b=W74P6AMIYaVjEmQmGGhxMHQe62m4i30tsBu1kmsD3CIJb9Mtd/tSc2e+ApbGy9Cv1wlqvMg1VfGtQ93Kmiqs169BVifVfPqBATORGChRC+DlMzOhmJILiCKPjMH4zDa+nQebm4VhJes+MOkoOgIr8vvxR3JDfeZ7tRn7DNJufws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619102; c=relaxed/simple;
	bh=js+gMC5eLRI/h7lg8fWV043sEgqqte2YGRZsWqCw4zI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=taAB1B1Dq7oRb/ucV7DHmhb/jnDBzsxZONf8BIOapxTZJlhajr8ufZ6ISFzzDCfHQPwZTXAk8P74Ke96HaKegyOorQAeDTtqZWBU3BgMN5pIqvgtxdr5NzSVHoY9LFqaxcNT7K5FGqX3Fulb56oyWEWi6Msfcvtb+AMI9701u9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rt+VtRAx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2B2C4CEFE;
	Thu, 16 Oct 2025 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760619102;
	bh=js+gMC5eLRI/h7lg8fWV043sEgqqte2YGRZsWqCw4zI=;
	h=Subject:To:Cc:From:Date:From;
	b=rt+VtRAxQG5TZ0BUgu15VYSITs1TpnCBBU5A8mR+Rdvtaitzf5YevTzfLTCpHa/3Q
	 AycWSlTl6uUZg7c2AObPvzSYirj0/+U2vduIJcxArY8Q/zqqZSlH/LNq+41Jcstp1E
	 ZP2HfMtg6Wva23rxG7yUez6jJ96gY2QNvulViDMY=
Subject: FAILED: patch "[PATCH] padata: Reset next CPU when reorder sequence wraps around" failed to apply to 6.6-stable tree
To: shaw.leon@gmail.com,herbert@gondor.apana.org.au,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 14:49:50 +0200
Message-ID: <2025101650-feline-ellipse-6256@gregkh>
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
git cherry-pick -x 501302d5cee0d8e8ec2c4a5919c37e0df9abc99b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101650-feline-ellipse-6256@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 501302d5cee0d8e8ec2c4a5919c37e0df9abc99b Mon Sep 17 00:00:00 2001
From: Xiao Liang <shaw.leon@gmail.com>
Date: Sun, 17 Aug 2025 00:30:15 +0800
Subject: [PATCH] padata: Reset next CPU when reorder sequence wraps around

When seq_nr wraps around, the next reorder job with seq 0 is hashed to
the first CPU in padata_do_serial(). Correspondingly, need reset pd->cpu
to the first one when pd->processed wraps around. Otherwise, if the
number of used CPUs is not a power of 2, padata_find_next() will be
checking a wrong list, hence deadlock.

Fixes: 6fc4dbcf0276 ("padata: Replace delayed timer with immediate workqueue in padata_reorder")
Cc: <stable@vger.kernel.org>
Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/kernel/padata.c b/kernel/padata.c
index f85f8bd788d0..833740d75483 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -291,8 +291,12 @@ static void padata_reorder(struct padata_priv *padata)
 		struct padata_serial_queue *squeue;
 		int cb_cpu;
 
-		cpu = cpumask_next_wrap(cpu, pd->cpumask.pcpu);
 		processed++;
+		/* When sequence wraps around, reset to the first CPU. */
+		if (unlikely(processed == 0))
+			cpu = cpumask_first(pd->cpumask.pcpu);
+		else
+			cpu = cpumask_next_wrap(cpu, pd->cpumask.pcpu);
 
 		cb_cpu = padata->cb_cpu;
 		squeue = per_cpu_ptr(pd->squeue, cb_cpu);


