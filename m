Return-Path: <stable+bounces-167404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 480C7B23003
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98CC6188EA4C
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A412C15B5;
	Tue, 12 Aug 2025 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kQWth5Aa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9361B2FE570;
	Tue, 12 Aug 2025 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020705; cv=none; b=VWiUjugSdpkX6MDeAOrDkF0XzWcg9wwTxIqvAoLx9Eo7a0Db1AMWFst1z7mT89XLeizYcXmbTV9A/oHXHKB0HnaXHud7OMV8TRyUBB3oM9DN0zp5H47aMaxfQUIgGqC1V45OzW8VwNWIuW72Sf0QK7z9cE58Uhivp0OoSfRCUZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020705; c=relaxed/simple;
	bh=tPuZRYbWdmS59Ozv6fmsi4eBn0+E34fcy6DG3Hl5tpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LwZRtb3UkjABgbUWx9RcM5CWBVO+f1MXWGJooOgCNcVvwhWW3fkSs4YJiAgMCnEFhn6T1BmxGCuoCUhHTAmxTJh5vSkfaFilsByvRoHYs+X6mPfcof38gXWFUD4EI3W52FNHplMhRk0PlbsqYSExgp1iDdk4AG2+TRHQ2Q4F+dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kQWth5Aa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C8AC4CEF1;
	Tue, 12 Aug 2025 17:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755020705;
	bh=tPuZRYbWdmS59Ozv6fmsi4eBn0+E34fcy6DG3Hl5tpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kQWth5AaIu+4SVWXHd8M+srkJ4JO5qZ5H+v4ogRVQGDRTPBvo9hcLMxnyC9Q842/y
	 cwczlg3Wv2uXZNbrGGbnjXGdcF3P7l6OCtObp7NiZL0wrKe4ebfLuHBuDgjN84c+Gk
	 ym7hZQ4XNCsvs49qYd1GowEDjJZpYZq3DwbMGphU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 131/253] can: kvaser_usb: Assign netdev.dev_port based on device channel index
Date: Tue, 12 Aug 2025 19:28:39 +0200
Message-ID: <20250812172954.272982946@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172948.675299901@linuxfoundation.org>
References: <20250812172948.675299901@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jimmy Assarsson <extja@kvaser.com>

[ Upstream commit c151b06a087a61c7a1790b75ee2f1d6edb6a8a45 ]

Assign netdev.dev_port based on the device channel index, to indicate the
port number of the network device.
While this driver already uses netdev.dev_id for that purpose, dev_port is
more appropriate. However, retain dev_id to avoid potential regressions.

Fixes: 3e66d0138c05 ("can: populate netdev::dev_id for udev discrimination")
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://patch.msgid.link/20250725123452.41-4-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 65dd57247c62..57e5cb3c39c5 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -858,6 +858,7 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 	}
 	SET_NETDEV_DEV(netdev, &dev->intf->dev);
 	netdev->dev_id = channel;
+	netdev->dev_port = channel;
 
 	dev->nets[channel] = priv;
 
-- 
2.39.5




