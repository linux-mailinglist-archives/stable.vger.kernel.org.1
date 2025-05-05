Return-Path: <stable+bounces-141422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DD9AAB36C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 344463AE47A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB7A22FDF2;
	Tue,  6 May 2025 00:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5Lca7IT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF21281516;
	Mon,  5 May 2025 23:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486244; cv=none; b=NkMfYuGB1mOhE0jJ/EKGCF1N5GkRAL+vWtBhB8QcomZtsUw/wIPJYdJUCOpw8ScWCDBqCPDdqiAEFTVFBa47+mzP0NOtu8jRI8fe0erkxh8hqrDVWfGqDsY7PaatyB5z8GnOj8vktGuLg4n2t0DxBnjIRPSR2NxakRjt3QwuVwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486244; c=relaxed/simple;
	bh=VxKNg81st5yBFqNHGE1oif7k67R0iHenoDCXfIenh+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ouNK2b9epF+37jwPv16hiISiszk4uXd1lxd/m6DT3QGjQ/Ofrdzy9lZxoJHhxOFu/Tk+YeqIfMZN+JPIJsSW2b1sQW05N022916LNMtrE/CBdlZFxDi/+0bCOq9YLXOr6cnXy+pDr+1XNzIpH8MIIy99y9C82ntS9ZE25xUunYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5Lca7IT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3404C4CEED;
	Mon,  5 May 2025 23:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486243;
	bh=VxKNg81st5yBFqNHGE1oif7k67R0iHenoDCXfIenh+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U5Lca7ITHCuIXzLa6SaT+NuUDUvh7AMp+XxupYJKmDiKPA7otZ0rGAhMdsMfyiWj0
	 GHs6BERaIp7OmZiMkiMde1x2uuQclpBTS1u7SdAxZFw9MSDHb7UDJrXtthqkis9yWi
	 dGEaHREksNWXX+PojYakPSLFc+nfobaVstppdBdlWHMAzeKLa0VbcK5JK/4BS6Hk/2
	 B9TvtIbGAjR2K9MUCSd2MoJHaDM+juPh7YVE18TnooKJeCOrqS9G7I7cnI49tqhMuc
	 moSVamOVTI/wGh8YdVTBwJuJG1ax2jp+XNPOnlFlqipX4q+gVDsfZ1sUZOGJa/vlHb
	 KxWsrTVpNx2Zg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ilya Bakoulin <Ilya.Bakoulin@amd.com>,
	Wenjing Liu <wenjing.liu@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	michael.strauss@amd.com,
	zaeem.mohamed@amd.com,
	PeiChen.Huang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 223/294] drm/amd/display: Don't try AUX transactions on disconnected link
Date: Mon,  5 May 2025 18:55:23 -0400
Message-Id: <20250505225634.2688578-223-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[ Upstream commit e8bffa52e0253cfd689813a620e64521256bc712 ]

[Why]
Setting link DPMS off in response to HPD disconnect creates AUX
transactions on a link that is supposed to be disconnected. This can
cause issues in some cases when the sink re-asserts HPD and expects
source to re-enable the link.

[How]
Avoid AUX transactions on disconnected link.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c   | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
index 9bde0c8bf914a..f01a3df584552 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
@@ -74,7 +74,8 @@ void dp_disable_link_phy(struct dc_link *link,
 	struct dc  *dc = link->ctx->dc;
 
 	if (!link->wa_flags.dp_keep_receiver_powered &&
-		!link->skip_implict_edp_power_control)
+			!link->skip_implict_edp_power_control &&
+			link->type != dc_connection_none)
 		dpcd_write_rx_power_ctrl(link, false);
 
 	dc->hwss.disable_link_output(link, link_res, signal);
@@ -159,8 +160,9 @@ enum dc_status dp_set_fec_ready(struct dc_link *link, const struct link_resource
 	} else {
 		if (link->fec_state == dc_link_fec_ready) {
 			fec_config = 0;
-			core_link_write_dpcd(link, DP_FEC_CONFIGURATION,
-				&fec_config, sizeof(fec_config));
+			if (link->type != dc_connection_none)
+				core_link_write_dpcd(link, DP_FEC_CONFIGURATION,
+					&fec_config, sizeof(fec_config));
 
 			link_enc->funcs->fec_set_ready(link_enc, false);
 			link->fec_state = dc_link_fec_not_ready;
-- 
2.39.5


