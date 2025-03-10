Return-Path: <stable+bounces-121764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B912A59C22
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E34216DC4E
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CE8230D0F;
	Mon, 10 Mar 2025 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jcZQDvas"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E501DE89C;
	Mon, 10 Mar 2025 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626562; cv=none; b=uTAQ+/7h3xoRBlpOmRDU/sz0LQ3s5Vt0m2sHWIwQqK5eIvixRGwGapjlwf/dEW54efaZ56E64UVqJBkDlqKkMDpiDt/TzCdBbQyapP9b24t2l3gwYAznqiV2eQ3tyAToLAK+2DYtS2VyFPiyAjWxjQPERoht5bxowJJQBcY8kDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626562; c=relaxed/simple;
	bh=pmTh4VtTZAQ8hOnvtr0DY8ud9bIiVKN+JLL5xPe+ob4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjBX4VonM0xYnzOWeZ0BDprbuW+YM+uLcvcmpZiMPq+AAYrRCWOq96H8RljXPxR01wWqbNFsilowXKEEOPuO1gSRvbBafRsYTbbfSZWoP7FZJMXApHR7SiJJv8JojNE7jMZzcvJgKH+dbUvvnjIwzbL1zeM4mVXgBl8qCn3O0xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jcZQDvas; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BFCC4CEE5;
	Mon, 10 Mar 2025 17:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741626561;
	bh=pmTh4VtTZAQ8hOnvtr0DY8ud9bIiVKN+JLL5xPe+ob4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jcZQDvasdFWiVFz/DgsbNVlua3/fS9ueBL70P+qXL2XD05P10hkDsq/IMiVsYFZBB
	 Qaw4hBmSvleCoE3dnuI3Hb6NEE8RvP04gqyAzIvb9fpZQ166FoBVVbCXS86v+al5GU
	 KxU9FbKZtIvq1yzsNpquMGgM3bT7B1MZ2YwoC8Xw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paul Fertser <fercerpav@gmail.com>,
	Iwona Winiarska <iwona.winiarska@intel.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.13 033/207] hwmon: (peci/dimmtemp) Do not provide fake thresholds data
Date: Mon, 10 Mar 2025 18:03:46 +0100
Message-ID: <20250310170449.093293466@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170447.729440535@linuxfoundation.org>
References: <20250310170447.729440535@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Fertser <fercerpav@gmail.com>

commit 5797c04400ee117bfe459ff1e468d0ea38054ab4 upstream.

When an Icelake or Sapphire Rapids CPU isn't providing the maximum and
critical thresholds for particular DIMM the driver should return an
error to the userspace instead of giving it stale (best case) or wrong
(the structure contains all zeros after kzalloc() call) data.

The issue can be reproduced by binding the peci driver while the host is
fully booted and idle, this makes PECI interaction unreliable enough.

Fixes: 73bc1b885dae ("hwmon: peci: Add dimmtemp driver")
Fixes: 621995b6d795 ("hwmon: (peci/dimmtemp) Add Sapphire Rapids support")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Fertser <fercerpav@gmail.com>
Reviewed-by: Iwona Winiarska <iwona.winiarska@intel.com>
Link: https://lore.kernel.org/r/20250123122003.6010-1-fercerpav@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/peci/dimmtemp.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/drivers/hwmon/peci/dimmtemp.c
+++ b/drivers/hwmon/peci/dimmtemp.c
@@ -127,8 +127,6 @@ static int update_thresholds(struct peci
 		return 0;
 
 	ret = priv->gen_info->read_thresholds(priv, dimm_order, chan_rank, &data);
-	if (ret == -ENODATA) /* Use default or previous value */
-		return 0;
 	if (ret)
 		return ret;
 
@@ -509,11 +507,11 @@ read_thresholds_icx(struct peci_dimmtemp
 
 	ret = peci_ep_pci_local_read(priv->peci_dev, 0, 13, 0, 2, 0xd4, &reg_val);
 	if (ret || !(reg_val & BIT(31)))
-		return -ENODATA; /* Use default or previous value */
+		return -ENODATA;
 
 	ret = peci_ep_pci_local_read(priv->peci_dev, 0, 13, 0, 2, 0xd0, &reg_val);
 	if (ret)
-		return -ENODATA; /* Use default or previous value */
+		return -ENODATA;
 
 	/*
 	 * Device 26, Offset 224e0: IMC 0 channel 0 -> rank 0
@@ -546,11 +544,11 @@ read_thresholds_spr(struct peci_dimmtemp
 
 	ret = peci_ep_pci_local_read(priv->peci_dev, 0, 30, 0, 2, 0xd4, &reg_val);
 	if (ret || !(reg_val & BIT(31)))
-		return -ENODATA; /* Use default or previous value */
+		return -ENODATA;
 
 	ret = peci_ep_pci_local_read(priv->peci_dev, 0, 30, 0, 2, 0xd0, &reg_val);
 	if (ret)
-		return -ENODATA; /* Use default or previous value */
+		return -ENODATA;
 
 	/*
 	 * Device 26, Offset 219a8: IMC 0 channel 0 -> rank 0



