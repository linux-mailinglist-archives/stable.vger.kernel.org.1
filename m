Return-Path: <stable+bounces-204276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0267CEA7F5
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 19:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADE68303E671
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 18:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093EA32F751;
	Tue, 30 Dec 2025 18:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKyRmW9R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6CD31BC95
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 18:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767120205; cv=none; b=tgqGCcMsM/nygGoAIsMNF0aO0lcUxxv2pwcwmoCJm6Vyk/CN8ot9yZD+UYRJ3jVtoU/VLzizQKY4i76a+qJiCnr25d4dJ9zY5VdIP2bJGqn1RZ/2hxIu6km/uikXFu2NfWheoFnyiWrbEHgbZQYJuuJGfHH4h1o8e2HpSNtPo3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767120205; c=relaxed/simple;
	bh=4138rPDhLcWoxNtqYfGc2OoqKWo0mMr94W+HKB+q+5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GxkQpLZg+1gh9uVWpIJdsbHxLqujNUF2lv8TwKWMS4ZmwhO1LKlZY0pvC/ML/ZQGtWj0biQbieBlOxrCDqlBkq/sOG92L5A7HLhoP+afxHmIQNXseu8A+VYrKQItDV3205sY4Ukcnz1UtRCbZ79sOLsviZueez/lZ4pGEz2SD88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKyRmW9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45E3C16AAE;
	Tue, 30 Dec 2025 18:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767120205;
	bh=4138rPDhLcWoxNtqYfGc2OoqKWo0mMr94W+HKB+q+5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XKyRmW9RYVt7sQCmxALTSIwXds6BKvOrdAnQ+5oQ7XSIE8FQGHYpfajKajogSZvud
	 OVc9BF2iZP7szGTq5PRZCiyvmyKS5iXwhQWsIOB3xS4m66NoJCMkYqthCZS+RxG/I8
	 B+otcjZ2VHYC85gSGED0snNNXlXUVbuGM+Mezkg/xipelw6wNWIPkxG5bzPcBu7wnY
	 v5QZGO0UoCKoxXHBlo5WsFh00sSU36sQB/FbWIrUMLRyP0w7wS2TZ0aRtuNPhsALX8
	 zRC4bX+zrr4+Czc5y4XhDT878KDXk1jNGpb1NE4mNVwHMoziTKg7D79vBcjZV7VQGA
	 BbOAj1ObD8ztw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] xhci: dbgtty: fix device unregister: fixup
Date: Tue, 30 Dec 2025 13:43:21 -0500
Message-ID: <20251230184321.2402789-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251230184321.2402789-1-sashal@kernel.org>
References: <2025122917-keenly-greyhound-4fa6@gregkh>
 <20251230184321.2402789-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Łukasz Bartosik <ukaszb@chromium.org>

[ Upstream commit 74098cc06e753d3ffd8398b040a3a1dfb65260c0 ]

This fixup replaces tty_vhangup() call with call to
tty_port_tty_vhangup(). Both calls hangup tty device
synchronously however tty_port_tty_vhangup() increases
reference count during the hangup operation using
scoped_guard(tty_port_tty).

Cc: stable <stable@kernel.org>
Fixes: 1f73b8b56cf3 ("xhci: dbgtty: fix device unregister")
Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
Link: https://patch.msgid.link/20251127111644.3161386-1-ukaszb@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-dbgtty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index f2c74e20b572..3bc7bb958524 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -522,7 +522,7 @@ static void xhci_dbc_tty_unregister_device(struct xhci_dbc *dbc)
 	 * Hang up the TTY. This wakes up any blocked
 	 * writers and causes subsequent writes to fail.
 	 */
-	tty_vhangup(port->port.tty);
+	tty_port_tty_vhangup(&port->port);
 
 	tty_unregister_device(dbc_tty_driver, port->minor);
 	xhci_dbc_tty_exit_port(port);
-- 
2.51.0


