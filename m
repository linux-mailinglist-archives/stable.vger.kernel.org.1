Return-Path: <stable+bounces-83589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D033A99B470
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836961F26059
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6652071EF;
	Sat, 12 Oct 2024 11:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDoqGzYC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CF3206E87;
	Sat, 12 Oct 2024 11:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732612; cv=none; b=SDNBS6LXYHftt3TRBdGsiPM9zJ2kh2vomqFfeO2JpI9Jxaa89xTQUnF4S2aCTWOLOZmW66Iv60TlCfNWOzTkxjrabsMaSVXIcbjuVFRgTDIIUyYrMAR4MF5fHneEp4HCpig2t0vOtzURvBk79aEKhwQhGGTARB9UipL8CRyMMS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732612; c=relaxed/simple;
	bh=8OBu2cqnDAzLu4KPvPWmve/cJux7/7IAaJOlRV8JjV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PUS8xBmAYT5HlGCpfVHYQyeMJng2DmIXMHC747ioSUT7r5UO7G1ehdYN4HDwm+SPRrYcxGzLZxTs1F8A2ki2Rdm8nFuwBwvXVdlkWMwf59z3crd+MG0JC1tUGm1mnoODvGC5fsPWyx3wwvfZfGdYc5cJHn7fvvDBlas5y9P26jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDoqGzYC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D87C4CEC6;
	Sat, 12 Oct 2024 11:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732612;
	bh=8OBu2cqnDAzLu4KPvPWmve/cJux7/7IAaJOlRV8JjV8=;
	h=From:To:Cc:Subject:Date:From;
	b=qDoqGzYCP9OruEjyYp8xhNcLYumf8boiEGMFPgZLHPp18nlze2crMJbsWOFReDP9c
	 fcXzU/JtU3KIEcihBQ1qu8kseuuCAvFw0ofck3TNVUJuGwRsk+k86IUQqjzOS5/Tk/
	 oonCPj3FoaDk1+mV5nxw4E5sAjtXIyodjX67yyMsr/moIJrdPSvj1aOUCcWax+cXf6
	 RsR4E1zfUQobnuJS0yyN2oVsN/dsq68iznmRg0x1x6IrbdQmEi2YtrfrEC/SFY/Svi
	 Vnk9CMAeY6sl2tGDlrCBmUoSe57HsGh02CpTh7AvVFFo7HrJNpIv8fekIY0JhUQQ6L
	 JF5jQsSz/SscA==
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
Date: Sat, 12 Oct 2024 07:29:58 -0400
Message-ID: <20241012113009.1764620-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.322
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


