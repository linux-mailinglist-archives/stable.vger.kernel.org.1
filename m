Return-Path: <stable+bounces-95144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2D79D73AD
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129ED166462
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DB522E9FE;
	Sun, 24 Nov 2024 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixXQ0+vj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD00122E9F3;
	Sun, 24 Nov 2024 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456134; cv=none; b=d1o0hS7wufyuDBWch9+UZqxXuPIvxzggS6WCE+PJX8Qs112Zhhlcyts85S0z9fD+s1mPn9H7+RPwe185LSkFmpSmWm9QIje5Wn3W0WD3gGlhnIwr1l+I+IGWixOES3Q050zn9B7IhP/47yjPgV2sNLVN7Fc+jrmPsdtHqvtgYVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456134; c=relaxed/simple;
	bh=5htpbNVlVssuaDXD5ZQBYFnRPksov76uNiMXsIOOPjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gj5NMsN5MKISCm7eGFfg0SEi0pE6WWAwdci4BlXQTqBKEWrsRZuVz14ttR2FAqY9I5vA7M8agc7h0bjYfLqvpw8fvFKi/G+aiLInUxyonggmaYHBMdXJcTPncl07FsQ3Q657hn2dqVMHZVZwnVjmwwgiA7Xo8nEzkaDJyeiL9iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixXQ0+vj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C48C4CECC;
	Sun, 24 Nov 2024 13:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456134;
	bh=5htpbNVlVssuaDXD5ZQBYFnRPksov76uNiMXsIOOPjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ixXQ0+vjN7BQ9aCGOOXWilN9prMcKyTEnefCMXqfL+d/kJvn6iwJJklIIJb5bN7SS
	 1i6gb8O6utpJVwq0lm2e4wSz3CpzWIk0OLlFZzZnywC0UGqWi2TbqvH/TwdsQTx44L
	 uU52xRXz63DXSK44lPO/IjpOTo+XujeLGkPGv2JXfw2cwcJI7u2SGQ68Bu4wTCR7sV
	 4pstZ1pV2oEBiGmFLrMUsvmw1lo6YBHW7g5cdrPlDubFNmmyvfCePb+AA8mtYo3/7J
	 Ln6Fb3oyuAzfSAcmzf0rvnmckgzGE2agI5OwXwGKFVNxFqko4qBTog405CBvxLdPU2
	 27ivzrg13caxA==
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
Subject: [PATCH AUTOSEL 6.6 54/61] Bluetooth: hci_core: Fix not checking skb length on hci_acldata_packet
Date: Sun, 24 Nov 2024 08:45:29 -0500
Message-ID: <20241124134637.3346391-54-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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
index 3cf4dd9cad8a3..30519d47e8a69 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3735,18 +3735,22 @@ static void hci_tx_work(struct work_struct *work)
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
 
@@ -3765,6 +3769,7 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 			   handle);
 	}
 
+drop:
 	kfree_skb(skb);
 }
 
-- 
2.43.0


