Return-Path: <stable+bounces-204203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54818CE9C40
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 14:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B534D3003B0E
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 13:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530F71F4CBB;
	Tue, 30 Dec 2025 13:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LstturgM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129322222B7
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 13:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767100765; cv=none; b=X01qnm506qq28MhBE48fT1XoTGxml5Wj9DJH87gkQU/VJWlfOmP1rWjmxXmhAMGy7Fvbr6qLulci2b6k7eGFZD5I5essBK6Q5MqNEM/qkobrnyOOUvjPAJ263t5vyee5/UMbdD1uz8ljbTvbGumK8yBqAw5/CaNotjnjMoqyk+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767100765; c=relaxed/simple;
	bh=LRnoaPjrP3oLhb6LSgdVEG6S7r71E4s04QT5a5l9ECM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PILcAKpFM3PAeV45klqfrPDu354niUP0T+m7BYgvadP4MxA9L7oe5T/fu6lx3dptj2uglNkCJ0eSe2XjOIP3g3ElNAycoX9VvIYp8fGe2CpzO3E4oS9tJ776fbnVN/HXqMMvHnOLibP9RafKEHt4S9EVoPrGqLZggJzDyn99MiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LstturgM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118FDC116D0;
	Tue, 30 Dec 2025 13:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767100764;
	bh=LRnoaPjrP3oLhb6LSgdVEG6S7r71E4s04QT5a5l9ECM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LstturgMnkplYTM+oHnoM6JG6eZF/mlAZ7dOS8LNEtXoGzPWLmMyufoCYq4XC5qKh
	 jr3yx4iINAf6g+l1MdwVTZRG7rcMpZsgWE87VoKciS8IJcbbI2hCDNLPcvLLkKECuM
	 QIcGQ94eKWdxQsXHlejdfpBeK37gcxzVO+O4kHFPzHMwImAzVWngNHc+GXyAV5o+cQ
	 rCUxrVLhh1O8lMEi29KxoqcgebCup9+rt/5Sx0OsEz60YgMMA92kUvS9pAZliFBEFo
	 +z8nywLLstTSQHc4NUBsys8cWbhFtEKcmsnE3jDHty4hL/rjEvIlQ+FDPoaBLyegyW
	 Vdqkav2WP+rJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Ma Ke <make24@iscas.ac.cn>,
	Alan Stern <stern@rowland.harvard.edu>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] usb: ohci-nxp: fix device leak on probe failure
Date: Tue, 30 Dec 2025 08:19:21 -0500
Message-ID: <20251230131921.2177523-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251230131921.2177523-1-sashal@kernel.org>
References: <2025122926-cushy-unstylish-3577@gregkh>
 <20251230131921.2177523-1-sashal@kernel.org>
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
index 5b775e1ea527..25a739ebc215 100644
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
2.51.0


