Return-Path: <stable+bounces-94130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A809D3B3B
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 13:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178301F21B44
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 12:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6D41A9B5A;
	Wed, 20 Nov 2024 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XyFYkJM6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89571A4F12;
	Wed, 20 Nov 2024 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732107497; cv=none; b=WfdYEdS3s0upV1mjOlknulWCubpR7QL2h+lW5L97kYxq4U/tIKhNMeVphZAd2AYJtkLr8s7r41ySfKrYXPZWVkq3CREK3plwmcZ8lVz7Y/i0ypErSnZwJOj8l3wZF+2xiwHM1FCCnqiXrUerI8YAqCP/EFmfc5uUOoNmecEE/Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732107497; c=relaxed/simple;
	bh=zRiHoOdZkbZMUVCg6EoUZf3EsG+FlD0SOtvrXyiLgf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMukfJkph7jHea+L05zXqOTn/zr0zteNt9AjlTvQd9fLTgB58zV0ZlKdx7R6RbpyTzKVSYygWnRbE0JqQPers0OSQsn6kOVom9YdG81rvoeJrIVgtFzLRPdSbuWKvtPr5/Vgt33eLj1tPH9Iknfxu/iLUt7xpOCVNeaNwN5D0jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XyFYkJM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAB1C4CECD;
	Wed, 20 Nov 2024 12:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732107497;
	bh=zRiHoOdZkbZMUVCg6EoUZf3EsG+FlD0SOtvrXyiLgf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XyFYkJM6ZGedh5qFqV27/TQj0LdWXPUxgrhgt7cQonVO0drjwXUWyoTJ3xnxwoo60
	 NZlB0MmUvk2HGB4huI1Y8y8rReaF+ZLuCAAxVIrkvBaZaq6VVyL8vMxBICbgH7kzav
	 Sm+SYHXvhPLBaIKIr1a0bZ79lTKz/Crx4egS1Pjk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 020/107] Bluetooth: hci_core: Fix calling mgmt_device_connected
Date: Wed, 20 Nov 2024 13:55:55 +0100
Message-ID: <20241120125630.132903787@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120125629.681745345@linuxfoundation.org>
References: <20241120125629.681745345@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 7967dc8f797f454d4f4acec15c7df0cdf4801617 ]

Since 61a939c68ee0 ("Bluetooth: Queue incoming ACL data until
BT_CONNECTED state is reached") there is no long the need to call
mgmt_device_connected as ACL data will be queued until BT_CONNECTED
state.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219458
Link: https://github.com/bluez/bluez/issues/1014
Fixes: 333b4fd11e89 ("Bluetooth: L2CAP: Fix uaf in l2cap_connect")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6e07350817bec..eeb4f025ca3bf 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3788,8 +3788,6 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	if (conn && hci_dev_test_flag(hdev, HCI_MGMT))
-		mgmt_device_connected(hdev, conn, NULL, 0);
 	hci_dev_unlock(hdev);
 
 	if (conn) {
-- 
2.43.0




