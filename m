Return-Path: <stable+bounces-127954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 771FBA7AD97
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05178176B26
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2452328D848;
	Thu,  3 Apr 2025 19:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WN287TCZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30C328D836;
	Thu,  3 Apr 2025 19:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707468; cv=none; b=fznWCqSOe0iRGR9+/ThiG0SWyCYDygToMYfbfqUk0IW+NAgGdO51ZqZ+EENcVL02+tjFM8vl986hdmw+DXv1tddMfat+cG+5nMuG/33BO43zDTpeFmGQTMU8skqUCRG/wV3cGVDiZaBEvTK1U3GZd8NYVhj5Ej1UWIZY6S5Cak4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707468; c=relaxed/simple;
	bh=TcvEGJ6+kDIkGSbkDlox3kWTb4rDObBfnOvnpRdWC9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I83fG4NK3x6RpWrNdoTd/pGnAgz29cO8ldw3IU6AcxyXf2HFndPih4VTR8qh1r9D392KDygqXOgSwSr1rcL+fTAdckHgiaEkCXTJK3URw1CuEbMvs4LMyqDs1ST7/clx0fbXcppdyvTcLc/GEXsZobkIDxnQlCF3vnXGnnDDxBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WN287TCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1423C4CEE8;
	Thu,  3 Apr 2025 19:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707468;
	bh=TcvEGJ6+kDIkGSbkDlox3kWTb4rDObBfnOvnpRdWC9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WN287TCZjIxVU3gd2MROkVj1Sf4eJG6o1pTpWj5m5iOHmGGmha7W8pacZJy85Jv66
	 vtEI6WauE/XZpqNvZ0D3+sNVsI7+4TL43vRUDZh3wzJ86hRszk+clCvcuQvhM0bCSO
	 7GYj14zdu8gp10MAOm7ByRHxR6mUDEmVp2yfVDrth43WDxF8Bkn1HqPtLUUXMS8jlf
	 MAqr0lyl6Y7XtvI6SscSlb/pVtxO3fyvpnIxB0Tq9sToTe/b0Bh7yqjS22sKZH0HI1
	 XJSyKDGtc+dMwlaKqU68n4DDIq2dKS6aZ68wROKssK24r81mydwM4lVRG0FHzUNtuW
	 KAG09J7/QR9EQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 14/14] Bluetooth: hci_uart: fix race during initialization
Date: Thu,  3 Apr 2025 15:10:36 -0400
Message-Id: <20250403191036.2678799-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191036.2678799-1-sashal@kernel.org>
References: <20250403191036.2678799-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.291
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
index 600c88fc3145f..8e4a23cd40218 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -703,12 +703,13 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
 
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


