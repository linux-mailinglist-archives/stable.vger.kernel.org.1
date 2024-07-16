Return-Path: <stable+bounces-59492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2090E93294F
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC06283265
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5DF1A2C3D;
	Tue, 16 Jul 2024 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l948XojN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DDC1A2C36;
	Tue, 16 Jul 2024 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140235; cv=none; b=Voe9DmoNd551ciTpyj9j1mwk/Nd2IcT0CGvlrxDlKpUaJZIEjLt+JkxggTZGYq6D14iAjbrXpxyVOtZKXaicX/nF/mVDsocgQTz2GHctETXWRyEmA6X8z65m2kHo3cgjub1C82omaHM/R6wBhC82RZA1S2m2krGzPtgIqp/fV88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140235; c=relaxed/simple;
	bh=t6Ou0cgHkOSKv9/IlyZnC/gqXLn53JTX48K5CiGFsbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEuesM+9A/2dnKhfD/Z3E3uIj0qpjdmx5VBwroZPSkgNJEruB64ZZN6AWk1dU8b1YzxDRImrBaYd8YEq6h83FuvPOiH38um4J53PnmzVKdg7gNZSLtcbviC71pDuMQ/2Qb2+GCMDrStI8dYQl3vBRxTiwo7vPHTI4N+dAJc/OQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l948XojN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B59C4AF0F;
	Tue, 16 Jul 2024 14:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140235;
	bh=t6Ou0cgHkOSKv9/IlyZnC/gqXLn53JTX48K5CiGFsbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l948XojNMYsJcyKCA5gqGIYqZr7rGJl1exonPTQq/PvxcUDy0/lLYSllEVbaleBvM
	 x+uIOPAhQoVdXaT/XSjpGQU6PO1N6F1yZN50dvAIVGxLp4iriR1H22yhLOdTCZ8s78
	 7v4QCrnQG27ZBSZHpZ526b7mrm7FFrqlXaztiiSHZV6B0wz5xEeZsRh/yCTgWFN4rf
	 0ImnQlSB0diMBLdKBjBhoBaxTDnFwNng9Ew4OWLaTwgL5A6k/3g6dDxVN3tlvoh3A+
	 w/w8Vpfbq0qwbktxxsbKdXe7VCgUvhz7+bSkH8jD9Q2qJsf+bMMaQyUl06+7X04UvU
	 7wpzBacvMYH5Q==
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
Subject: [PATCH AUTOSEL 5.4 5/7] Bluetooth: hci_core: cancel all works upon hci_unregister_dev()
Date: Tue, 16 Jul 2024 10:30:13 -0400
Message-ID: <20240716143021.2714348-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716143021.2714348-1-sashal@kernel.org>
References: <20240716143021.2714348-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.279
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
index c60204b639ab7..71a7e42097cc0 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3412,7 +3412,11 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	list_del(&hdev->list);
 	write_unlock(&hci_dev_list_lock);
 
+	cancel_work_sync(&hdev->rx_work);
+	cancel_work_sync(&hdev->cmd_work);
+	cancel_work_sync(&hdev->tx_work);
 	cancel_work_sync(&hdev->power_on);
+	cancel_work_sync(&hdev->error_reset);
 
 	hci_dev_do_close(hdev);
 
-- 
2.43.0


