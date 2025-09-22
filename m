Return-Path: <stable+bounces-181376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDEAB93143
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 21:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99E797AE8A1
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 19:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04E318C2C;
	Mon, 22 Sep 2025 19:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MccJFLjz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E63922CBC6;
	Mon, 22 Sep 2025 19:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570388; cv=none; b=a+DY4f/o6ZnFIxUhtldaE0yRGeQsFh6SUGDE05cw+68VZyH5ul/HfuFaxm6vAeesuFezk3RiBiTsFLPCxK2obYB+NicFfvKWe1DeONGNxQXwCSH2BVZZuF6ExQfkoYXQXsFjxK5INPVvS1AwuK6kFdducRdaLsQ0BciXR7fQo6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570388; c=relaxed/simple;
	bh=ucR92+4ccRH+ltF3PmFO8h+4VuUVFxVDwbH6Ryw4JNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pkFYz30mZ/obCjNhPltMbuYgBS06cwXDCP1HGvIvTzWL7UvIfACkQGSFG4+tUx8lYCGxOuSPLqS/1KJCAL3n091lnrDwj0MnU8MAEnSJZbUjWhRYgP13x5eosnaJPSirdHhV47EpVhi5A/x/0UaJ8ueHgvvBUhRLfVmF/cvhaxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MccJFLjz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9B4C4CEF0;
	Mon, 22 Sep 2025 19:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758570387;
	bh=ucR92+4ccRH+ltF3PmFO8h+4VuUVFxVDwbH6Ryw4JNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MccJFLjzrvrxtjBVZqVA4va9bllPcX5Vo0INdZWHRcM4j/ZUuxd2fsnmOdgSvpiaT
	 AKhT/RBA5QrwqVKxTqtccGNRPjaY/Ktxpm34b6YaUcAzSzeiF6nbg+aXgm8W3/95nW
	 NtKKwbeNxBstxjA51ljj25XlEipBpYewJ6Rsfhpw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 117/149] drm/xe/tile: Release kobject for the failure path
Date: Mon, 22 Sep 2025 21:30:17 +0200
Message-ID: <20250922192415.826285000@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
References: <20250922192412.885919229@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuicheng Lin <shuicheng.lin@intel.com>

[ Upstream commit 013e484dbd687a9174acf8f4450217bdb86ad788 ]

Call kobject_put() for the failure path to release the kobject

v2: remove extra newline. (Matt)

Fixes: e3d0839aa501 ("drm/xe/tile: Abort driver load for sysfs creation failure")
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
Link: https://lore.kernel.org/r/20250819153950.2973344-2-shuicheng.lin@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
(cherry picked from commit b98775bca99511cc22ab459a2de646cd2fa7241f)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_tile_sysfs.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_tile_sysfs.c b/drivers/gpu/drm/xe/xe_tile_sysfs.c
index b804234a65516..9e1236a9ec673 100644
--- a/drivers/gpu/drm/xe/xe_tile_sysfs.c
+++ b/drivers/gpu/drm/xe/xe_tile_sysfs.c
@@ -44,16 +44,18 @@ int xe_tile_sysfs_init(struct xe_tile *tile)
 	kt->tile = tile;
 
 	err = kobject_add(&kt->base, &dev->kobj, "tile%d", tile->id);
-	if (err) {
-		kobject_put(&kt->base);
-		return err;
-	}
+	if (err)
+		goto err_object;
 
 	tile->sysfs = &kt->base;
 
 	err = xe_vram_freq_sysfs_init(tile);
 	if (err)
-		return err;
+		goto err_object;
 
 	return devm_add_action_or_reset(xe->drm.dev, tile_sysfs_fini, tile);
+
+err_object:
+	kobject_put(&kt->base);
+	return err;
 }
-- 
2.51.0




