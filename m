Return-Path: <stable+bounces-127940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB69A7AD71
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A720165497
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79FE2550CE;
	Thu,  3 Apr 2025 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRLC80IL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560892550C7;
	Thu,  3 Apr 2025 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707436; cv=none; b=ZXvrL9hFODD7j7jQgyERp+4TVHOraHhu1pL/nMc2d2Wcfs0W+Z68lAvzDiI9Gua0m1zApG2mTEhiMzVTbsBrJlE6Xd8CGxmhAn/buhBrCVaidby91IB7MvxoDXPMd5fxVBwlUEZZc6X7+/isa03ohlm1Po980UHdh2SAAc9zy0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707436; c=relaxed/simple;
	bh=PbcYz7bxFLedZ5ZzdHbmuxTgcku+VPUGlZi/qQ1CUW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ncy92eiRTvy+MqQ8tONEtk/WQWBP/STKlKIh3nEqj0PUrq8xhfkFkLQm/Tj8A8GGwrkxw8BK0XeyvVb6t7WI2PVDmIbCwEUmankMIv0+/MVax1aaoawiu12xqVfC1aiigQfenapsWQYhdhEah7RRkkjQi14N/X0d4pZHXSPxwzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRLC80IL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03A7C4CEE8;
	Thu,  3 Apr 2025 19:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707435;
	bh=PbcYz7bxFLedZ5ZzdHbmuxTgcku+VPUGlZi/qQ1CUW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JRLC80ILH6vqOydmDw8ZPVWepm0yMh1KWTYn0twTsy5MenjgsVDu7uPKpwZR0xfvK
	 /WWpAQjki5xPOMpo7cwcd5sjcdr2J/+jX6cBKdVFpg1nMCMUqTjVvoZtxWgoPR7tKp
	 HhUNroUp/nMtpL9n/n0E8MJF8MhnhTLeSMZtHefiBKTL5z7O8ezpUQLvA84Q+BPBnH
	 S3DCa9vglXHkO521okFsfwlySM2/lTfDGJUkVQjJ6ztxH0h3CZNaPINBq3UV/2SkSp
	 HmwVFj2OMS045ymOIlaRCRqblBCG59fSEwkomFligg/h1SeLHhMG28KYx+TPDVD9gh
	 VsJ+WTJprJ+sQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 15/15] Bluetooth: hci_uart: fix race during initialization
Date: Thu,  3 Apr 2025 15:10:02 -0400
Message-Id: <20250403191002.2678588-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191002.2678588-1-sashal@kernel.org>
References: <20250403191002.2678588-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.235
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
index e7d78937f7d6b..8ca0ac3a440c9 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -706,12 +706,13 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
 
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


