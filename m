Return-Path: <stable+bounces-8923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEED1820573
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E24C1F220AF
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B73881F;
	Sat, 30 Dec 2023 12:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZKj/Mtyh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2AC8486;
	Sat, 30 Dec 2023 12:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E24C433C7;
	Sat, 30 Dec 2023 12:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703938113;
	bh=WPrDYYGxTxRowPNe0SmqEqXs9yULJBSMOJsz2ijeV3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZKj/MtyhUidhzJYa4jog4q4ZbqExq+2tnWN3Z2kuDXuLtgq1vGk5NywgQTqr0MgFq
	 SdXAJr/93hsymbHgcHlOyDRUBRQRctj3MMFRve5I1BeZ+hZmAdjGdRvF01izC6YM4c
	 XrdGbaHK7LWARkSpjyKG0QiXHB3zBGiBkQzRgbto=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 032/112] Bluetooth: hci_event: shut up a false-positive warning
Date: Sat, 30 Dec 2023 11:59:05 +0000
Message-ID: <20231230115807.781587487@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115806.714618407@linuxfoundation.org>
References: <20231230115806.714618407@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit a5812c68d849505ea657f653446512b85887f813 ]

Turning on -Wstringop-overflow globally exposed a misleading compiler
warning in bluetooth:

net/bluetooth/hci_event.c: In function 'hci_cc_read_class_of_dev':
net/bluetooth/hci_event.c:524:9: error: 'memcpy' writing 3 bytes into a
region of size 0 overflows the destination [-Werror=stringop-overflow=]
  524 |         memcpy(hdev->dev_class, rp->dev_class, 3);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The problem here is the check for hdev being NULL in bt_dev_dbg() that
leads the compiler to conclude that hdev->dev_class might be an invalid
pointer access.

Add another explicit check for the same condition to make sure gcc sees
this cannot happen.

Fixes: a9de9248064b ("[Bluetooth] Switch from OGF+OCF to using only opcodes")
Fixes: 1b56c90018f0 ("Makefile: Enable -Wstringop-overflow globally")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_event.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c86a45344fe28..5e406e8716a0e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -515,6 +515,9 @@ static u8 hci_cc_read_class_of_dev(struct hci_dev *hdev, void *data,
 {
 	struct hci_rp_read_class_of_dev *rp = data;
 
+	if (WARN_ON(!hdev))
+		return HCI_ERROR_UNSPECIFIED;
+
 	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
 
 	if (rp->status)
-- 
2.43.0




