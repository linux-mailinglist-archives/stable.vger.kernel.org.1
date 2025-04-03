Return-Path: <stable+bounces-127763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51193A7AB1D
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A583A63B2
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AC825DAF7;
	Thu,  3 Apr 2025 19:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i76aScqo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD05254B11;
	Thu,  3 Apr 2025 19:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707037; cv=none; b=bokuixtE9ebiBeWhjo5U8NBXzh61gC6VEl7u2fvHRk6VdNQe9Ec45ayuST+cn1jepVNK8/QCMOulE5AxHQNiX5WGCNTSt4bEBZPnMUTZD7pFy5K0SmvfAptMiGm9ypo8Voe7/x42r1bPn1I/Jcpyse/h+NCCMjcixhvlq5KOfic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707037; c=relaxed/simple;
	bh=0CfZ1LFAwTI/kMhGfmqIM4dALQf99ljdyycOiP3RwxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZTA/PifLMtHcqShqvouwr21jvHVHY/qzf4FScw9DwdOZLHG4sk6ENLPGttB3HUzraRLwSzZ/0nAGpNKaByvwpFPuGKU0zkOHPiww08TXeivsrbyfrm69ghg4/W1kxXZ2sGVKoy3zqWDVY3DwQWVyCkMXrjhTIGefrKQFttACB+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i76aScqo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECECBC4CEE8;
	Thu,  3 Apr 2025 19:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707036;
	bh=0CfZ1LFAwTI/kMhGfmqIM4dALQf99ljdyycOiP3RwxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i76aScqo52XleYaRM0DVgSOA3L6ohO8u62SEBZz9Y0G/pDbr5kqzpks3XOoW/KJl8
	 SFSIPl7OXGrbRJ8OxGD/IiUavBQnJZTCEBf1eBFBifEy7Wdc4DSKKvtjqVJ13xZ3H8
	 fHu3eeJO9BO1A3HOShN0fRfufwFAGZVYO++KvoMozsaA77PT3ERVc9GyorjNsHqCOd
	 MeqY+lYlSlGYfcllwV2r8Gttvlh/YTQrzdLpLrT4FbHHIbhfOQ+G4Qn1SqGteMQTU7
	 UY0pK2S1D4bnvT/3w3ctklHU+m3NxrCBAGprJSKXkw+mAjlyu5lzCZVSYpmWvMh4e0
	 W07OPrR0LuDzQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 48/54] Bluetooth: hci_uart: fix race during initialization
Date: Thu,  3 Apr 2025 15:02:03 -0400
Message-Id: <20250403190209.2675485-48-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190209.2675485-1-sashal@kernel.org>
References: <20250403190209.2675485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Arseniy Krasnov <avkrasnov@salutedevices.com>

[ Upstream commit 366ceff495f902182d42b6f41525c2474caf3f9a ]

'hci_register_dev()' calls power up function, which is executed by
kworker - 'hci_power_on()'. This function does access to bluetooth chip
using callbacks from 'hci_ldisc.c', for example 'hci_uart_send_frame()'.
Now 'hci_uart_send_frame()' checks 'HCI_UART_PROTO_READY' bit set, and
if not - it fails. Problem is that 'HCI_UART_PROTO_READY' is set after
'hci_register_dev()', and there is tiny chance that 'hci_power_on()' will
be executed before setting this bit. In that case HCI init logic fails.

Patch moves setting of 'HCI_UART_PROTO_READY' before calling function
'hci_uart_register_dev()'.

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_ldisc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index d2d6ba8d2f8b1..b955dc96b483a 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -707,12 +707,13 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
 
 	hu->proto = p;
 
+	set_bit(HCI_UART_PROTO_READY, &hu->flags);
+
 	err = hci_uart_register_dev(hu);
 	if (err) {
 		return err;
 	}
 
-	set_bit(HCI_UART_PROTO_READY, &hu->flags);
 	return 0;
 }
 
-- 
2.39.5


