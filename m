Return-Path: <stable+bounces-23992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416C18692A9
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A84FB2D044
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB62145356;
	Tue, 27 Feb 2024 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VezKYiDO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E080A13A25D;
	Tue, 27 Feb 2024 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040725; cv=none; b=md/insJb/VgOj7f9Dwh13qCLPv7+nIES2NiqmBphTqZM4GJKhB9wQdHhkT9LG2sMPCtRj9jpybokkN4LdfCG71O4OujL3nGkOtkk53fcevnuxXWHrBHbj+5G4RJr5zzNJwq/RKUovgwpBgVEcvk0Wq/3q0tCTlgfwWJseGsYjL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040725; c=relaxed/simple;
	bh=i5dvSq5E9gohbYPgzLIwxWW80KaIZzAozsISN9Z4fQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxRjeP0G26v8tlMpGj2vpI7IiknByLijqdE2HMdNk7E+oHiE4J9cAPmtWkkUMhX+5Hk/lv+9coa+8NZIjmqrriZczw5yYgz39XujshdgMfiBEtdj5UUfbBhDbPNMuLwOGHPzmAaR87lFnZcc+LgddrOBb8cbxl11ZtiGbHgiefg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VezKYiDO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A8FC433F1;
	Tue, 27 Feb 2024 13:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709040724;
	bh=i5dvSq5E9gohbYPgzLIwxWW80KaIZzAozsISN9Z4fQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VezKYiDOcGS5fMibixbylPXBbSPLoQwsHNWpIzV7+n1t7UG/9VilQAmIt08souWcY
	 UNxyxAzKqZipV0us1QitA8Ar0/kDQYhLAZ0TXQz3MuAD/lyAelGICQ+lgk1DR1O0Hp
	 o3KZYwCuKv6jG9XiSv5Nj4mEV0cQwR8CAFn+DG1g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Muhammad Ahmed <ahmed.ahmed@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 058/334] drm/amd/display: fix USB-C flag update after enc10 feature init
Date: Tue, 27 Feb 2024 14:18:36 +0100
Message-ID: <20240227131632.437999221@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Charlene Liu <charlene.liu@amd.com>

[ Upstream commit b5abd7f983e14054593dc91d6df2aa5f8cc67652 ]

[why]
BIOS's integration info table not following the original order
which is phy instance is ext_displaypath's array index.

[how]
Move them to follow the original order.

Reviewed-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
index 501388014855c..d761b0df28784 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
@@ -203,12 +203,12 @@ void dcn32_link_encoder_construct(
 	enc10->base.hpd_source = init_data->hpd_source;
 	enc10->base.connector = init_data->connector;
 
-	if (enc10->base.connector.id == CONNECTOR_ID_USBC)
-		enc10->base.features.flags.bits.DP_IS_USB_C = 1;
 
 	enc10->base.preferred_engine = ENGINE_ID_UNKNOWN;
 
 	enc10->base.features = *enc_features;
+	if (enc10->base.connector.id == CONNECTOR_ID_USBC)
+		enc10->base.features.flags.bits.DP_IS_USB_C = 1;
 
 	enc10->base.transmitter = init_data->transmitter;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
index da94e5309fbaf..81e349d5835bb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
@@ -184,8 +184,6 @@ void dcn35_link_encoder_construct(
 	enc10->base.hpd_source = init_data->hpd_source;
 	enc10->base.connector = init_data->connector;
 
-	if (enc10->base.connector.id == CONNECTOR_ID_USBC)
-		enc10->base.features.flags.bits.DP_IS_USB_C = 1;
 
 	enc10->base.preferred_engine = ENGINE_ID_UNKNOWN;
 
@@ -240,6 +238,8 @@ void dcn35_link_encoder_construct(
 	}
 
 	enc10->base.features.flags.bits.HDMI_6GB_EN = 1;
+	if (enc10->base.connector.id == CONNECTOR_ID_USBC)
+		enc10->base.features.flags.bits.DP_IS_USB_C = 1;
 
 	if (bp_funcs->get_connector_speed_cap_info)
 		result = bp_funcs->get_connector_speed_cap_info(enc10->base.ctx->dc_bios,
-- 
2.43.0




