Return-Path: <stable+bounces-94995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8908F9D7215
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2387C1644FF
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47171EE037;
	Sun, 24 Nov 2024 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqBj7xq1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCEE1B6D1F;
	Sun, 24 Nov 2024 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455525; cv=none; b=Ohvc4v42QQsgx0VDq3ZxDRdPzk67n90lwWnR6eto8c6SXV4TEw4g/UuOjHoqtqY53O9C+UcnMArP4pqV0e8MqxBHRqcs94Ybow0+mVbaforGsv+zEWVhUUUEg9t7XBfPFB6C8PCaQ7vdWkUyYooYF6JZNvkriFNRuAiztaWx8UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455525; c=relaxed/simple;
	bh=l4gT6jNyp+HK5lUUKE0DkcveD3IUypWZQeESm7U9j3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZmL9phuFROmXSc3hAnRZegM8abnngAp7P9sFse58nIeT+4wM1JmzfsWoTGjE4rUqv42mTs2NyaE2NDuxa6ovpgSC0zEvKmbwFVZ/sW17qzBbnyP0GEF6LbQ3Dee+yu+6pOEfM+exw6c79s29H3DICCRfxvYqtJCkK83RUtVY4rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqBj7xq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D680C4CECC;
	Sun, 24 Nov 2024 13:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455525;
	bh=l4gT6jNyp+HK5lUUKE0DkcveD3IUypWZQeESm7U9j3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uqBj7xq18v5o2BUjqh7HL0cEibHGb/VVQMLcr0jWo+0FxefkVZErV8nMlxploS9eO
	 yGqyq3hSH9LvHifE2VP96c+aUVDzbQ8cOlnOD43PNgEcT7jVPDGdObCrXeGfhaF6M5
	 8+KKQoeV30w2YIB+LsLCdkYFJRUuPolyQ08OsmJsBj67/qZGMTJ88FcGRxb5Z+Hu2Q
	 m7vx8xRSYOAU5M0/IOqmnzT23R3ymEDKy6Q8ijoXhh2H3/9avMna21cRh/8PTIjA+q
	 CZztnMD2l3DXWgeTsTRJGLTx6jmurxtNhO7Yql6nhqho1TZ//zGUyuvOh2DYBugYyY
	 SkTp4KxvcRGlQ==
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
Subject: [PATCH AUTOSEL 6.12 099/107] Bluetooth: Support new quirks for ATS2851
Date: Sun, 24 Nov 2024 08:29:59 -0500
Message-ID: <20241124133301.3341829-99-sashal@kernel.org>
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
index 0bbad90ddd6f8..65f5ed2ded707 100644
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


