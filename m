Return-Path: <stable+bounces-70014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5439995CF5A
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C18EB2B0E8
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD6B19D074;
	Fri, 23 Aug 2024 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swriNiFn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B5D19D062;
	Fri, 23 Aug 2024 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421873; cv=none; b=dUCvFg3rwhr+WoLV+12dEhohokMjGVTX2nc61EN0DSYpwGRVl78DHqUcxP4B73cdpSz/Cwov2hhjZvGdwL2PbhZoQLpXtREneez6trZhw+q3Vfjkjb9KXI5Z67qq9Bh7FGNMXGH1Tx5HtPpImMMbDBFsD8zAVIeFHgCzzhLEh0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421873; c=relaxed/simple;
	bh=B01UTgvIToN2TIawqIAKwTVipLzfV4bmoRHB/+7kaHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s113/Q2cvDvL7DtUuEIOvarCWaeGyTvgc7tbUBCEDItKPiy6jaGum2zUNDzAm1e2B5T8GILQVITFO0AxOAmfOZviGUC9c1QjsB3eZQtd8SWdSlOiU4G8LwsUAjpKUJghKsoxJL9cUobMgIE1iSvWunmK54vOU9Gt1f9pAYAclFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swriNiFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D98C4AF0B;
	Fri, 23 Aug 2024 14:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421873;
	bh=B01UTgvIToN2TIawqIAKwTVipLzfV4bmoRHB/+7kaHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=swriNiFnqyXpWBWI3Li3Fc/a4TPPZWdiABc0QSHPvUppZnb/QZ32RwJ+6I/YOZWNn
	 F8zqKcz6TZunmXUl69QygTwABiNrdvbOvB1GqS5aHa1a5LO2CGalWEU59iaIs9fCVP
	 mDtQfDP2eHeqHy26qOmX0Pu0F88eOTu1PZmMshGTbdRgchPzGGX1mpZ2S1jcdkP2RM
	 0mgAiAUVAgpAN4KshPnSMYUhK2aMCcil7QPUYJYfi0r3VBim0doMyE9CZ58ncZCkB8
	 JwLnCB8UIC7hn1q1+Uzz9tfmdccVT2cJnF8leedJKfmbGOYyMMgnEYjj17TxhW3tBm
	 eT1WNNXvM4DHA==
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
Date: Fri, 23 Aug 2024 10:03:52 -0400
Message-ID: <20240823140425.1975208-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140425.1975208-1-sashal@kernel.org>
References: <20240823140425.1975208-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.106
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


