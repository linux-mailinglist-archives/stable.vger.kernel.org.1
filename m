Return-Path: <stable+bounces-204218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7209BCE9CE2
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 14:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52E853016CD6
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 13:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B34722258C;
	Tue, 30 Dec 2025 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eErgsJ2T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02CB2A1BB
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767102086; cv=none; b=ExzKXiLyzBuq4r+I52QekxGyhjl6dxXXHxIOlJNhN+LtEaTBXC1GiIzd8BIr39nUhc6zQa1E5XHFzRXN0GkFjPitYec6OgFLm7xLEOkvHNabAUhTCcGLZRIpL33s51c/+QgG6TsaoGXfj0HPHeIFeVpf5t6sJ5yyPn6RXO+fy/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767102086; c=relaxed/simple;
	bh=7iYVTR0KhvixAODeEfVyxc/HgiB/m61jgLZhf9cSnjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+YkvQfIAO3DqgECPWqjipms/usX/kTIVkFHZ/JaZDLGHzCmdoxFfK4WPfIg+z9yJNYKOPUfztjPnUtAQA+vUMTRl7N7ee+BhkcZBSXLy7XERzCalaOJur5/VE3IhR6euCGx8+0c9/1Hjlv59dKAisfP/XHQws4JPDR4BQbCAWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eErgsJ2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96996C19421;
	Tue, 30 Dec 2025 13:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767102086;
	bh=7iYVTR0KhvixAODeEfVyxc/HgiB/m61jgLZhf9cSnjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eErgsJ2TO6TjTHg/mYEObwdbtZtSDDHVlX2SUZxBwG/f8aR6HgKs2rRl/ZgJkOHh+
	 U3vhZk6LNsbfNY6toH6WYZhpjaPixCC1hAlYooWRC9/fILmfKGQwzGcO9fy/GgkC3J
	 5poCDYmfSzRov1gczaT1TvLon4iKk4tmVFNXkSjPCfWhcDWQRBqI2p0iTJ9KPS8y1z
	 IcMSynU3dHwyrVq9om+CYdNS+24Mvk0MARcVukPVvOl0oH3tXuBqNrgLpioX95+7Hi
	 T3+cL4b4A6XphuzZi8goweynpW0489GbbLCRhCycx8TlS+0jBmlahzdyEQwybw+Wcz
	 /rQ4cRSEWToWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Ma Ke <make24@iscas.ac.cn>,
	Alan Stern <stern@rowland.harvard.edu>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] usb: ohci-nxp: fix device leak on probe failure
Date: Tue, 30 Dec 2025 08:41:23 -0500
Message-ID: <20251230134123.2206998-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251230134123.2206998-1-sashal@kernel.org>
References: <2025122927-preppy-grab-bb17@gregkh>
 <20251230134123.2206998-1-sashal@kernel.org>
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
index f7f85fc9ce8f..a1555bce22d0 100644
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


