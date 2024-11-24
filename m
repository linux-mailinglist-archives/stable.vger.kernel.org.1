Return-Path: <stable+bounces-95195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B034E9D7414
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A339A165147
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A17238F68;
	Sun, 24 Nov 2024 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwoBYgtQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCCD1E2317;
	Sun, 24 Nov 2024 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456298; cv=none; b=cuf8QZx/lA/mUcrhhqTTtJjnWXkRRpDgd/HC8HLc8/E0e8MawgM0AxTvojWzxI1DKNAAD0zye3q0o8cjNM/t+SMDqigaNOLiHuOG/0GJirdbFn2jVeSnBeAGJBiJsd0jQEDIE7/5QWF49aDMdf7AWCbp0nCQSfm5qrlj0FmxNZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456298; c=relaxed/simple;
	bh=P3xeDvBAparxvrvnb4QO/f6mT7L9L0794cMCIByUdPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhKnyQqtlMfY6SKwJJPUxWuhIdt0ZhewoOdJCdG0F6fSPgz5jETdzXY0G+vAZwwlJNz+sgd8h4UC2/XCYKyb2Km6jOXfZ50DupeH1RTUB/j/BrGV32jiKFgy/gA1gf/cVLmQ0LVVHpohFWZ5B1fUpF2yFVffOB6WUMYrzHbmyOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwoBYgtQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B3DC4CED9;
	Sun, 24 Nov 2024 13:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456297;
	bh=P3xeDvBAparxvrvnb4QO/f6mT7L9L0794cMCIByUdPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EwoBYgtQf3uWjd5mHpM6Iv6sxa7h/jpKrCmDNQYBpZkOhGLz5YuJOuhtc/0yllm/A
	 INh4bhQ05/+EeRx5vjgMWq8B/HEO89KhVCXKdX92PNyBEnMJx7L0TrRIZYyoWn5JQP
	 4gj/1JZsfpsIFtbIKukrti6Rm+AA9SVV+7rLCdbBwK7nHCdyWIt3zhRsTstEuVgUsk
	 CG8Z/VuNBEp0h22Vg43FIo1hmvf64lxfQolYZikkxsTajh/8TSYhq84LG+KPM8Gp/V
	 U8gnZVqm3c+tW1PIXIl8urvv9ca1RWNpaaQJBiXI+st3t6atGDoXw3zTRX196oK1Bz
	 Y4Z4wC5p6BAvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 44/48] Bluetooth: hci_core: Fix not checking skb length on hci_acldata_packet
Date: Sun, 24 Nov 2024 08:49:07 -0500
Message-ID: <20241124134950.3348099-44-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134950.3348099-1-sashal@kernel.org>
References: <20241124134950.3348099-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 3fe288a8214e7dd784d1f9b7c9e448244d316b47 ]

This fixes not checking if skb really contains an ACL header otherwise
the code may attempt to access some uninitilized/invalid memory past the
valid skb->data.

Reported-by: syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com
Tested-by: syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6ea290ba76d8c1eb1ac2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 789f7f4a09089..3cd7c212375fc 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3829,18 +3829,22 @@ static void hci_tx_work(struct work_struct *work)
 /* ACL data packet */
 static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_acl_hdr *hdr = (void *) skb->data;
+	struct hci_acl_hdr *hdr;
 	struct hci_conn *conn;
 	__u16 handle, flags;
 
-	skb_pull(skb, HCI_ACL_HDR_SIZE);
+	hdr = skb_pull_data(skb, sizeof(*hdr));
+	if (!hdr) {
+		bt_dev_err(hdev, "ACL packet too small");
+		goto drop;
+	}
 
 	handle = __le16_to_cpu(hdr->handle);
 	flags  = hci_flags(handle);
 	handle = hci_handle(handle);
 
-	BT_DBG("%s len %d handle 0x%4.4x flags 0x%4.4x", hdev->name, skb->len,
-	       handle, flags);
+	bt_dev_dbg(hdev, "len %d handle 0x%4.4x flags 0x%4.4x", skb->len,
+		   handle, flags);
 
 	hdev->stat.acl_rx++;
 
@@ -3859,6 +3863,7 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 			   handle);
 	}
 
+drop:
 	kfree_skb(skb);
 }
 
-- 
2.43.0


