Return-Path: <stable+bounces-200326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E80ACAC3C7
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 07:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B06B230262A5
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 06:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C95720A5C4;
	Mon,  8 Dec 2025 06:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eF1HthZT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBAA1E2606
	for <stable@vger.kernel.org>; Mon,  8 Dec 2025 06:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765176867; cv=none; b=kQWej/b9p0z6LJmapID4lJ4k9MYyjh+kLonwX3J8nhJ8aqL8g1MH90GwPoJChlKojMVr+Z72+e2M/ampQ9pnDTUeatwiGZq55WU82rn8FtvY3DE92xJS2zPEaQUWLMx7Kk1RUmwvW2c5fwNr7Hvtc+cLK++JXbClqpUcxs9KNXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765176867; c=relaxed/simple;
	bh=oERhIVPlrs+MhSQFUmVlpIVXskxNYcWoijN25jHFOmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hk49tbR7L9TiAG39aeSJBMVGYq8Qaa5x1HhVJz9r9Nxj02hKruznEagKuP7OKxsZON/CMs3/9Fg6AAhcgv85czk/45P2U7tOfsUQDpdx4fX6BonzDxCjCQyR7XBmbWjDx7cCsbulK2bFuI6PVvE/ge/3UYdx2Lj+OXJieGQfSGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eF1HthZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BDFC19421;
	Mon,  8 Dec 2025 06:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765176867;
	bh=oERhIVPlrs+MhSQFUmVlpIVXskxNYcWoijN25jHFOmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eF1HthZTn/m3GSxHqiynNmpbsiz0Uk0EUT6SLtbW4hYxT4OLPCMR3vAy7axT4S4hF
	 4p7OgsbZPtt5oguK+C7nRhvMAKgGMeyJoi2NPwugBIXo/pt7m4VNo3BS2zFrAotQ7e
	 hUlA3N6SOaqzQZK2WrAwv70RWnMx46cv3CRnDBnXtUd7suViIdQ+Xah7OU0l6MQ0DO
	 2ea9HrhPu1/MXpyp40GgpF06LIce3Gj5/9PkYHpqcIvU+AWT7/3IJDvzO6XFgsB+rI
	 5WY4ubdu0HibmgS9lzGJa8TRjCmrB5nXGJ4xWefZfcp4iizv9Xidwa5NV41y8KvoLe
	 vjeKqrFHafUmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] xhci: dbgtty: fix device unregister
Date: Mon,  8 Dec 2025 01:54:23 -0500
Message-ID: <20251208065423.260017-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251208065423.260017-1-sashal@kernel.org>
References: <2025120110-deuce-arrange-e66c@gregkh>
 <20251208065423.260017-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Łukasz Bartosik <ukaszb@chromium.org>

[ Upstream commit 1f73b8b56cf35de29a433aee7bfff26cea98be3f ]

When DbC is disconnected then xhci_dbc_tty_unregister_device()
is called. However if there is any user space process blocked
on write to DbC terminal device then it will never be signalled
and thus stay blocked indifinitely.

This fix adds a tty_vhangup() call in xhci_dbc_tty_unregister_device().
The tty_vhangup() wakes up any blocked writers and causes subsequent
write attempts to DbC terminal device to fail.

Cc: stable <stable@kernel.org>
Fixes: dfba2174dc42 ("usb: xhci: Add DbC support in xHCI driver")
Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
Link: https://patch.msgid.link/20251119212910.1245694-1-ukaszb@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-dbgtty.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index 20e50e559c2a2..32f8c3d40fb0c 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -489,6 +489,12 @@ static void xhci_dbc_tty_unregister_device(struct xhci_dbc *dbc)
 
 	if (!port->registered)
 		return;
+	/*
+	 * Hang up the TTY. This wakes up any blocked
+	 * writers and causes subsequent writes to fail.
+	 */
+	tty_vhangup(port->port.tty);
+
 	tty_unregister_device(dbc_tty_driver, port->minor);
 	xhci_dbc_tty_exit_port(port);
 	port->registered = false;
-- 
2.51.0


