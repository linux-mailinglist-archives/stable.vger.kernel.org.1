Return-Path: <stable+bounces-83535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BA799B3AA
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D204B23739
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE151A7066;
	Sat, 12 Oct 2024 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJBg3a3x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919A11A705A;
	Sat, 12 Oct 2024 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732448; cv=none; b=P4UPW7loGeEzUDop1RbQ+NRs0i+UhJooF0n2j5ZGZTkn6Cs3r/hnkG52xGlxxZn0cYVtDHztGhhi4BV/lgfR0XZbRoXfqLc7ywYD/Ov33FvFaevacAHGeYl6Xsu4p78L76SgfPmpJodn6gNssMQOaPrVzD8bWH27G2KSYb4+k5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732448; c=relaxed/simple;
	bh=A+8IDrqHLvCaio1WlnaM+9dxm61MWuaWKW5yzW0PJQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMQYC1POsYyt/o7m394s2jmftZHe6skMuccdc4Xabp7G4/sSbEA5On4OPCq9ZETlkpC20PgelpJh3uRKefzCnKWkAlahLjz9NAK5nn8RHLRiVJCWg8MaeKnEdG4fg6XpGcfKhZ95vAsxcurzqMcFrEblSZtCzcWakTy5tN4pnLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJBg3a3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E855AC4CEC6;
	Sat, 12 Oct 2024 11:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732448;
	bh=A+8IDrqHLvCaio1WlnaM+9dxm61MWuaWKW5yzW0PJQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DJBg3a3x5JeSOVCCMpPURymq6nvNFYvRII4L6iQSjSpL/BTdRAxM8xtl6HFAb6phz
	 434ZFI62XKnWSOrJl0nn1kQkJ/uFrI4+uu/nfl3GV410DGMdg7dfnu7Z1LkNuF/1HP
	 HRCRloeXa7qMxi7sk31H+Yg4895SrTYHaEDypzBJdaOGc+YobwArLJ4VCNUNJ0Hf87
	 XJnrBnILyv6NMJh+tqfQWWu0v9NeNGuT6XOGBu2LWMtfeAGp2YfbZ7MBzNBrEw6P0v
	 +4p9F11anHruOrsn+gT8qg4vC7wO75ZybLJ+BY5a7BDAPY5wvNdrHMawlmzu0sYuOp
	 e0NRIOi3A5EDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Foster Snowhill <forst@pen.gy>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	oneukum@suse.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 05/20] usbnet: ipheth: drop RX URBs with no payload
Date: Sat, 12 Oct 2024 07:26:37 -0400
Message-ID: <20241012112715.1763241-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112715.1763241-1-sashal@kernel.org>
References: <20241012112715.1763241-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.56
Content-Transfer-Encoding: 8bit

From: Foster Snowhill <forst@pen.gy>

[ Upstream commit 94d7eeb6c0ef0310992944f0d0296929816a2cb0 ]

On iPhone 15 Pro Max one can observe periodic URBs with no payload
on the "bulk in" (RX) endpoint. These don't seem to do anything
meaningful. Reproduced on iOS 17.5.1 and 17.6.

This behaviour isn't observed on iPhone 11 on the same iOS version. The
nature of these zero-length URBs is so far unknown.

Drop RX URBs with no payload.

Signed-off-by: Foster Snowhill <forst@pen.gy>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/ipheth.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 017255615508f..f04c7bf796654 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -286,6 +286,12 @@ static void ipheth_rcvbulk_callback(struct urb *urb)
 		return;
 	}
 
+	/* iPhone may periodically send URBs with no payload
+	 * on the "bulk in" endpoint. It is safe to ignore them.
+	 */
+	if (urb->actual_length == 0)
+		goto rx_submit;
+
 	/* RX URBs starting with 0x00 0x01 do not encapsulate Ethernet frames,
 	 * but rather are control frames. Their purpose is not documented, and
 	 * they don't affect driver functionality, okay to drop them.
-- 
2.43.0


