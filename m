Return-Path: <stable+bounces-83582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 594D299B448
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04AA41F233FF
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3699D201242;
	Sat, 12 Oct 2024 11:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPQab3xa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15A520110A;
	Sat, 12 Oct 2024 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732592; cv=none; b=GPHQzXVndxVbxgZfmsueJyiesanLnpB/8i6xYm21yiJFLlVhiM9qS76ilr96P5Dt2tYpcdXoc0ROh0b2XVN+KpeRIN+TTA6brkzqpuuv9+bmQGFGHqFlSj7tYAxPaYN81LoJR+JQ+O0+nQTZoVMG3sIoC1ruyTMo8Mzs/V6SXZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732592; c=relaxed/simple;
	bh=i6H85g7iWTCKvOl28Kd9R/lEDQAsUzGltT4u0pdJOT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MQoBOESIR6WL9alJ/0vt5Qwh8pDNrilfCw8K1oeEcM+A5Y2m1rU5dD8gfxm9SjtI0+ypp9YGEK5OqI+W0QyyWms7VQzXa5McjI7LTJQ3VgkdLbn70I5n9dUZCjAfvkdtl6ZDA4kJC6nYtAjq0qu3BsQ8rnDpUxjRNKRD9ssEizo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPQab3xa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A739C4CECF;
	Sat, 12 Oct 2024 11:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732591;
	bh=i6H85g7iWTCKvOl28Kd9R/lEDQAsUzGltT4u0pdJOT8=;
	h=From:To:Cc:Subject:Date:From;
	b=RPQab3xaJwhyKdwCSkbr7PIE98e2OXHqE2BCLUUT8MJB/EAn8RU82nE3I8r5/33dn
	 59pPze3uBG91LZCN9rWiAZa/L8huzYztsLyiSJCEqpaxvalZbNbhfKYnK3YypmQAOF
	 FUzdnw8tWpbaY2cpLsz2DkWg1aJduTl4J3lIexKbT0gFvKgTqBBZafTEkD1I4dswFK
	 6xHPF7VtdGEIlVIUCIk1wLoyffIDVwrBVI1dI5iIqvPXXBWsLfy6YrLRi1oXzebppY
	 i32YY8FfulTLjXnx63nGtrmktdWnBP0VPID5oDZ2LALRaSm7YBUjWRBdclpWcJRAOd
	 4arlFJrixoIRg==
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
Date: Sat, 12 Oct 2024 07:29:36 -0400
Message-ID: <20241012112948.1764454-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.284
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


