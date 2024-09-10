Return-Path: <stable+bounces-74750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F71A973143
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268E11F27310
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A400188A0C;
	Tue, 10 Sep 2024 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VBdig1BI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD83C18B462;
	Tue, 10 Sep 2024 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962719; cv=none; b=g/+UZRiWZhmWYiIPyBx+g96GVG962mtchb5PEKpCMP0SqZ2JdjOit7UaFskL96Ky+IKm7FgfrbVfwraNec+CTKNXgNYP3ED59kbUKfIPSXq1tesU3CTjjmaoNzHbOMY+fwpl17UhQ56Nxlr+74n9TjnWZWCcGtMgS5CZnfBExPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962719; c=relaxed/simple;
	bh=+CWA4KU+KSgJJ0TuzqQ27Noi2YEYFXffIDmHzdZnncw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mb+roBAcFM97kAOxb4OzvWW4GGMPeWJLXlvmizsoXPhqnhl1PFCMmzO3dqayAnaTPcdfTZbnZJzLqUvQC4/c+Gl1D/l1dpOyZcBpZmDXvzzS6wQEmCZdIvM3z9ojGczbtFMF1A79uMwzo8onTB9I9FQ7MvdFMZThPR+SVObiZcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VBdig1BI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25088C4CEC3;
	Tue, 10 Sep 2024 10:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725962719;
	bh=+CWA4KU+KSgJJ0TuzqQ27Noi2YEYFXffIDmHzdZnncw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VBdig1BIDo2P8RhWrXFb2aKoJzw5roi+OgDUWRjKT9vPh712oDlEXfbUQqJC185hR
	 JqPQ4aMEzFTYWAiCQK3mWtwlNd2YTCxur/Y9Rz5Pd86HG86NXYDfsZ5DKDsI3EKLne
	 RwDtPecb8XIBqvSWKZTCzHDcwxpG/C5HFg1CuA+E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hulk Robot <hulkci@huawei.com>,
	Zhang Changzhong <zhangchangzhong@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.4 121/121] cx82310_eth: fix error return code in cx82310_bind()
Date: Tue, 10 Sep 2024 11:33:16 +0200
Message-ID: <20240910092551.528054575@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092545.737864202@linuxfoundation.org>
References: <20240910092545.737864202@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Changzhong <zhangchangzhong@huawei.com>

commit cfbaa8b33e022aca62a3f2815ffbc02874d4cb8b upstream.

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: ca139d76b0d9 ("cx82310_eth: re-enable ethernet mode after router reboot")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
Link: https://lore.kernel.org/r/1605247627-15385-1-git-send-email-zhangchangzhong@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/cx82310_eth.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/usb/cx82310_eth.c
+++ b/drivers/net/usb/cx82310_eth.c
@@ -201,7 +201,8 @@ static int cx82310_bind(struct usbnet *d
 	}
 
 	/* enable ethernet mode (?) */
-	if (cx82310_enable_ethernet(dev))
+	ret = cx82310_enable_ethernet(dev);
+	if (ret)
 		goto err;
 
 	/* get the MAC address */



