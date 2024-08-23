Return-Path: <stable+bounces-70034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0B995CF77
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E631C21126
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B332190045;
	Fri, 23 Aug 2024 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L22WcKiu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027DE18892C;
	Fri, 23 Aug 2024 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421944; cv=none; b=it03pT1gEnxjh2vQ0BoG/WCEWDXutxMDKtO+DqsHohqz2EuXwnyG432Mg2NrM4Unaj5uEOpGSl7EyP5YR9eodBkCJThyIcRyhx21Ri8F3Hb6Sjn5lNTVhkQN230zDObhqG89DcXaLXNKb3zmbKPBAVBPSXhNzgrxGPgPftDL99E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421944; c=relaxed/simple;
	bh=LZ6MiG4YRlQZkMjpzaXtBjLp8oaosKcR3U5nFR+187w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d0VQ96kMeTLDzEol9FNCP7pxCFu+/L/gfpNycchKtQiRuISencH6wXzktE+8GYGcaDytWsexz85TOEzM+EsiqRaXCyKACY+qO20N9IAxfDArWP/RAk91KwEmt1flrTsdfrj9YDmuYFkwZklSJLEW42i9Crymu41l3xNasc0SYMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L22WcKiu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C121C32786;
	Fri, 23 Aug 2024 14:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421943;
	bh=LZ6MiG4YRlQZkMjpzaXtBjLp8oaosKcR3U5nFR+187w=;
	h=From:To:Cc:Subject:Date:From;
	b=L22WcKiu10qAndF7o3dFaaVrkLBj4KLMk8gCR91d2rhUR5R1MxdSQFvT6ueZKIiIA
	 mMGDlGSNu52I1HuSMAr9ixpGvlLdYlzH+3KRHJdTQMN8pmxyQCWO8StDSeZvxMDord
	 Za4EPei89Ian4nZb1qGAKulNnYUeeyTffz9nKfkfiIBrC60v4rhoMwbKvDSJEI/+UM
	 6cv5FIPVmY+tZedG3qGg+2inowjxSYFc1Y3t/Oxup8ZDkGzWxrPACCqQb9YfyGoHsO
	 +BIhFIkpDggdF6XiicTV4UEs5FnqtiGRzDHudHFxhYD6sL5TFiJmgNbZQVZzQg3DFR
	 /IqNbvDV6a+8Q==
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
Date: Fri, 23 Aug 2024 10:05:21 -0400
Message-ID: <20240823140541.1975737-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.224
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


