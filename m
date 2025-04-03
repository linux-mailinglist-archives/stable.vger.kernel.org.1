Return-Path: <stable+bounces-127813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2BAA7AC0A
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B4BE17B39E
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A612267F74;
	Thu,  3 Apr 2025 19:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sc0RtPVr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347A2267F69;
	Thu,  3 Apr 2025 19:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707146; cv=none; b=Pdrjae+7fE8B4scUH9SrCeDUY5GUFgKicbkfghiBQo81/d/ABrQhS/KbAGapdtkiYRxSIdG96aDamUFCrxbjld45VXWx/6q8pIificME0s/xdNme7UgxI3ymekYNQwKYprkHwWfZzRDw8+bgFGDVqqx12XWQ4SOHdkMy68bMqg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707146; c=relaxed/simple;
	bh=0CfZ1LFAwTI/kMhGfmqIM4dALQf99ljdyycOiP3RwxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eHWlBdh3U9FUAmLsNDgGPl/1Zbfijb97egbKgm9aE7y2eIwaiFLJFIfAYTyqjOQvN7sRgnkJ6tAo913AQvU3IA9ssAYgp8jSPltiCkFejP/SeCrs/YFCtgzWv1P6BS3LVIwObn9GJ0xwk7zX1npNFUAOHMQH0AKU0YKyROBAvZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sc0RtPVr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF37FC4CEE8;
	Thu,  3 Apr 2025 19:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707145;
	bh=0CfZ1LFAwTI/kMhGfmqIM4dALQf99ljdyycOiP3RwxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sc0RtPVr7PLacJpskURluDyF7ORIEq5BMFyLdMqjXF5kgNCnl8vFWg36V81uViOBi
	 nmIMp0rZ/k1/wCWeSZ3ngf4o/YZB0ZBDpXZnP96wursFayAhhpZstYm1UHwEmonG5D
	 Bh5a2qLCKEaZFIA79PvPmEubWu2Og9nNlvAY4HwkTtFddXrQfGEs7JKmVDhBPqalZV
	 nKeDRGWhGbwxzSNeai36yXLIaZQ65e/zQyROfI6CF5M5FLvZagIjHHnkTECD/xsh8V
	 lHYLIMr5VRbSpYBgMQYUqh8k6U64zCl+viy9iFtdqdZ92r0Oeif2khkNNQ1NdcLqZx
	 yGfgpd8F0ZP6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 44/49] Bluetooth: hci_uart: fix race during initialization
Date: Thu,  3 Apr 2025 15:04:03 -0400
Message-Id: <20250403190408.2676344-44-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190408.2676344-1-sashal@kernel.org>
References: <20250403190408.2676344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
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


