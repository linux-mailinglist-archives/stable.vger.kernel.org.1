Return-Path: <stable+bounces-13965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428D2837EFD
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B081C28931
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F5E604B5;
	Tue, 23 Jan 2024 00:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s0KOI35R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3388960252;
	Tue, 23 Jan 2024 00:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970866; cv=none; b=mAx+/OuFrQUjBIHRmKrbgLPmWiww89G7fMQwQ5XqJ9L5mDHojevtmsC7wXBj9KcvM6Nue4z7jWkUVBNDvdPPNOXUIGw+bC5KHBiwpfLc3E3dPL4t9HTGnrS+zsmgbdtfO2l908eHavnvK+nr+T6GZ3HQcCQeLGXTJEKB+1EdSoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970866; c=relaxed/simple;
	bh=flscZ/plt75/6tg0sDtyhpmPISXlp8527Yj5S0UP4Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iE1W8nNdoEqstdf9S1ZHPs77pqnIbDXUSk6XMNe0NzxsWNI5scFNxqAgnWC+ZeJiMNeBTmFP4Ug2zaDwCi/9f6EivFNxNdRAVNMbXj2JfGTWyMdh6HgBeu1+a1HCEMCAtoPciyvBP7C316FbcP70FEhIIcwPv2g9m/p7wW1G4dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s0KOI35R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6BFC433C7;
	Tue, 23 Jan 2024 00:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705970866;
	bh=flscZ/plt75/6tg0sDtyhpmPISXlp8527Yj5S0UP4Xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s0KOI35R0Ci/o+miPqofW6HIX2WEHD1HvNAyAqaWGkAkavw7bvoaNvDiAeme/qk9t
	 0+uP25luG63Okk4V5kaB86HHKMZO08HZVSnknrVS7e5PFIycHxRbffCfhaYaOGSzW5
	 kTfI7wSp05ZNJtVFmPeUNml9oWOYJtHMgE7bvjtY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luca Weiss <luca@z3ntu.xyz>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 034/286] Input: xpad - add Razer Wolverine V2 support
Date: Mon, 22 Jan 2024 15:55:40 -0800
Message-ID: <20240122235733.334468490@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235732.009174833@linuxfoundation.org>
References: <20240122235732.009174833@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luca Weiss <luca@z3ntu.xyz>

[ Upstream commit c3d1610345b79cbe29ef6ca04a4780eff0d360c7 ]

Add the VID and PID of Razer Wolverine V2 to xpad_device.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Link: https://lore.kernel.org/r/20231125-razer-wolverine-v2-v1-1-979fe9f9288e@z3ntu.xyz
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index beedad0fe09a..239471cf7e4c 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -266,6 +266,7 @@ static const struct xpad_device {
 	{ 0x146b, 0x0604, "Bigben Interactive DAIJA Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x1532, 0x0a00, "Razer Atrox Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
 	{ 0x1532, 0x0a03, "Razer Wildcat", 0, XTYPE_XBOXONE },
+	{ 0x1532, 0x0a29, "Razer Wolverine V2", 0, XTYPE_XBOXONE },
 	{ 0x15e4, 0x3f00, "Power A Mini Pro Elite", 0, XTYPE_XBOX360 },
 	{ 0x15e4, 0x3f0a, "Xbox Airflo wired controller", 0, XTYPE_XBOX360 },
 	{ 0x15e4, 0x3f10, "Batarang Xbox 360 controller", 0, XTYPE_XBOX360 },
-- 
2.43.0




