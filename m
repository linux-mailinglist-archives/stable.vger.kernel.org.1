Return-Path: <stable+bounces-144800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A35EABBE03
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 14:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72943189772D
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 12:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BB9269AE6;
	Mon, 19 May 2025 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AqZmm3Yt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F7826D4E3
	for <stable@vger.kernel.org>; Mon, 19 May 2025 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747658212; cv=none; b=Zeuvu5HDIXhdE4hHSeI9B093RtDAqbu58PTg5MLQUZ4rZxCiWXYoCUTPSEj39TXyW7vOzicWg0+rRUxzZ/TuiXonn13bbEEoRKD82yVL6WDkwDl9e/tAIN0C8JveFf7X/FXcVT7m29vWZko+tZXl512fDqvJ7BvMDH/yBoWR9Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747658212; c=relaxed/simple;
	bh=7Q33aqPD+paja+LFxCeNrCqTauw4in8EQ2OJdugTQAI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=e74LZiMIVD6Lf8frSJBAaCM96I0+KIQjMbpMQL9xdxtw2BwQKgYMmp/scgAchdYCUru2QY6107JbzdqteJ7ac9HBl0XB/38hEAz/W/A638eTio3RrtqVQdjpX6h69NO5LPkNVe0iPyHGlal6Fh/7q8XAwaqcuBpY0o1jY1/hVhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AqZmm3Yt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9000EC4CEE4;
	Mon, 19 May 2025 12:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747658212;
	bh=7Q33aqPD+paja+LFxCeNrCqTauw4in8EQ2OJdugTQAI=;
	h=Subject:To:Cc:From:Date:From;
	b=AqZmm3YtZo4Ggq94wmU0bm4gadyMKyjA8nOFNoTuL/zRDX0B3TkIW84ZYtfgNipRE
	 Y2yCFuhpMqcH3QNg8vP8vloz/mMjukWsyoTjJw1OlFhRboYmv0aNMbplXo4TxCDT4c
	 KAi1R6rpaFhtfkc5aJUgzu4akMFLOVlfuS9wmb00=
Subject: FAILED: patch "[PATCH] dma-buf: insert memory barrier before updating num_fences" failed to apply to 5.4-stable tree
To: hjeong.choi@samsung.com,christian.koenig@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 14:35:49 +0200
Message-ID: <2025051949-jaywalker-stargazer-fc9f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 72c7d62583ebce7baeb61acce6057c361f73be4a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051949-jaywalker-stargazer-fc9f@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 72c7d62583ebce7baeb61acce6057c361f73be4a Mon Sep 17 00:00:00 2001
From: Hyejeong Choi <hjeong.choi@samsung.com>
Date: Mon, 12 May 2025 21:06:38 -0500
Subject: [PATCH] dma-buf: insert memory barrier before updating num_fences
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

smp_store_mb() inserts memory barrier after storing operation.
It is different with what the comment is originally aiming so Null
pointer dereference can be happened if memory update is reordered.

Signed-off-by: Hyejeong Choi <hjeong.choi@samsung.com>
Fixes: a590d0fdbaa5 ("dma-buf: Update reservation shared_count after adding the new fence")
CC: stable@vger.kernel.org
Reviewed-by: Christian König <christian.koenig@amd.com>
Link: https://lore.kernel.org/r/20250513020638.GA2329653@au1-maretx-p37.eng.sarc.samsung.com
Signed-off-by: Christian König <christian.koenig@amd.com>

diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index 5f8d010516f0..b1ef4546346d 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -320,8 +320,9 @@ void dma_resv_add_fence(struct dma_resv *obj, struct dma_fence *fence,
 	count++;
 
 	dma_resv_list_set(fobj, i, fence, usage);
-	/* pointer update must be visible before we extend the num_fences */
-	smp_store_mb(fobj->num_fences, count);
+	/* fence update must be visible before we extend the num_fences */
+	smp_wmb();
+	fobj->num_fences = count;
 }
 EXPORT_SYMBOL(dma_resv_add_fence);
 


