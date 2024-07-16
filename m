Return-Path: <stable+bounces-59444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6419328C7
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9473284C90
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779B01A38F0;
	Tue, 16 Jul 2024 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtpENPCb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310441A38CA;
	Tue, 16 Jul 2024 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140049; cv=none; b=VACEJ2GrUq8beCRjoCAqSfn05e5GnAzZ5FibXcMBvjQJcpnDIwn4zoBcPO1dKD2wubU1XfsRsTJrTmZ4/ky5OoJ7q76ZmeSzTGV0Ehn4+LB4qBqPMWhAIdXzj45HCewqxjDxP28v2R1IcmFpUAX4qUTp+hOPR+KEp/P6IpfqxPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140049; c=relaxed/simple;
	bh=3W1wUoGGs1BquKcz6HkntueG/jrF+IRZb3GT9f1M2K4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdreR14+XQSlBYNOuXXoAQBXZs0a0SrOAu8+scBS0bwBvxMoeSTOwIEbXyVOobgT0F7ZPzgnx95edxLKTyytxV6V9wB/zE4Ls7Ys3Dy+Yi4Y+SDfCKd3zZ00DXmqfb7WdeCeQBKRy2/UFhku40774Ujon0/ZPaW4Ok6jCaRmwA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtpENPCb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0B3C4AF09;
	Tue, 16 Jul 2024 14:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140049;
	bh=3W1wUoGGs1BquKcz6HkntueG/jrF+IRZb3GT9f1M2K4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NtpENPCbGQ3tSbuzIRFTyMFA2OF3onIN/EOa5ObUC+tacLQIeeF18bR5L+Hge9zeq
	 usverx4r+SYtX81zwvhP/1LWU8GuokemQDgmtvsHFtogWVCKBVG7+gB0AQWBkbjKN7
	 ZQndtAwLtoojQqw1r/YhyQ7sCzvU0Txi3JSxLEiXqOkoxwcZ5RetW7dNGWyiIXfG68
	 sz081TdKATEnBV096ev8oOMZTxh03Vg4Uw56jO+Z21f6gDa/Ubipjvg+oSoDEVdl9o
	 rnTNaMDrobGJZnXZauyPycwdgypwuknPWlZ75Neavkvv4adPt3Ynr0TQ6OTe50gQHH
	 i4V+kyR5foVgQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot <syzbot+da0a9c9721e36db712e8@syzkaller.appspotmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 06/18] Bluetooth: hci_core: cancel all works upon hci_unregister_dev()
Date: Tue, 16 Jul 2024 10:26:41 -0400
Message-ID: <20240716142713.2712998-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142713.2712998-1-sashal@kernel.org>
References: <20240716142713.2712998-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.40
Content-Transfer-Encoding: 8bit

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit 0d151a103775dd9645c78c97f77d6e2a5298d913 ]

syzbot is reporting that calling hci_release_dev() from hci_error_reset()
due to hci_dev_put() from hci_error_reset() can cause deadlock at
destroy_workqueue(), for hci_error_reset() is called from
hdev->req_workqueue which destroy_workqueue() needs to flush.

We need to make sure that hdev->{rx_work,cmd_work,tx_work} which are
queued into hdev->workqueue and hdev->{power_on,error_reset} which are
queued into hdev->req_workqueue are no longer running by the moment

       destroy_workqueue(hdev->workqueue);
       destroy_workqueue(hdev->req_workqueue);

are called from hci_release_dev().

Call cancel_work_sync() on these work items from hci_unregister_dev()
as soon as hdev->list is removed from hci_dev_list.

Reported-by: syzbot <syzbot+da0a9c9721e36db712e8@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=da0a9c9721e36db712e8
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3817d6369f0cc..b4d5b7200ff9c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2704,7 +2704,11 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	list_del(&hdev->list);
 	write_unlock(&hci_dev_list_lock);
 
+	cancel_work_sync(&hdev->rx_work);
+	cancel_work_sync(&hdev->cmd_work);
+	cancel_work_sync(&hdev->tx_work);
 	cancel_work_sync(&hdev->power_on);
+	cancel_work_sync(&hdev->error_reset);
 
 	hci_cmd_sync_clear(hdev);
 
-- 
2.43.0


