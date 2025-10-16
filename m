Return-Path: <stable+bounces-186071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 267EABE37EB
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2613E358C04
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5832825A357;
	Thu, 16 Oct 2025 12:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eIuLBHTX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0137A2E229C
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619110; cv=none; b=XBBe4C266m3bhVrA8GJ4KqgZmoB+SevnQW7zBnyYWbo+ELSGh61AVOe7lo8xnQ83K6RzRQXOkfQ9noocFz5G4CVXI8mdoHRWLaL6jPQG9hhBqrFPuOXVRb6U2UF7ysxLYaUBduYVcG4WUOVbsg99hwaZMA2Hb4zfrdXAxpmBxx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619110; c=relaxed/simple;
	bh=TLadINnvLLJagkge1J4hCd3+ddVIgUZ+tjqDrrr5uNk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=j/WKa1znuLhMUvJfdHJ/BT2P6FCoJAlq+Se/vUpzhwiyAkDFCYruSSSUP2pweivmUddM6OHkvw1OmpVw1vdV1Ba4Uij+wIN1kbQH8xc6BnmK+EhVv+D631mQxoN3hhP1ePvFpLiDHkJdXgIMvQbW1eumXT/0d/52dB++/0PJFOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eIuLBHTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128BEC4CEFE;
	Thu, 16 Oct 2025 12:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760619108;
	bh=TLadINnvLLJagkge1J4hCd3+ddVIgUZ+tjqDrrr5uNk=;
	h=Subject:To:Cc:From:Date:From;
	b=eIuLBHTXDEwQkQ0oDI1ZqnzXAcqLhT1yboq6OvxVH99KQhWuxEa4fMf3Oc0JXmwTF
	 xbLoDMFXtLOkK9sJTNRKkS6FwlhiRaWxaBB7M5NADdBcZi9XSzzizZK8kmHwVuqeX2
	 1WHJFsOUys9Y/+m1WIY5BgaNSdNRIFg13Q/SWARM=
Subject: FAILED: patch "[PATCH] padata: Reset next CPU when reorder sequence wraps around" failed to apply to 5.4-stable tree
To: shaw.leon@gmail.com,herbert@gondor.apana.org.au,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 14:49:51 +0200
Message-ID: <2025101651-kerosene-quartered-684e@gregkh>
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
git cherry-pick -x 501302d5cee0d8e8ec2c4a5919c37e0df9abc99b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101651-kerosene-quartered-684e@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


