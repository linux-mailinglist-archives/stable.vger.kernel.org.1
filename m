Return-Path: <stable+bounces-197032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 102B5C8A7C3
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 15:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8FF2A35A2D2
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 14:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6548309EE9;
	Wed, 26 Nov 2025 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCcdXyqd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577F0305054;
	Wed, 26 Nov 2025 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168850; cv=none; b=AAHlcpOz9nl05+2B73o3FUpc3ql0VE5TSuWt3s+x7kff2rpFeiQKwXn2qyeGTI3zShfGBYl+InpS3XKLmlB1HcydjJ59zjlGgmMdA5E2HsgiOGXosyxcUZTRIkjSdpDd/DVIzuxku4TLjONO8XyTxD+1WOLemirICTREOL9bxrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168850; c=relaxed/simple;
	bh=RpHADdMaabfWP2N6LAPqW6uX7ikYAtv63iCYxtB/txE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4bkBkdlZQDKX7WiFEvtMewzOKd/5N6OOiKmR5IgGPGRUW0sTsJ6MpLpar4nHPpupH0uapgw8BAf1y9akZDmQvx3Hou2zo5bgnYj8yKQt7jQbMFm8HB3juE7Tc1mKvjizENqSfCUwbO20NKzF75oNscrZkMWVSs4YKkUlyVZHP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCcdXyqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16994C116C6;
	Wed, 26 Nov 2025 14:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764168850;
	bh=RpHADdMaabfWP2N6LAPqW6uX7ikYAtv63iCYxtB/txE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hCcdXyqd+XQLCbbgMwHojpkOG6pgK42ks6ynS3yiUWiAU8OUmA2jod02raOWjAP36
	 kCimN8lZCnRevW/uufkUeaUwBIZMGlTXWE3J44Dxmrxvs5bN0sod3P6yfwi0M8zqsO
	 MnyUyDHThdpBWTiIIUwbXBAXf9DIMUjSaVIUUka3X7H29mWPX8fQAhWZUCkZZPIEkC
	 y6DxkDc/zqFk8vQrvHHIz0XF5z04p5B4a6SpWDMXTwzEmU4OkgVpwT5ccy/IaUrMg8
	 Y6MCDMTj5MRVivR4Y8c8819t+COCPvbSWs7FY6uWFEMzpZVX2aahS0Kl+BYAFQ4YA3
	 csexvzL8j7aYg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vOGuJ-000000001K3-2L92;
	Wed, 26 Nov 2025 15:54:11 +0100
From: Johan Hovold <johan@kernel.org>
To: Srinivas Kandagatla <srini@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 3/6] slimbus: core: fix device reference leak on report present
Date: Wed, 26 Nov 2025 15:53:26 +0100
Message-ID: <20251126145329.5022-4-johan@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251126145329.5022-1-johan@kernel.org>
References: <20251126145329.5022-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Slimbus devices can be allocated dynamically upon reception of
report-present messages.

Make sure to drop the reference taken when looking up already registered
devices.

Note that this requires taking an extra reference in case the device has
not yet been registered and has to be allocated.

Fixes: 46a2bb5a7f7e ("slimbus: core: Add slim controllers support")
Cc: stable@vger.kernel.org	# 4.16
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/slimbus/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 9f85c4280171..b4ab9a5d44b3 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -379,6 +379,8 @@ struct slim_device *slim_get_device(struct slim_controller *ctrl,
 		sbdev = slim_alloc_device(ctrl, e_addr, NULL);
 		if (!sbdev)
 			return ERR_PTR(-ENOMEM);
+
+		get_device(&sbdev->dev);
 	}
 
 	return sbdev;
@@ -505,6 +507,7 @@ int slim_device_report_present(struct slim_controller *ctrl,
 		ret = slim_device_alloc_laddr(sbdev, true);
 	}
 
+	put_device(&sbdev->dev);
 out_put_rpm:
 	pm_runtime_mark_last_busy(ctrl->dev);
 	pm_runtime_put_autosuspend(ctrl->dev);
-- 
2.51.2


