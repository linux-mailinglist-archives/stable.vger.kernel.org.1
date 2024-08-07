Return-Path: <stable+bounces-65637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6C194AB47
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 17:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F34DFB25BE4
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 15:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5901A84DF5;
	Wed,  7 Aug 2024 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a2+EXITr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116B174055;
	Wed,  7 Aug 2024 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043003; cv=none; b=H6iYJcJnWsmHtxjeab3d4chD4snu0E9E8Vs+M2NX+jAQ5UrcqDWKWiUxLXcoSGOM9H6Jr/mVS1OY9DNdHxsqCUJQ++W36/BWNnV0nJPRoDU4LTRaavOdXGSQUeHxUFrsAcOBhMGGyw1QtMvaF+LbNolor9rfxjQD09whGMUrlVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043003; c=relaxed/simple;
	bh=SL92PvVJUAXhxS045EPAynU+rGud/Bc9a1HGuNULb8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gy7EANb0jGNct+odbDSeJdfayhXtzs1yTH3bpJMYqsY2rx8t6M2DDrJ4gDgyYHiE/g+Hp6YKfRk+tceczJ78639qXM2fjcN+sCwPp/QKwVNT9DmR5WiJr85ewz2RmiE9gX8RnDxCRWELCRnJbz23LgwgAINAdYZJwLObwYA/b8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a2+EXITr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539AAC32781;
	Wed,  7 Aug 2024 15:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723043002;
	bh=SL92PvVJUAXhxS045EPAynU+rGud/Bc9a1HGuNULb8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a2+EXITr/ZxZZKW4Xd6bhupoA3JUegnfGC+vkAeMlfxS/1HaSMnNa2XsMnDTiPa8C
	 eGLUNgfGCLywMXc7KcxSGpGt8Jjb52g71Q6/t7ayzJIZnEH4WLrYMORjzD5jwtnxVn
	 uab5m+pTN7PkxJCY8BM+tIhm6OS23yazD2HY/+0I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 054/123] ALSA: hda: Conditionally use snooping for AMD HDMI
Date: Wed,  7 Aug 2024 16:59:33 +0200
Message-ID: <20240807150022.559953819@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807150020.790615758@linuxfoundation.org>
References: <20240807150020.790615758@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 478689b5990deb626a0b3f1ebf165979914d6be4 ]

The recent regression report revealed that the use of WC pages for AMD
HDMI device together with AMD IOMMU leads to unexpected truncation or
noises.  The issue seems triggered by the change in the kernel core
memory allocation that enables IOMMU driver to use always S/G
buffers.  Meanwhile, the use of WC pages has been a workaround for the
similar issue with standard pages in the past.  So, now we need to
apply the workaround conditionally, namely, only when IOMMU isn't in
place.

This patch modifies the workaround code to check the DMA ops at first
and apply the snoop-off only when needed.

Fixes: f5ff79fddf0e ("dma-mapping: remove CONFIG_DMA_REMAP")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219087
Link: https://patch.msgid.link/20240731170521.31714-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_controller.h |  2 +-
 sound/pci/hda/hda_intel.c      | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index c2d0109866e62..68c883f202ca5 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -28,7 +28,7 @@
 #else
 #define AZX_DCAPS_I915_COMPONENT 0		/* NOP */
 #endif
-/* 14 unused */
+#define AZX_DCAPS_AMD_ALLOC_FIX	(1 << 14)	/* AMD allocation workaround */
 #define AZX_DCAPS_CTX_WORKAROUND (1 << 15)	/* X-Fi workaround */
 #define AZX_DCAPS_POSFIX_LPIB	(1 << 16)	/* Use LPIB as default */
 #define AZX_DCAPS_AMD_WORKAROUND (1 << 17)	/* AMD-specific workaround */
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 3500108f6ba37..87203b819dd47 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -40,6 +40,7 @@
 
 #ifdef CONFIG_X86
 /* for snoop control */
+#include <linux/dma-map-ops.h>
 #include <asm/set_memory.h>
 #include <asm/cpufeature.h>
 #endif
@@ -306,7 +307,7 @@ enum {
 
 /* quirks for ATI HDMI with snoop off */
 #define AZX_DCAPS_PRESET_ATI_HDMI_NS \
-	(AZX_DCAPS_PRESET_ATI_HDMI | AZX_DCAPS_SNOOP_OFF)
+	(AZX_DCAPS_PRESET_ATI_HDMI | AZX_DCAPS_AMD_ALLOC_FIX)
 
 /* quirks for AMD SB */
 #define AZX_DCAPS_PRESET_AMD_SB \
@@ -1702,6 +1703,13 @@ static void azx_check_snoop_available(struct azx *chip)
 	if (chip->driver_caps & AZX_DCAPS_SNOOP_OFF)
 		snoop = false;
 
+#ifdef CONFIG_X86
+	/* check the presence of DMA ops (i.e. IOMMU), disable snoop conditionally */
+	if ((chip->driver_caps & AZX_DCAPS_AMD_ALLOC_FIX) &&
+	    !get_dma_ops(chip->card->dev))
+		snoop = false;
+#endif
+
 	chip->snoop = snoop;
 	if (!snoop) {
 		dev_info(chip->card->dev, "Force to non-snoop mode\n");
-- 
2.43.0




