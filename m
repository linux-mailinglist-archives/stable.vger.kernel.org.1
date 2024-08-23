Return-Path: <stable+bounces-70025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C2C95CF66
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31862B26D11
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A6B18DF7E;
	Fri, 23 Aug 2024 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNOOhCjC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6BA188924;
	Fri, 23 Aug 2024 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421910; cv=none; b=IsJOkSNmk5u9tIJezvgbh3IUteDwvb3mWETFl79dK6IiEAmGXcgEaJz9UaEMBn1M+7WaGmGokHfJgS5Elh+jNd5s7jyM0HDd3TIgH0Sc3jN8SbAg6gtUS6Uk7HVlbFAJe46JiVNBUu4F/eAvqyFnLBeKNENakg9XaIhGeruDByk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421910; c=relaxed/simple;
	bh=cSVzKJrjPvRVqCnvnA/b3enMcZATt+KB5hXmJy1CwGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A8Jc9O7imxOAqimHmYPqRevcwR2qx11/OgleF60cJLPUR2KQcxnSiA5l2Dry42kf1whxEbRyBgEuylsfnhzSFa1nW1wDuS+2YqvD334KnTUgznRlLKA/XebNGKqouiFEgjb6feiY7djRIEcZYDR5SDe/yU0D++D4OX6uKSwwGzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNOOhCjC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D89C4AF0B;
	Fri, 23 Aug 2024 14:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421910;
	bh=cSVzKJrjPvRVqCnvnA/b3enMcZATt+KB5hXmJy1CwGo=;
	h=From:To:Cc:Subject:Date:From;
	b=KNOOhCjCRJ78xY9G5DJpgzvOaPDOLogqLg0i1oeLTNTCK/GWoP6qmDgtctmbk8/5x
	 r1K1fxFIWREn2cb8xJRyD1mndvUhNBphx7/C2GAJr2oTbWGbpC5GXwzB+yLjffKoLa
	 3d2ymUdRbiimsm+IeVi/NXLhn5YTdn+b79yYEvY8V8zON0WsC7/J3FY4kjkFOYlJqI
	 PhL+yyLgf+H4FeTza0O8brxeBkVcfwZu683tYJAtg14cZDy1K0aTNql4TRQdLO7RDF
	 LLacvyCRdBuOmJVVU1Kdhhw0e0lcdGu8Kk4xa0RdGrWJ4fZ4Ni2dp5fDc59zUAoxro
	 yIXHW968uvGRw==
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
Subject: [PATCH AUTOSEL 5.15 1/9] usbnet: ipheth: race between ipheth_close and error handling
Date: Fri, 23 Aug 2024 10:04:48 -0400
Message-ID: <20240823140507.1975524-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.165
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
index d56e276e4d805..4485388dcff2e 100644
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


