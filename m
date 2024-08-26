Return-Path: <stable+bounces-70169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFC095F041
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 13:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 884B4B208F5
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 11:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28A614B08E;
	Mon, 26 Aug 2024 11:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i1ZFIElP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936FA149018
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 11:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673539; cv=none; b=eo431vrj/NlLwvPb9ueeFBGSR/Nxz8rCiR/D3JYUBhQk49OFIJNYsS1uXg3Wgw6ZQjd0Ir4pfOmHs2diCp2OS0fH7D9yf/wsuHiJK5yxQoRGthG58nw0CjYIMzWSHlMr8jOzbYjc5AvrPUpn1n2v57EQrNXsGARD/1MgRppe8QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673539; c=relaxed/simple;
	bh=KSDNnraruNSVF0Vsd4zQ4yx64Vca7PuiXyW3gYFW8n4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Pqd8yT5ZfjLC1BVWQsJZ+YcHxyaBPjadpwEffVHWRIy4f+mEMlXPAuHfiO7fOZ4m536aFO2YQr0jNLaeumkzHN8kgdlKhuPpIeJOy56gc6liXAy10s5mE3IkkAVYeqzleHV0/q5myPQRaVmx4kPmfELopyIfYB8SBuS2YOrpnMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i1ZFIElP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C015FC51400;
	Mon, 26 Aug 2024 11:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724673538;
	bh=KSDNnraruNSVF0Vsd4zQ4yx64Vca7PuiXyW3gYFW8n4=;
	h=Subject:To:Cc:From:Date:From;
	b=i1ZFIElPG1C57PRIJdbwJrQlaOGNYFLz5ideeVpW77HhATeLjBtkwoMW15efRYOOM
	 fKI0pBjkAw++XQ4g+oeld1tH1DVrJe9HJVXYkhMbvj2P9+m4DhVXbBdK2pPZoCdW6z
	 TIsfkhAONy6v7YW4iP3lBixDA14YbP1AIbzBewT4=
Subject: FAILED: patch "[PATCH] mmc: mtk-sd: receive cmd8 data when hs400 tuning fail" failed to apply to 6.1-stable tree
To: mengqi.zhang@mediatek.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 13:58:55 +0200
Message-ID: <2024082654-stood-dollop-a306@gregkh>
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
git cherry-pick -x 9374ae912dbb1eed8139ed75fd2c0f1b30ca454d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082654-stood-dollop-a306@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

9374ae912dbb ("mmc: mtk-sd: receive cmd8 data when hs400 tuning fail")
b98e7e8daf0e ("mmc: Avoid open coding by using mmc_op_tuning()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9374ae912dbb1eed8139ed75fd2c0f1b30ca454d Mon Sep 17 00:00:00 2001
From: Mengqi Zhang <mengqi.zhang@mediatek.com>
Date: Tue, 16 Jul 2024 09:37:04 +0800
Subject: [PATCH] mmc: mtk-sd: receive cmd8 data when hs400 tuning fail

When we use cmd8 as the tuning command in hs400 mode, the command
response sent back by some eMMC devices cannot be correctly sampled
by MTK eMMC controller at some weak sample timing. In this case,
command timeout error may occur. So we must receive the following
data to make sure the next cmd8 send correctly.

Signed-off-by: Mengqi Zhang <mengqi.zhang@mediatek.com>
Fixes: c4ac38c6539b ("mmc: mtk-sd: Add HS400 online tuning support")
Cc: stable@vger.stable.com
Link: https://lore.kernel.org/r/20240716013704.10578-1-mengqi.zhang@mediatek.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index a94835b8ab93..e386f78e3267 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1230,7 +1230,7 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
 	}
 
 	if (!sbc_error && !(events & MSDC_INT_CMDRDY)) {
-		if (events & MSDC_INT_CMDTMO ||
+		if ((events & MSDC_INT_CMDTMO && !host->hs400_tuning) ||
 		    (!mmc_op_tuning(cmd->opcode) && !host->hs400_tuning))
 			/*
 			 * should not clear fifo/interrupt as the tune data
@@ -1323,9 +1323,9 @@ static void msdc_start_command(struct msdc_host *host,
 static void msdc_cmd_next(struct msdc_host *host,
 		struct mmc_request *mrq, struct mmc_command *cmd)
 {
-	if ((cmd->error &&
-	    !(cmd->error == -EILSEQ &&
-	      (mmc_op_tuning(cmd->opcode) || host->hs400_tuning))) ||
+	if ((cmd->error && !host->hs400_tuning &&
+	     !(cmd->error == -EILSEQ &&
+	     mmc_op_tuning(cmd->opcode))) ||
 	    (mrq->sbc && mrq->sbc->error))
 		msdc_request_done(host, mrq);
 	else if (cmd == mrq->sbc)


