Return-Path: <stable+bounces-203005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C04FCCCC70
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 17:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 95E023052D6B
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 16:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C4C34FF41;
	Thu, 18 Dec 2025 15:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKMAILWi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347BB34F482;
	Thu, 18 Dec 2025 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766072245; cv=none; b=XM18mfS7noJnGQ7fBViGvw3Z/vd5vIBkUvk+4Ov5olGdQlXpgnzAwuoc2jvMkuVGNbkJ2O+ZoHXwfwoVhm6d+5/AW2Rv14yYZKg0balJuy1dOgOxuL/SUPZZG4mGB7L1GOSuSUWOOv2V3CdmPZIREevyW03Lgo6LIE44m+W4VC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766072245; c=relaxed/simple;
	bh=Pez/lqPEVsmpWvjU1ySBtrqLxe0+pAjZm/LpmZXtL6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jt5umA5xolg9quRY1PdbjykjolXUiDhxLvO0olskGFAN3+dBZ+fSzF+OGNrjwXVjKOGut5qGnT3Vo+GAh4yekZR7K8pU8e1R6+/hA8KvFKC5BmMfeyv14plOKeVf8mbi5BT3kA3FerYqa71aL/UNdkDn9cTtmEEp860zIInsAnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKMAILWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53FEC19423;
	Thu, 18 Dec 2025 15:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766072244;
	bh=Pez/lqPEVsmpWvjU1ySBtrqLxe0+pAjZm/LpmZXtL6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GKMAILWiU3IvfH5WvUVC9wwsOcZzJcpYZ7idEO0ybRs1ND/nUsfL7Se9teq135xPA
	 wcJK1unOxTbSwHiUe30j0oLVHIs8ei6I3rosPYd6gh8XSARn3ZDFhqJyLKCIuBCYz7
	 fyoYcZLIrz/5XpxjA1FXGv5f0ewGWQOK2vgZwnILrE/yQfzEi4jWBu4Q2lH+fuStXG
	 j20RWRbTbdxF+HTcTwwo0/H5V4wxgHsUlnk/5uQEXOImBywvcpDW7tX5u+e1GYWVTa
	 +vjTRIs+5ZBVqKD8tL3aCKLgOMAYO/4XnRrtP7a77daj42Q+fUgbQ3EWb2vYU7gMSz
	 n8m8Mo1yoZCjg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vWG4B-0000000056C-0g0g;
	Thu, 18 Dec 2025 16:37:23 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Ma Ke <make24@iscas.ac.cn>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/5] usb: ohci-nxp: fix device leak on probe failure
Date: Thu, 18 Dec 2025 16:35:17 +0100
Message-ID: <20251218153519.19453-4-johan@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251218153519.19453-1-johan@kernel.org>
References: <20251218153519.19453-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken when looking up the PHY I2C device
during probe on probe failure (e.g. probe deferral) and on driver
unbind.

Fixes: 73108aa90cbf ("USB: ohci-nxp: Use isp1301 driver")
Cc: stable@vger.kernel.org	# 3.5
Reported-by: Ma Ke <make24@iscas.ac.cn>
Link: https://lore.kernel.org/lkml/20251117013428.21840-1-make24@iscas.ac.cn/
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/host/ohci-nxp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/ohci-nxp.c b/drivers/usb/host/ohci-nxp.c
index 24d5a1dc5056..509ca7d8d513 100644
--- a/drivers/usb/host/ohci-nxp.c
+++ b/drivers/usb/host/ohci-nxp.c
@@ -223,6 +223,7 @@ static int ohci_hcd_nxp_probe(struct platform_device *pdev)
 fail_resource:
 	usb_put_hcd(hcd);
 fail_disable:
+	put_device(&isp1301_i2c_client->dev);
 	isp1301_i2c_client = NULL;
 	return ret;
 }
@@ -234,6 +235,7 @@ static void ohci_hcd_nxp_remove(struct platform_device *pdev)
 	usb_remove_hcd(hcd);
 	ohci_nxp_stop_hc();
 	usb_put_hcd(hcd);
+	put_device(&isp1301_i2c_client->dev);
 	isp1301_i2c_client = NULL;
 }
 
-- 
2.51.2


