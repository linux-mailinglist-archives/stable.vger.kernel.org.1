Return-Path: <stable+bounces-147361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE08AC5755
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 238627A5F7B
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC5927CCF0;
	Tue, 27 May 2025 17:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zHJTWcZa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0F72110E;
	Tue, 27 May 2025 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367105; cv=none; b=Wxw47JDVjHdKJinFbjlG87BF5P0k29RDZKP7NfVnbVdNiGSVHSk1T8ox9eM2uKG/kaDm2P760PkseiajOqZ4BSov0PihkKnZh9hz/ochYmDUbRqVQ+wEMAWU4DuRs/2ktat/bYfOorvGoJC+5u8V71ehfjz4FE9BMH0JA3oDfOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367105; c=relaxed/simple;
	bh=qFcFZORoL76IAb1eorXlfOAp+XriqhAdNYF4YCZqPNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Azaq+ljmEP1N+XVAIV+tV0I/PbscEmgck90KehD+Xb974FLxaAaOYz3J5q77CVYiFhPCLII4y39KGRR8c+/a/SpJI+DmxP10EoplE1Soy3QqQukFhbTGyor816Lbnxf+ioutpzNcbZ/LTxqBhlPNpOBKL/q9o/1/BbwjSeW2d4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zHJTWcZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79AC9C4CEE9;
	Tue, 27 May 2025 17:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748367103;
	bh=qFcFZORoL76IAb1eorXlfOAp+XriqhAdNYF4YCZqPNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zHJTWcZanSCu+CoqqZc4U8DHMASJ6TKWFPNBQZVtGZ+ZOoe+156/BZzjI2e0IAeti
	 KgIPJPShkuHzKr/BUHeXltQkNbmZpxt95okRL7KIu1GTKHcRLvBk15BVpbrZkK5qIb
	 LlsuncS6XEPLFd6Gir1KjnykM1YlcvsQK509RFqc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matt Roper <matthew.d.roper@intel.com>,
	Gustavo Sousa <gustavo.sousa@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 278/783] drm/xe: Disambiguate GMDID-based IP names
Date: Tue, 27 May 2025 18:21:15 +0200
Message-ID: <20250527162524.404030750@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo Sousa <gustavo.sousa@intel.com>

[ Upstream commit 0695c746f55c875f4cf20bab92533a800a0fe4d6 ]

The name of an IP is a function of its version. As such, given an IP
version, it should be clear to identify the name of that IP release.

With the current code, we keep that mapping clear for pre-GMDID IPs, but
ambiguous for GMDID-based ones. That causes two types of inconveniences:

 1. The end user, who might not have all the necessary mapping at hand,
    might be confused when seeing different possible IP names in the
    dmesg log.

 2. It makes a developer who is not familiar with the "IP version" to
    "Release name" need to resort to looking at the specs to understand
    see what version maps to what. While the specs should be the
    authority on the mapping, we should make our lives easier by
    reflecting that mapping in the source code.

Thus, since the IP name is tied to the version, let's  remove the
ambiguity by using a "name" field in struct gmdid_map instead of
accumulating names in the descriptor instances.

This does result in the code having IP name being defined in
different structs (gmdid_map, xe_graphics_desc, xe_media_desc), but that
will be resolved in upcoming changes.

A side-effect of this change is that media_xe2 exactly matches
media_xelpmp now, so we just re-use the latter.

