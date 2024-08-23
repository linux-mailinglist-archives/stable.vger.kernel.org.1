Return-Path: <stable+bounces-70043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D0695CF90
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234E31C239BF
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24050191F6B;
	Fri, 23 Aug 2024 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXsqcDmD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAF2188A08;
	Fri, 23 Aug 2024 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421974; cv=none; b=juPbRBnItVO/N64jiYGOI19pv9mTRPkBAOAucjqlGUimtOfkucv4g83bvzKdQGewbAxZcUwa5HGBcAdJad6WQMmqeoQv9CG2L90NqpZPYP87AyLhRWHK7nNVUtL4aX9VBzyRHqXLovDfFM4pC3f8FDAarfgnCSaAUa7CqvUIBkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421974; c=relaxed/simple;
	bh=i6H85g7iWTCKvOl28Kd9R/lEDQAsUzGltT4u0pdJOT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pe1J5Zk3GSuC3SqRLB7+REJu6szwj6YgZC4i0uGwL7bEti1IWMujaRAzlgCHcxMdnIBcbnAPwPAuJSM/RM1uLZyAFGKi8AxqS/OVx2cOi0UF7hBxCo3cchgK9diDAk0aNlmCvA5930JSrElUPLYrorinu+TPA2Ne+UebGKT//4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXsqcDmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBB4C32786;
	Fri, 23 Aug 2024 14:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421974;
	bh=i6H85g7iWTCKvOl28Kd9R/lEDQAsUzGltT4u0pdJOT8=;
	h=From:To:Cc:Subject:Date:From;
	b=nXsqcDmDowOO8eY+NYxukQdCfYP5iQsGUNXZs5g/BGCJTUI1Xx89SVO5uipaPcQht
	 f77vKUX/KdkXVcM38lO49iLDLiYYjCK/43TNNoqasDtSDxmCVxOuQ7N+jnVjweihJT
	 A81vAXD6AedsAdI+BFZqdBl8r0Cyip5UY1MKMDDBZ6FhGGddiEwO1KVsXbnvKVxihg
	 9qinMupRTQPU7fKAtaDnQaOmWJiHYt0gE53KJNvmpC2cftl7+5/fxP6WgpO171p3Ns
	 JMyoJc+GKKXTrBLIS5wh2nK0XiBI5yEoiC/q2NvomfPRPXhatRzJMTTp+ayQdJuM8B
	 gRgGSFUL4ggRg==
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
Subject: [PATCH AUTOSEL 5.4 1/7] usbnet: ipheth: race between ipheth_close and error handling
Date: Fri, 23 Aug 2024 10:05:56 -0400
Message-ID: <20240823140611.1975950-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.282
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
index 73ad78f47763c..7814856636907 100644
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


