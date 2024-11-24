Return-Path: <stable+bounces-94993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EC19D720F
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0DF0284AB1
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2181EC008;
	Sun, 24 Nov 2024 13:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/g/BHoo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643DB1EBFFF;
	Sun, 24 Nov 2024 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455522; cv=none; b=O0rsQ96Vux1mArOn69EUmYadpbraXROoZQIvMrmCweaibY+f9S3DAC5a0ZYLz1OLdLmZAk/CCdHXG/yUP2l+xo6hE8+Um/y/PBSpgxT1tvU0ppC3epo5YbiuuQX97M3arNrxSQRv+GTMbb+t9RLA0h9PSb2pl580Tjtl4SxPgpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455522; c=relaxed/simple;
	bh=zo8U0xBYsAN5HIsAOqtdzlLCdhJfbuLX8nPlkhdPqyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R42osaucWC5ImR/4l7uR6ICwpjkS76CIvUIuV0qncbvnGfq3HH82zhRJbnPpCC6ZfuFxN1UJ5LjWgt8rr40AFAVFgT8u2kg5X3kqRWqpKJ1Z7j0nrnm6GQ1Qr1OKEYdaDIVeDgsBLsaXMa8syWZZgk8PYmY3GWCvViK6ZvIkN6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/g/BHoo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2295C4CED1;
	Sun, 24 Nov 2024 13:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455521;
	bh=zo8U0xBYsAN5HIsAOqtdzlLCdhJfbuLX8nPlkhdPqyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M/g/BHoo42oswarRLIxNYGce9T6cz3XGMVqzckHKTZM/9cuIm2yngqwFnzoWdqKtH
	 p7Jo9smwuxuS0s0Vm/XwTGf2zz3LKfnv0METjBBhFam3qVcJ63yYvjEat1GTcHwFvv
	 PLmRsG9LILHADCXmz6Mj9rGcYH8OR3zOdWSf7y+4GTL0Dfgj22PzxzeE2Fyuawp+JW
	 kF6HXj6M30Y+sPJ360u9itdxjWm8bGBW/eU7hpBYOusbqPQlHVpuXswPH4uFaGq1eR
	 9cEEeHQApyjKCo1nNI27EDOOTxNTuypjtLVeDYLmXLa2Z15km6A63E1eopIBBQeNG0
	 ytDDeyv6UQ2PA==
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
Subject: [PATCH AUTOSEL 6.12 097/107] Bluetooth: hci_core: Fix not checking skb length on hci_acldata_packet
Date: Sun, 24 Nov 2024 08:29:57 -0500
Message-ID: <20241124133301.3341829-97-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index 0ac354db81779..72439764186ed 100644
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


