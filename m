Return-Path: <stable+bounces-95005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 834899D7234
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4841C283745
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5397C18E054;
	Sun, 24 Nov 2024 13:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKLKc0m9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BCE18DF80;
	Sun, 24 Nov 2024 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455669; cv=none; b=CCTE2HhWdmAWdV/Z0a0rWR8YRo6uCP3CEaLLpMpYweeotv8+pUxDN6GEGYM2o91LaCqQfM95qb4MGbPIoeeZrm71WYecVT7rhaC8iBzezJIW4uipLXiQ8KbhS9PNfAIT4eZLhYazKoIHPmJppDjn1+xFWsEtdGVguCSCpvcqIaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455669; c=relaxed/simple;
	bh=i5n8i85CiaDqJq0okw0QSIMrqOa9fli68JfJ6AVn8xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3naWofVZB9Uo8OtlIqMK0sU9Oqs1R/X2ZgZtU43xITR7CUNeaC8rYmcogn/dy4ewjiAvseUkJGQx9DaTbaTbaVcOvvryB9WOLMPdMg+g6hn1j4Zxu3eEWf7K8RQr7WK6IJry6AvpOFUkoYxCEsWPJ5Or+s76ToaD1XvFblg1mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKLKc0m9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E074C4CED1;
	Sun, 24 Nov 2024 13:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455668;
	bh=i5n8i85CiaDqJq0okw0QSIMrqOa9fli68JfJ6AVn8xY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fKLKc0m9bmE4TXRTQ42z5JdybUzVnXCUvfCw+pi30IY8Usky4O5U3ioAfGhLxN1dt
	 z6bUvctYMwW1OKd4WVl9z+PR1J3tRgukYZwrXfvWwZBfkwsXZS1fmhwc5QYDb/Og5/
	 pD33ZlAq6vGiaYbnjgASwx+insjX34nRcYIiaN0OBZBFBJMvnVeuyjb0W84wtOw6ak
	 mIsfzx2RJ7rxWPWJvOSY7onb+u0BDPh/it6MKWXgrC6de431Y8xfiZA46wsv/O9Oy8
	 mVKxuxlPrlRyB3M5jHBMozMvKfy/rXBY0YWLGZCSt/QxQ97Jlgu52uekdpqsLGZf8x
	 asBxingfTITrw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Shekhar Chauhan <shekhar.chauhan@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 02/87] drm/xe/pciids: separate ARL and MTL PCI IDs
Date: Sun, 24 Nov 2024 08:37:40 -0500
Message-ID: <20241124134102.3344326-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Jani Nikula <jani.nikula@intel.com>

[ Upstream commit cdb56a63f7eef34e89b045fc8bcae8d326bbdb19 ]

Avoid including PCI IDs for one platform to the PCI IDs of another. It's
more clear to deal with them completely separately at the PCI ID macro
level.

Reviewed-by: Shekhar Chauhan <shekhar.chauhan@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/a30cb0da7694a8eccceba66d676ac59aa0e96176.1725443121.git.jani.nikula@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_pci.c   |  1 +
 include/drm/intel/xe_pciids.h | 13 ++++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index dde4a929f5873..0719b74443e71 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -388,6 +388,7 @@ static const struct pci_device_id pciidlist[] = {
 	XE_RPLS_IDS(INTEL_VGA_DEVICE, &adl_s_desc),
 	XE_DG1_IDS(INTEL_VGA_DEVICE, &dg1_desc),
 	XE_ATS_M_IDS(INTEL_VGA_DEVICE, &ats_m_desc),
+	XE_ARL_IDS(INTEL_VGA_DEVICE, &mtl_desc),
 	XE_DG2_IDS(INTEL_VGA_DEVICE, &dg2_desc),
 	XE_MTL_IDS(INTEL_VGA_DEVICE, &mtl_desc),
 	XE_LNL_IDS(INTEL_VGA_DEVICE, &lnl_desc),
diff --git a/include/drm/intel/xe_pciids.h b/include/drm/intel/xe_pciids.h
index 7ee7524141f10..67dad09e62bc8 100644
--- a/include/drm/intel/xe_pciids.h
+++ b/include/drm/intel/xe_pciids.h
@@ -174,16 +174,19 @@
 	XE_ATS_M150_IDS(MACRO__, ## __VA_ARGS__),\
 	XE_ATS_M75_IDS(MACRO__, ## __VA_ARGS__)
 
-/* MTL / ARL */
+/* ARL */
+#define XE_ARL_IDS(MACRO__, ...)		\
+	MACRO__(0x7D41, ## __VA_ARGS__),	\
+	MACRO__(0x7D51, ## __VA_ARGS__),        \
+	MACRO__(0x7D67, ## __VA_ARGS__),	\
+	MACRO__(0x7DD1, ## __VA_ARGS__)
+
+/* MTL */
 #define XE_MTL_IDS(MACRO__, ...)		\
 	MACRO__(0x7D40, ## __VA_ARGS__),	\
-	MACRO__(0x7D41, ## __VA_ARGS__),	\
 	MACRO__(0x7D45, ## __VA_ARGS__),	\
-	MACRO__(0x7D51, ## __VA_ARGS__),        \
 	MACRO__(0x7D55, ## __VA_ARGS__),	\
 	MACRO__(0x7D60, ## __VA_ARGS__),	\
-	MACRO__(0x7D67, ## __VA_ARGS__),	\
-	MACRO__(0x7DD1, ## __VA_ARGS__),        \
 	MACRO__(0x7DD5, ## __VA_ARGS__)
 
 #define XE_LNL_IDS(MACRO__, ...) \
-- 
2.43.0


