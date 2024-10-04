Return-Path: <stable+bounces-80836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 343B0990BA7
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 632831C217F4
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CD31E5721;
	Fri,  4 Oct 2024 18:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPZlvlJi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967461E5713;
	Fri,  4 Oct 2024 18:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066015; cv=none; b=XtoElp5iTVyR7y3faBHmgU2VFRFJCJc193nCc3LBh9fosYKKz2t1hIxe2QIlZKbkMXJomzPBQVhQ96Hqs1nTru9OtcdFMc00qdQxekne9/Ue0K1hc6RnpBPh9VNdjfF1tT+PRPcPRrNJ9cKbaJ3SH2xXUKaLadfHuCDa2HWdcBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066015; c=relaxed/simple;
	bh=UUbP7Gg32+SWQXQ/jjMw9oOI8oG5r4cghcMCBqdZ/pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EzfpNjJVFxCYZCl32ac8XsgCbqHKJDbPgdUWG+7L3N/0fsTxv1W5m9uvRlQFRCGZ16l+JvNRfrAX3hbylvc/kKVqGV0K9xWS9CpzHdXJUWzjoHep06g5qB7/ydegYgNr9oYgBLWeS7hxjxHctWyAMweSh3MemN2qidzQoL5cOUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPZlvlJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E941C4CECC;
	Fri,  4 Oct 2024 18:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066015;
	bh=UUbP7Gg32+SWQXQ/jjMw9oOI8oG5r4cghcMCBqdZ/pY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jPZlvlJiLq+0I0bAlmeshZL5XrWrYkLcDW3zNOr0eKLEzPmahoPWVCwnc6lHEKst4
	 4LkSkcD/+GM5azb7roLlqN/Vkfz3wWab6YKDdC1trpV4HgKSUF+iEIUqr3wkDRrzWj
	 0NBU/N+dFzJKORzXILPgi0OCxqHn1PYSp1vOau+R8XnjGskWDOkOsGVM9FCMKxDda+
	 wiL4Hz80a6zU0U7uhmnqoMpwWxOHXmTeGDekFbOhL9v1egapAzVMQuc8x/gICg2Cz9
	 PjDN4UP/HGkLG1GjgU7Evxt0PrxW74H8E2IIGp0mPnf79OpK+TPjqTOWwBA5KEXO2L
	 bdAo7pSxAxO6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mathias.nyman@intel.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 56/76] usb: host: xhci-plat: Parse xhci-missing_cas_quirk and apply quirk
Date: Fri,  4 Oct 2024 14:17:13 -0400
Message-ID: <20241004181828.3669209-56-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
Content-Transfer-Encoding: 8bit

From: Frank Li <Frank.Li@nxp.com>

[ Upstream commit a6cd2b3fa89468b5f28b83d211bd25cc589f9eba ]

Parse software managed property 'xhci-skip-phy-init-quirk' and
'xhci-skip-phy-init-quirk' to apply related quirk. It allows usb glue layer
driver apply these quirk.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20240906-dwc-mp-v5-1-ea8ec6774e7b@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-plat.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 31bdfa52eeb25..ecaa75718e592 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -259,6 +259,12 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 		if (device_property_read_bool(tmpdev, "write-64-hi-lo-quirk"))
 			xhci->quirks |= XHCI_WRITE_64_HI_LO;
 
+		if (device_property_read_bool(tmpdev, "xhci-missing-cas-quirk"))
+			xhci->quirks |= XHCI_MISSING_CAS;
+
+		if (device_property_read_bool(tmpdev, "xhci-skip-phy-init-quirk"))
+			xhci->quirks |= XHCI_SKIP_PHY_INIT;
+
 		device_property_read_u32(tmpdev, "imod-interval-ns",
 					 &xhci->imod_interval);
 	}
-- 
2.43.0


