Return-Path: <stable+bounces-204283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B52CEA8D7
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 20:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93BF4301C3C6
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 19:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5969423F424;
	Tue, 30 Dec 2025 19:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9IBN4mk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192D421ABAC
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 19:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767124150; cv=none; b=oL1a1nmlEUQm/bXze4HcPdyEtOnOKaF25DCiughldfyXL+uZAOt3a1aKRnxAam+UkqNM4mKvzgAbXUQGeB7uxpKe7hPwiPbW82ELsPRBogqfZG0rNHlaxpSvpeFAxd5oiMpot/c897gpld0fOmqVdtqvvaIApKHEO8fFBQJMX3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767124150; c=relaxed/simple;
	bh=VuO/3sCpbf3InPsEuzordnvx/8/mK5HD29uPua24mbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4WNtoP5J40IAd+tTSvkdUQSDJLTJNOmQTkdedXyLoJB7ZE7X3O3etEoZk5zl9mNGByhvhk3YEVcWZza/M1eacQnzKrCoRwx/17mw1V7HNSbLNofitm241ISnDpEv5dj7koAhOXhrmXHbgCKgm9YG8Gx12o2JqMilGbXXQ7x3r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9IBN4mk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0425AC116D0;
	Tue, 30 Dec 2025 19:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767124149;
	bh=VuO/3sCpbf3InPsEuzordnvx/8/mK5HD29uPua24mbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T9IBN4mkaOxkmezEncSNGHHj/+2RDRgasGVZZr4DQKaVyu17LbZPlG0L2ZBqarLtn
	 zZ9A6pawi9GLOtAeF00uJ3UYZLNr4BOwBmVTIn21JD+7sXm2PRTiULgR5r4GtRKP/O
	 i9u6vgXpEMvYro+ONAbQ2SMbfXUZg7ENrqnD0CtvE0IPMLFRoH6FtXG5ms8Ko+/mdo
	 vElRo71mA10YSl8HwPqU2LkFOnYeaKATm88ry9YjtQ12QBUydUl/GJ6Wm5p0IbymPb
	 rVZNbLYo4n9Sfl71qJIM5P9wRaiw1GSoA50qjYEIs7ChREN/vpfl+Qz3zijbSDS511
	 L/DgzBpJGgCGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] xhci: dbgtty: fix device unregister: fixup
Date: Tue, 30 Dec 2025 14:49:04 -0500
Message-ID: <20251230194904.2442970-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251230194904.2442970-1-sashal@kernel.org>
References: <2025122918-sagging-divisible-a4a4@gregkh>
 <20251230194904.2442970-1-sashal@kernel.org>
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
index d6652db4f7c1..3e388f385372 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -523,7 +523,7 @@ static void xhci_dbc_tty_unregister_device(struct xhci_dbc *dbc)
 	 * Hang up the TTY. This wakes up any blocked
 	 * writers and causes subsequent writes to fail.
 	 */
-	tty_vhangup(port->port.tty);
+	tty_port_tty_vhangup(&port->port);
 
 	tty_unregister_device(dbc_tty_driver, port->minor);
 	xhci_dbc_tty_exit_port(port);
-- 
2.51.0


