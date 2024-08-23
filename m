Return-Path: <stable+bounces-69972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235C095CEA3
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 466BA1C2374F
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C563188903;
	Fri, 23 Aug 2024 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgyYZ5ml"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC12517E01F;
	Fri, 23 Aug 2024 14:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421701; cv=none; b=IQl65FvStOd0b7ZbuREJcLBpi7kVKRYggPy194pP23/meOrs1x27YyBa+zRUvASCEIaZbwsjEXRmBBVk7dWPbmWUhcCNJUCb6lxlSGn/FVAEc+NRrM6vjyRefhlMiA1hFR6Xe1ZWkrwJ2n20M5Uz7D4dZh9A/tknMZ34BNXIiFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421701; c=relaxed/simple;
	bh=9r/O/dswXk/5RkreAaB9f5SvarXl/nHMYeYvW80dEcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NdAUOICVO4Pp0/zjzMYfQLdVDTMcmKH32MJPJXTi2OOcMiospTtb69UtW/IdPG34FyqVgMeTNEcHKMAW1AbJ7bCBbM2MrsRFcWYZQ67iTUjUQJAw295hiuJeLtniWtTndduVkEs87Ynz+ogRqn63W1gLr9bf+0jH35D6LqHzlVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgyYZ5ml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BCFC4AF0B;
	Fri, 23 Aug 2024 14:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421701;
	bh=9r/O/dswXk/5RkreAaB9f5SvarXl/nHMYeYvW80dEcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QgyYZ5mlSR2djXgv4Q8NjJJ+gFDsLzkk1BMlX0upqT4bo9e5lvPn5GTNaUmmNQrGK
	 qeQ1YIs/LHtNt3cR1RkENXIBUGgpwD9offllH3j9hKz0Z5msJuAnekoKemxfxqMBBi
	 FTxl2xYl+yHOTcTImYCVBeSP+n2P4qDT0RzOgbjRnx9d94GC/Syuthyp73ya0YiXVw
	 RwqUfeu3WgNeRzkaNpYKu96ju8dW3dkCzWVI3RPWaLppmAkkC9ECw3tHX6dTYh7Epl
	 uywJiyYPKokSZ3wyoGvq4Ce0gQSJ0/odjRrcaEX2DIPLGpRUxruncVjz9PamQTX5Gw
	 UnQMxvlhSPTow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Foster Snowhill <forst@pen.gy>,
	Georgi Valkov <gvalkov@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	oneukum@suse.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 05/24] usbnet: ipheth: remove extraneous rx URB length check
Date: Fri, 23 Aug 2024 10:00:27 -0400
Message-ID: <20240823140121.1974012-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140121.1974012-1-sashal@kernel.org>
References: <20240823140121.1974012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.6
Content-Transfer-Encoding: 8bit

From: Foster Snowhill <forst@pen.gy>

[ Upstream commit 655b46d7a39ac6f049698b27c1568c0f7ff85d1e ]

Rx URB length was already checked in ipheth_rcvbulk_callback_legacy()
and ipheth_rcvbulk_callback_ncm(), depending on the current mode.
The check in ipheth_rcvbulk_callback() was thus mostly a duplicate.

The only place in ipheth_rcvbulk_callback() where we care about the URB
length is for the initial control frame. These frames are always 4 bytes
long. This has been checked as far back as iOS 4.2.1 on iPhone 3G.

Remove the extraneous URB length check. For control frames, check for
the specific 4-byte length instead.

Signed-off-by: Foster Snowhill <forst@pen.gy>
Tested-by: Georgi Valkov <gvalkov@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/ipheth.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 6eeef10edadad..017255615508f 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -286,11 +286,6 @@ static void ipheth_rcvbulk_callback(struct urb *urb)
 		return;
 	}
 
-	if (urb->actual_length <= IPHETH_IP_ALIGN) {
-		dev->net->stats.rx_length_errors++;
-		return;
-	}
-
 	/* RX URBs starting with 0x00 0x01 do not encapsulate Ethernet frames,
 	 * but rather are control frames. Their purpose is not documented, and
 	 * they don't affect driver functionality, okay to drop them.
@@ -298,7 +293,8 @@ static void ipheth_rcvbulk_callback(struct urb *urb)
 	 * URB received from the bulk IN endpoint.
 	 */
 	if (unlikely
-		(((char *)urb->transfer_buffer)[0] == 0 &&
+		(urb->actual_length == 4 &&
+		 ((char *)urb->transfer_buffer)[0] == 0 &&
 		 ((char *)urb->transfer_buffer)[1] == 1))
 		goto rx_submit;
 
-- 
2.43.0


