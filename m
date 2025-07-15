Return-Path: <stable+bounces-162496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DD1B05E56
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55D51C23E8B
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AD02E3B02;
	Tue, 15 Jul 2025 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hdxpLUAh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29A71F4CB3;
	Tue, 15 Jul 2025 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586709; cv=none; b=hSCfXV/enmt8nkksFQTHEYbXJ2CO/ib/DI4Kq83TiJ38WpKMsQ5FQoUATnQEEoZx7qStZBWl19zfux+2Q8hWhOXJ1DrVbCIFPLG398tB4kKpA5HcWQ9rh8P3yilJvnX0Ec2ruJvlPE1NrLnBzVnYZgjP+nr1lm1GfWNChNjzXzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586709; c=relaxed/simple;
	bh=1nZMXwpaYa8oIsjC+LQhMFYepHw2uwY24NItX6o76gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SC5BS9BDR/Tn6NrcXOvu7MxYDyYATbdgPjlLNu+K/cYWZLGPkKRPdYu02oAd6WJPnqQXJX/bjCNmS3yqxfQX7/0gD0vQzBV8fHx9UuEPKUkfo+dVykHLwOBHGT7Abq7qU0piw3Xbu9pWWVXTCNL8Pbv3ioDtX+1lls+hYpuZqRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hdxpLUAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE7AC4CEE3;
	Tue, 15 Jul 2025 13:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752586708;
	bh=1nZMXwpaYa8oIsjC+LQhMFYepHw2uwY24NItX6o76gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hdxpLUAhinZtRB3CWb5sHYb/IrZymypC+sPSifRbY4lXOzV0ARka+AbcCuZh3ycBg
	 f5NIaayXlGAgfeVY9XaetN/uOf63Y1E1+1zmTTnCV6CgM4AL599J6bCImXO2dxcv1p
	 LD/5gHtUZ9A3KKqyouy8iNo/D3sjq6A2oA//obKg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 019/192] Bluetooth: hci_event: Fix not marking Broadcast Sink BIS as connected
Date: Tue, 15 Jul 2025 15:11:54 +0200
Message-ID: <20250715130815.635419069@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130814.854109770@linuxfoundation.org>
References: <20250715130814.854109770@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit c7349772c268ec3c91d83cbfbbcf63f1bd7c256c ]

Upon receiving HCI_EVT_LE_BIG_SYNC_ESTABLISHED with status 0x00
(success) the corresponding BIS hci_conn state shall be set to
BT_CONNECTED otherwise they will be left with BT_OPEN which is invalid
at that point, also create the debugfs and sysfs entries following the
same logic as the likes of Broadcast Source BIS and CIS connections.

Fixes: f777d8827817 ("Bluetooth: ISO: Notify user space about failed bis connections")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_event.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4d5ace9d245d9..992131f88a456 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6966,7 +6966,10 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 		bis->iso_qos.bcast.in.sdu = le16_to_cpu(ev->max_pdu);
 
 		if (!ev->status) {
+			bis->state = BT_CONNECTED;
 			set_bit(HCI_CONN_BIG_SYNC, &bis->flags);
+			hci_debugfs_create_conn(bis);
+			hci_conn_add_sysfs(bis);
 			hci_iso_setup_path(bis);
 		}
 	}
-- 
2.39.5