v2:
  - Drop media_xe2 and re-use media_xelpmp. (Matt)

Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Signed-off-by: Gustavo Sousa <gustavo.sousa@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250221-xe-unify-ip-descriptors-v2-2-5bc0c6d0c13f@intel.com
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_pci.c       | 36 +++++++++++--------------------
 drivers/gpu/drm/xe/xe_pci_types.h |  1 +
 2 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index 39be74848e447..9b8813a518d72 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -150,7 +150,6 @@ static const struct xe_graphics_desc graphics_xehpc = {
 };
 
 static const struct xe_graphics_desc graphics_xelpg = {
-	.name = "Xe_LPG",
 	.hw_engine_mask =
 		BIT(XE_HW_ENGINE_RCS0) | BIT(XE_HW_ENGINE_BCS0) |
 		BIT(XE_HW_ENGINE_CCS0),
@@ -174,8 +173,6 @@ static const struct xe_graphics_desc graphics_xelpg = {
 		GENMASK(XE_HW_ENGINE_CCS3, XE_HW_ENGINE_CCS0)
 
 static const struct xe_graphics_desc graphics_xe2 = {
-	.name = "Xe2_LPG / Xe2_HPG / Xe3_LPG",
-
 	XE2_GFX_FEATURES,
 };
 
@@ -200,15 +197,6 @@ static const struct xe_media_desc media_xehpm = {
 };
 
 static const struct xe_media_desc media_xelpmp = {
-	.name = "Xe_LPM+",
-	.hw_engine_mask =
-		GENMASK(XE_HW_ENGINE_VCS7, XE_HW_ENGINE_VCS0) |
-		GENMASK(XE_HW_ENGINE_VECS3, XE_HW_ENGINE_VECS0) |
-		BIT(XE_HW_ENGINE_GSCCS0)
-};
-
-static const struct xe_media_desc media_xe2 = {
-	.name = "Xe2_LPM / Xe2_HPM / Xe3_LPM",
 	.hw_engine_mask =
 		GENMASK(XE_HW_ENGINE_VCS7, XE_HW_ENGINE_VCS0) |
 		GENMASK(XE_HW_ENGINE_VECS3, XE_HW_ENGINE_VECS0) |
@@ -357,21 +345,21 @@ __diag_pop();
 
 /* Map of GMD_ID values to graphics IP */
 static const struct gmdid_map graphics_ip_map[] = {
-	{ 1270, &graphics_xelpg },
-	{ 1271, &graphics_xelpg },
-	{ 1274, &graphics_xelpg },	/* Xe_LPG+ */
-	{ 2001, &graphics_xe2 },
-	{ 2004, &graphics_xe2 },
-	{ 3000, &graphics_xe2 },
-	{ 3001, &graphics_xe2 },
+	{ 1270, "Xe_LPG", &graphics_xelpg },
+	{ 1271, "Xe_LPG", &graphics_xelpg },
+	{ 1274, "Xe_LPG+", &graphics_xelpg },
+	{ 2001, "Xe2_HPG", &graphics_xe2 },
+	{ 2004, "Xe2_LPG", &graphics_xe2 },
+	{ 3000, "Xe3_LPG", &graphics_xe2 },
+	{ 3001, "Xe3_LPG", &graphics_xe2 },
 };
 
 /* Map of GMD_ID values to media IP */
 static const struct gmdid_map media_ip_map[] = {
-	{ 1300, &media_xelpmp },
-	{ 1301, &media_xe2 },
-	{ 2000, &media_xe2 },
-	{ 3000, &media_xe2 },
+	{ 1300, "Xe_LPM+", &media_xelpmp },
+	{ 1301, "Xe2_HPM", &media_xelpmp },
+	{ 2000, "Xe2_LPM", &media_xelpmp },
+	{ 3000, "Xe3_LPM", &media_xelpmp },
 };
 
 /*
@@ -566,6 +554,7 @@ static void handle_gmdid(struct xe_device *xe,
 	for (int i = 0; i < ARRAY_SIZE(graphics_ip_map); i++) {
 		if (ver == graphics_ip_map[i].ver) {
 			xe->info.graphics_verx100 = ver;
+			xe->info.graphics_name = graphics_ip_map[i].name;
 			*graphics = graphics_ip_map[i].ip;
 
 			break;
@@ -586,6 +575,7 @@ static void handle_gmdid(struct xe_device *xe,
 	for (int i = 0; i < ARRAY_SIZE(media_ip_map); i++) {
 		if (ver == media_ip_map[i].ver) {
 			xe->info.media_verx100 = ver;
+			xe->info.media_name = media_ip_map[i].name;
 			*media = media_ip_map[i].ip;
 
 			break;
diff --git a/drivers/gpu/drm/xe/xe_pci_types.h b/drivers/gpu/drm/xe/xe_pci_types.h
index 79b0f80376a4d..665b4447b2ebc 100644
--- a/drivers/gpu/drm/xe/xe_pci_types.h
+++ b/drivers/gpu/drm/xe/xe_pci_types.h
@@ -44,6 +44,7 @@ struct xe_media_desc {
 
 struct gmdid_map {
 	unsigned int ver;
+	const char *name;
 	const void *ip;
 };
 
-- 
2.39.5




