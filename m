Return-Path: <stable+bounces-83573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D30CF99B41A
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B8C3B2304C
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075AB19F41B;
	Sat, 12 Oct 2024 11:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mwqoe44C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C56155726;
	Sat, 12 Oct 2024 11:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732565; cv=none; b=Xe/fpaPeiTh7szOL16ykHDPln43boAsVZAFQcVeBMFXY1i4utKcJUo3iIiOZRF0PycXIwa+qQYXCzo6iGrBgWqjuuhh1r+0B/KP+UKXSxVNFPCrEROkLfMhlK6FMLoGSspnFioCArdANJS9S+m1CfTmPSwQykKKve3s0QKUl3qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732565; c=relaxed/simple;
	bh=LZ6MiG4YRlQZkMjpzaXtBjLp8oaosKcR3U5nFR+187w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cf/VOqV2DE8VKq7wqv1rDsIFNbC7nFb7x18HvedLT7xyqwumdR07VClDxkWeh9y7487CiYmgSGYSb8utbp5yBZh8SYDsgsqTSlCSYE+fQkLefzjFO661RPSKM96asDUq5hNDrgBdspay4AbIc7mfWllXnmnuCFJFOMmbBq26EsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mwqoe44C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA03C4CEC6;
	Sat, 12 Oct 2024 11:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732565;
	bh=LZ6MiG4YRlQZkMjpzaXtBjLp8oaosKcR3U5nFR+187w=;
	h=From:To:Cc:Subject:Date:From;
	b=Mwqoe44CkjpkxI56flBq5HUNySDrZs/C6Izz//mwPLx07MM7Qch48FVc7Uxm90BAi
	 a2XEraG21TvMskYYposgQmcglGUkCFloi9Lq2rNVEpmx5rZ+O09AnFUOuCQib6/y0f
	 dv74Hkmv3jhn+8ld+VN/eAhTZYxWvo0aRfD9ZFyZR5sx93xuYWn6VeoZJh7NGB7MIX
	 ChipbqMjGSpU7ja5L/kpikdX6j+mT/kmktiib6Z3CtM0C3k49sRGzyR78dl68lNthn
	 u4v6LeNnAV0M3NBUCyAm4tQQVyxiSNSXHsof2vKFNTuvgv1JINVcq/NyAXIS6Beuad
	 ULRkRT8mmdK0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>,
	Foster Snowhill <forst@pen.gy>,
	Georgi Valkov <gvalkov@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 1/9] usbnet: ipheth: race between ipheth_close and error handling
Date: Sat, 12 Oct 2024 07:29:06 -0400
Message-ID: <20241012112922.1764240-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.226
Content-Transfer-Encoding: 8bit

From: Oliver Neukum <oneukum@suse.com>

[ Upstream commit e5876b088ba03a62124266fa20d00e65533c7269 ]

ipheth_sndbulk_callback() can submit carrier_work
as a part of its error handling. That means that
the driver must make sure that the work is cancelled
after it has made sure that no more URB can terminate
with an error condition.

Hence the order of actions in ipheth_close() needs
to be inverted.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Foster Snowhill <forst@pen.gy>
Tested-by: Georgi Valkov <gvalkov@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/ipheth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 06d9f19ca142a..0774d753dd316 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -353,8 +353,8 @@ static int ipheth_close(struct net_device *net)
 {
 	struct ipheth_device *dev = netdev_priv(net);
 
-	cancel_delayed_work_sync(&dev->carrier_work);
 	netif_stop_queue(net);
+	cancel_delayed_work_sync(&dev->carrier_work);
 	return 0;
 }
 
-- 
2.43.0


