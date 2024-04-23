Return-Path: <stable+bounces-41255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4429D8AFB41
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03A4EB2CA75
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8320B14B073;
	Tue, 23 Apr 2024 21:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ceRVOH0V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F59614883C;
	Tue, 23 Apr 2024 21:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908783; cv=none; b=IawC5h1o64Dj5+Yclm8V3e+RG9GFyP4IH9NOksATDn4efr5xWlRvOzVT7w5JGGk/QZfYzkf0aUQXjPJ1THe30UgzAOTm9qlrcvrHBSd45DhXwpkvZVtJMhqu1FkemccO/UCzBXFOLZBM0xVnYiPZzjzosa8c3jrHSTnF6kgCV4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908783; c=relaxed/simple;
	bh=QdMro4Ty2B87S4XBCP+7XK0FLWdRmKhA9F2+GHYYZFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owc+aOj1eL+RVz1l28y+Gwt3LHlplLiguphc+I0hPadaSTpCOIwnOoltnKbcxUGFj/VDPM0AfbOUs3YIuR1vNM6a6umWiqXnTemhnRWrQSNqQ+kNmX/EUnw2C73r8THIOEpZzOfSVzerkoApqRD/VFBoSWaevB4o5hd3oaMRJ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ceRVOH0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15180C116B1;
	Tue, 23 Apr 2024 21:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908783;
	bh=QdMro4Ty2B87S4XBCP+7XK0FLWdRmKhA9F2+GHYYZFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ceRVOH0VFDRYSQHdMkTXJWe/GxpJyGDRI903IAsZTxnyojpXE+Mnrz50C5YgAln2T
	 57Vler6Z3/Uk1RYQ8FZ4Eb9X5q7xiinQZQO0ng7i10VKUYI2iHPAEX3ql/AtgJmtoi
	 VQEeip31/yDbtdzdIo9VX1/+b2X2jtes7kMG+ByQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikhail Kobuk <m.kobuk@ispras.ru>,
	Danilo Krummrich <dakr@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 32/71] drm: nv04: Fix out of bounds access
Date: Tue, 23 Apr 2024 14:39:45 -0700
Message-ID: <20240423213845.252177598@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213844.122920086@linuxfoundation.org>
References: <20240423213844.122920086@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikhail Kobuk <m.kobuk@ispras.ru>

[ Upstream commit cf92bb778eda7830e79452c6917efa8474a30c1e ]

When Output Resource (dcb->or) value is assigned in
fabricate_dcb_output(), there may be out of bounds access to
dac_users array in case dcb->or is zero because ffs(dcb->or) is
used as index there.
The 'or' argument of fabricate_dcb_output() must be interpreted as a
number of bit to set, not value.

Utilize macros from 'enum nouveau_or' in calls instead of hardcoding.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 2e5702aff395 ("drm/nouveau: fabricate DCB encoder table for iMac G4")
Fixes: 670820c0e6a9 ("drm/nouveau: Workaround incorrect DCB entry on a GeForce3 Ti 200.")
Signed-off-by: Mikhail Kobuk <m.kobuk@ispras.ru>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240411110854.16701-1-m.kobuk@ispras.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_bios.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bios.c b/drivers/gpu/drm/nouveau/nouveau_bios.c
index e8c445eb11004..f63ceb8d3e4ef 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bios.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bios.c
@@ -23,6 +23,7 @@
  */
 
 #include "nouveau_drv.h"
+#include "nouveau_bios.h"
 #include "nouveau_reg.h"
 #include "dispnv04/hw.h"
 #include "nouveau_encoder.h"
@@ -1675,7 +1676,7 @@ apply_dcb_encoder_quirks(struct drm_device *dev, int idx, u32 *conn, u32 *conf)
 	 */
 	if (nv_match_device(dev, 0x0201, 0x1462, 0x8851)) {
 		if (*conn == 0xf2005014 && *conf == 0xffffffff) {
-			fabricate_dcb_output(dcb, DCB_OUTPUT_TMDS, 1, 1, 1);
+			fabricate_dcb_output(dcb, DCB_OUTPUT_TMDS, 1, 1, DCB_OUTPUT_B);
 			return false;
 		}
 	}
@@ -1761,26 +1762,26 @@ fabricate_dcb_encoder_table(struct drm_device *dev, struct nvbios *bios)
 #ifdef __powerpc__
 	/* Apple iMac G4 NV17 */
 	if (of_machine_is_compatible("PowerMac4,5")) {
-		fabricate_dcb_output(dcb, DCB_OUTPUT_TMDS, 0, all_heads, 1);
-		fabricate_dcb_output(dcb, DCB_OUTPUT_ANALOG, 1, all_heads, 2);
+		fabricate_dcb_output(dcb, DCB_OUTPUT_TMDS, 0, all_heads, DCB_OUTPUT_B);
+		fabricate_dcb_output(dcb, DCB_OUTPUT_ANALOG, 1, all_heads, DCB_OUTPUT_C);
 		return;
 	}
 #endif
 
 	/* Make up some sane defaults */
 	fabricate_dcb_output(dcb, DCB_OUTPUT_ANALOG,
-			     bios->legacy.i2c_indices.crt, 1, 1);
+			     bios->legacy.i2c_indices.crt, 1, DCB_OUTPUT_B);
 
 	if (nv04_tv_identify(dev, bios->legacy.i2c_indices.tv) >= 0)
 		fabricate_dcb_output(dcb, DCB_OUTPUT_TV,
 				     bios->legacy.i2c_indices.tv,
-				     all_heads, 0);
+				     all_heads, DCB_OUTPUT_A);
 
 	else if (bios->tmds.output0_script_ptr ||
 		 bios->tmds.output1_script_ptr)
 		fabricate_dcb_output(dcb, DCB_OUTPUT_TMDS,
 				     bios->legacy.i2c_indices.panel,
-				     all_heads, 1);
+				     all_heads, DCB_OUTPUT_B);
 }
 
 static int
-- 
2.43.0




