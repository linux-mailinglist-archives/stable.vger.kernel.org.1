Return-Path: <stable+bounces-89665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FAA9BB251
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 12:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B32B1C21BE4
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F101E285A;
	Mon,  4 Nov 2024 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmMyjcja"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E4C1B394D;
	Mon,  4 Nov 2024 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717676; cv=none; b=F8ZIE+T9qlUPbC3bevU//X3uH7vXhsV8ckkz7U5Pk9iaIncrg5lu5Kqy/lVHk6aIJXroOBUMQ8TuZG7Wxe6NgYDUwm5J6IoeKkvSDUfWHte83LWf5YHfH+8Lg4wivMw9L10SRc+r19buDhkgzSrlWw/zKzgTiq6JNYvLDxIv3rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717676; c=relaxed/simple;
	bh=JySOKYHLcoB8FEupEEITxbcmbNPZinGa0YHZsZnkWb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l1GgZLsCN19Rf/NXWzHIL++YvJ07ecY0xw40d3/uQhv760ktzyCS4erbIgZ3YBh5T5bqvzSUtpcW+ujuBzX3QeMECkyjTiU+ETBRc3axS/kEKqCXKm9Ur64MC29zmrJwd3dkD6QPlHZdY/M8U8QeuIv4wMudTUiMOAYTkevNMwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmMyjcja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EACC4CED2;
	Mon,  4 Nov 2024 10:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717675;
	bh=JySOKYHLcoB8FEupEEITxbcmbNPZinGa0YHZsZnkWb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RmMyjcjaLcBLbN99Kkkqkr7KRbD6jIenVEPn2kqkyC0TqIypWcNTaPTDe0JPG8fBI
	 95l1Kccs/2uLibyZAxA7MGSonOM2nR5I2oJD7j2njsfmXJxF7yuncfxsnwQr2pJX/6
	 A5IdWuCwrdY7lVToDJ7tOJbFgcp7/AM7zbbGLXHW2ASLQLDnMync4dj0EwA2MXAlov
	 fmgotFW4zFWZC6UW3zx2vqu6YDYjOpmeb2n9xhaXDoM1tv8GoZcjGkGQxZgG9L7D6c
	 ayUj62JhU0lB3LCSkdReQ5t2gOzIb5Kr/026UUbKTrM/gqiNpLqehNU6WvHRT1yvgr
	 cczrufHNzbGcQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Benjamin=20Gro=C3=9Fe?= <ste3ls@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	hayeswang@realtek.com,
	dianders@chromium.org,
	grundler@chromium.org,
	hkallweit1@gmail.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 06/10] usb: add support for new USB device ID 0x17EF:0x3098 for the r8152 driver
Date: Mon,  4 Nov 2024 05:53:55 -0500
Message-ID: <20241104105414.97666-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105414.97666-1-sashal@kernel.org>
References: <20241104105414.97666-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.170
Content-Transfer-Encoding: 8bit

From: Benjamin Große <ste3ls@gmail.com>

[ Upstream commit 94c11e852955b2eef5c4f0b36cfeae7dcf11a759 ]

This patch adds support for another Lenovo Mini dock 0x17EF:0x3098 to the
r8152 driver. The device has been tested on NixOS, hotplugging and sleep
included.

Signed-off-by: Benjamin Große <ste3ls@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20241020174128.160898-1-ste3ls@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index e8fd743a1509d..abf4a488075ef 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9843,6 +9843,7 @@ static const struct usb_device_id rtl8152_table[] = {
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3062) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3069) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3082) },
+	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3098) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x7205) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x720c) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x7214) },
-- 
2.43.0


