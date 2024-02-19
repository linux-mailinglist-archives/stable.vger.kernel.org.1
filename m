Return-Path: <stable+bounces-20703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF4985AB5B
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A3B1C21B1C
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C8E41C78;
	Mon, 19 Feb 2024 18:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DXJembwV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877BF1F952
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368316; cv=none; b=IywrjAIoa9bSj+yhRZmN+KUItioZzsWZ/OlU5uefqKmOMhUlQcaCURTOw9fP2UJfIle+M6o4Dhzi7NspoLo/XA2p/7RaxUvDPFMmitqThuCKGKZayQtm9qPzbgKP9+G0BW3JNgLEJBLjRkGBLM85V13IUxGSR5bEbXkHQQjwDV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368316; c=relaxed/simple;
	bh=t/dSVCK9Cv7i2noCSvJUCZLtUJoFmhTMQ+yB1sP56kY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=X+8x+c5RRw4RShpaILVzvt39RQFceIs1JRJFNrsbq/tLBj3AAk0/g69/YKObIeORBeblRmOjFOOr0JAwx3MMMWzFaoShhZdCYILmXDNlwaat1jt0usyFFEhfJ3hpOPqx6eDxOmvK2DrgJFYNh6Aqqa62swfwPZsuKDMumtI4tfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DXJembwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C08C433C7;
	Mon, 19 Feb 2024 18:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708368316;
	bh=t/dSVCK9Cv7i2noCSvJUCZLtUJoFmhTMQ+yB1sP56kY=;
	h=Subject:To:Cc:From:Date:From;
	b=DXJembwVNFSCA+0ZuC79nAZOQDCY0Ql2rwpNL51SO61/YAljEDh9GbTpJyPEJ4uqj
	 Fz60B36eunHS9M8xUgZiKEDiT79N0EDM9DQF/fGFosKBwBxG8NDDMzb/LiJGw/tTo1
	 ZQ0Ikz1tOik9aauptaDd3ypc4MA3gK3Oi7VsH/AA=
Subject: FAILED: patch "[PATCH] ASoC: SOF: IPC3: fix message bounds on ipc ops" failed to apply to 6.1-stable tree
To: cujomalainey@chromium.org,broonie@kernel.org,daniel.baluta@nxp.com,peter.ujfalusi@linux.intel.com,pierre-louis.bossart@linux.intel.com,timvp@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:45:13 +0100
Message-ID: <2024021912-plastic-bannister-f6dc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x fcbe4873089c84da641df75cda9cac2e9addbb4b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021912-plastic-bannister-f6dc@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

fcbe4873089c ("ASoC: SOF: IPC3: fix message bounds on ipc ops")
12c41c779fad ("ASoC: SOF: Refactor rx function for fuzzing")
989a3e447917 ("ASoC: SOF: ipc3: Check for upper size limit for the received message")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fcbe4873089c84da641df75cda9cac2e9addbb4b Mon Sep 17 00:00:00 2001
From: Curtis Malainey <cujomalainey@chromium.org>
Date: Tue, 13 Feb 2024 14:38:34 +0200
Subject: [PATCH] ASoC: SOF: IPC3: fix message bounds on ipc ops
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit 74ad8ed65121 ("ASoC: SOF: ipc3: Implement rx_msg IPC ops")
introduced a new allocation before the upper bounds check in
do_rx_work. As a result A DSP can cause bad allocations if spewing
garbage.

Fixes: 74ad8ed65121 ("ASoC: SOF: ipc3: Implement rx_msg IPC ops")
Reported-by: Tim Van Patten <timvp@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://msgid.link/r/20240213123834.4827-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/sof/ipc3.c b/sound/soc/sof/ipc3.c
index fb40378ad084..c03dd513fbff 100644
--- a/sound/soc/sof/ipc3.c
+++ b/sound/soc/sof/ipc3.c
@@ -1067,7 +1067,7 @@ static void sof_ipc3_rx_msg(struct snd_sof_dev *sdev)
 		return;
 	}
 
-	if (hdr.size < sizeof(hdr)) {
+	if (hdr.size < sizeof(hdr) || hdr.size > SOF_IPC_MSG_MAX_SIZE) {
 		dev_err(sdev->dev, "The received message size is invalid\n");
 		return;
 	}


