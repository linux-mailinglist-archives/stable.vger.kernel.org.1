Return-Path: <stable+bounces-89642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF5B9BB1F1
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260EB1C212DC
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 10:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1961D1E71;
	Mon,  4 Nov 2024 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Feo+lQnM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD491BAED6;
	Mon,  4 Nov 2024 10:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717574; cv=none; b=HDoPd8CU8vBbpbe4zutT2RZGWeUMdHMPJU+r5grhM3CJ7fPuaTrnxCirTcqn1/oqB9rjB6CWg0fkWH3ZeRiNtjRH8eg04tewWgh53PKAnyyyFHfTaIQXMrpro/956eC3i8YFyWn0Fq5I78GFYKwqepVIiymEFkAi8LRwbahrxFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717574; c=relaxed/simple;
	bh=COcmdmlZ2lzhXaSD5dX+uOgCV0ihYITXwubTgU7eht4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ko++lp/Oamu7a/1PjQgqqcJ8iBVkNvx69gtEgo23YuCpNr5x8lr+2sSmydK6OGl2pDe6vGcfr/d4COPYsRB4YTGT6kxVyK6WaYy9G4mrnKuMSppQ3wgm7jIoMwpE1xOyp2NyHUoXybl3uxfc3RtytXM5cuUgf8Gik5AlsC+hmKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Feo+lQnM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66BEC4CECE;
	Mon,  4 Nov 2024 10:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717573;
	bh=COcmdmlZ2lzhXaSD5dX+uOgCV0ihYITXwubTgU7eht4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Feo+lQnMQpIij1ExfMQpUXtYVJ7TgkiBBKKqePtKQKO0otsDJ2H0yR1IkOQL/CXnu
	 IJdRiBDmfky+qfKdLdTbb8VN/6Xj5Gr33odPOdtC+l/HX34O8UuZvfeu1mYLUiAKIz
	 1NOTMc0P9wrM/+pgs0m6zA+l2Mld3T9FMf6C0CVc7rcNNMPKUdPpSpWOcU8QczS96N
	 9qrahpkMxUgEKDgvUnmOyAIGu1EIhHhhhUSjoigZUvM5cCgySWsVqcsgyphygxblLq
	 vHJ1i/5wlMtGd5CwL4fnZy53qStXDZg1aPjwID75uTCVof2w+V/MnyypMHazJCr9Mb
	 zIQZGnC3fmw1g==
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
	gmazyland@gmail.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/14] usb: add support for new USB device ID 0x17EF:0x3098 for the r8152 driver
Date: Mon,  4 Nov 2024 05:52:00 -0500
Message-ID: <20241104105228.97053-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105228.97053-1-sashal@kernel.org>
References: <20241104105228.97053-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.59
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
index ce19ebd180f12..3e5998555f981 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -10016,6 +10016,7 @@ static const struct usb_device_id rtl8152_table[] = {
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3062) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3069) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3082) },
+	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3098) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x7205) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x720c) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x7214) },
-- 
2.43.0


