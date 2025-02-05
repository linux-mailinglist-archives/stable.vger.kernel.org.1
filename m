Return-Path: <stable+bounces-113229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 590E5A2908E
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 078DC3A7ECE
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3794E156C76;
	Wed,  5 Feb 2025 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rUZKaWzf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E862C155CBD;
	Wed,  5 Feb 2025 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738766255; cv=none; b=VJuY6cxSbO+tXpI/W707v9B8RSDczBCoZbMQAqfLFp8uR5vEdTfEVCLgr8vgMa1zilvp153LguyBCcWFHBiJ6rZ6PyNw2stB1rqVgiKQQpDQUEhvE7AgEuQJ4qsgGM6TlH3K/BSxSQ7m93i6XTCM9Mr2XHX9t35TLmEAbjiV8qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738766255; c=relaxed/simple;
	bh=G52zXO+kJpJ3/EO4Op1swP2J4qjyWYCyzpPeepokYN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LwItmM7KcLr0ZxvO+4eRRzWWapBu2ZrNjmQFBOve1mWxX1t1/2rmpJlnhCPtaZlRCT7CVXEhjEQ+HzoeeiHxIz+9WaxYUeznPsIfhAP0s3i+zhZdq8hUgiRBGSzwHwgwXGf50uKKWqZmlGMhcqlciXdI7VjxVvF+O0DlcASKNAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rUZKaWzf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B9BC4CED1;
	Wed,  5 Feb 2025 14:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738766254;
	bh=G52zXO+kJpJ3/EO4Op1swP2J4qjyWYCyzpPeepokYN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rUZKaWzfAvjdZkbP+WMdGEtXqdagIS46os27gi7QesD6GJfgCHx9WPvm6eMBfyjQh
	 pDl5DzhhcMpAW23PJ+x4sOd6EU5dqMPgsYN/+B4BUrm/tWAAxCesKvvNYar1WtnTg4
	 VL5nQAyryeEi32umbZmcDEXJt63YE7ckATmwf/LM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 346/393] net: sh_eth: Fix missing rtnl lock in suspend/resume path
Date: Wed,  5 Feb 2025 14:44:25 +0100
Message-ID: <20250205134433.548811065@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
References: <20250205134420.279368572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kory Maincent <kory.maincent@bootlin.com>

[ Upstream commit b95102215a8d0987789715ce11c0d4ec031cbfbe ]

Fix the suspend/resume path by ensuring the rtnl lock is held where
required. Calls to sh_eth_close, sh_eth_open and wol operations must be
performed under the rtnl lock to prevent conflicts with ongoing ndo
operations.

Fixes: b71af04676e9 ("sh_eth: add more PM methods")
Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/sh_eth.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index 274ea16c0a1f7..0c0fd68ded423 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -3496,10 +3496,12 @@ static int sh_eth_suspend(struct device *dev)
 
 	netif_device_detach(ndev);
 
+	rtnl_lock();
 	if (mdp->wol_enabled)
 		ret = sh_eth_wol_setup(ndev);
 	else
 		ret = sh_eth_close(ndev);
+	rtnl_unlock();
 
 	return ret;
 }
@@ -3513,10 +3515,12 @@ static int sh_eth_resume(struct device *dev)
 	if (!netif_running(ndev))
 		return 0;
 
+	rtnl_lock();
 	if (mdp->wol_enabled)
 		ret = sh_eth_wol_restore(ndev);
 	else
 		ret = sh_eth_open(ndev);
+	rtnl_unlock();
 
 	if (ret < 0)
 		return ret;
-- 
2.39.5




