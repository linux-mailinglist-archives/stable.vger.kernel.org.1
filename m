Return-Path: <stable+bounces-95146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EC19D759B
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 17:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8830C01C0B
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4259A1E0DB1;
	Sun, 24 Nov 2024 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EB0w5Y4y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFBC1B87F9;
	Sun, 24 Nov 2024 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456138; cv=none; b=ar50krU5tTQiwGGZ2Ty+DPzyNC46VsyylL7YBW0KKf2hhFjvv0MKcxusFwC3WX6iEk8LVt/p9Ixy8Riib8FsFecaDHbgTjQIo3ahPQuK+H6BD4dbgQutRnXrNWDa3u7P28EdpIXFsMIwYXhh8tDHI6FZGRDlrPGq2a5efBOnOIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456138; c=relaxed/simple;
	bh=kYRkmfw6gi6LQh2+0thzLbw/xkBleyDDTO2puPXO3/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MC3w8Lz95KGMOAdRVFpEk11nCudUp4SH1kRaMyceMnl6sSPYu3H2AMt+lOGcM2zB9212E5f2lxOhKRH+biuuSe3i7vfV4WDfHYHJpI1eUh7MJpfTXYCJczo6HxqtWT1T+axoULFQzzCCP9Wl0o7LVpfAjCv3pOnIsNnVjrhZX+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EB0w5Y4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F25C4CECC;
	Sun, 24 Nov 2024 13:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456137;
	bh=kYRkmfw6gi6LQh2+0thzLbw/xkBleyDDTO2puPXO3/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EB0w5Y4yCdJT+DNf7QbPDHQEgTzPd+njtMomROr9SLD8v99Df0Wrbd9ZN3UmMLoZW
	 Xd3OlOqosZlsB10BdkW6NHu2tdnLqHsJXkdfI0Lis7j3Kqaa4F8e4MJkls+0jmVT80
	 insCDwhMREBYxWukNxxEC2aWN3AwzBf19va9yjuKszPGtZHjrmiLDbNyozagXW7+rW
	 1mbnUaZVnKCdZ/0HuVhrNyH/zrT9zcnwUkJbIT1fOaw7tf7Cy2gCk5ZKaFhYrr+x6X
	 zluvNxb2B0bjMdlj5Uw6te4WmqUwLtOXr/R6ZPBY7bkp8EHltuaLEzT2+276KKAynS
	 E1kDSLEq+V35w==
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
Subject: [PATCH AUTOSEL 6.6 56/61] Bluetooth: Support new quirks for ATS2851
Date: Sun, 24 Nov 2024 08:45:31 -0500
Message-ID: <20241124134637.3346391-56-sashal@kernel.org>
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
index da056cca3edbc..141b4fce55e35 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3627,6 +3627,13 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
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
index c553b637cda7f..d95e2b55badb4 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4853,6 +4853,13 @@ static const struct {
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
@@ -6485,7 +6492,7 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
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


