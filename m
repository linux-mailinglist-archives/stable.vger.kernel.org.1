Return-Path: <stable+bounces-128648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD10A7EA1B
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 298A97A5D1B
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84F725DCE5;
	Mon,  7 Apr 2025 18:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCzMR6p+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA7525DB18;
	Mon,  7 Apr 2025 18:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049581; cv=none; b=MWrwK85F+AlxU7SW/nUpv3DIVrXo/gNmON9koA21IuB3lhIw8N+Oh6yH9veCFA9E2h48lMdtQWm1Kaa0S8bq8haxze9yraltbK4sxgx967XVo6Uz3DoZpoI9ToABk1dZ5OdRnpQWapRV1EaCtmQ+m9imLCRpb1Bdx4lCsps7MYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049581; c=relaxed/simple;
	bh=USTUdd+X23ngKX5LHHa0s3x3VrueV8uT36p/v1J1cCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a5KFerXg+oSTdin7VI+tzVLJrJPH0y8MnFGhcTiqAMLMMyHyb0YwezarOfmBYbQXK1aWHwHmf+qfh5HX/vQOslJJ8rQQgDp25x57kn314PH90lBPNYAAtcAVR1+zUom3fvX1xWROimG5kh0TolwhM8J8ZFxqyQLjn3C7synlEgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCzMR6p+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EAAC4CEE7;
	Mon,  7 Apr 2025 18:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049580;
	bh=USTUdd+X23ngKX5LHHa0s3x3VrueV8uT36p/v1J1cCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GCzMR6p+OqgRiZVcJkHKHWazPNHtGBqK5fJIycrOZvP6c/3onY/dBBAV0YRM1k8zt
	 OPBjT0qgmQrOO7WfSHr8Vp2IDmo+ceZG2DzRzaVdXZAh6TNg5Xoc3S9E+MYbhAQzyk
	 zB501Kh7/zpu55jW2GzKL4p50XHDVLZOQLAPehvoCzrRT+PT9mh6yeo3cnAebfRxwx
	 R5E+YPUK/AO2mBg4IVh3z89pFh96b+MK2LMALVdq1JzxqbzX5l7/ZsVLeMpcF3kWvO
	 nJUwn3h14YplW2/fHCk5JpCVjOgjJHyNf4tU6ORznwajmVzRCsJeKKVtl+E/kztPVn
	 S9rwKLgzpoE1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Thomas Lynema <lyz27@yahoo.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	andreas.noever@gmail.com,
	michael.jamet@intel.com,
	westeri@kernel.org,
	YehezkelShB@gmail.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 19/28] thunderbolt: Scan retimers after device router has been enumerated
Date: Mon,  7 Apr 2025 14:12:09 -0400
Message-Id: <20250407181224.3180941-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181224.3180941-1-sashal@kernel.org>
References: <20250407181224.3180941-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.10
Content-Transfer-Encoding: 8bit

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit 75749d2c1d8cef439f8b69fa1f4f36d0fc3193e6 ]

Thomas reported connection issues on AMD system with Pluggable UD-4VPD
dock. After some experiments it looks like the device has some sort of
internal timeout that triggers reconnect. This is completely against the
USB4 spec, as there is no requirement for the host to enumerate the
device right away or even at all.

In Linux case the delay is caused by scanning of retimers on the link so
we can work this around by doing the scanning after the device router
has been enumerated.

Reported-by: Thomas Lynema <lyz27@yahoo.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219748
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/tb.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index a7c6919fbf978..e1da433a9e7fb 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -1295,11 +1295,15 @@ static void tb_scan_port(struct tb_port *port)
 		goto out_rpm_put;
 	}
 
-	tb_retimer_scan(port, true);
-
 	sw = tb_switch_alloc(port->sw->tb, &port->sw->dev,
 			     tb_downstream_route(port));
 	if (IS_ERR(sw)) {
+		/*
+		 * Make the downstream retimers available even if there
+		 * is no router connected.
+		 */
+		tb_retimer_scan(port, true);
+
 		/*
 		 * If there is an error accessing the connected switch
 		 * it may be connected to another domain. Also we allow
@@ -1349,6 +1353,14 @@ static void tb_scan_port(struct tb_port *port)
 	upstream_port = tb_upstream_port(sw);
 	tb_configure_link(port, upstream_port, sw);
 
+	/*
+	 * Scan for downstream retimers. We only scan them after the
+	 * router has been enumerated to avoid issues with certain
+	 * Pluggable devices that expect the host to enumerate them
+	 * within certain timeout.
+	 */
+	tb_retimer_scan(port, true);
+
 	/*
 	 * CL0s and CL1 are enabled and supported together.
 	 * Silently ignore CLx enabling in case CLx is not supported.
-- 
2.39.5


