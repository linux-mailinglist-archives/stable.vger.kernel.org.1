Return-Path: <stable+bounces-95004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98F29D7232
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC502834FE
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1BB187355;
	Sun, 24 Nov 2024 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHxT2Skk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7604A18787A;
	Sun, 24 Nov 2024 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455666; cv=none; b=laGddptAIUY5afqzli5GTgNuN/LEwOc8RgXW3ZIIDqQf3O6jBS0GcYYFn/U9lNErbl00JkjZlCnKmma0u47IXESpd3BJQe7TIJbzxcD5Eo7xm9hO8jOtu6hpErLMWuGdxcrCAU0PP08ZCbCpPF54KCDk9XsW/Ec96ONYg+a1uXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455666; c=relaxed/simple;
	bh=cIKtMrcV2rEjOhLuX0Jd/uzPUs7Pfub37mdd5xM0grI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tPi3TO5xdXozfs/WO4E3XbNpYkjXCLhWH6EsIAK+EWYie26LAZqnUsmI6QC91WDF/Wrr/W46ygFgXnE6bcF79BEfERAKFz7l/Fle+4cDm6bMwU4bBdmiTwOJURESRdgLTrUyNg1hW5GBR3DvkLwvlBMExVCCXNFO07HG0XnnZhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHxT2Skk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA686C4CECC;
	Sun, 24 Nov 2024 13:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455666;
	bh=cIKtMrcV2rEjOhLuX0Jd/uzPUs7Pfub37mdd5xM0grI=;
	h=From:To:Cc:Subject:Date:From;
	b=VHxT2SkkbthM1ziVgJI4oUF9IkjsELTTJQmC92Rx7R3d9pe8nrq5/eJKH/FC01xDn
	 3FAnYLjL4IyK6p+As5rF5f2+dHTQv3bIOZQ5jLQZjFbhYkt5rKbE1YHxFxOM3BrBXv
	 sXQybXMAmxbBJfyIsHSAv+lOqpOPyGhzMZZcuByLxLxOKc7BspEJLsNw2ofLl4IIbG
	 dicL8MsWfuVlTe0xU92dzhtSMrsh8RaMLMYYh+Mb5OZRykmMmLS+vY5jW4FOWuU05P
	 cozW1SzPdZVDSBmby3lLaJ1luhROcHKDW5V2t1EEdEDWPYjd8DMdoUb27C/8vOGfcp
	 zwicVApleP+Ng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Sai Teja Pottumuttu <sai.teja.pottumuttu@intel.com>,
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
Subject: [PATCH AUTOSEL 6.11 01/87] drm/xe/pciids: separate RPL-U and RPL-P PCI IDs
Date: Sun, 24 Nov 2024 08:37:39 -0500
Message-ID: <20241124134102.3344326-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
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

[ Upstream commit d454902a690db47f1880f963514bbf0fc7a129a8 ]

Avoid including PCI IDs for one platform to the PCI IDs of another. It's
more clear to deal with them completely separately at the PCI ID macro
level.

Reviewed-by: Sai Teja Pottumuttu <sai.teja.pottumuttu@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/4868d36fbfa8c38ea2d490bca82cf6370b8d65dd.1725443121.git.jani.nikula@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_pci.c   | 1 +
 include/drm/intel/xe_pciids.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index 5929ac61dbe0a..dde4a929f5873 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -383,6 +383,7 @@ static const struct pci_device_id pciidlist[] = {
 	XE_ADLS_IDS(INTEL_VGA_DEVICE, &adl_s_desc),
 	XE_ADLP_IDS(INTEL_VGA_DEVICE, &adl_p_desc),
 	XE_ADLN_IDS(INTEL_VGA_DEVICE, &adl_n_desc),
+	XE_RPLU_IDS(INTEL_VGA_DEVICE, &adl_p_desc),
 	XE_RPLP_IDS(INTEL_VGA_DEVICE, &adl_p_desc),
 	XE_RPLS_IDS(INTEL_VGA_DEVICE, &adl_s_desc),
 	XE_DG1_IDS(INTEL_VGA_DEVICE, &dg1_desc),
diff --git a/include/drm/intel/xe_pciids.h b/include/drm/intel/xe_pciids.h
index 644872a35c352..7ee7524141f10 100644
--- a/include/drm/intel/xe_pciids.h
+++ b/include/drm/intel/xe_pciids.h
@@ -120,7 +120,6 @@
 
 /* RPL-P */
 #define XE_RPLP_IDS(MACRO__, ...)		\
-	XE_RPLU_IDS(MACRO__, ## __VA_ARGS__),	\
 	MACRO__(0xA720, ## __VA_ARGS__),	\
 	MACRO__(0xA7A0, ## __VA_ARGS__),	\
 	MACRO__(0xA7A8, ## __VA_ARGS__),	\
-- 
2.43.0


