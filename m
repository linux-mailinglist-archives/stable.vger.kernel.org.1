Return-Path: <stable+bounces-204274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8480CCEA79E
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 19:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6C1D3021769
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 18:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED8032E14E;
	Tue, 30 Dec 2025 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCb7swBT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F17E2741B5
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767119561; cv=none; b=rb1uFyK01ygn/8sUlJjiCQVRHSHVBcUnMZrcHmUCtgw4/+d6e99hoLkU2o4g0Z5DCkWEjdsSTwL6h4KiDiKNtngParfRruUSyxrAHE3VmYCEnGjxBqRwIg2Zajcc0xqJYfm/a9ImG7SSuqVH7SyArU6kuxXDc5j5oFWlwMI026s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767119561; c=relaxed/simple;
	bh=oTsKkyKYuXnsiSMCv+FZFjmlJ9UCshv2hUgCqIX/BI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WK6QrIJuZqSf125LbU0H4S2Av5qoP3MFqRT4gtXNr+tk4WzxLpdjwwo7+giVdhGQj0QIB+G6UzRYgLCEMn+A+prkaRaNHYwuaKUyquq1/eT8TggizcOWIVnlSKJl86v0/lBPe8Li2oeImNkHUJZaAKVy7Nwp1RwN1PMmUpXnZw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCb7swBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DECDC116D0;
	Tue, 30 Dec 2025 18:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767119561;
	bh=oTsKkyKYuXnsiSMCv+FZFjmlJ9UCshv2hUgCqIX/BI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GCb7swBTCVLtfEOcgtc0P9jVr+Qu7HACTBo1qvbOhuTfPbEUVb2sPYlIRkStaNFPr
	 1C68hH8yWzLSxYiXTIrllksdVp84lX0Rjny0czzmzgOizWlfTWlZH+nhnzbAyoJiVk
	 lt1FNusYcFHHl8l3fJQNudE6MrWT+wX23nXmgD8nPZPndfaxfksi43C+4ApaNvlCBB
	 EZ8ybImmIbUSXUZfJxFD1jriUhaiZcwg2oa3njl42w2AqA9XCTOP2E+ZeoWTfx/B3m
	 A8HqLIyu8VjDeLPEC/f0h3QUC4dhkWXx+mZuSKF13eL+zJKEQirCvr90cbHito97+p
	 csW6ZBov4IP4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] xhci: dbgtty: fix device unregister: fixup
Date: Tue, 30 Dec 2025 13:32:37 -0500
Message-ID: <20251230183237.2393657-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251230183237.2393657-1-sashal@kernel.org>
References: <2025122917-unsheathe-breeder-0ac2@gregkh>
 <20251230183237.2393657-1-sashal@kernel.org>
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
index 349931a80cc8..54b68ce8f2f5 100644
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


