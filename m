Return-Path: <stable+bounces-83564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8979599B400
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98D61C2143C
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535A519E804;
	Sat, 12 Oct 2024 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrFIYKis"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A230199249;
	Sat, 12 Oct 2024 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732538; cv=none; b=Dj21E9FGkunLlSba4MHwqhPGP19yXtqU0XBtpRwQQYlF+MR11q61XyTjDpOnpn+X7n2lweCXKmGUn+uCNiWP08effK4QaD7BdizeYI5bv8rZDXnsuzFDithSo+jZoOz/1Z2Mc0hrh9wjUe5jbTuzXMt/eBNwWQHhj65w78Jb2hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732538; c=relaxed/simple;
	bh=cSVzKJrjPvRVqCnvnA/b3enMcZATt+KB5hXmJy1CwGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aSCfZoQ3kQiz/JdX3Md3e2ToefJsgpLf0sowtbIs+meNVgoEJqKpzgNEnrM2vfjo7pCNRwaciX7hAJHjMG9I3favgDtVVwRa2IfFsJZa1J96WsxpaiUpZMYuDsN+rNPDcu4aRRHXRETNo+KRq+lWRRGybHwPdwJTaEiIMp031go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrFIYKis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3E6C4CEC6;
	Sat, 12 Oct 2024 11:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732537;
	bh=cSVzKJrjPvRVqCnvnA/b3enMcZATt+KB5hXmJy1CwGo=;
	h=From:To:Cc:Subject:Date:From;
	b=SrFIYKisnbMTCD9XGIPhCPc39gxTeKR7CfbUwZD5DF0iBP6qxhR3jG2w5DOALMr2v
	 m5gGpHhecfz3dyOTDEN05yKg9fE023S3dpZUJIoOHj2/wTne4JDv7gaVSXYQ7unP4X
	 YD5UtJKKIpJICbDGxPr4iqZXcGaFKuvDosTT91WJGTv+BoGxYtdlCC3tdfvx5od0Ue
	 H0cshm5NsbevwbXmH01juvl31HPUy93PT6ybFOz1z8qT2Hnisna5j1FhI/AaWFY4oZ
	 TvMyayfzrpX6VFaFSVqiV19lQM4WR9Q2d+PS6r0jPeQ90ri8VwCvmniiWHn5M9ZR52
	 s98cw4fkdBpGw==
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
Date: Sat, 12 Oct 2024 07:28:39 -0400
Message-ID: <20241012112855.1764028-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.167
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


