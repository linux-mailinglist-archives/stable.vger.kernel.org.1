Return-Path: <stable+bounces-162863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3039B06050
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 16:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0F675A1050
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 14:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA6D2EE28D;
	Tue, 15 Jul 2025 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IQ1h0Zgq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF4E2E92DA;
	Tue, 15 Jul 2025 13:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587674; cv=none; b=N38tkwIawaTFh2n4XsDQMNZXIQ2U8LChHaIHts8iO1QHm/oslouvIO9yqM8V4GpkWj2iqb9VE/IaZdLhfnJS2h9x3vN/Lh1t4tKdPaQk+6JCow2NkY5GzB7gcyq2QdOh4H0N9W8lrsPJKfZOPnoAkJTAwRgU5EgX/DI8Lv2YTpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587674; c=relaxed/simple;
	bh=QPI/u55P1gfXwX6oN+uiu/M0YQGRCF7hFiJz9nSNZco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SF6i1H2Gy1HwaH2RxuEA/HYg6UNt1gQx5sIyNl/zxAdmG/pxPdBM9E9fDID57u850MgSStNim6FVCzfafOsI5MJlKkCJVEe9c43ZPgeXKnQ1tVdwpxdahlQCZklqqxBQdbYV+PzF1VJNy7LCdZK6BYHtUnS33/MptAtUeyM59h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IQ1h0Zgq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60466C4CEE3;
	Tue, 15 Jul 2025 13:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752587673;
	bh=QPI/u55P1gfXwX6oN+uiu/M0YQGRCF7hFiJz9nSNZco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IQ1h0ZgqN9hj9VCuA6CtnheC/fgcDe55lKPI2KogTxS3bc0SicmrDAtGYw/lqUz07
	 kvYCgMcjS+t2pggUaoRQ2Z/56yhIxoSNTxK3ZKXdOS4qpQnusQvE4wkAvkp/IbPL0Z
	 KuKYXeGwAF9G7pK9KlR4+d3HNuDXqmQBDLEzzjxs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Aradhya Bhatia <aradhya.bhatia@linux.dev>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 5.10 069/208] drm/bridge: cdns-dsi: Check return value when getting default PHY config
Date: Tue, 15 Jul 2025 15:12:58 +0200
Message-ID: <20250715130813.716396554@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130810.830580412@linuxfoundation.org>
References: <20250715130810.830580412@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aradhya Bhatia <a-bhatia1@ti.com>

commit c6a7ef0d4856b9629df390e9935d7fd67fe39f81 upstream.

Check for the return value of the phy_mipi_dphy_get_default_config()
call, and in case of an error, return back the same.

Fixes: fced5a364dee ("drm/bridge: cdns: Convert to phy framework")
Cc: stable@vger.kernel.org
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
Signed-off-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
Link: https://lore.kernel.org/r/20250329113925.68204-5-aradhya.bhatia@linux.dev
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/bridge/cdns-dsi.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/bridge/cdns-dsi.c
+++ b/drivers/gpu/drm/bridge/cdns-dsi.c
@@ -615,9 +615,11 @@ static int cdns_dsi_check_conf(struct cd
 	if (ret)
 		return ret;
 
-	phy_mipi_dphy_get_default_config(mode_clock * 1000,
-					 mipi_dsi_pixel_format_to_bpp(output->dev->format),
-					 nlanes, phy_cfg);
+	ret = phy_mipi_dphy_get_default_config(mode_clock * 1000,
+					       mipi_dsi_pixel_format_to_bpp(output->dev->format),
+					       nlanes, phy_cfg);
+	if (ret)
+		return ret;
 
 	ret = cdns_dsi_adjust_phy_config(dsi, dsi_cfg, phy_cfg, mode, mode_valid_check);
 	if (ret)



