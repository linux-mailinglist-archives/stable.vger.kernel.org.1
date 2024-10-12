Return-Path: <stable+bounces-83536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD63199B3AF
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C496B2397F
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AB91A727D;
	Sat, 12 Oct 2024 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjtlN7xz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7C71A7266;
	Sat, 12 Oct 2024 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732451; cv=none; b=uOhJdSSdx+ZHMXmL7aX7hEuFTRrm/qSqxfcx7NMCrPatxHwRlgjkpKJ8m9UlXhvGJ2/E8959931hEvxFizIsxeN0vdle3shbLp1L1/Nug4aVI6rKDKpAbQ3dtpeKL95cUd18rJcDraTy4PMEoEIDXryikE0fYceIoIL2m0juDwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732451; c=relaxed/simple;
	bh=qJ762Uw+ii78oNsS5nEKNHQZVHwTP0SI+68hPCD2y+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7iXLsQNSqQupnJv0y20htlAfIr0uq4iwTWAxI3pw7kCVtzhXjNZNM+LW06XhU8+xQNc2Z98m7rshHmKtnvwTD6Y/RGeX7880Bvy0pTH1e5qmTMGGyzLx3T+oUwuuED1nwQmypHS5fF3+ex5dPs+ZZ5uTObZZszb3oLFAc0Lr+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjtlN7xz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E0AC4CEC6;
	Sat, 12 Oct 2024 11:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732451;
	bh=qJ762Uw+ii78oNsS5nEKNHQZVHwTP0SI+68hPCD2y+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qjtlN7xztd+ZoymSrFaAp2Ao3cyHz2ZSW7jdJJn+M8cL8wYfUw1RkxZnftMsMkmPN
	 rRucREIMRPNEt+QuWIROvC5yTbS40XHW6RnuaXvqNZ5VcC8bEEcJmHrD4GD15WBpy2
	 +1l0A9RpyZCADf+Kh+KB9UfmJKRSK3VGuae4SAqgQLB2mHQtaTKYjYRJRwtynRoYRF
	 kywqynDXaJmP7kTQzx5j4wDBj/ts+m8l4FIGhzkm5R3U9m0WwWdGSjuQNTLpwOzTcO
	 z3v4iCD70RRRjwWXz/n/Vg7dIIKYHKTWzhPLMNfVnxOT+AzBqeFThDw82S9MTa+EfS
	 rseIzAwetc75w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Foster Snowhill <forst@pen.gy>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	oneukum@suse.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 06/20] usbnet: ipheth: do not stop RX on failing RX callback
Date: Sat, 12 Oct 2024 07:26:38 -0400
Message-ID: <20241012112715.1763241-6-sashal@kernel.org>
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

From: Foster Snowhill <forst@pen.gy>

[ Upstream commit 74efed51e0a4d62f998f806c307778b47fc73395 ]

RX callbacks can fail for multiple reasons:

* Payload too short
* Payload formatted incorrecly (e.g. bad NCM framing)
* Lack of memory

None of these should cause the driver to seize up.

Make such failures non-critical and continue processing further
incoming URBs.

Signed-off-by: Foster Snowhill <forst@pen.gy>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/ipheth.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index f04c7bf796654..cdc72559790a6 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -308,7 +308,6 @@ static void ipheth_rcvbulk_callback(struct urb *urb)
 	if (retval != 0) {
 		dev_err(&dev->intf->dev, "%s: callback retval: %d\n",
 			__func__, retval);
-		return;
 	}
 
 rx_submit:
-- 
2.43.0


