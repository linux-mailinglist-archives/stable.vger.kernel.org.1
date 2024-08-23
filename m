Return-Path: <stable+bounces-69971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE51395CE9D
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57874B265EC
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61621188A02;
	Fri, 23 Aug 2024 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCS6wPLF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1549C17E01F;
	Fri, 23 Aug 2024 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421698; cv=none; b=DAJaOKwBBuYAV3nBlD/8k7kn8Pzx601y9nE7gQySOmo6T3uJP6vOrhRFOxgC6635Vsi4X+0LmH4Y1geWTUJEgQ/vAurbuidCAFEkgeCQkK/C4y/P15zMeXJWIpwDGmBWT0vRskkMtiFLGxTU/CX8WMODFYBUGd/8x4Z3qzPUwIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421698; c=relaxed/simple;
	bh=yyLRPc7BWlh0n3nzjsmQdJGceCFz05ihd1PqC5TEijI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVioUxia7a3W4udJ3mqlhbKbcETpDBU3p+8z2OQraEDsAT/D1dEE6zonpq7JHtB4ok7NaUOEDSJ2t0fnVgL8liugqthyd+mxjLwzPPORTQnW2dscxcNhjt3t8XZ6GT94eEpjmVnZ4oOhCFgCnPxtfex/3Q7zQ2EiBmCzTczEjSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCS6wPLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEAFC32786;
	Fri, 23 Aug 2024 14:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421697;
	bh=yyLRPc7BWlh0n3nzjsmQdJGceCFz05ihd1PqC5TEijI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DCS6wPLFSuerifA8IL4WydUW8GV0ZNRh2zRpqkQKrelFTrrNN7/7AE5B3zrOxPecD
	 Nme+BMKFh38O4DGqxL54dBtWMBhPBfJfMn5ZZXEnM4LH6g5u3l2d9KCHXIrLyzm7Yn
	 UAwdBIy7V8W8tTX6Jp9EaqkDR08t8SwJ36aSNT0IkS1CZs6npNSPiZ3JEuYl3fCnmC
	 bJ7cmZWvMwdYtQCPEgxjGT42GdoRxONGLPGX4XZ3g8f7hZiJmIcSCgYs2T6BVC9+xC
	 fOcMH1ZK9xe+/7hlxWe4INB75FZuVKduPStlRJfZPJcvXV2p3fnJaVTsyk7AEGb2UB
	 +9D9FjQylmZFQ==
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
Subject: [PATCH AUTOSEL 6.10 04/24] usbnet: ipheth: race between ipheth_close and error handling
Date: Fri, 23 Aug 2024 10:00:26 -0400
Message-ID: <20240823140121.1974012-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140121.1974012-1-sashal@kernel.org>
References: <20240823140121.1974012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.6
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


