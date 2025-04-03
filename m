Return-Path: <stable+bounces-127865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586F2A7AC9C
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D7493B96EA
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A6E27CB3D;
	Thu,  3 Apr 2025 19:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDu2PfD7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA1E27CB35;
	Thu,  3 Apr 2025 19:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707265; cv=none; b=kH6qf/3tvLcGNHj/PkUiWoit42AEROLQBx2Div50FWul253cv1XfDepZiTlKR+JlP8JjX6xBXZiul3NzJJ3MDPGGKgEV5qqSaUROORnRg+DEbfk2TTwtBibZ3wFPKRSTeMkZvhnCJSCEUbk5pGxG8HYQzFWEtZ+BraeYNrvflQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707265; c=relaxed/simple;
	bh=sLGuf5qMyQRvYXekjBOQCrvBgQ4VbTNYdEKerVwGC04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=etuPWjXMkTsCYu/eM3TADhJ7VoFJHf7FHCWABGJ8QJBXmZ+PfUpdjqizab23EuBWMIZIrDHJGuqkltDjeXIKWAyyTfUs34zIN5+uXespNtj6GDt4Fie9A3XnePo5YeTCPxI6qQxTXBOHDMx3sivtVd5QL8KVSuCwaRUBXsVfN5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDu2PfD7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C11C4CEE9;
	Thu,  3 Apr 2025 19:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707264;
	bh=sLGuf5qMyQRvYXekjBOQCrvBgQ4VbTNYdEKerVwGC04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cDu2PfD738NLql7VxGXc0+DaEkjQu9p6oMrnQTwv6lGGnVX6S2RAKqy4GyXbdr2VW
	 xVUo+2SKLonRJJuplqortetHAfP6qZGD7Gv3ZWlpZHB8Yvz6+13G1LqbMCViPj4bpb
	 sCRkPJr1AYtfUbxbojFZYDYZ3MCOa93SCQyHeORDhLn4yAF+eOTubyKHkz/QQUb72E
	 +UXWYhUqFHBVBjkz5f7/ZMCTAHIJPDgj6/W3d6OaR82MNX0Eqp3O7FgNCd3MLF6zGz
	 4L4qWkIS2pXXpnhRUskdnbrFS1hRnKc6qclocB7R/dWiUE65v+H9ebnRvXDFt0Ok82
	 PKcDRHm+xZg7w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pedro Nishiyama <nishiyama.pedro@gmail.com>,
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
Subject: [PATCH AUTOSEL 6.12 47/47] Bluetooth: Add quirk for broken READ_PAGE_SCAN_TYPE
Date: Thu,  3 Apr 2025 15:05:55 -0400
Message-Id: <20250403190555.2677001-47-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190555.2677001-1-sashal@kernel.org>
References: <20250403190555.2677001-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: Pedro Nishiyama <nishiyama.pedro@gmail.com>

[ Upstream commit 127881334eaad639e0a19a399ee8c91d6c9dc982 ]

Some fake controllers cannot be initialized because they return a smaller
report than expected for READ_PAGE_SCAN_TYPE.

Signed-off-by: Pedro Nishiyama <nishiyama.pedro@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci.h | 8 ++++++++
 net/bluetooth/hci_sync.c    | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index dc8a3e4002e87..eb978a33a9d1d 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -361,6 +361,14 @@ enum {
 	 * This quirk must be set before hci_register_dev is called.
 	 */
 	HCI_QUIRK_BROKEN_READ_VOICE_SETTING,
+
+	/* When this quirk is set, the HCI_OP_READ_PAGE_SCAN_TYPE command is
+	 * skipped. This is required for a subset of the CSR controller clones
+	 * which erroneously claim to support it.
+	 *
+	 * This quirk must be set before hci_register_dev is called.
+	 */
+	HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE,
 };
 
 /* HCI device flags */
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index bb455e96a715a..cb4d47ae129e8 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4156,7 +4156,8 @@ static int hci_read_page_scan_type_sync(struct hci_dev *hdev)
 	 * support the Read Page Scan Type command. Check support for
 	 * this command in the bit mask of supported commands.
 	 */
-	if (!(hdev->commands[13] & 0x01))
+	if (!(hdev->commands[13] & 0x01) ||
+	    test_bit(HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE, &hdev->quirks))
 		return 0;
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_READ_PAGE_SCAN_TYPE,
-- 
2.39.5


