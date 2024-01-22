Return-Path: <stable+bounces-14717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 757FF83823E
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 302FA2845C6
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9981B59B76;
	Tue, 23 Jan 2024 01:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WrNLlxm4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558782B9B7;
	Tue, 23 Jan 2024 01:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974109; cv=none; b=lMBbsMAYG0thaq9j0h2vn1DnWJZ5WiPlnUifZPJ7AxgpaS6dRCMAAzXB1OgKyApfUKcyCSWGD2swUeXXmGueoNu1hI8oEIED68PIc+9bWpdzmaQLNkHXRMiwZ2WAZbmwKsewtZ5vBdv22XqaKfbcgqA00mUAP0vO55SbIyJPbVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974109; c=relaxed/simple;
	bh=+p9zbJwduckakHQFo+c1iBqwImAhhsVynLP0xUhcw9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=du78XxASzHIi1SLY6VkDbjzOFYhtv8NlD09xDp8PqSth36SQH1mt3JysvtBK3dVR6SSKtoBTdq7TF+PCO0aRY4k9hkeCNdaDz9OF7mmIMhb3dxQdsDA9PPJeR/QfhCoum2YwkW9gQfqjWIi6Cw/iAClLvAWSKnKzbASaeQPmlcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WrNLlxm4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16352C433C7;
	Tue, 23 Jan 2024 01:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705974109;
	bh=+p9zbJwduckakHQFo+c1iBqwImAhhsVynLP0xUhcw9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WrNLlxm4/X6UM5A12MlEfKSxhVCey5l33/5t24UvQq4bY+y9KwXWZHKsGpiQDk+Yh
	 ym5bHdPU19L4pP8EkEHsK2yXCRkbh/ZlvSVhMFnq4Iyf39SPbzMAUcrBHDQK2hThui
	 GqB+0JRv751+zq3767RI/YSstF7G/53UniXR0IyE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 166/374] Bluetooth: Fix bogus check for re-auth no supported with non-ssp
Date: Mon, 22 Jan 2024 15:57:02 -0800
Message-ID: <20240122235750.388569754@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235744.598274724@linuxfoundation.org>
References: <20240122235744.598274724@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit d03376c185926098cb4d668d6458801eb785c0a5 ]

This reverts 19f8def031bfa50c579149b200bfeeb919727b27
"Bluetooth: Fix auth_complete_evt for legacy units" which seems to be
working around a bug on a broken controller rather then any limitation
imposed by the Bluetooth spec, in fact if there ws not possible to
re-auth the command shall fail not succeed.

Fixes: 19f8def031bf ("Bluetooth: Fix auth_complete_evt for legacy units")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_conn.c         |  8 +++-----
 net/bluetooth/hci_event.c        | 11 ++---------
 3 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9a21ccbb5b5c..b6114bc0dd0f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -852,7 +852,6 @@ void hci_inquiry_cache_flush(struct hci_dev *hdev);
 /* ----- HCI Connections ----- */
 enum {
 	HCI_CONN_AUTH_PEND,
-	HCI_CONN_REAUTH_PEND,
 	HCI_CONN_ENCRYPT_PEND,
 	HCI_CONN_RSWITCH_PEND,
 	HCI_CONN_MODE_CHANGE_PEND,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index ce538dbe89d1..700920aea39e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1436,12 +1436,10 @@ static int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 		hci_send_cmd(conn->hdev, HCI_OP_AUTH_REQUESTED,
 			     sizeof(cp), &cp);
 
-		/* If we're already encrypted set the REAUTH_PEND flag,
-		 * otherwise set the ENCRYPT_PEND.
+		/* Set the ENCRYPT_PEND to trigger encryption after
+		 * authentication.
 		 */
-		if (test_bit(HCI_CONN_ENCRYPT, &conn->flags))
-			set_bit(HCI_CONN_REAUTH_PEND, &conn->flags);
-		else
+		if (!test_bit(HCI_CONN_ENCRYPT, &conn->flags))
 			set_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
 	}
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index edf5132b5dc9..2ad2f4647847 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3017,14 +3017,8 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (!ev->status) {
 		clear_bit(HCI_CONN_AUTH_FAILURE, &conn->flags);
-
-		if (!hci_conn_ssp_enabled(conn) &&
-		    test_bit(HCI_CONN_REAUTH_PEND, &conn->flags)) {
-			bt_dev_info(hdev, "re-auth of legacy device is not possible.");
-		} else {
-			set_bit(HCI_CONN_AUTH, &conn->flags);
-			conn->sec_level = conn->pending_sec_level;
-		}
+		set_bit(HCI_CONN_AUTH, &conn->flags);
+		conn->sec_level = conn->pending_sec_level;
 	} else {
 		if (ev->status == HCI_ERROR_PIN_OR_KEY_MISSING)
 			set_bit(HCI_CONN_AUTH_FAILURE, &conn->flags);
@@ -3033,7 +3027,6 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	clear_bit(HCI_CONN_AUTH_PEND, &conn->flags);
-	clear_bit(HCI_CONN_REAUTH_PEND, &conn->flags);
 
 	if (conn->state == BT_CONFIG) {
 		if (!ev->status && hci_conn_ssp_enabled(conn)) {
-- 
2.43.0




