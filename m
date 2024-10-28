Return-Path: <stable+bounces-89051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BD69B2E26
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 12:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2D871F22060
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6EE204095;
	Mon, 28 Oct 2024 10:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEFK5o8r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B29204086;
	Mon, 28 Oct 2024 10:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112823; cv=none; b=lCDTI4Sc1+NPCN+QA3+SzJtZhNXOnFw0pGCM8jreEbPH3ZgNYAGL7wG/TQnA0fNTPPRfFfuoSDzc6Xl2luU4Yf4f1XkgBWOpteDa/Ml8XAqtJlgvEmk0ilylfiAYWf++jycUMFbIJ2fwkSd0gdsM0INBUAdXLxEcGolE3vt4FYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112823; c=relaxed/simple;
	bh=il6lkg5jDhtId9fEvJ3VqpFBL8gZnVU8tsvEzN6SW9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uGAgjGNj7x+TAF2vkKnDY9fasUZ2rsTaGwNaQKp5AK2+Vx/4WLb3uqvq4jin0uZSiUAIZMoC9dxSxCrMTlTbEzZ+xDCO8v5b4EroMxZH+bIepIsCJz7J6iGI3zeJeI08LM2MRpMDGeoyoiX+jYYANzavhlZLuUnNflbRxqsVWuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEFK5o8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3E5C4CEE7;
	Mon, 28 Oct 2024 10:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112822;
	bh=il6lkg5jDhtId9fEvJ3VqpFBL8gZnVU8tsvEzN6SW9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SEFK5o8rHq1G1QIiyoFMzuHq5qxF0sdLgLrJ7r3aGgHmibEL8FTQqlg0g2hrfvANw
	 cyazn94onmGCw2TdIUR/J0tWnazjW1HcEw6jYjJ6urXf/HYSnGt4yW3/peR4gby5ms
	 aWxrMtvCeKiwDItqzlSSAJYIiZ63+T7NvKZDX84UcAJXPW/k0R++k3U7ABOZyDql1V
	 oZTa0gTM2vJHn3uhfxYgpzgz166/MNy1CLkLT1xbOpr1PZivf47g7UlLhDE7Xp0xvT
	 vhbxb7XVxyCRr8jk53vBCv7HbUkjSjCZ9F4FYGnfhIreCOAKgZ9Pmm+5qjYpP9HPlN
	 iKFzd8+yJJz+A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Reinhard Speyerer <rspmn@arcor.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	bjorn@mork.no,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 3/3] net: usb: qmi_wwan: add Fibocom FG132 0x0112 composition
Date: Mon, 28 Oct 2024 06:53:35 -0400
Message-ID: <20241028105336.3560730-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105336.3560730-1-sashal@kernel.org>
References: <20241028105336.3560730-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.284
Content-Transfer-Encoding: 8bit

From: Reinhard Speyerer <rspmn@arcor.de>

[ Upstream commit 64761c980cbf71fb7a532a8c7299907ea972a88c ]

Add Fibocom FG132 0x0112 composition:

T:  Bus=03 Lev=02 Prnt=06 Port=01 Cnt=02 Dev#= 10 Spd=12   MxCh= 0
D:  Ver= 2.01 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=2cb7 ProdID=0112 Rev= 5.15
S:  Manufacturer=Fibocom Wireless Inc.
S:  Product=Fibocom Module
S:  SerialNumber=xxxxxxxx
C:* #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=84(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=86(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms

Signed-off-by: Reinhard Speyerer <rspmn@arcor.de>

Link: https://patch.msgid.link/ZxLKp5YZDy-OM0-e@arcor.de
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index cce5ee84d29d3..db52090bb27be 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1382,6 +1382,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x2c7c, 0x0296, 4)},	/* Quectel BG96 */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x030e, 4)},	/* Quectel EM05GV2 */
 	{QMI_QUIRK_SET_DTR(0x2cb7, 0x0104, 4)},	/* Fibocom NL678 series */
+	{QMI_QUIRK_SET_DTR(0x2cb7, 0x0112, 0)},	/* Fibocom FG132 */
 	{QMI_FIXED_INTF(0x0489, 0xe0b4, 0)},	/* Foxconn T77W968 LTE */
 	{QMI_FIXED_INTF(0x0489, 0xe0b5, 0)},	/* Foxconn T77W968 LTE with eSIM support*/
 	{QMI_FIXED_INTF(0x2692, 0x9025, 4)},    /* Cellient MPL200 (rebranded Qualcomm 05c6:9025) */
-- 
2.43.0


