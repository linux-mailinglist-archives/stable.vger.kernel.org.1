Return-Path: <stable+bounces-59476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BC4932920
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CAC21F22298
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE231AC244;
	Tue, 16 Jul 2024 14:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DK15zU3W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454591AC23F;
	Tue, 16 Jul 2024 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140174; cv=none; b=k4aoeSYxkNtUIRjicpjzrVnbQvRpvEqpRe8QAAOSvLTUgXw/ynO2979klNxd5BgT4prv9p05GFkcIZ6a8uQnROFAnl5/CRJmaQcPstMTzDFhOL6kxU3r9Q3/mXAZBtSnnsg6dFV4/qGYEcdlUCr2pIGL69qXkzW+SASvMOgRoYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140174; c=relaxed/simple;
	bh=FvRVvRhDxhKgP6Knvs6LvIfWCCEoEm9h1K96gVgf11U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDSSwQWjZPBTe6YmBvGHeyV7P/+1dAr6ukcCt0Gds2txCYT/Tg69JP/aG5kM1wTb5Q5bbdrAm0tVy+67dc+B+5Z+S9xwbAWnX4usf2RYt9HKinSuahgZ5rmqHnHTdygBsvfk6i7Q1+q/v3XivcR5Q+Sxq+Etzztc0H2XMDDdJIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DK15zU3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A86C4AF0D;
	Tue, 16 Jul 2024 14:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140173;
	bh=FvRVvRhDxhKgP6Knvs6LvIfWCCEoEm9h1K96gVgf11U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DK15zU3WS7llyUZ1V5ZiP+Hhljgju9wrL721zzFS3ejAfqcUkGqyAgbegKxlz3pvW
	 5CrZQFz/FOtHlSmzpSMI6FJtE9sKBuPHqqbHGTeGPvEiBs12h8bHvRgL8U4mBMEUjk
	 R6FKLx4gtHFj3WArdcwIbkKp9sdFZq4HhIiZJO89LJ7bl1+t7YXz8GEti/TX74TzI0
	 Ho5sRrNO1yGcrPTUiyZvsB1TG/qVT9IJ5nFOashGqMaMw0pYKQGL7eJZc+ywuthFrv
	 35s7syCzfH4Oe2DiGsQHSVgOF9qjXCYrfnWHeWeDtgu2QBLCFy2LZo2EJejjOwn8o0
	 TVyuYCgUwcl+w==
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
Subject: [PATCH AUTOSEL 5.15 5/9] Bluetooth: hci_core: cancel all works upon hci_unregister_dev()
Date: Tue, 16 Jul 2024 10:29:07 -0400
Message-ID: <20240716142920.2713829-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142920.2713829-1-sashal@kernel.org>
References: <20240716142920.2713829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.162
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
index 8a3c867bdff03..fc4e02b3f26ad 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4025,7 +4025,11 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	list_del(&hdev->list);
 	write_unlock(&hci_dev_list_lock);
 
+	cancel_work_sync(&hdev->rx_work);
+	cancel_work_sync(&hdev->cmd_work);
+	cancel_work_sync(&hdev->tx_work);
 	cancel_work_sync(&hdev->power_on);
+	cancel_work_sync(&hdev->error_reset);
 
 	if (!test_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks)) {
 		hci_suspend_clear_tasks(hdev);
-- 
2.43.0


