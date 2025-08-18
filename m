Return-Path: <stable+bounces-171381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1944B2AA22
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 16:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC0606E4E30
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EA433A026;
	Mon, 18 Aug 2025 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ENJYjv2y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD2733A00E;
	Mon, 18 Aug 2025 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525729; cv=none; b=Y2KsSGkqp3ni8aR3E8J8sPVZzmbh/TEjrsbxHuEyuXkqC3ZdUSIF5n24k5ivg5gqdu+gVNvFxrfqBbhnMvPF72b/0zP/KLw59c/qczpVwdWIqQscMWWicqiPV55v2iAG8SKOTJIt7/gi8MlghNKsZyZ/cyLTTucJ+gibDOaDMDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525729; c=relaxed/simple;
	bh=yZQ7HLOiOzlARTu6FlT0AOt95glGzs9p6yu4Co2g6HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPmv1uUN+PZY1/TpkDvxJEQDjZBiIogrW1f0ytlbi9LGH8l9rbN/OdtCYB3VEoCfVOrmUg90b1zljdMvMNkNLnrb3ilhbqQV+p8ykD0N802uDNptTYrudnH2chhG5zA8ACwOqLGSO/NzoxX69TbUTewUNA8pMh6OXnwrE+V5WyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ENJYjv2y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D734CC4CEEB;
	Mon, 18 Aug 2025 14:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755525729;
	bh=yZQ7HLOiOzlARTu6FlT0AOt95glGzs9p6yu4Co2g6HQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ENJYjv2yzdwMvnSUCB4eHAr21UjoYMIAGUCCUCA6gz/smUH34kcQ/PLyZ6iKdv6Bh
	 twHAOQM+8ko+NZ38gVBZShbxFXFsEml+D4U+Ao9DLwkrA4xbwbv91xY0pr0R0tMl3T
	 YEn7JLjJkDCccfoVWKC5xwBZFu1+7rhdP7I+fydY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Wayne Lin <Wayne.Lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 350/570] drm/amd/display: Avoid trying AUX transactions on disconnected ports
Date: Mon, 18 Aug 2025 14:45:37 +0200
Message-ID: <20250818124519.341928492@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
References: <20250818124505.781598737@linuxfoundation.org>
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

From: Wayne Lin <Wayne.Lin@amd.com>

[ Upstream commit deb24e64c8881c462b29e2c69afd9e6669058be5 ]

[Why & How]
Observe that we try to access DPCD 0x600h of disconnected DP ports.
In order not to wasting time on retrying these ports, call
dpcd_write_rx_power_ctrl() after checking its connection status.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 273a3be6d593..f16cba4b9119 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -140,7 +140,8 @@ void link_blank_dp_stream(struct dc_link *link, bool hw_init)
 				}
 		}
 
-		if ((!link->wa_flags.dp_keep_receiver_powered) || hw_init)
+		if (((!link->wa_flags.dp_keep_receiver_powered) || hw_init) &&
+			(link->type != dc_connection_none))
 			dpcd_write_rx_power_ctrl(link, false);
 	}
 }
-- 
2.39.5




