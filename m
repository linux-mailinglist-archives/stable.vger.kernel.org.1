Return-Path: <stable+bounces-84099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D19799CE20
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5AD11F23346
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663C31A0724;
	Mon, 14 Oct 2024 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CmeYbtkB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225E620EB;
	Mon, 14 Oct 2024 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916824; cv=none; b=bicnYAaYK/Q1aOEHqz0I/ZH99PMj27qE8VteJufsLn6EAz7jaIJAWqjP7LjbVp5lWxZPU2v+Hx7OQYj91/suYb1qVZW+Lox8oDxF8XtYjOKCGxuHbRmtHL2eZPGu2zW1Hn0Q7cb58jw28IQJ2s7JGGFJtmdikFflVyKi9yP4mCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916824; c=relaxed/simple;
	bh=DjsAsfDt+h1jUGxbEFZDr6qyQSWZ0xSpztlCXx/85hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYAciN7IUKkAUbUH4r0Mz1zYm+pLLuGcXkeLYqZ3CcFTF6icaHdRfIseM14fvp1kYCKVkCKKpxZEbwjbAoJwxzVQfSuGwDgcTzw76hRbq1lLZzcy9C0aaic3LsQhvrNSKCSG1xzNWyrlc54ok5NDmZw9pvez8uDzcQTOKAbi33g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CmeYbtkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADCEC4CEC3;
	Mon, 14 Oct 2024 14:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728916824;
	bh=DjsAsfDt+h1jUGxbEFZDr6qyQSWZ0xSpztlCXx/85hE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CmeYbtkBpZt475IwZ/pktPyD33dlk2ZYVnqyWPv7X1M2KWAaNHF8IkpsL1+s/2/G4
	 XeIEXNbL28ai+FBrB4MoY/3EBv1uzE7cIA8WiHH77iaw6LmiA/38z/yGG4Cb/dfq/E
	 o/BsALtxXsoTIwiynGDWjTCySjMIhoqZcDMxPCng=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 043/213] Bluetooth: Fix usage of __hci_cmd_sync_status
Date: Mon, 14 Oct 2024 16:19:09 +0200
Message-ID: <20241014141044.670469934@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141042.954319779@linuxfoundation.org>
References: <20241014141042.954319779@linuxfoundation.org>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 87be7b189b2c50d4b51512f59e4e97db4eedee8a ]

__hci_cmd_sync_status shall only be used if hci_req_sync_lock is _not_
required which is not the case of hci_dev_cmd so it needs to use
hci_cmd_sync_status which uses hci_req_sync_lock internally.

Fixes: f1a8f402f13f ("Bluetooth: L2CAP: Fix deadlock")
Reported-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_core.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f787b0eb7d669..d4e607bf35baf 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -711,8 +711,8 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 
 	switch (cmd) {
 	case HCISETAUTH:
-		err = __hci_cmd_sync_status(hdev, HCI_OP_WRITE_AUTH_ENABLE,
-					    1, &dr.dev_opt, HCI_CMD_TIMEOUT);
+		err = hci_cmd_sync_status(hdev, HCI_OP_WRITE_AUTH_ENABLE,
+					  1, &dr.dev_opt, HCI_CMD_TIMEOUT);
 		break;
 
 	case HCISETENCRYPT:
@@ -723,23 +723,21 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 
 		if (!test_bit(HCI_AUTH, &hdev->flags)) {
 			/* Auth must be enabled first */
-			err = __hci_cmd_sync_status(hdev,
-						    HCI_OP_WRITE_AUTH_ENABLE,
-						    1, &dr.dev_opt,
-						    HCI_CMD_TIMEOUT);
+			err = hci_cmd_sync_status(hdev,
+						  HCI_OP_WRITE_AUTH_ENABLE,
+						  1, &dr.dev_opt,
+						  HCI_CMD_TIMEOUT);
 			if (err)
 				break;
 		}
 
-		err = __hci_cmd_sync_status(hdev, HCI_OP_WRITE_ENCRYPT_MODE,
-					    1, &dr.dev_opt,
-					    HCI_CMD_TIMEOUT);
+		err = hci_cmd_sync_status(hdev, HCI_OP_WRITE_ENCRYPT_MODE,
+					  1, &dr.dev_opt, HCI_CMD_TIMEOUT);
 		break;
 
 	case HCISETSCAN:
-		err = __hci_cmd_sync_status(hdev, HCI_OP_WRITE_SCAN_ENABLE,
-					    1, &dr.dev_opt,
-					    HCI_CMD_TIMEOUT);
+		err = hci_cmd_sync_status(hdev, HCI_OP_WRITE_SCAN_ENABLE,
+					  1, &dr.dev_opt, HCI_CMD_TIMEOUT);
 
 		/* Ensure that the connectable and discoverable states
 		 * get correctly modified as this was a non-mgmt change.
@@ -751,9 +749,8 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 	case HCISETLINKPOL:
 		policy = cpu_to_le16(dr.dev_opt);
 
-		err = __hci_cmd_sync_status(hdev, HCI_OP_WRITE_DEF_LINK_POLICY,
-					    2, &policy,
-					    HCI_CMD_TIMEOUT);
+		err = hci_cmd_sync_status(hdev, HCI_OP_WRITE_DEF_LINK_POLICY,
+					  2, &policy, HCI_CMD_TIMEOUT);
 		break;
 
 	case HCISETLINKMODE:
-- 
2.43.0




