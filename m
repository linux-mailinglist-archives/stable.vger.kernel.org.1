Return-Path: <stable+bounces-200349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF680CAD356
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 14:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED8223020687
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 13:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D061ADC7E;
	Mon,  8 Dec 2025 13:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqgRG5nx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B397779DA
	for <stable@vger.kernel.org>; Mon,  8 Dec 2025 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765198901; cv=none; b=RbxmTzw2Mv1HSLjIWklWUZdG16wPw2ukkr4RvgMu2LtWzTiab3Mx04XAaFT4SLDgjLU69AD6VJ+Wn0iZ5Ivbw5AMZ/U0VTGXuSPgwXnCebVpUp+xu72DcYhvdQevOcXDCN2dEvAIPrKfIzkFXvFXmr83wTT3lHBpUzTwDyd6cxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765198901; c=relaxed/simple;
	bh=2z9EaWkbPv4FMRtgOzbsp8f/6Na3FFtIZFoQD1Ajkjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yt1+RX9IT9hO7oDKAo5DJEvrgaUa3PAdgLli74cjDyVpKuwFcNEW8sPngbueSoSiwwlcZXQvZg062zAbBQgZQZib93t+J0Vz3jmDYRfFCZmPLNfV7E8wxTwSHXsLmT1M2oyi4qQTs+B7UBBnqf1aN7PK1ot54v4tfJ458ND6uzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqgRG5nx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D675C4CEF1;
	Mon,  8 Dec 2025 13:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765198901;
	bh=2z9EaWkbPv4FMRtgOzbsp8f/6Na3FFtIZFoQD1Ajkjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kqgRG5nxnINs3XubJqwf5Twm2T1LQMSBTO7soynsf4AkhSDGPTItFPyU1bep6ERxR
	 Ox2VF05QFhVgEzUp2ZlDFcZs0+p4BePF3ptqMaW1IasKo4fNmOTa7LIstY6FJw9ggO
	 KE1OKQBaPm4XjRQXj20NcxgyDAw1A1UMUszmTjZ3WLBGDcCNH+sHgjangqS6gE1b7h
	 BUOP6zCvpD7Msx2ZyYI500xgw2DSq9/NsZO53fMu+pGen1IqKxkMQvaIfgFOgG69bT
	 7OxlE56Y8VXuir5ZStwNLojlKHAjt9ID+sumevmSCBWBkPviGW0UA5PYK8xGfaJ+Jt
	 KC9sIzQ75uySA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] xhci: dbgtty: fix device unregister
Date: Mon,  8 Dec 2025 08:01:36 -0500
Message-ID: <20251208130137.296454-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025120110-coastal-litigator-8952@gregkh>
References: <2025120110-coastal-litigator-8952@gregkh>
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
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-dbgtty.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index 980235169d811..d03eea7beeca0 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -468,6 +468,12 @@ static void xhci_dbc_tty_unregister_device(struct xhci_dbc *dbc)
 
 	if (!port->registered)
 		return;
+	/*
+	 * Hang up the TTY. This wakes up any blocked
+	 * writers and causes subsequent writes to fail.
+	 */
+	tty_vhangup(port->port.tty);
+
 	tty_unregister_device(dbc_tty_driver, 0);
 	xhci_dbc_tty_exit_port(port);
 	port->registered = false;
-- 
2.51.0


