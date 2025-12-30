Return-Path: <stable+bounces-204221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF10CE9D7B
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 15:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88A8D301A1A6
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 13:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A626424466B;
	Tue, 30 Dec 2025 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyLI7SBV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EA8244665
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767103166; cv=none; b=G/OR3ONoDDv1JSYgK5lDemfRurDMUqdwHdYDjxBnvHhH8c+fyxkdLQU/t64IQxS/Kiv9YsgWmJ/uQz6f9clcxMCYHi5C15Sy+ytgkcStkAbQjewKNUMq2Uaih6kFH+k+Im1Msm7EGEaIeFMUCoZwU+eXLSzo5WxNd7fK+hswMWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767103166; c=relaxed/simple;
	bh=PQIIiwy0fjGYs1LQN49s/Ph/OXgH2+h60itqVZb90Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1dFNyHKARF7jnTsplu/CW1BZZGDLGoCYHSPCAvrb6O3s9OGX1RdnwqFryFfOgceGth3SHzgRqgb0qyasNM+8BEKdSjHYPNdqtbDz3kSmpLyt8Icm+7V9uMIUICApl3YoRjv5B+uFMxtbJjBmSo10VJtMNt/UZHCTs7VQWAacjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyLI7SBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C97C4CEFB;
	Tue, 30 Dec 2025 13:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767103166;
	bh=PQIIiwy0fjGYs1LQN49s/Ph/OXgH2+h60itqVZb90Vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UyLI7SBVzSSTKSZIpF/sSR0VQIaVVOFG3OQeP5fv7VY0KdKikp6SKO+6MOPG4cRsk
	 MXV6SVEX+n9jyTBXQhhbUrGcl+gTHwFhE9Ps+paUxxnINHSDriByE9zpiUyQbOiJZA
	 jrvSoosVjjBykxupmHL82iRTfZUYI6Nga98qSxGf+lbYaWSSVu+1gVYXCZm74IrcBY
	 HxomJn8xw1i42+O2YBLq5eAKP1wk7L2jWH0hdGV2WU2YpqAPsKhz3gyxSJ0pJRI06z
	 Z50CzaDQocEIRiAEWQC0b5QBdVzHDofakE6Dd95tc3HbFPLG4ef26vIL77eo3BVmZZ
	 yHoPwbjwy7c5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Aidan Stewart <astewart@tektelic.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] serial: core: fix OF node leak
Date: Tue, 30 Dec 2025 08:59:17 -0500
Message-ID: <20251230135918.2221627-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122929-reoccupy-raking-f984@gregkh>
References: <2025122929-reoccupy-raking-f984@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 273cc3406c8d4e830ed45967c70d08d20ca1380e ]

Make sure to drop the OF node reference taken when initialising the
control and port devices when the devices are later released.

Fixes: d36f0e9a0002 ("serial: core: restore of_node information in sysfs")
Cc: Aidan Stewart <astewart@tektelic.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20250708085817.16070-1-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 24ec03cc5512 ("serial: core: Restore sysfs fwnode information")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/serial_base_bus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
index cb3b127b06b6..22749ab0428a 100644
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -13,6 +13,7 @@
 #include <linux/device.h>
 #include <linux/idr.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/serial_core.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -93,6 +94,7 @@ static void serial_base_ctrl_release(struct device *dev)
 {
 	struct serial_ctrl_device *ctrl_dev = to_serial_base_ctrl_device(dev);
 
+	of_node_put(dev->of_node);
 	kfree(ctrl_dev);
 }
 
@@ -140,6 +142,7 @@ static void serial_base_port_release(struct device *dev)
 {
 	struct serial_port_device *port_dev = to_serial_base_port_device(dev);
 
+	of_node_put(dev->of_node);
 	kfree(port_dev);
 }
 
-- 
2.51.0


