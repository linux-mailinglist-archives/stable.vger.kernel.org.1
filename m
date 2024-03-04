Return-Path: <stable+bounces-26272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D83DB870DD5
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DFAE1F22F13
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97212200D4;
	Mon,  4 Mar 2024 21:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HV4wPBam"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A9979DCE;
	Mon,  4 Mar 2024 21:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588289; cv=none; b=BLZ3FTQEu1859MJOJUMekrjEXC7cxO6ZQSKIBAJY6VdEnMX+jiIdBDboC6L0OIWP3srzAeJrKVRAUrFpGB41U/8dNC3WXqyWfGKmLUWIcY0u6OQGGV3ohuPx0Zo4Wi2BW4aiIVorRxIDg40cnydEwh1bFtYgPwNw4999LQnmIwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588289; c=relaxed/simple;
	bh=z9piTKs2+ha47E9GqOogUN1WWyjE35nlumQRhvM+KNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4QqYPBGacV6NeL3UEBvpjUZnMv0LSRDqB94Mj2+f33jnHZqoQlGpyOC6fxdU3Pg1Fr1bIlXAmXjghVGKhw5XIxLVQdOyfk8p2bDDNZockGYa5M9h+vR1VSbeHQOI7jtNiyvzmW42uL6pSvYMXmDJG9+mK7roO4JdXT9yQmdJ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HV4wPBam; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8DEC433C7;
	Mon,  4 Mar 2024 21:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588289;
	bh=z9piTKs2+ha47E9GqOogUN1WWyjE35nlumQRhvM+KNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HV4wPBam6RMe4hzK28JlvUnFo3JPYzjkEFWOM7ryTehHjM1HQCpLyTnxJD0gJQwbj
	 h6HhZsT8BwV/r49mY2loZr8mSQkqtxCgLwKfNIcgRG7dLCT94YBSH6dw6PH27wS/J8
	 WdkuOTBnT99LEioWQzK4B/mAiWyWmMy3xzp/ZkFs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 026/143] Bluetooth: hci_event: Fix wrongly recorded wakeup BD_ADDR
Date: Mon,  4 Mar 2024 21:22:26 +0000
Message-ID: <20240304211550.783154823@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211549.876981797@linuxfoundation.org>
References: <20240304211549.876981797@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zijun Hu <quic_zijuhu@quicinc.com>

[ Upstream commit 61a5ab72edea7ebc3ad2c6beea29d966f528ebfb ]

hci_store_wake_reason() wrongly parses event HCI_Connection_Request
as HCI_Connection_Complete and HCI_Connection_Complete as
HCI_Connection_Request, so causes recording wakeup BD_ADDR error and
potential stability issue, fix it by using the correct field.

Fixes: 2f20216c1d6f ("Bluetooth: Emit controller suspend and resume events")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 16e442773229b..2c5b321806b3f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7430,10 +7430,10 @@ static void hci_store_wake_reason(struct hci_dev *hdev, u8 event,
 	 * keep track of the bdaddr of the connection event that woke us up.
 	 */
 	if (event == HCI_EV_CONN_REQUEST) {
-		bacpy(&hdev->wake_addr, &conn_complete->bdaddr);
+		bacpy(&hdev->wake_addr, &conn_request->bdaddr);
 		hdev->wake_addr_type = BDADDR_BREDR;
 	} else if (event == HCI_EV_CONN_COMPLETE) {
-		bacpy(&hdev->wake_addr, &conn_request->bdaddr);
+		bacpy(&hdev->wake_addr, &conn_complete->bdaddr);
 		hdev->wake_addr_type = BDADDR_BREDR;
 	} else if (event == HCI_EV_LE_META) {
 		struct hci_ev_le_meta *le_ev = (void *)skb->data;
-- 
2.43.0




