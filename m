Return-Path: <stable+bounces-164577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A186B10598
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 11:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56786189B2F2
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 09:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86109259CA7;
	Thu, 24 Jul 2025 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lD4hFQdo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF28258CE7;
	Thu, 24 Jul 2025 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753348771; cv=none; b=Slg+klEJ62VjIDqewK3bNzu7DywLlkuudqzqu+1owhovDdFRccysPJ6AcTExWqjQOnEXxk+cAbS9W2biz3kXQDpLc+LNQGXcTBfgoFMboSQ303BG8/DiKX57uFbtOhXLVxQMdvA3zClMLEyN9TzJRXtxylC3VMKskxdg1fJJdVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753348771; c=relaxed/simple;
	bh=4QBXBq2TIpUKWHS0dOXuGcrJ+33C285poMFsrX5wwTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgjw3zdsqUQ7uCYFGkAeDddLWd1nzcDkaSmqmmALLVJDz0wku5Ht6iMNWHvT0zbxyIvYWP8jkQT7IhpOW3MKyv+tOShho5kyLzOIp43bBXBclr+tmQ/mpLFnYPkWalAHZzg8fmUyKSDPswIeDfXm3PSMwuA77mQ9WuOHICfmaks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lD4hFQdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2DFC4CEF9;
	Thu, 24 Jul 2025 09:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753348771;
	bh=4QBXBq2TIpUKWHS0dOXuGcrJ+33C285poMFsrX5wwTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lD4hFQdowc88sXR1TgcS7XG5ndJMfIitgPEMmTsz0cCJc4tWsisycukC9VS6ss0NT
	 MIQmHBJhXF2fnufLG596NEWAWuq6ExVLDg1HbpuNARxR61xym8PTuageJWbIcY6B2m
	 QyXZUF0MEd4N6dkanizu8zzRdniSMJqmMeyPurBmulYCpvl6+JTiY5EEZYXtOlBnLE
	 JacPFdBdVZO6nWNq6XDh3bCyEIf2iFokhDcr2iYNzGoxcKKjyndryaJlrW4P95/UVU
	 +OKvygmKzo1gYoDX5yqnGXalFw5PLHH8VIJ5OsM+l1jZcv0PU2u/cEPnI2rZR+9IRD
	 zoFWRreT9l5+w==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ues6n-000000005Uz-3YCG;
	Thu, 24 Jul 2025 11:19:25 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Bin Liu <b-liu@ti.com>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 3/5] usb: gadget: udc: renesas_usb3: fix device leak at unbind
Date: Thu, 24 Jul 2025 11:19:08 +0200
Message-ID: <20250724091910.21092-4-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250724091910.21092-1-johan@kernel.org>
References: <20250724091910.21092-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference to the companion device taken during
probe when the driver is unbound.

Fixes: 39facfa01c9f ("usb: gadget: udc: renesas_usb3: Add register of usb role switch")
Cc: stable@vger.kernel.org	# 4.19
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/gadget/udc/renesas_usb3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index 3e4d56457597..d23b1762e0e4 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -2657,6 +2657,7 @@ static void renesas_usb3_remove(struct platform_device *pdev)
 	struct renesas_usb3 *usb3 = platform_get_drvdata(pdev);
 
 	debugfs_remove_recursive(usb3->dentry);
+	put_device(usb3->host_dev);
 	device_remove_file(&pdev->dev, &dev_attr_role);
 
 	cancel_work_sync(&usb3->role_work);
-- 
2.49.1


