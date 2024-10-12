Return-Path: <stable+bounces-83553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A8C99B3E1
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFC11B240A2
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D1D1CF2A2;
	Sat, 12 Oct 2024 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9EeDiLo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615A41CEADB;
	Sat, 12 Oct 2024 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732506; cv=none; b=gBYsHxdMq6cwv2VabQXHt/OlWRD6EPBP03SxcJhh1GgeLtKsJAJLrsEypP8d3Rji5RM3WeSgoLZDg0rZ9YdDjC9+jbLWQvbCzUg/AIcqRibLJRz9TlQAfkgpPT8RIPsDR2qWjYIEQho2sIx5/x4iYZ/EeTIb6riKwk5Aye23DjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732506; c=relaxed/simple;
	bh=B01UTgvIToN2TIawqIAKwTVipLzfV4bmoRHB/+7kaHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jYNCAoG2ZJvuXZejNT2HBd4X/iXzoSDv9oOBVf4igRSb0DOqA/JWCig3VoZKQFlCNimfBxM/VZOVzvx57p6kVALN8SGe92KsYlUo3AzjbTAHRhNZb0VhqHwnVKymds8xc+XrxB2h1sYMjxEY0w5pMBMgxY/6w3RlEXq6R2U/CfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9EeDiLo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83D1C4CECE;
	Sat, 12 Oct 2024 11:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732506;
	bh=B01UTgvIToN2TIawqIAKwTVipLzfV4bmoRHB/+7kaHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X9EeDiLoAsKiDXTzUSxI+Su27pHKcReTCAIGj3mdl/voyQuMt+9vjB72ZT4Eq9JJl
	 iB2N/izDrFV8h5bKDEKn9CGcBX/lb9bHy5jm1MrRA3ielpa+4PPyFR4YmOJ/3FYUqf
	 E89rBg6SstXlEqVt7AeO9vt8KrJS1ynQp/ylVLIcuo7NqFRiUQ5H68B6YjW/tIi2Ez
	 j0IkEi+QjB0PBwxLLY75DS1wt36K6O21odItGSdwZ1lUqBUkdVdd5UmAc/JRkClqxa
	 jOYxlslX49MVSMcOZYVyVQLE0qr0ZDGNRY660fsV8bavCDcLNBvEpTZYR2eVpWuTb+
	 dGWWNVPn041AA==
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
Subject: [PATCH AUTOSEL 6.1 03/13] usbnet: ipheth: race between ipheth_close and error handling
Date: Sat, 12 Oct 2024 07:27:52 -0400
Message-ID: <20241012112818.1763719-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112818.1763719-1-sashal@kernel.org>
References: <20241012112818.1763719-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
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
index 6a769df0b4213..13381d87eeb09 100644
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


