Return-Path: <stable+bounces-173709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65340B35E9B
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06B2856174A
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCDE2FAC02;
	Tue, 26 Aug 2025 11:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oJKQjQXt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC75B2BEFF0;
	Tue, 26 Aug 2025 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208954; cv=none; b=iaY9fB9Y4OGr+czcPS+WWSjHJI0/3aJy+jDA3TatDRj5R0G/gTNAio8mKBLu65Q3ewD7YbdSs+Eebzf0kzC6PCJk/UtFVWH/OWP6x/FM6c4JwR7CGsUgIVhArseAC8/e5LwvxyLhbipBVmvFX8rytrbCawYKN8QSd0293wOSTP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208954; c=relaxed/simple;
	bh=C+ZzB/RAtO/UvUeCYhLOfTZNqL9FjrERBejrbyvFfhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JIJ09NkfCs+L2ZOj/oRK+aGBKA6M35KLmTzKud01GMFuVngGDRJUjvoWSuoC1vlOLvwS4OBJ+vI3GFHJGJaA9K4Mz93sugsEiKKVcaGuEH/iPo/yy0GVbKAL92PlI5usIB0Rflgmn3W69lNBj/htSJyDE3IFp/Tzk4Vrpn+xEpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oJKQjQXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673DCC4CEF1;
	Tue, 26 Aug 2025 11:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208953;
	bh=C+ZzB/RAtO/UvUeCYhLOfTZNqL9FjrERBejrbyvFfhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oJKQjQXt+OeyqS23vZYHmFq8B1E0NYOUepiyNIF+JwojdcynjmxaBuO5Qy+Fmu3i6
	 R1Zv6gNFTzMipNK08/XRrP9jw0gyPkQ9qXBmASsjxvUSsDRKG3ld+RuXay1d706gJc
	 9lr8VhnekbMyyrne7BefPFrnGDaO7QM4Di973QIU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 277/322] Bluetooth: hci_sync: Fix scan state after PA Sync has been established
Date: Tue, 26 Aug 2025 13:11:32 +0200
Message-ID: <20250826110922.764325792@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
References: <20250826110915.169062587@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit ca88be1a2725a42f8dbad579181611d9dcca8e88 ]

Passive scanning is used to program the address of the peer to be
synchronized, so once HCI_EV_LE_PA_SYNC_ESTABLISHED is received it
needs to be updated after clearing HCI_PA_SYNC then call
hci_update_passive_scan_sync to return it to its original state.

Fixes: 6d0417e4e1cf ("Bluetooth: hci_conn: Fix not setting conn_timeout for Broadcast Receiver")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_sync.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index bbd809414b2f..c7fd657c86ff 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6960,8 +6960,6 @@ static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 
 	hci_dev_lock(hdev);
 
-	hci_dev_clear_flag(hdev, HCI_PA_SYNC);
-
 	if (!hci_conn_valid(hdev, conn))
 		clear_bit(HCI_CONN_CREATE_PA_SYNC, &conn->flags);
 
@@ -7055,6 +7053,11 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 		__hci_cmd_sync_status(hdev, HCI_OP_LE_PA_CREATE_SYNC_CANCEL,
 				      0, NULL, HCI_CMD_TIMEOUT);
 
+	hci_dev_clear_flag(hdev, HCI_PA_SYNC);
+
+	/* Update passive scan since HCI_PA_SYNC flag has been cleared */
+	hci_update_passive_scan_sync(hdev);
+
 	return err;
 }
 
-- 
2.50.1




