Return-Path: <stable+bounces-95145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E689D76D0
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 18:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 068BDB3DFF7
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9051B87DC;
	Sun, 24 Nov 2024 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AALT3wf2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00751B87D0;
	Sun, 24 Nov 2024 13:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456136; cv=none; b=hjZj64cqm82A5ogRlpPhYUGSxQFCphbK0ufqqIWmDB4E8qW4vMGYBJzahkaYKIOxa8F7vzSkprsWllSVX6xz9aSKy7qqrsPqR2WCSR/69XqoATHD8LRI7VpZ45RnnWhRy229GcolhTfbDu8nsezuOCgVjpwBkJfsuLCnXYpEjAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456136; c=relaxed/simple;
	bh=hosWer0wZknNWSVpixY2RwGXm8piDaeKDh4woSPxqhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1bB48RLbMJaAD3PJNcdmcwr6YtiwnSz+8qdBy/YEEJ8cFQpBz1+OvXesX8eXbtvfQWi9gPtyrPB7v7FewF/T60b8kC+eI/gJuZZe/55I4m7PfyNuaKG5oay0AYKDkIOwgag/cI3MXHnC6e3Htm33rBnFZ5bGq8uqrXZEcIg468=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AALT3wf2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BFEC4CED3;
	Sun, 24 Nov 2024 13:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456136;
	bh=hosWer0wZknNWSVpixY2RwGXm8piDaeKDh4woSPxqhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AALT3wf2cpbk96FXmh5I6Xm0ZrdHziNOdPQloOUpgbCMFh/0f5tGgpY2UpkucHWDb
	 X+8hlqZysZfUKtz7NVj116uSzYQl2ostDrO8kkr69oJH5ltMvB9MW4eRs07EQB5OpG
	 p87dBB8AUfaRtVUmEDcJaenHFfRSKCt00EcOhw7u7fm83jktO2kdeTLbM5PpDPtAw7
	 oRXVZvFTOekcA84v/ZkTt3napMuHXUQHKjhB1gDuh0aOYtGn3acVGeuc2YnI92zzeA
	 O1fXRX8QIJJYGPh82//cvIOTKlVGmwu6la17MZoNkH2eUdcbQiRMxP6tE7f8VpXkec
	 BzsVUwKF6RHHA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Danil Pylaev <danstiv404@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 55/61] Bluetooth: Add new quirks for ATS2851
Date: Sun, 24 Nov 2024 08:45:30 -0500
Message-ID: <20241124134637.3346391-55-sashal@kernel.org>
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

[ Upstream commit 94464a7b71634037b13d54021e0dfd0fb0d8c1f0 ]

This adds quirks for broken extended create connection,
and write auth payload timeout.

Signed-off-by: Danil Pylaev <danstiv404@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci.h      | 14 ++++++++++++++
 include/net/bluetooth/hci_core.h | 10 ++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 2129d071c3725..77a3040a3f29d 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -297,6 +297,20 @@ enum {
 	 */
 	HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT,
 
+	/*
+	 * When this quirk is set, the HCI_OP_LE_EXT_CREATE_CONN command is
+	 * disabled. This is required for the Actions Semiconductor ATS2851
+	 * based controllers, which erroneously claims to support it.
+	 */
+	HCI_QUIRK_BROKEN_EXT_CREATE_CONN,
+
+	/*
+	 * When this quirk is set, the command WRITE_AUTH_PAYLOAD_TIMEOUT is
+	 * skipped. This is required for the Actions Semiconductor ATS2851
+	 * based controllers, due to a race condition in pairing process.
+	 */
+	HCI_QUIRK_BROKEN_WRITE_AUTH_PAYLOAD_TIMEOUT,
+
 	/* When this quirk is set, MSFT extension monitor tracking by
 	 * address filter is supported. Since tracking quantity of each
 	 * pattern is limited, this feature supports tracking multiple
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0f50c0cefcb7d..4185eb679180d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1852,8 +1852,8 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 			   !test_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &(dev)->quirks))
 
 /* Use ext create connection if command is supported */
-#define use_ext_conn(dev) ((dev)->commands[37] & 0x80)
-
+#define use_ext_conn(dev) (((dev)->commands[37] & 0x80) && \
+	!test_bit(HCI_QUIRK_BROKEN_EXT_CREATE_CONN, &(dev)->quirks))
 /* Extended advertising support */
 #define ext_adv_capable(dev) (((dev)->le_features[1] & HCI_LE_EXT_ADV))
 
@@ -1866,8 +1866,10 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
  * C24: Mandatory if the LE Controller supports Connection State and either
  * LE Feature (LL Privacy) or LE Feature (Extended Advertising) is supported
  */
-#define use_enhanced_conn_complete(dev) (ll_privacy_capable(dev) || \
-					 ext_adv_capable(dev))
+#define use_enhanced_conn_complete(dev) ((ll_privacy_capable(dev) || \
+					 ext_adv_capable(dev)) && \
+					 !test_bit(HCI_QUIRK_BROKEN_EXT_CREATE_CONN, \
+						 &(dev)->quirks))
 
 /* Periodic advertising support */
 #define per_adv_capable(dev) (((dev)->le_features[1] & HCI_LE_PERIODIC_ADV))
-- 
2.43.0


