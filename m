Return-Path: <stable+bounces-160310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD91DAFA4FA
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 13:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311C63BD158
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 11:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576E9202C44;
	Sun,  6 Jul 2025 11:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n5r9TcIl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1790417BCE
	for <stable@vger.kernel.org>; Sun,  6 Jul 2025 11:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751802778; cv=none; b=uhAjCEsB0ubtj2JuVNi3tRgvUcui4SONQFzMtNtomJmHgVs/RxLuNlwtPKL6og7rUiWGeuxmASO4WRhiLrRq8jdGrfKp7K68+o7CtEeuNdgBkAqD/j5kMJ1MkdtHRhJkihopDoUb6buri/dr291KR6GpLZLbdwiApW23MEZcvtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751802778; c=relaxed/simple;
	bh=vaf5KtmiBmnYNsK24vdb35jMpd6ctyevYbTUA7VcWr4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hmuCUuh5Il4aGmw2tGxhTM39Gz5We+Yb5LZ7eAKIqOYVXWN69+iDqyeTKjsW5b1petTeRx9cz+4qiWMcYVFjmNZi0Fsve+Z+8KpZJ27zA/wNgX+f1eIlzBKkcd8HZy1Tg3KAIfiULBCiOH5zmtpf4aU35oTbJ0cATVsGx6Tpl2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n5r9TcIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953A8C4CEED;
	Sun,  6 Jul 2025 11:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751802778;
	bh=vaf5KtmiBmnYNsK24vdb35jMpd6ctyevYbTUA7VcWr4=;
	h=Subject:To:Cc:From:Date:From;
	b=n5r9TcIl6ezLoXzN/b1Ax6L+Vtn4cjZnwBYr44Lk8gqFbtrTRq405D9kYrp/rnkiX
	 abr7LTTeADsn7rU8ahqaKPJtjxfxTAsvLkZR/PgTBHaie04YON2R7Xv5zPjvDLhtGR
	 ZOQJe3GuyuN/7CxR/mxMnRDTz38OiJn1vMyfaIUg=
Subject: FAILED: patch "[PATCH] mtk-sd: reset host->mrq on prepare_data() error" failed to apply to 5.10-stable tree
To: senozhatsky@chromium.org,mhiramat@kernel.org,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 06 Jul 2025 13:52:55 +0200
Message-ID: <2025070655-kindred-magnify-4bcf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x ec54c0a20709ed6e56f40a8d59eee725c31a916b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025070655-kindred-magnify-4bcf@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ec54c0a20709ed6e56f40a8d59eee725c31a916b Mon Sep 17 00:00:00 2001
From: Sergey Senozhatsky <senozhatsky@chromium.org>
Date: Wed, 25 Jun 2025 14:20:37 +0900
Subject: [PATCH] mtk-sd: reset host->mrq on prepare_data() error

Do not leave host with dangling ->mrq pointer if we hit
the msdc_prepare_data() error out path.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Fixes: f5de469990f1 ("mtk-sd: Prevent memory corruption from DMA map failure")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250625052106.584905-1-senozhatsky@chromium.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index b12cfb9a5e5f..d7020e06dd55 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1492,6 +1492,7 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	if (mrq->data) {
 		msdc_prepare_data(host, mrq->data);
 		if (!msdc_data_prepared(mrq->data)) {
+			host->mrq = NULL;
 			/*
 			 * Failed to prepare DMA area, fail fast before
 			 * starting any commands.


