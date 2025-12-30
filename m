Return-Path: <stable+bounces-204213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B99EBCE9C97
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 14:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1214300E7EE
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 13:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682C522FE0E;
	Tue, 30 Dec 2025 13:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0LnCRsK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268921DD525
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 13:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767101198; cv=none; b=mJ1agF9Jdu0vUbR6J65wUwFx79OcQ3ckqaGjuId/LWZD1EfR2jYnzTP1MYsJ55Z7eBus/NsfeorgxG/slK5HMbLfbujlWmech93uVrNWOY/y79v+PI6cgWP0lRD+ePQHnuudOeiz7dWWoay88eUlKaceYOPkDPQn5ydfLz7HSUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767101198; c=relaxed/simple;
	bh=7KQzBGUq1qhwBc4J8CLzRIJUwUKLa/NRWPm1JL+KssM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izy+d4MKQHNu9G36Ry5oljaDLdIYhtQVyb93sScDmp8ClEiwnlIqb/gQ7HcFG+7P84MDvyLwbNK/YWqpiQWxDXi4HMK5M52nyJHn48xuiSHwhm+UcELfyProKK9CFAEWTA2wpkL8XX5EeaPHqxS+br8y10HFIrh1Uxu8zuGtyJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0LnCRsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF42C116D0;
	Tue, 30 Dec 2025 13:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767101197;
	bh=7KQzBGUq1qhwBc4J8CLzRIJUwUKLa/NRWPm1JL+KssM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f0LnCRsKavVGnobjIvW9FYQYGvmTUxD8Y6X/scpXrMsZPhmI3NIPHYe5z0R6Edshw
	 +ssauRNMWOJ+O4fe7K6jIBxdgjRWrgchHxiO91c+BctL8BLcIMYoEFOn+NPYmiYzcq
	 pvauuIZR0GdCGvreGjwIn2QYLIMTMrVC+vYnANau/nO6XaLWydNzefi/vDMie7LqWx
	 PG9hYBl3PdzyvfRxZplFsu7Q4h8NMBBKhSaOumN1eSPs/64iQd+SGDZyUdlCebmVhY
	 L8Pgj052Hit3VIEt8sBRjEmZHJxVQIfWyWqkKU0puQ8pTa7Kcqwwiqa4JizlXsa8dO
	 UN8kHpxNi0MOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Ma Ke <make24@iscas.ac.cn>,
	Alan Stern <stern@rowland.harvard.edu>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] usb: ohci-nxp: fix device leak on probe failure
Date: Tue, 30 Dec 2025 08:26:34 -0500
Message-ID: <20251230132634.2198371-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251230132634.2198371-1-sashal@kernel.org>
References: <2025122926-trifocals-slept-6573@gregkh>
 <20251230132634.2198371-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit b4c61e542faf8c9131d69ecfc3ad6de96d1b2ab8 ]

Make sure to drop the reference taken when looking up the PHY I2C device
during probe on probe failure (e.g. probe deferral) and on driver
unbind.

Fixes: 73108aa90cbf ("USB: ohci-nxp: Use isp1301 driver")
Cc: stable@vger.kernel.org	# 3.5
Reported-by: Ma Ke <make24@iscas.ac.cn>
Link: https://lore.kernel.org/lkml/20251117013428.21840-1-make24@iscas.ac.cn/
Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
Link: https://patch.msgid.link/20251218153519.19453-4-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/ohci-nxp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/ohci-nxp.c b/drivers/usb/host/ohci-nxp.c
index 78ffd2f40bd7..b0decd8722b2 100644
--- a/drivers/usb/host/ohci-nxp.c
+++ b/drivers/usb/host/ohci-nxp.c
@@ -224,6 +224,7 @@ static int ohci_hcd_nxp_probe(struct platform_device *pdev)
 fail_resource:
 	usb_put_hcd(hcd);
 fail_disable:
+	put_device(&isp1301_i2c_client->dev);
 	isp1301_i2c_client = NULL;
 	return ret;
 }
@@ -235,6 +236,7 @@ static int ohci_hcd_nxp_remove(struct platform_device *pdev)
 	usb_remove_hcd(hcd);
 	ohci_nxp_stop_hc();
 	usb_put_hcd(hcd);
+	put_device(&isp1301_i2c_client->dev);
 	isp1301_i2c_client = NULL;
 
 	return 0;
-- 
2.51.0


