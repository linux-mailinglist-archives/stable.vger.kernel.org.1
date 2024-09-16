Return-Path: <stable+bounces-76404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B3E97A191
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 14:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA74A1C22436
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 12:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC4815533B;
	Mon, 16 Sep 2024 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZfTadYE9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC6F14D2B3;
	Mon, 16 Sep 2024 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726488495; cv=none; b=MCogeZVdzD4Uvrsku56RxkWnKvLtirm8P9PaoaU2ZpPQUhAbE75dXxhwqxSmtIqvgKl49ZnbZM2IBQeBavnGJ76hAUgn7F5fqVE8p1O8tnIGc24cH8iw3WW0ofDeQP+qTSWKaTz17v9cwuabbnWaGlsEilAHu5OOZsm1ZgHRFFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726488495; c=relaxed/simple;
	bh=H4zSf22/RLPk/4OpP59lOFY3MyyprMdVzEW7Q0YDHy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pab54ymO2iwmU5IdZXi57dZBGSHGrkVDLBz7JAHouU1101L/IqYj2C4nZQSw6AYzkn5v0LUxofd4p6Dzma2Bn3cYAC6zKD9XaEIwvVYq5a+Vq4DLjfnAzh7/fXXLIbWmugWJY+84HQcV+6X8FafA32mdHQObt7dnCWoCv7qokSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZfTadYE9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17111C4CEC4;
	Mon, 16 Sep 2024 12:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726488495;
	bh=H4zSf22/RLPk/4OpP59lOFY3MyyprMdVzEW7Q0YDHy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZfTadYE9hqeSI1yO2t636PLtWS7qx9RqlVbK4xAJUzYYTbBaE4OScdIz0bsf4YIXi
	 +NFoxpDTYOvMhS4/VnGdvIAv1X54P3f3HsxMWQLvcVvLiqnBnI1/pzfFaVE5eLI/Zm
	 6dD9HNLJcEc6KkMvIfsr/4wlIPan8r+9iX5O2UhQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Foster Snowhill <forst@pen.gy>,
	Georgi Valkov <gvalkov@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 12/91] usbnet: ipheth: remove extraneous rx URB length check
Date: Mon, 16 Sep 2024 13:43:48 +0200
Message-ID: <20240916114224.938380819@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916114224.509743970@linuxfoundation.org>
References: <20240916114224.509743970@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 6eeef10edada..017255615508 100644
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




