Return-Path: <stable+bounces-161746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF3AB02C5F
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 20:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A401AA3DE6
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 18:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FFB28B401;
	Sat, 12 Jul 2025 18:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJnwI31I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10A228A721;
	Sat, 12 Jul 2025 18:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752344264; cv=none; b=njunf4JzioKNuzdlfyrW/Xhuxj9106kUxt63HjPG91wsSSCMWuOrwyS11UGgT+DDHvvg47YalO6W4f810lqPuFy1kQUa9Utx6g/HR58vgRdj5NfwXaemMXxDtRYWJnywnUOsPD95tYhi7LWc1Hcak0Au84MkxbXQA8GgvFI2jeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752344264; c=relaxed/simple;
	bh=iz+txLZgt8thaEXgI+AQiZRzOLWLiZIRkBupCC4u23k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2C0tRi9ifLhxP53EoQtv+ktwmnj8uffvl1UlGbH+ZL+sdqqGf3ZYAcCyH8mp47B0zwR9QZPqVACeO81mjlDKFy6hqcz3yesHjiL+BwgwLMV1QrCoXgjyn/1b4KCMWbciRO2o69x+izV3uYNX3ITSSRzGWs+yolZHyi0bLfcONU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJnwI31I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A7CC4CEF0;
	Sat, 12 Jul 2025 18:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752344263;
	bh=iz+txLZgt8thaEXgI+AQiZRzOLWLiZIRkBupCC4u23k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OJnwI31IMfKFYmkA4nk0PHDxxptao5byB3aasXe5Vscez2wFBNQGHO2vPnwBd3ahL
	 +btYczBvLm4Vail33UUCmX4fofQ4kPMiTpqyvMxmtqur4DWg4VBOkRTmmkhtixm4Nq
	 Af+/uEtgRwuLPI636IXT5rFnIQ6E6UD501iZd07GlKxfQ0NocgVCHWxxy/UpoZrNaX
	 51Fj87QdUXJNjV9PCItt+3S3flMl84EGGTO7d6Iph1EPTtSvGj7zAqotdPAzqm2rHX
	 ieDxFD3UKASDoSjVHz6NRiFJWqhOKiLQNUWv5eQngJ2SIr+sbhp9g/igxZUOmJAz69
	 JvYW8iKStrlyQ==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Steffen=20B=C3=A4tz?= <steffen@innosonix.de>,
	stable@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 2/2] nvmem: imx-ocotp: fix MAC address byte length
Date: Sat, 12 Jul 2025 19:17:27 +0100
Message-ID: <20250712181729.6495-3-srini@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250712181729.6495-1-srini@kernel.org>
References: <20250712181729.6495-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Steffen Bätz <steffen@innosonix.de>

The commit "13bcd440f2ff nvmem: core: verify cell's raw_len" caused an
extension of the "mac-address" cell from 6 to 8 bytes due to word_size
of 4 bytes. This led to a required byte swap of the full buffer length,
which caused truncation of the mac-address when read.

Previously, the mac-address was incorrectly truncated from
70:B3:D5:14:E9:0E to 00:00:70:B3:D5:14.

Fix the issue by swapping only the first 6 bytes to correctly pass the
mac-address to the upper layers.

Fixes: 13bcd440f2ff ("nvmem: core: verify cell's raw_len")
Cc: stable@vger.kernel.org
Signed-off-by: Steffen Bätz <steffen@innosonix.de>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/nvmem/imx-ocotp-ele.c | 5 ++++-
 drivers/nvmem/imx-ocotp.c     | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp-ele.c b/drivers/nvmem/imx-ocotp-ele.c
index ca6dd71d8a2e..7807ec0e2d18 100644
--- a/drivers/nvmem/imx-ocotp-ele.c
+++ b/drivers/nvmem/imx-ocotp-ele.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/if_ether.h>	/* ETH_ALEN */
 
 enum fuse_type {
 	FUSE_FSB = BIT(0),
@@ -118,9 +119,11 @@ static int imx_ocotp_cell_pp(void *context, const char *id, int index,
 	int i;
 
 	/* Deal with some post processing of nvmem cell data */
-	if (id && !strcmp(id, "mac-address"))
+	if (id && !strcmp(id, "mac-address")) {
+		bytes = min(bytes, ETH_ALEN);
 		for (i = 0; i < bytes / 2; i++)
 			swap(buf[i], buf[bytes - i - 1]);
+	}
 
 	return 0;
 }
diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 79dd4fda0329..7bf7656d4f96 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/if_ether.h>	/* ETH_ALEN */
 
 #define IMX_OCOTP_OFFSET_B0W0		0x400 /* Offset from base address of the
 					       * OTP Bank0 Word0
@@ -227,9 +228,11 @@ static int imx_ocotp_cell_pp(void *context, const char *id, int index,
 	int i;
 
 	/* Deal with some post processing of nvmem cell data */
-	if (id && !strcmp(id, "mac-address"))
+	if (id && !strcmp(id, "mac-address")) {
+		bytes = min(bytes, ETH_ALEN);
 		for (i = 0; i < bytes / 2; i++)
 			swap(buf[i], buf[bytes - i - 1]);
+	}
 
 	return 0;
 }
-- 
2.43.0


