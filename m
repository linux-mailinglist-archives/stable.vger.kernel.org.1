Return-Path: <stable+bounces-115481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05461A343EE
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F0E016E225
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3B7155743;
	Thu, 13 Feb 2025 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QAqLTiyy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9B1149C55;
	Thu, 13 Feb 2025 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458201; cv=none; b=WuQChrViNNx5RvnRRFrBDrV4PrbvKRi5xbmm3DxMMMyUxZN/mmfko4AvdFe3l8zehrxuLmDdfBlswAtxh9dP+OXSzEC6P0c2QkvaqE5p0gMVqEQlKt/jfc5mW3UziCDH/n7NcMazGrxolmCugcnQnTToFJRgLEED9icfyqkkQSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458201; c=relaxed/simple;
	bh=WnPQ/EgIxrbDHUgegHYYz9Xlds5gHoMBOzLQ3V9fCbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJSmunDtVtwbMuBb8erMRjCTXts988oGyqreJRJqYv0NMxfMZHLswTp1Y9mZh0pz4nqc9i9UKCfzXsFYPtFNaSyyroQsNNQaHHA71DEOGbTGXguQ0UTxw3ffddjkzZ2R8kvSWOZOcnfzRq3GEWwB1swA3YDB89CehzroeWI+7aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QAqLTiyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4B6C4CEE5;
	Thu, 13 Feb 2025 14:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739458200;
	bh=WnPQ/EgIxrbDHUgegHYYz9Xlds5gHoMBOzLQ3V9fCbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QAqLTiyytvGplS+5QqLKAS1zBYo/2buE3fLTk5K+sK2QA306dkk3sVSOxd9wchZpE
	 DB5TINHJH4PV8fIR4wjhw6vBDVh+Rfb0oIHormxPs7Yw3SZ5RVK0aneVZeClLuczB/
	 lTOOFg2mZ99adwvEibNThEGERZHV8TxzriLunDOY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jai Luthra <jai.luthra@ideasonboard.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 6.12 330/422] media: i2c: ds90ub9x3: Fix extra fwnode_handle_put()
Date: Thu, 13 Feb 2025 15:27:59 +0100
Message-ID: <20250213142449.289218609@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142436.408121546@linuxfoundation.org>
References: <20250213142436.408121546@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

commit 60b45ece41c5632a3a3274115a401cb244180646 upstream.

The ub913 and ub953 drivers call fwnode_handle_put(priv->sd.fwnode) as
part of their remove process, and if the driver is removed multiple
times, eventually leads to put "overflow", possibly causing memory
corruption or crash.

The fwnode_handle_put() is a leftover from commit 905f88ccebb1 ("media:
i2c: ds90ub9x3: Fix sub-device matching"), which changed the code
related to the sd.fwnode, but missed removing these fwnode_handle_put()
calls.

Cc: stable@vger.kernel.org
Fixes: 905f88ccebb1 ("media: i2c: ds90ub9x3: Fix sub-device matching")
Reviewed-by: Jai Luthra <jai.luthra@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/ds90ub913.c |    1 -
 drivers/media/i2c/ds90ub953.c |    1 -
 2 files changed, 2 deletions(-)

--- a/drivers/media/i2c/ds90ub913.c
+++ b/drivers/media/i2c/ds90ub913.c
@@ -793,7 +793,6 @@ static void ub913_subdev_uninit(struct u
 	v4l2_async_unregister_subdev(&priv->sd);
 	ub913_v4l2_nf_unregister(priv);
 	v4l2_subdev_cleanup(&priv->sd);
-	fwnode_handle_put(priv->sd.fwnode);
 	media_entity_cleanup(&priv->sd.entity);
 }
 
--- a/drivers/media/i2c/ds90ub953.c
+++ b/drivers/media/i2c/ds90ub953.c
@@ -1291,7 +1291,6 @@ static void ub953_subdev_uninit(struct u
 	v4l2_async_unregister_subdev(&priv->sd);
 	ub953_v4l2_notifier_unregister(priv);
 	v4l2_subdev_cleanup(&priv->sd);
-	fwnode_handle_put(priv->sd.fwnode);
 	media_entity_cleanup(&priv->sd.entity);
 }
 



