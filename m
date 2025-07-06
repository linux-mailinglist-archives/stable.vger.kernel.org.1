Return-Path: <stable+bounces-160311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD34AFA4FB
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 13:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA1FD1689AC
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 11:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95943209F56;
	Sun,  6 Jul 2025 11:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e79HkHWp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5514117BCE
	for <stable@vger.kernel.org>; Sun,  6 Jul 2025 11:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751802786; cv=none; b=cWgONGQ/DgJxMF/c45PFHK41iTkqaGFpTw+7tufLyYOTQWacQyEUKx0ecimnSyyFbdKX4FGqkg6b9+tWV75pBE9mx5kEKBU5VrMmtB8Ucth6/tymAI3qzK0X210up7wK4DDExa6H5UunVp1aIpT0UIVVJH8d2lXRxer3rbi9fQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751802786; c=relaxed/simple;
	bh=qfWtksvk5i8wXJ25c4BIvicao7I8p4nVRaLrgXpFgzI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iHdWVVNYBxUE8P9OlS8bBXZzbYoUIIMxOEEneOXaUs3yE5vbcm3HG7JW38EMC+4LEGNiyd4kehe7GemxpOCRZ7JEMBgs4/slk6DnDXr599eacPIk7XP7VETRVxNYveRYpCMIszDbAZf8mwTiFTkcRpatBlP0DosGOo0t1PYo668=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e79HkHWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7817C4CEED;
	Sun,  6 Jul 2025 11:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751802786;
	bh=qfWtksvk5i8wXJ25c4BIvicao7I8p4nVRaLrgXpFgzI=;
	h=Subject:To:Cc:From:Date:From;
	b=e79HkHWpogYcxYSLhXxWGj9WwdfcRSP1CnqZcCjFI8yn+UoVHL1WdpWrVL9hVOqI5
	 MD27hGCjnhiuO1Oo+0Omt/9fd82eUTjoTBmS/gkn3CjU4W/kp4KzaQwynnv/47M+7a
	 9Y32UrNjG7ymW3YpATLGzft6BwFuJpyTG1nJZO3g=
Subject: FAILED: patch "[PATCH] mtk-sd: reset host->mrq on prepare_data() error" failed to apply to 5.4-stable tree
To: senozhatsky@chromium.org,mhiramat@kernel.org,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 06 Jul 2025 13:52:55 +0200
Message-ID: <2025070655-graded-numbly-6d00@gregkh>
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
git cherry-pick -x ec54c0a20709ed6e56f40a8d59eee725c31a916b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025070655-graded-numbly-6d00@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


