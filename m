Return-Path: <stable+bounces-70050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE73D95CFAC
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A214E1F27763
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5301192586;
	Fri, 23 Aug 2024 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMmxyKGW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A45E188A0E;
	Fri, 23 Aug 2024 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421999; cv=none; b=AATQxHfw4H8DMHbc2a/z7O9WWd1S8jDm6/DC3M11aqEHt7gmrD5YSXhGoCBRc2keGJLAuFSKMcIhtySYXxwjitlZbL6wIHFzjFemUD4K5m74mvPiXS8wqqy5gUx7XepZ+6mo8TY3UABh/6NKJtj/AzXqcHXq6tbxHX4fr7L1Mxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421999; c=relaxed/simple;
	bh=8OBu2cqnDAzLu4KPvPWmve/cJux7/7IAaJOlRV8JjV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M2SvLc7taWxe5SaN8WtVWsQhhmux0ZnzXun3oiHtbx/ShY7bJ6C3qZyv0fBGlobp29QNDjgLhb3yUDL3Ip96QhbaTDkBPPo5sTN3Emuel4Ou4HrhH1dnRQmpHUGBNWu1N0h8GueoIZxltTa91Sj24wwwIBw6xUXX80i5YFgOteo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMmxyKGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF200C32786;
	Fri, 23 Aug 2024 14:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421999;
	bh=8OBu2cqnDAzLu4KPvPWmve/cJux7/7IAaJOlRV8JjV8=;
	h=From:To:Cc:Subject:Date:From;
	b=MMmxyKGWBiXblkPAihC6vbdUEXNZJCdad57uhNHk6qJ483CV8tNcrymiPTB9TgTSB
	 3bkTBpELhHWWOfgkMadrDXZuIDYVL4TTyJWRjRKfdEjSCi2ASkNO6uSW36p1/nYVR3
	 WC0IioC08NntCGaJfRHm2zZNBQ7WtR6BHpH4Bcnk5p8lbdK8brZl+12mBzpnL5P9lc
	 ezk9IcxhYHekZldBeakNHbcHAi58GFvLlAh1i0gs70kl9nbdGZBwY9KviLRAeWbyZ1
	 absgNDy5y6osg9DeFzxCu47Mo61Yj/GORG0zg6+hhZjOHBN5P96njxBCHW56cwOt5H
	 v5TPz2mqJIJEA==
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
Subject: [PATCH AUTOSEL 4.19 1/6] usbnet: ipheth: race between ipheth_close and error handling
Date: Fri, 23 Aug 2024 10:06:22 -0400
Message-ID: <20240823140636.1976114-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.320
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
index cea005cc7b2ab..c762335587a43 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -407,8 +407,8 @@ static int ipheth_close(struct net_device *net)
 {
 	struct ipheth_device *dev = netdev_priv(net);
 
-	cancel_delayed_work_sync(&dev->carrier_work);
 	netif_stop_queue(net);
+	cancel_delayed_work_sync(&dev->carrier_work);
 	return 0;
 }
 
-- 
2.43.0


