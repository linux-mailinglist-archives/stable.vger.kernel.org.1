Return-Path: <stable+bounces-49204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAB98FEC4F
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014B81F29991
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86521B0106;
	Thu,  6 Jun 2024 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NILJGsN6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7683D19AD8C;
	Thu,  6 Jun 2024 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683352; cv=none; b=FkDEYnfL9uY0bHkG13CB7cMhx9edxio2LBL6Jxfa1VzX/KKc4vOsLp4TwcPZU3N9vsraC48sy5jrpTsqKRoLZeoKaJ5YriOUgM2TzMvUamma9gO7r0Q2sCzZeMdITGxHmi/iOZdBU/bje5/Q5LZz0Z1rS7IDLxuxaPPKdi6TXbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683352; c=relaxed/simple;
	bh=KY1bkwIz5fc0eT08gFmEjfixGnH+OsFa1AXdgaRDCPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ui3D3xWcASRxeF1zVWvT/6GI/kb0g+P1M+T02U+6MiYh/T8hn0cIasqHPPQIXdkORlJdVKUV3shIT2KDcmgP18+dtfYGBI9worvK/uYssL70uLfwS5cOn0wGrvY+/7xI9e1X+g1PIuCOPur66QqioEveil0EE5p1xOKMbUw3DSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NILJGsN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F9EC2BD10;
	Thu,  6 Jun 2024 14:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683352;
	bh=KY1bkwIz5fc0eT08gFmEjfixGnH+OsFa1AXdgaRDCPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NILJGsN6X57Q4uavFsTyDZPz01pYEx2qIhiih3QgNE4EanoJjtRYsUh1fgw4PU60Z
	 VQgTHrR0v8UTgn0f5rUSippn+5oD/rYPfkvYAvsbCAFpI3nxcmuBHGqD3OFdCC0Dqa
	 c+aHq50+QOsXh4FjTjKP1n9Z6DC3NY5bMUB2f6qw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 233/473] drm/mipi-dsi: use correct return type for the DSC functions
Date: Thu,  6 Jun 2024 16:02:42 +0200
Message-ID: <20240606131707.543599402@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit de1c705c50326acaceaf1f02bc5bf6f267c572bd ]

The functions mipi_dsi_compression_mode() and
mipi_dsi_picture_parameter_set() return 0-or-error rather than a buffer
size. Follow example of other similar MIPI DSI functions and use int
return type instead of size_t.

Fixes: f4dea1aaa9a1 ("drm/dsi: add helpers for DSI compression mode and PPS packets")
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240408-lg-sw43408-panel-v5-2-4e092da22991@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 6 +++---
 include/drm/drm_mipi_dsi.h     | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index ef7ec68867df0..112f213cc8d9b 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -653,7 +653,7 @@ EXPORT_SYMBOL(mipi_dsi_set_maximum_return_packet_size);
  *
  * Return: 0 on success or a negative error code on failure.
  */
-ssize_t mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable)
+int mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable)
 {
 	/* Note: Needs updating for non-default PPS or algorithm */
 	u8 tx[2] = { enable << 0, 0 };
@@ -678,8 +678,8 @@ EXPORT_SYMBOL(mipi_dsi_compression_mode);
  *
  * Return: 0 on success or a negative error code on failure.
  */
-ssize_t mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
-				       const struct drm_dsc_picture_parameter_set *pps)
+int mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
+				   const struct drm_dsc_picture_parameter_set *pps)
 {
 	struct mipi_dsi_msg msg = {
 		.channel = dsi->channel,
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 31171914990a3..66a7e01c62608 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -244,9 +244,9 @@ int mipi_dsi_shutdown_peripheral(struct mipi_dsi_device *dsi);
 int mipi_dsi_turn_on_peripheral(struct mipi_dsi_device *dsi);
 int mipi_dsi_set_maximum_return_packet_size(struct mipi_dsi_device *dsi,
 					    u16 value);
-ssize_t mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable);
-ssize_t mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
-				       const struct drm_dsc_picture_parameter_set *pps);
+int mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable);
+int mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
+				   const struct drm_dsc_picture_parameter_set *pps);
 
 ssize_t mipi_dsi_generic_write(struct mipi_dsi_device *dsi, const void *payload,
 			       size_t size);
-- 
2.43.0




