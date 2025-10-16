Return-Path: <stable+bounces-186068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F59BE37E5
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EBA0A358B79
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302763314BF;
	Thu, 16 Oct 2025 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OxZCB1t4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E359B262FE9
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619100; cv=none; b=cbSgyKxZcsD0U34sIFkWNXUBOoWoOkRBbmIIxGL5ypokGTpph6EqwJPRHOQOLVoPdD2N1bL61+X7ZBfQDwVaznEunMPJbiMtGp2nPOKN6PX7UG55crN20ni4mf8gVeyQpd21Hj6QcczhW7qEIg2BfmXlPIQu/VIdM0BPlvzfjCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619100; c=relaxed/simple;
	bh=BeKny27TLW01mQpYrpbLCF4fWNqxeqZB5ndK5pwvj34=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RCWxz6oPSv5kr3MKlwe0gTOqo3PQbULYZHEM47Y8qThPUPIA8RNUSzDnE0IHOVbi4M+1MQvXdxB9p2FxJbTTv4Yh/3VYBpp++xUOAE+bnHUJFHXUpWwYtDA6ZwPXnQUy3o95ocdoQO8fmNQyaoc0IeM3PRKlHopRW8bEJ7LOFGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OxZCB1t4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC18C4CEFE;
	Thu, 16 Oct 2025 12:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760619099;
	bh=BeKny27TLW01mQpYrpbLCF4fWNqxeqZB5ndK5pwvj34=;
	h=Subject:To:Cc:From:Date:From;
	b=OxZCB1t4o/weLu9Zd/l4WeEePkRRpfaBi9trMKajeHoGYknEdZ/3qcfci9UL9sroH
	 0hziiAh7L6ual2gFidajrBSaco7rXzMku19zqKs+23gBzJMCzGyeoUgs7RMu+0DHoz
	 XZHDWySvVgDPggxxl7dlDREX7f0ska3LkGmWDCKI=
Subject: FAILED: patch "[PATCH] padata: Reset next CPU when reorder sequence wraps around" failed to apply to 6.1-stable tree
To: shaw.leon@gmail.com,herbert@gondor.apana.org.au,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 14:49:50 +0200
Message-ID: <2025101650-dreamless-dry-49d5@gregkh>
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
git cherry-pick -x 501302d5cee0d8e8ec2c4a5919c37e0df9abc99b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101650-dreamless-dry-49d5@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


