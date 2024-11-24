Return-Path: <stable+bounces-95081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C6B9D74DC
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0074B66A54
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4414E2139C7;
	Sun, 24 Nov 2024 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="om3avAKi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F0C2139AF;
	Sun, 24 Nov 2024 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455916; cv=none; b=DRMWXWkS1mBqBysZQC/eK/XvYXzHnDulc1zyKLkuERo+/UdMOVXSso2fbZ2BrQO9UbG2hwd/sYSfW4IyZO3Y/q0IqkTy1hAenwytdImm6W8YA8dSdOLIoBw4aP9cxMzniura/R9keli6nkLKo02Nroy/VHtA1BtZG1z72xLXtIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455916; c=relaxed/simple;
	bh=y0KnpBy0/m3xTNELe/nW9mxevfXS/VOna3RkgHO6PJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EmYjdtEteFdPQ3mjit/Mxya0TRF/b3xsO9DW06MEPUmPlvXmxvxVc2fzu5LAZIz8pfrj0B86NboMV9Oai+4bBjWymdL2Z1VdtwEAos/rBEO6TXygawepJ94ACsdD5ErevOhSTQW5c19MAIxHNedDRSc76g1CdytMJEwlE/ss5Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=om3avAKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DC4C4CED3;
	Sun, 24 Nov 2024 13:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455915;
	bh=y0KnpBy0/m3xTNELe/nW9mxevfXS/VOna3RkgHO6PJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=om3avAKirdgK/zLdMo0nN3eyGY+lWx/OoN1QTxs92NMtbOOBjZ6QHParQiG8UTMgq
	 3KVThLHZFX6kAR1qCjvVEIVyo6omXEFAWRqWHrSSjpcUHCle6xFSej7hK0UoG8TGMu
	 kz/6mQaY1WR6E76Tg7UDTmkwuqahLOHbeEPGA4tcGjb+Hv9B0ZW/pAcSRxXCvbqiYl
	 zDuagbuXIh/H8wOC20Ov+g6mtkkBk/J1E3+sKAwckH8rBlZT//lxzQb2N5keqvckDk
	 Kg7QklV4+73wMlsDnB4njnsqweypc6QIQRUCMD5JgqZDzUrbLBsSANBHxEntqiCQJl
	 9v6GDsj1El3kw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	syzbot+2446dd3cb07277388db6@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 78/87] Bluetooth: hci_conn: Use disable_delayed_work_sync
Date: Sun, 24 Nov 2024 08:38:56 -0500
Message-ID: <20241124134102.3344326-78-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 2b0f2fc9ed62e73c95df1fa8ed2ba3dac54699df ]

This makes use of disable_delayed_work_sync instead
cancel_delayed_work_sync as it not only cancel the ongoing work but also
disables new submit which is disarable since the object holding the work
is about to be freed.

Reported-by: syzbot+2446dd3cb07277388db6@syzkaller.appspotmail.com
Tested-by: syzbot+2446dd3cb07277388db6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2446dd3cb07277388db6
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_conn.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 49e3d4fb49a0e..7fc928e1106fd 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1128,9 +1128,9 @@ void hci_conn_del(struct hci_conn *conn)
 
 	hci_conn_unlink(conn);
 
-	cancel_delayed_work_sync(&conn->disc_work);
-	cancel_delayed_work_sync(&conn->auto_accept_work);
-	cancel_delayed_work_sync(&conn->idle_work);
+	disable_delayed_work_sync(&conn->disc_work);
+	disable_delayed_work_sync(&conn->auto_accept_work);
+	disable_delayed_work_sync(&conn->idle_work);
 
 	if (conn->type == ACL_LINK) {
 		/* Unacked frames */
-- 
2.43.0


