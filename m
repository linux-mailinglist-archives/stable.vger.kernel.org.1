Return-Path: <stable+bounces-83533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA1D99B3A2
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2260DB23A15
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F356F1946C2;
	Sat, 12 Oct 2024 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3PlRjri"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98521A01D8;
	Sat, 12 Oct 2024 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732442; cv=none; b=HerB+a3TzawNGKG1tVxr/IAkgWE9RIYF5knpMWK3Je4dvaJ5uZPzm5iAR+206O6qhpz7+NeAWNHBcuaI6lvkEonlA7FEmt4aaeoHWHEtpjU9BPNSuLVwO8EE8ABpPULsn6myKcf7K2RMvCABMs/x4LFgqznOYO5LypSjilmnsWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732442; c=relaxed/simple;
	bh=yyLRPc7BWlh0n3nzjsmQdJGceCFz05ihd1PqC5TEijI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FbTGonnoj3Fxw3IJCJc71QyZafw41JrLgp+Li8qliodx+cGvQuL0E3qqysUwialvIYSyt4w2ru/9TT8gds0bsHJrGYnQQjwSKUHyfDJuBJIv96WwgHo0kLc6GRLUaIW8k0AFp4D62eqMH1aaIBi6IXZ/pa03TZCnuHLXMyJ9fv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3PlRjri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F6DC4CEC7;
	Sat, 12 Oct 2024 11:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732442;
	bh=yyLRPc7BWlh0n3nzjsmQdJGceCFz05ihd1PqC5TEijI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J3PlRjribwI8vpt7Ff7t/ad9Tk8k2D20lMPkCoFs+x7UYhsm9rGk3UZh3Xm3imNYz
	 WK5e6+W/jnwF/nnygoyGq1U4u6lUxNXXvA4sb9rZqxivK7XsKv7J7rpGrrmCggjK+9
	 ndgFnHhrxZyjXYzH/LqyPemE7c/yvfjgetykXLHeDduDMPtiXIQN/nvKIhrczN0XXD
	 syRm08fK6GQhPk5+gF8xm7dujkVwmamjLsm4gu6JjzzA4a40iy27mS6XZdmV9FGZIT
	 hfhFVj3+/VWOf8oS8MBdTKJe1jAMNwVpvnMqJd25RZMuFaW2I/mzadX/+eMlwG9lwN
	 KFl9mvWnnCbNg==
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
Subject: [PATCH AUTOSEL 6.6 03/20] usbnet: ipheth: race between ipheth_close and error handling
Date: Sat, 12 Oct 2024 07:26:35 -0400
Message-ID: <20241012112715.1763241-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112715.1763241-1-sashal@kernel.org>
References: <20241012112715.1763241-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.56
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
index 687d70cfc5563..6eeef10edadad 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -475,8 +475,8 @@ static int ipheth_close(struct net_device *net)
 {
 	struct ipheth_device *dev = netdev_priv(net);
 
-	cancel_delayed_work_sync(&dev->carrier_work);
 	netif_stop_queue(net);
+	cancel_delayed_work_sync(&dev->carrier_work);
 	return 0;
 }
 
-- 
2.43.0


