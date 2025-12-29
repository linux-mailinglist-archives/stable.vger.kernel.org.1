Return-Path: <stable+bounces-203953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9D0CE7A11
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 17:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A02830BD504
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780503128BC;
	Mon, 29 Dec 2025 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KmPzYwHL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3581928488D;
	Mon, 29 Dec 2025 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767025637; cv=none; b=Tf+9igv87zN7uEDldqVq07rDeq3dR30KloIe1UMLvILZvob2ZFxIvuv5l9DVkLQDZ3JXfXmFSFrTR5INhAscjJnmEndkYIoIDYPtUJjyridtY2d/ss8bKRU1rciqNwo3soFbRGG+kaE2HzFZQG2HIyLu44gngaPQm0w6rV8dZMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767025637; c=relaxed/simple;
	bh=kzA9UtcQZLbRt8Xqg0kcMPOhe24vRhVHw2FJfQjv3Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kDPAi7EImnNn/5g5OS/96GjkJHpYfsM/8x1eA4ogZuuyWqGbKagw6oyYrnbfPooZya5qtkc4YFZ44ZihS5/45lieDkchL8E3HuvoMydJ38JekeHmcMnpS7M4akeY7ppWczfiqhgK7+d2oLlQeL1P85YP0HbjZDTGVTHyXi/tjt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KmPzYwHL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6207AC16AAE;
	Mon, 29 Dec 2025 16:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767025636;
	bh=kzA9UtcQZLbRt8Xqg0kcMPOhe24vRhVHw2FJfQjv3Jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KmPzYwHLBGxrMwz3oX5LG3d2nP8fJwd1FUGfr3vuFkRqYVqqYUiDLBkh+5TuKxE16
	 IG+yeBKbVD0rVKwrOiUkCmjuiGZT685gsTjGkeA1Q2Za0BwChtzODCHMHj4tt8ajYJ
	 Nv8au3EyD1cNn3mEWM8xrNBvHvTd8Y8+NrEUIHpg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Ke <make24@iscas.ac.cn>,
	Johan Hovold <johan@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 6.18 284/430] usb: ohci-nxp: fix device leak on probe failure
Date: Mon, 29 Dec 2025 17:11:26 +0100
Message-ID: <20251229160734.797404420@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229160724.139406961@linuxfoundation.org>
References: <20251229160724.139406961@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit b4c61e542faf8c9131d69ecfc3ad6de96d1b2ab8 upstream.

Make sure to drop the reference taken when looking up the PHY I2C device
during probe on probe failure (e.g. probe deferral) and on driver
unbind.

Fixes: 73108aa90cbf ("USB: ohci-nxp: Use isp1301 driver")
Cc: stable@vger.kernel.org	# 3.5
Reported-by: Ma Ke <make24@iscas.ac.cn>
Link: https://lore.kernel.org/lkml/20251117013428.21840-1-make24@iscas.ac.cn/
Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
Link: https://patch.msgid.link/20251218153519.19453-4-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/ohci-nxp.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/host/ohci-nxp.c
+++ b/drivers/usb/host/ohci-nxp.c
@@ -223,6 +223,7 @@ static int ohci_hcd_nxp_probe(struct pla
 fail_resource:
 	usb_put_hcd(hcd);
 fail_disable:
+	put_device(&isp1301_i2c_client->dev);
 	isp1301_i2c_client = NULL;
 	return ret;
 }
@@ -234,6 +235,7 @@ static void ohci_hcd_nxp_remove(struct p
 	usb_remove_hcd(hcd);
 	ohci_nxp_stop_hc();
 	usb_put_hcd(hcd);
+	put_device(&isp1301_i2c_client->dev);
 	isp1301_i2c_client = NULL;
 }
 



