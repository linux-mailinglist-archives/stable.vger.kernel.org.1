Return-Path: <stable+bounces-162023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FB2B05B30
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40904565419
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982502E1C69;
	Tue, 15 Jul 2025 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bJCQONlw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D04192D8A;
	Tue, 15 Jul 2025 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585468; cv=none; b=M0fSZv3MX8HBiW3r8lgVziQaUS2Syoig62eLpWAHj2ibg0wUERkFKd4ZZv6RXad1ix3IE4i0qEVDNxLDibnx0l/n7Y8gewAydJoH0FI8TW+u9RD13MtI3oShGtnFQMUxlCMGlxmvcrNmCdxCeBVFrSbWFf1gvQ+aH9LF//a2rW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585468; c=relaxed/simple;
	bh=pjvzWtg0jTZXL/bix1slAobAM3wezzNSDNub6Frxpks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C48gRBZQ9oqUV+ZF2xtOBTI5Z/E4dHVRHCC+ydkbqZhVBa25fnlan9Qi1W89DixRmjtdsd9R5cAXevcJers2NGoJxAaUtpQXIAWBG3FqpAlMX1M+NwUbCmU9Gvc1k6tZO+WW48y14xHjqsUhpxfpadJiPoDLiu+qOa9qg8Ku0mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bJCQONlw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2313C4CEE3;
	Tue, 15 Jul 2025 13:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752585468;
	bh=pjvzWtg0jTZXL/bix1slAobAM3wezzNSDNub6Frxpks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bJCQONlwhgUumUyy0yknQ5dSCxrSjxBzhMgkoK7VczuPPJTasiNZRowS/A2lVSTnu
	 FbP8LdZcscd+xpW0ViQWnlHT2EnRPrlfaQMIjnfetSQAzTEzUqoYTTsrRePzXuLUJu
	 6acMthC7+T59lzV1uAN83NF6pl8iYDqDabt/1mQk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 020/163] Bluetooth: hci_sync: Fix not disabling advertising instance
Date: Tue, 15 Jul 2025 15:11:28 +0200
Message-ID: <20250715130809.577602736@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130808.777350091@linuxfoundation.org>
References: <20250715130808.777350091@linuxfoundation.org>
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

[ Upstream commit ef9675b0ef030d135413e8638989f3a7d1f3217a ]

As the code comments on hci_setup_ext_adv_instance_sync suggests the
advertising instance needs to be disabled in order to update its
parameters, but it was wrongly checking that !adv->pending.

Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 79d1a6ed08b29..bc01135e43f3e 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1345,7 +1345,7 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 	 * Command Disallowed error, so we must first disable the
 	 * instance if it is active.
 	 */
-	if (adv && !adv->pending) {
+	if (adv) {
 		err = hci_disable_ext_adv_instance_sync(hdev, instance);
 		if (err)
 			return err;
-- 
2.39.5




