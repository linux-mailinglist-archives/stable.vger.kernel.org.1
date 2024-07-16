Return-Path: <stable+bounces-59462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD1A9328FD
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B466280A11
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7CC1A9910;
	Tue, 16 Jul 2024 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6HhQp3z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B511A9908;
	Tue, 16 Jul 2024 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140122; cv=none; b=qmYHJM7x2tT/0zGmGzeIOR/Fsiri31sIcI0reZD0uRpIQDL39J4o7J/MlsurHMo9m8nSrCEwWLqatG4zXD0T9kF8W6TML8Zs0DWJOKPRSwdqlbl+aN59dcOHR90uVsJXg/onUEBKdyNLWEOggZJ3JJWI8m72j6CjMgK+nfCE1VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140122; c=relaxed/simple;
	bh=Q6Sgdr3qcfiBjDgWELUHUDzF5i9bT4+h0gQF2MoJbzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SuAaIaoNiz/+8W7ziwVhNZb8y5301JEdQEo///QBFXJ1ZoG5bQMBD8xK+Nzp1wbqEAzGGFcFTWojtMBdFpwckQJemNBDdREZ9H5nEToTfrZg0Z1CBcAbL51pJTpvYI1EGH6JtcJIiNiu75v9EdmhOFdu6ZfLuHb88X6SgSuN3YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6HhQp3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5E8C4AF0F;
	Tue, 16 Jul 2024 14:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140121;
	bh=Q6Sgdr3qcfiBjDgWELUHUDzF5i9bT4+h0gQF2MoJbzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G6HhQp3z8Brug+uaZEXVTgyDG+r3GPMNCUGAENleMOLPv1lKAD507vBEnS6Bpn87H
	 NvO1ZzI8DQcq13sQwUrhDR+MTLSU7nPlok8dCULIdILD9/Cy4btTym9y+TJDoSr/KW
	 ZCwJ3iwUH6wwIK4pp3M/1ouo2IhzIZbwgtpkCBCfzDpr0DNw305BNFwaq6daMTkuJG
	 TRWXrpiFRGmnhgS0Jq5r2F+aAJoRQUOUwVY1ZJ584jjbopFJWyvbVEs5DPhpDEO6Un
	 yIjyIwDpQK2eL7b/mmbdqlwJKb6/U6BYiisoepSEY5WP73Qvn6K0MP5NHACMk5DD0O
	 HCkh5LpqG34Lw==
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
Subject: [PATCH AUTOSEL 6.1 06/15] Bluetooth: hci_core: cancel all works upon hci_unregister_dev()
Date: Tue, 16 Jul 2024 10:28:03 -0400
Message-ID: <20240716142825.2713416-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142825.2713416-1-sashal@kernel.org>
References: <20240716142825.2713416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.99
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
index d6be3cb86598e..3b1b0fbd1240a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2727,7 +2727,11 @@ void hci_unregister_dev(struct hci_dev *hdev)
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


