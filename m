Return-Path: <stable+bounces-3012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B477FC73E
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 22:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504C8287BD4
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 21:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8795A42A8A;
	Tue, 28 Nov 2023 21:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBMcwf4n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBDC3527B;
	Tue, 28 Nov 2023 21:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C4DC43397;
	Tue, 28 Nov 2023 21:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205726;
	bh=y20RWt1ln0U/lgGf+V/Mh1Nqa9sBgpOm++xBDVkNX5I=;
	h=From:To:Cc:Subject:Date:From;
	b=JBMcwf4n6AgUSa29X/b886Dbt/l0QLUQ1IsuilbrASw9hDZRNL+Rj5MZEatYFuHW7
	 a4jLWL2zm3tpBYNo5ivihN11H9pkpz9AQV2eQHjPMUZ+OhDmmtI9l6xvS5RuY9zYg/
	 ZX+0Vqi82jlpXe2QPBDmcvco5+KZwpFSLLV8306nTnR+OlOYesLLjZyxF92qgzyOq9
	 LD145jjtnFLZO1f68DJfn1UsbRqkEZsJ17V4Jwf7xYjrsNbDcRtjCxj9QtVbayudgG
	 aRcAxjY8AXZ6o8/6reu3PJjO3O75DMr/RelGkM5TFt/Tf9Zl/FElY7hFiYyhCTVOhC
	 9Hpmycff3bl4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 01/15] usb: aqc111: check packet for fixup for true limit
Date: Tue, 28 Nov 2023 16:08:22 -0500
Message-ID: <20231128210843.876493-1-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.140
Content-Transfer-Encoding: 8bit

From: Oliver Neukum <oneukum@suse.com>

[ Upstream commit ccab434e674ca95d483788b1895a70c21b7f016a ]

If a device sends a packet that is inbetween 0
and sizeof(u64) the value passed to skb_trim()
as length will wrap around ending up as some very
large value.

The driver will then proceed to parse the header
located at that position, which will either oops or
process some random value.

The fix is to check against sizeof(u64) rather than
0, which the driver currently does. The issue exists
since the introduction of the driver.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/aqc111.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/aqc111.c b/drivers/net/usb/aqc111.c
index e8d49886d6953..bc5e3f45c499e 100644
--- a/drivers/net/usb/aqc111.c
+++ b/drivers/net/usb/aqc111.c
@@ -1079,17 +1079,17 @@ static int aqc111_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 	u16 pkt_count = 0;
 	u64 desc_hdr = 0;
 	u16 vlan_tag = 0;
-	u32 skb_len = 0;
+	u32 skb_len;
 
 	if (!skb)
 		goto err;
 
-	if (skb->len == 0)
+	skb_len = skb->len;
+	if (skb_len < sizeof(desc_hdr))
 		goto err;
 
-	skb_len = skb->len;
 	/* RX Descriptor Header */
-	skb_trim(skb, skb->len - sizeof(desc_hdr));
+	skb_trim(skb, skb_len - sizeof(desc_hdr));
 	desc_hdr = le64_to_cpup((u64 *)skb_tail_pointer(skb));
 
 	/* Check these packets */
-- 
2.42.0


