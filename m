Return-Path: <stable+bounces-26009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DD7870C93
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37BF1C23A92
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2FC651AB;
	Mon,  4 Mar 2024 21:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zTT3k/pC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7850C4CE04;
	Mon,  4 Mar 2024 21:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587607; cv=none; b=cLF5fD3KobEytrdsGovWGT5CVufWsphp8M9D+LoCAYT+pMbFtlFRHUP3++nabbde/Gf7Djs3qSstw88dXyyE9xxZG7IVUZepcaDttWv+gayoPZHBmDxLu3fb31EkYmuRps3a3Iyi35qnFjUhiPpxJVpmP+v1ME7SNGxC/TGrmIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587607; c=relaxed/simple;
	bh=SR/lsGzD1bb08mlD4qY7pGWcCxFF30ep4ClHUcDWRLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNBmGkeToTOhY6/rmovNPeBbrD0Wn3bAP5PBfWuPo2La2pc0JqRFMCrwq+YU6prMzg8xFh478zQ8CF3tpxNErT/iqkOuLNZsKCX6JmMz9hjkZv780ABOGk5Qw2e/C/5x9JjIoW76UwiKPVlY20+008wwHGs/FKijbUn6V6D6yb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zTT3k/pC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E86C433C7;
	Mon,  4 Mar 2024 21:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709587607;
	bh=SR/lsGzD1bb08mlD4qY7pGWcCxFF30ep4ClHUcDWRLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zTT3k/pCwVTnyHvPrVXTvhA/UZfle9UrNz0v14FqoQcRLPwOpgpEHGuc6zLrH2Wwk
	 p6L91svfelsnDKBYeFELAwcvksbAUnMJitUc2zMXgrQphtn3zadUBxG9Yerpf6ODUD
	 CCcABY9Rk2bUQdAUngooxV8DD2AE6oOTckyooADM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Peter Korsgaard <peter@korsgaard.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 021/162] net: usb: dm9601: fix wrong return value in dm9601_mdio_read
Date: Mon,  4 Mar 2024 21:21:26 +0000
Message-ID: <20240304211552.511405967@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211551.833500257@linuxfoundation.org>
References: <20240304211551.833500257@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

[ Upstream commit c68b2c9eba38ec3f60f4894b189090febf4d8d22 ]

The MII code does not check the return value of mdio_read (among
others), and therefore no error code should be sent. A previous fix to
the use of an uninitialized variable propagates negative error codes,
that might lead to wrong operations by the MII library.

An example of such issues is the use of mii_nway_restart by the dm9601
driver. The mii_nway_restart function does not check the value returned
by mdio_read, which in this case might be a negative number which could
contain the exact bit the function checks (BMCR_ANENABLE = 0x1000).

Return zero in case of error, as it is common practice in users of
mdio_read to avoid wrong uses of the return value.

Fixes: 8f8abb863fa5 ("net: usb: dm9601: fix uninitialized variable use in dm9601_mdio_read")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Peter Korsgaard <peter@korsgaard.com>
Link: https://lore.kernel.org/r/20240225-dm9601_ret_err-v1-1-02c1d959ea59@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/dm9601.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/dm9601.c b/drivers/net/usb/dm9601.c
index 99ec1d4a972db..8b6d6a1b3c2ec 100644
--- a/drivers/net/usb/dm9601.c
+++ b/drivers/net/usb/dm9601.c
@@ -232,7 +232,7 @@ static int dm9601_mdio_read(struct net_device *netdev, int phy_id, int loc)
 	err = dm_read_shared_word(dev, 1, loc, &res);
 	if (err < 0) {
 		netdev_err(dev->net, "MDIO read error: %d\n", err);
-		return err;
+		return 0;
 	}
 
 	netdev_dbg(dev->net,
-- 
2.43.0




