Return-Path: <stable+bounces-69995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A1595CEF4
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878A71F2853E
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66DD189BB8;
	Fri, 23 Aug 2024 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQI974Yo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900E9188904;
	Fri, 23 Aug 2024 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421800; cv=none; b=dtw4WIAfIu/wELGEAEMT+KwfuLtYDYO7Uz+FBm5z3O1XEzg9kzj//cR5KuWta2nWJZrm6Yloj+7okUWc/pDupIZlxqdYcDVyXKmM4T3DriKLkTg7vJQ8ogmil+icMvl23NlBGEfNhJUBjKUaU+DopYsGESvlHxdhwE4x/J6DjO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421800; c=relaxed/simple;
	bh=9r/O/dswXk/5RkreAaB9f5SvarXl/nHMYeYvW80dEcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCNjjyQovL2QGzoFIasBzikFfpmIiFxz/ausgrLa/E9AxI2MMN9YkPf1vx76DID0404cgjlSa1UKjLZWn0E8f5NRx3yfgGWXAFDVRBZKYsxiwP+uYge+G4ND1BO+aDvK5m5XYpHTBSMJJgN9XHYBUQ4ogVJBLzrz4LtOoCIi/5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQI974Yo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B26C32786;
	Fri, 23 Aug 2024 14:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421800;
	bh=9r/O/dswXk/5RkreAaB9f5SvarXl/nHMYeYvW80dEcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sQI974YoL2a8EJt4cJopg9bBlfJyxDHWOnNxkujLkPSAZRfHzFmiZZdYrfHsE1enx
	 dwf+vGxT7/sRUOn/RebrwFmWYpDQehh6ZpPV5QQ/PXKKBJD9SkWWLlbBvE2Q+T2BsP
	 YLo8hJN/ecwsGg/tj4YJz5GzONeEwi2+e9PtPe7IO9XwhN6KD4cd1opaao0KvhWYwL
	 qTqQ4r7g5wgMFOG8OFoi2yn91FnHkUtRkDtJicgyq/ld/15MrgIrL/Ig1ql0k9fyOv
	 pgpNynuJctPOEjkMjVhGbsYfGvviuVznnf+pl9qtQsninIHOtQi7c8sfVtBVdjOEmc
	 LYiyo4ag6kLlQ==
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
Subject: [PATCH AUTOSEL 6.6 04/20] usbnet: ipheth: remove extraneous rx URB length check
Date: Fri, 23 Aug 2024 10:02:18 -0400
Message-ID: <20240823140309.1974696-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140309.1974696-1-sashal@kernel.org>
References: <20240823140309.1974696-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.47
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


