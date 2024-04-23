Return-Path: <stable+bounces-40657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B01B18AE681
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 14:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8241F21255
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 12:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398C812C474;
	Tue, 23 Apr 2024 12:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rFqHE8e6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEB812BF36
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 12:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876103; cv=none; b=F7AsEOf2cK/m5opU+IeJjKQ/jN9XB0BxJxUdMmRlUGNb7/DtgENnU5xcly4uKfzt5CMFYmYJrXY/gMOG5K7HRabcTc3oybGYpG6ymUVVnedN/Z2gNCavpJFnGK3feHwQWyse/hDXDbUr8NhWw0OkKLzM4u59B8pQCyKX6bp79R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876103; c=relaxed/simple;
	bh=CeSNmGY9Ogh5bnim8CPa7pFpYQ3+WLgHXYdmWDIz15M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OCudjzz0hy39tUb88zsSfSww6QmDXsr6Poc0WW+o3J6HgM4yQTX5f07qDGEY3IJiAdFExgpxuN9qEYdS7xf3mpX4UKnsuX+Rl6i5pWTjpLKn6IpYiI3q1s3VIFsCukevYs2NZa74TXt/Q6Rj360CrQWBBHTVQJvReVMMz2Qx8Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rFqHE8e6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EACC116B1;
	Tue, 23 Apr 2024 12:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713876102;
	bh=CeSNmGY9Ogh5bnim8CPa7pFpYQ3+WLgHXYdmWDIz15M=;
	h=Subject:To:Cc:From:Date:From;
	b=rFqHE8e696XaSpH6U7lm1tWtEOCK4+wU2gmwJGUG+zLmUKviYtkML07Kg770hr/y8
	 AmG3Hj6XtJ4YnTc7fOzLpq51NmnWvZyjH+4nFmy1SxfCS4U8Ba874dD/QF8s9dcMT3
	 O+5Jli/3ARBCkyNYmPo1YmKmrNuwWFlFOnPKEYMc=
Subject: FAILED: patch "[PATCH] Revert "drm/amd/display: fix USB-C flag update after enc10" failed to apply to 6.8-stable tree
To: alexander.deucher@amd.com,ahmed.ahmed@amd.com,charlene.liu@amd.com,chiahsuan.chung@amd.com,hamza.mahfooz@amd.com,harry.wentland@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Apr 2024 05:41:32 -0700
Message-ID: <2024042332-depose-frenzy-e027@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.8-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.8.y
git checkout FETCH_HEAD
git cherry-pick -x 91f10a3d21f2313485178d49efef8a3ba02bd8c7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042332-depose-frenzy-e027@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..

Possible dependencies:

91f10a3d21f2 ("Revert "drm/amd/display: fix USB-C flag update after enc10 feature init"")
7d1e9d0369e4 ("drm/amd/display: Check DP Alt mode DPCS state via DMUB")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 91f10a3d21f2313485178d49efef8a3ba02bd8c7 Mon Sep 17 00:00:00 2001
From: Alex Deucher <alexander.deucher@amd.com>
Date: Fri, 29 Mar 2024 18:03:03 -0400
Subject: [PATCH] Revert "drm/amd/display: fix USB-C flag update after enc10
 feature init"

This reverts commit b5abd7f983e14054593dc91d6df2aa5f8cc67652.

This change breaks DSC on 4k monitors at 144Hz over USB-C.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3254
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Muhammad Ahmed <ahmed.ahmed@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Charlene Liu <charlene.liu@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
index e224a028d68a..8a0460e86309 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
@@ -248,14 +248,12 @@ void dcn32_link_encoder_construct(
 	enc10->base.hpd_source = init_data->hpd_source;
 	enc10->base.connector = init_data->connector;
 
+	if (enc10->base.connector.id == CONNECTOR_ID_USBC)
+		enc10->base.features.flags.bits.DP_IS_USB_C = 1;
+
 	enc10->base.preferred_engine = ENGINE_ID_UNKNOWN;
 
 	enc10->base.features = *enc_features;
-	if (enc10->base.connector.id == CONNECTOR_ID_USBC)
-		enc10->base.features.flags.bits.DP_IS_USB_C = 1;
-
-	if (enc10->base.connector.id == CONNECTOR_ID_USBC)
-		enc10->base.features.flags.bits.DP_IS_USB_C = 1;
 
 	enc10->base.transmitter = init_data->transmitter;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
index 81e349d5835b..da94e5309fba 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
@@ -184,6 +184,8 @@ void dcn35_link_encoder_construct(
 	enc10->base.hpd_source = init_data->hpd_source;
 	enc10->base.connector = init_data->connector;
 
+	if (enc10->base.connector.id == CONNECTOR_ID_USBC)
+		enc10->base.features.flags.bits.DP_IS_USB_C = 1;
 
 	enc10->base.preferred_engine = ENGINE_ID_UNKNOWN;
 
@@ -238,8 +240,6 @@ void dcn35_link_encoder_construct(
 	}
 
 	enc10->base.features.flags.bits.HDMI_6GB_EN = 1;
-	if (enc10->base.connector.id == CONNECTOR_ID_USBC)
-		enc10->base.features.flags.bits.DP_IS_USB_C = 1;
 
 	if (bp_funcs->get_connector_speed_cap_info)
 		result = bp_funcs->get_connector_speed_cap_info(enc10->base.ctx->dc_bios,


