Return-Path: <stable+bounces-190067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C0013C0FF09
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F41B4EC323
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 18:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37A42D7806;
	Mon, 27 Oct 2025 18:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cU4aNE9Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF24218EB1;
	Mon, 27 Oct 2025 18:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761590348; cv=none; b=Uqf/wtil3IX+yXgs7h6P38LbzR3PEhgBfYsNUBKFpn7xezwuLxa/AcqyOPTbU54cHwWTS585WV8ycfAalpwjG+LlfEJTG85EGyhV749jmNJ+KtKkwowP0FtzGJbmA7hI2sQlLY66111zyoIcr2wqcZjGTXEAEfkgtA+B+pRVByE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761590348; c=relaxed/simple;
	bh=hIln6CbJu2jrHiC6fBvtxqD3Hl58vR+VQL2/KUVLtrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUB1+mWR+YkQNVauhHdMMYo+YVH/k4Q1Kjjshea1Bcj/UuxgwpTEHbX9LO2sllDj3w1NMuLzJ7NtsNWTjR4HfQun8Hsu0EDQYqZ0Wem2RQG/QRpOIu9mRH0AHncSsc+ij7kP2DfyiHHBUe8a+LPKGS+du/pg17uhE2Jki+iq4Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cU4aNE9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42745C4CEF1;
	Mon, 27 Oct 2025 18:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761590348;
	bh=hIln6CbJu2jrHiC6fBvtxqD3Hl58vR+VQL2/KUVLtrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cU4aNE9YaMFQgohGyw1yB0e2MuS+FN/faaqeNwkfKIy6FluLs1gAy273Hlog/8FWY
	 Kyw85hug2rNd2lKNzLh1ic+6n7TBVMvw6S/O6I/NbJ8hN9dcZcxB0lW+cZlL2adZri
	 +mlG14oZJE/VcB02JdmQlqCDKIv9c3ZPAl+dLwNg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH 5.4 012/224] wifi: rtlwifi: rtl8192cu: Dont claim USB ID 07b8:8188
Date: Mon, 27 Oct 2025 19:32:38 +0100
Message-ID: <20251027183509.316878792@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027183508.963233542@linuxfoundation.org>
References: <20251027183508.963233542@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

commit e798f2ac6040f46a04795d7de977341fa9aeabae upstream.

This ID appears to be RTL8188SU, not RTL8188CU. This is the wrong driver
for RTL8188SU. The r8712u driver from staging used to handle this ID.

Closes: https://lore.kernel.org/linux-wireless/ee0acfef-a753-4f90-87df-15f8eaa9c3a8@gmx.de/
Cc: stable@vger.kernel.org
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/2e5e2348-bdb3-44b2-92b2-0231dbf464b0@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
@@ -297,7 +297,6 @@ static const struct usb_device_id rtl819
 	{RTL_USB_DEVICE(0x050d, 0x1102, rtl92cu_hal_cfg)}, /*Belkin - Edimax*/
 	{RTL_USB_DEVICE(0x050d, 0x11f2, rtl92cu_hal_cfg)}, /*Belkin - ISY*/
 	{RTL_USB_DEVICE(0x06f8, 0xe033, rtl92cu_hal_cfg)}, /*Hercules - Edimax*/
-	{RTL_USB_DEVICE(0x07b8, 0x8188, rtl92cu_hal_cfg)}, /*Abocom - Abocom*/
 	{RTL_USB_DEVICE(0x07b8, 0x8189, rtl92cu_hal_cfg)}, /*Funai - Abocom*/
 	{RTL_USB_DEVICE(0x0846, 0x9041, rtl92cu_hal_cfg)}, /*NetGear WNA1000M*/
 	{RTL_USB_DEVICE(0x0846, 0x9043, rtl92cu_hal_cfg)}, /*NG WNA1000Mv2*/



