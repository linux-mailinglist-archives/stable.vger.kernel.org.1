Return-Path: <stable+bounces-186812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1506CBE9B9E
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60AA4188648D
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1864E32C944;
	Fri, 17 Oct 2025 15:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EwSte5zP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C726E3370F7;
	Fri, 17 Oct 2025 15:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714307; cv=none; b=iXsRrmdce7zwaZ5FnV+sAq3Oy1eWEj3UUXPZ+ndMtCGwh8gV1xBGpLKNUyK1FY8QsCKxGU0Ob85rgYn3jPBqECpuH7QnB8tkndReG+vFsgfp1jH1dn1dFozKCEnXi69Sl2Yz8XYwIVRqTnRf9G+EmlV+TlCB/NO0ZFk2sixGsRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714307; c=relaxed/simple;
	bh=0S6W15hrHQrDqF4sw/uxj8wu1sLoic+nYcqEH3RnMVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZROdQFHOaTiDNwYho/Trtef8fG9ZjkIRzurFzDWSzFJ7xiSctuUTygHyfuXOU+jsXYwxOMuTXL5MNf/gBUCJh2CL5ZhVVuO6Hffa8d72n9cO9iAcasSAxX7KRYSBWNfx1h8JdqAO/C+d/9lwMcX0aN3GSNvZN59eaKPQ1r2K7Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EwSte5zP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AFFC4CEE7;
	Fri, 17 Oct 2025 15:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760714307;
	bh=0S6W15hrHQrDqF4sw/uxj8wu1sLoic+nYcqEH3RnMVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EwSte5zPaqA98IV2CvzwRqdBF3Xwp4jbbLv/QIgV/MJuytANYdbtt+0XioQD34AV+
	 oetQBkJRt1JLkaFbJDYTn+6hJkf5FIPKbo2FPN6rgflw2VHdXl9aRIh5a6uQGR6eJ1
	 terJtvpAisnsKILQ0+Tv1zbbzmNYAxyqsIJBTTbg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 066/277] mailbox: mtk-cmdq-mailbox: Switch to __pm_runtime_put_autosuspend()
Date: Fri, 17 Oct 2025 16:51:13 +0200
Message-ID: <20251017145149.553252555@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145147.138822285@linuxfoundation.org>
References: <20251017145147.138822285@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 08fb6d8ff900a1d06ef2f4a6ded45cdaa7140c01 ]

pm_runtime_put_autosuspend() will soon be changed to include a call to
pm_runtime_mark_last_busy(). This patch switches the current users to
__pm_runtime_put_autosuspend() which will continue to have the
functionality of old pm_runtime_put_autosuspend().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
Stable-dep-of: 3f39f5652037 ("mailbox: mtk-cmdq: Remove pm_runtime APIs from cmdq_mbox_send_data()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index d24f71819c3d6..4e093b58fb7b5 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -390,7 +390,7 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
 
 	task = kzalloc(sizeof(*task), GFP_ATOMIC);
 	if (!task) {
-		pm_runtime_put_autosuspend(cmdq->mbox.dev);
+		__pm_runtime_put_autosuspend(cmdq->mbox.dev);
 		return -ENOMEM;
 	}
 
@@ -440,7 +440,7 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
 	list_move_tail(&task->list_entry, &thread->task_busy_list);
 
 	pm_runtime_mark_last_busy(cmdq->mbox.dev);
-	pm_runtime_put_autosuspend(cmdq->mbox.dev);
+	__pm_runtime_put_autosuspend(cmdq->mbox.dev);
 
 	return 0;
 }
@@ -488,7 +488,7 @@ static void cmdq_mbox_shutdown(struct mbox_chan *chan)
 	spin_unlock_irqrestore(&thread->chan->lock, flags);
 
 	pm_runtime_mark_last_busy(cmdq->mbox.dev);
-	pm_runtime_put_autosuspend(cmdq->mbox.dev);
+	__pm_runtime_put_autosuspend(cmdq->mbox.dev);
 }
 
 static int cmdq_mbox_flush(struct mbox_chan *chan, unsigned long timeout)
@@ -528,7 +528,7 @@ static int cmdq_mbox_flush(struct mbox_chan *chan, unsigned long timeout)
 out:
 	spin_unlock_irqrestore(&thread->chan->lock, flags);
 	pm_runtime_mark_last_busy(cmdq->mbox.dev);
-	pm_runtime_put_autosuspend(cmdq->mbox.dev);
+	__pm_runtime_put_autosuspend(cmdq->mbox.dev);
 
 	return 0;
 
@@ -543,7 +543,7 @@ static int cmdq_mbox_flush(struct mbox_chan *chan, unsigned long timeout)
 		return -EFAULT;
 	}
 	pm_runtime_mark_last_busy(cmdq->mbox.dev);
-	pm_runtime_put_autosuspend(cmdq->mbox.dev);
+	__pm_runtime_put_autosuspend(cmdq->mbox.dev);
 	return 0;
 }
 
-- 
2.51.0




