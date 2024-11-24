Return-Path: <stable+bounces-95082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FF49D74C2
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4E04BE0979
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10FF2144B5;
	Sun, 24 Nov 2024 13:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhYm+wKF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAE72144A9;
	Sun, 24 Nov 2024 13:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455917; cv=none; b=HdqvJQD0b4cT2y8PJ4btwmkfhzoccprxQVYRMp8Fo0zxKROgu4Ww5AYbzT04fVkRtGsdHKhmse4WkHEab84PBX5PLlm6lVZJFuIfNF0ToHjtaUYZOsehRZL8QiMe/Y4/MTLqQ9xiVoSQLuUip+QKKXCORKl0KVvtObChA2XFF+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455917; c=relaxed/simple;
	bh=AI3bhi9orj/Ra2LDSWfp+fKGd61qHE/l3ogcRvdkoPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QfijgKH8C8DrmZ7UL1EeejYl9v8eb51wVFYipL8RoAfC9rLM1YES3DLr5gWhtUomeHpd5iUZXPa5PFVgg8/z6Yqds2eE8KdUyoUWmyrXup5kjdRhZn+qw4Ol39V1S5sESBsrNkZtHRsN1WE4DuS1AGF8i8jp4ATHUk0vGqUslWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhYm+wKF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA82C4CECC;
	Sun, 24 Nov 2024 13:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455917;
	bh=AI3bhi9orj/Ra2LDSWfp+fKGd61qHE/l3ogcRvdkoPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KhYm+wKF7uspBpsoxutXPvIqXQIGUCKsVvOPWua1o82RBUKZF/RD97fXGHpLn2B5s
	 wlHvKNLpRRbB0DRpmjOXLT2gk3zwQl6BKeTquD3pJHtN9Gd7iSJIgnBXm/MGK8g/Cw
	 FRxkX+joFDAZYQCHZnCQ/kMdbD5Xv4S55BldKLRq7VVJ9bt9NYwzq6dwKk8fuEsTUf
	 EUY5owXN5Nxk66vhCmuNzxRdvhypkvqXSXweth6ZFvqzctBiTYgQGsud7z0zjCcAHh
	 u6BxTb3+nVMuA+0HwoPJ6qhIitTz9ffxfS/CfMf44/ZvGiH44vSSxYhjL/MphqdenN
	 DqigUEiGrnGXA==
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
Subject: [PATCH AUTOSEL 6.11 79/87] Bluetooth: hci_core: Fix not checking skb length on hci_acldata_packet
Date: Sun, 24 Nov 2024 08:38:57 -0500
Message-ID: <20241124134102.3344326-79-sashal@kernel.org>
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
index eeb4f025ca3bf..bda70d0268e09 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3771,18 +3771,22 @@ static void hci_tx_work(struct work_struct *work)
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
 
@@ -3801,6 +3805,7 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 			   handle);
 	}
 
+drop:
 	kfree_skb(skb);
 }
 
-- 
2.43.0


