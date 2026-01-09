Return-Path: <stable+bounces-207756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9ADCD0A28F
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 14:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CDEF73084C06
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 12:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8734635BDB2;
	Fri,  9 Jan 2026 12:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GRAn5NZE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4125F35B12B;
	Fri,  9 Jan 2026 12:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962958; cv=none; b=X5DyPexX0z1IlkFarHQlQkLwAy5r4cTEHBzP0fIM9WevA0bqG/DQ2XjRH+VIQGoB2lecAANJ5Dbmon12JA9SgxOMtdMDiP19g7C0SxvDr4IIZShNd61CVeJ/GL/l99P8zCQhd7FZ6fYUgLBYZ5VMgQdsu/DMHkJ9CW2vVBUGhLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962958; c=relaxed/simple;
	bh=Smq8Lx8JCOWzCl2CBqr4boRraSmv1BN1xb3+GT9TOY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mlPevA010QKQ4jdSd3/TUfeCV8yhNv+fFFtBDNJZZdSCAUaivkhczb9oitYuVww2i3Jp3Vs8c34pfHUve0+5InaEVmzaEb2OPIEZJYZ7FQ9OjueGfX1XPX53B5CG43eLZzuU1LsRwk9a7hYZ9n8FvAAGjkqa/0iLCk4+4nWcztE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GRAn5NZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859B9C4CEF1;
	Fri,  9 Jan 2026 12:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767962957;
	bh=Smq8Lx8JCOWzCl2CBqr4boRraSmv1BN1xb3+GT9TOY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GRAn5NZES+v0APc/J3PVIFYBaktujgR+EHSW0JIjmdGpCzBWxAzW6a5kdSnfGD+IH
	 p2Nt+IzDJaGBuePcfW2lV20TN06VoVFV58EMnvN8+0qcseBwt/6809oUCngoxOVuaT
	 GP7Qb3jZPiqloRjLkAIEkp/FY1hkpPSGNg2coK44=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Ke <make24@iscas.ac.cn>,
	Johan Hovold <johan@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 547/634] usb: ohci-nxp: fix device leak on probe failure
Date: Fri,  9 Jan 2026 12:43:45 +0100
Message-ID: <20260109112138.173333893@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109112117.407257400@linuxfoundation.org>
References: <20260109112117.407257400@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/ohci-nxp.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/host/ohci-nxp.c
+++ b/drivers/usb/host/ohci-nxp.c
@@ -224,6 +224,7 @@ static int ohci_hcd_nxp_probe(struct pla
 fail_resource:
 	usb_put_hcd(hcd);
 fail_disable:
+	put_device(&isp1301_i2c_client->dev);
 	isp1301_i2c_client = NULL;
 	return ret;
 }
@@ -235,6 +236,7 @@ static int ohci_hcd_nxp_remove(struct pl
 	usb_remove_hcd(hcd);
 	ohci_nxp_stop_hc();
 	usb_put_hcd(hcd);
+	put_device(&isp1301_i2c_client->dev);
 	isp1301_i2c_client = NULL;
 
 	return 0;



