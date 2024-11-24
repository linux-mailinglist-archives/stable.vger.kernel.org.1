Return-Path: <stable+bounces-95084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5819D731A
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73200160E3D
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315FC215F52;
	Sun, 24 Nov 2024 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjeeIfkj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D732144A8;
	Sun, 24 Nov 2024 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455920; cv=none; b=c/IgBKkE9qYeFoXkbYIeWXc7CotPNaf14+gd/sNk1WyAr1lRJwmBtjtuiQDz+Nz5RAuROEyfSKQBPKbBtlF2AbB96L1T3O/4crouEpj4/q+wNKofuHmey/S94dPAnpIh4hXYflMXD3TbaMC1NVHQcYws/yfBpg/SyA0pv5pmql4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455920; c=relaxed/simple;
	bh=wBazjWiBIqioXexxwzQDcrZpeKNFoZHYhPDsJW7CozA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QaNDK1VQ4GLHxVh7vJoP7uxs0p3ohqRreXKzI1RbOSrJdE2nuTuPhiibli0ZdsPjYMC3C1xUtXjM/pSII6jxb2NOYwK9Z0YBYKoqVZkQ1RIttXGvm2FZLCJBg08ceFgofhdfZ2UcjgJXRLotirVlUZ2v7xEfNiN6iktZ8N7twdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjeeIfkj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19E1C4CED3;
	Sun, 24 Nov 2024 13:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455920;
	bh=wBazjWiBIqioXexxwzQDcrZpeKNFoZHYhPDsJW7CozA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gjeeIfkj0TC1ONLM1zTemMj7n3CGk02nyvpj+ahrivpoH0Xf/bQjfnwiEa+WORKNB
	 y6ArneI5nKUQk+ueizpK9mtmeDNnWaFfnT7TjjKAWIF4N8WPtHiedJwYM4rITGf4Y+
	 2LdOypZ9FUlnAOG4tJfHoaN/qR1sbhpRM36DRutN+Bhs6i5ak7rr+ngXRrDdNdhK4w
	 J2tzNW8bwETp7qYL995H8mz6Xv+O2YfjjY0k1gav3is7FrPV9/AVqpg8CdSNpfQstG
	 HiwL7SVZj1g6JuPQY3MoYzHH5UP1ubuAEebE2RastatgoeuTifhN00dstCiuAGsRdR
	 DYzGQqojHwsLg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Danil Pylaev <danstiv404@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 81/87] Bluetooth: Support new quirks for ATS2851
Date: Sun, 24 Nov 2024 08:38:59 -0500
Message-ID: <20241124134102.3344326-81-sashal@kernel.org>
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

From: Danil Pylaev <danstiv404@gmail.com>

[ Upstream commit 5bd3135924b4570dcecc8793f7771cb8d42d8b19 ]

This adds support for quirks for broken extended create connection,
and write auth payload timeout.

Signed-off-by: Danil Pylaev <danstiv404@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_event.c | 7 +++++++
 net/bluetooth/hci_sync.c  | 9 ++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 561c8cb87473e..2203205e8e65b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3626,6 +3626,13 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
+	/* We skip the WRITE_AUTH_PAYLOAD_TIMEOUT for ATS2851 based controllers
+	 * to avoid unexpected SMP command errors when pairing.
+	 */
+	if (test_bit(HCI_QUIRK_BROKEN_WRITE_AUTH_PAYLOAD_TIMEOUT,
+		     &hdev->quirks))
+		goto notify;
+
 	/* Set the default Authenticated Payload Timeout after
 	 * an LE Link is established. As per Core Spec v5.0, Vol 2, Part B
 	 * Section 3.3, the HCI command WRITE_AUTH_PAYLOAD_TIMEOUT should be
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c0203a2b51075..c86f4e42e69ca 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4842,6 +4842,13 @@ static const struct {
 	HCI_QUIRK_BROKEN(SET_RPA_TIMEOUT,
 			 "HCI LE Set Random Private Address Timeout command is "
 			 "advertised, but not supported."),
+	HCI_QUIRK_BROKEN(EXT_CREATE_CONN,
+			 "HCI LE Extended Create Connection command is "
+			 "advertised, but not supported."),
+	HCI_QUIRK_BROKEN(WRITE_AUTH_PAYLOAD_TIMEOUT,
+			 "HCI WRITE AUTH PAYLOAD TIMEOUT command leads "
+			 "to unexpected SMP errors when pairing "
+			 "and will not be used."),
 	HCI_QUIRK_BROKEN(LE_CODED,
 			 "HCI LE Coded PHY feature bit is set, "
 			 "but its usage is not supported.")
@@ -6477,7 +6484,7 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 					     &own_addr_type);
 	if (err)
 		goto done;
-
+	/* Send command LE Extended Create Connection if supported */
 	if (use_ext_conn(hdev)) {
 		err = hci_le_ext_create_conn_sync(hdev, conn, own_addr_type);
 		goto done;
-- 
2.43.0


