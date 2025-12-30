Return-Path: <stable+bounces-204215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F68CE9CB8
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 14:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4DCF3018955
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 13:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187AA231836;
	Tue, 30 Dec 2025 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vx+23ncV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0A7AD5A
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 13:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767101701; cv=none; b=DriD9ffbbMvpPu5CewVkQ1o1/YDMXy66sgThOpRZxvlSx1dNOJT7ukrNq4wk28EW7PS6XMvg66nEkbHc6fNJMPOdS5Dld1D85Q2fOl2+e3dWCxVdH7d0GZEsWpKmbt2mM1z5o8JR0a2/Waut0s8YFxA4etjPjb4BY+6Z1NcMrIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767101701; c=relaxed/simple;
	bh=7iYVTR0KhvixAODeEfVyxc/HgiB/m61jgLZhf9cSnjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQo+98ewBBmIIuKcgbMk2O+qdJhWoZaSoZfQMq9Qaq1H0ndMV+R7gfH8NjncL89CVUF0TeRxfRIsn79tG3MdkK7r/AMLSP9spqAStTDOpMpz2xLCB1Vg3V4owRvT3OB2I6i/8oUIsfL/Oga7V9oLdlcbEcBXie3WICq3AJEd64A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vx+23ncV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F854C116C6;
	Tue, 30 Dec 2025 13:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767101701;
	bh=7iYVTR0KhvixAODeEfVyxc/HgiB/m61jgLZhf9cSnjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vx+23ncVxtm+OJ0UOn5DN3anzPmAni7sBY7bZKztKsSZgZf8C3Ufd6GSnscE7Zx7J
	 VAg5X80o9BMjxrIjnL59bJzjk9bWLUSNUINNEmgwbEC4WdbXXAHIzskxUFgf+EAaKl
	 C0PWeLMSM33RlWTc6UqkM+Y3ubenBDhjRy7aHU9nj5vLr0FVVT4UJ7W+r2X5JOzKEb
	 z8CTaEUfTBNnyqjUD1o9ob6/EFkWm2K7VNbi8IlS+CthImt5toFrOiLyh3KIq+1Iug
	 +gumVMNpds6BkEYqVdbtTi+VwcoQ8/EMS9QFuDntJTdtnbYCDz/tQO2pgZ+ykUhW7j
	 yfJuOedvfW8GA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Ma Ke <make24@iscas.ac.cn>,
	Alan Stern <stern@rowland.harvard.edu>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] usb: ohci-nxp: fix device leak on probe failure
Date: Tue, 30 Dec 2025 08:34:58 -0500
Message-ID: <20251230133458.2203341-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251230133458.2203341-1-sashal@kernel.org>
References: <2025122927-swiftly-press-a51f@gregkh>
 <20251230133458.2203341-1-sashal@kernel.org>
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


