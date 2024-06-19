Return-Path: <stable+bounces-53722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE7C90E5DE
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337241F21BBA
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3A07F484;
	Wed, 19 Jun 2024 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qqdCyiQY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9FA7EEF5
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786250; cv=none; b=eEu9jj870OVwDooSpF5Yxr2q8rzGH0TNjfXHM3rZunobrw8/8LnfC+1VuoDPvLNMq0jV8zO8PA1QauRZTQcCDjagVtYSvJ/MNJLdv+X7r5pKTCSkv9sV3AUKdq6hVPCAv0/DotvZQHLLwhlCrbg63sqRNJKBxVDce/wG865IpcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786250; c=relaxed/simple;
	bh=Bn1M7csuIa9AoKc6MmudHBmSFqo375I68L0ADINp1nA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AczTrrtkXMcfPpTNBRZyRO1ccOcbtj9bk3HYVDfzF0EoUCLtmfUQYO201xd8LzOykAmM7l20TAirx7X5jgydErkSaJMJyMjtHxNvV7OPvW39EswyW0Pgaf4W6t6+Jw1+xFAhreDzjHmDf+nony7/EhAZJOiRqLICya/2Ywg55oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qqdCyiQY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A852C32786;
	Wed, 19 Jun 2024 08:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718786249;
	bh=Bn1M7csuIa9AoKc6MmudHBmSFqo375I68L0ADINp1nA=;
	h=Subject:To:Cc:From:Date:From;
	b=qqdCyiQYcH8IyU0iEt929PL9YeY23YM8KPrxOVnE51RMBuN3QjbZVhoNlvdavt/ot
	 RXYgrreEJ7P1maRCWMuy13AQu+9yIaevCh405KAi5J54juRzHtyvpqTUGwa5Sn6cWv
	 GEBzZBekcEac05f1kiuoHyL/AWmeOGEtgszS/ADM=
Subject: FAILED: patch "[PATCH] drm/amd/display: Set DCN351 BB and IP the same as DCN35" failed to apply to 6.9-stable tree
To: xi.liu@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,jun.lei@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 10:37:26 +0200
Message-ID: <2024061926-humorist-untrimmed-875e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.9-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.9.y
git checkout FETCH_HEAD
git cherry-pick -x 1c5c36530a573de1a4b647b7d8c36f3b298e60ed
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061926-humorist-untrimmed-875e@gregkh' --subject-prefix 'PATCH 6.9.y' HEAD^..

Possible dependencies:

1c5c36530a57 ("drm/amd/display: Set DCN351 BB and IP the same as DCN35")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1c5c36530a573de1a4b647b7d8c36f3b298e60ed Mon Sep 17 00:00:00 2001
From: Xi Liu <xi.liu@amd.com>
Date: Tue, 27 Feb 2024 13:39:00 -0500
Subject: [PATCH] drm/amd/display: Set DCN351 BB and IP the same as DCN35

[WHY & HOW]
DCN351 and DCN35 should use the same bounding box and IP settings.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Xi Liu <xi.liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index cf98411d0799..151b480b3cea 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -229,17 +229,13 @@ void dml2_init_socbb_params(struct dml2_context *dml2, const struct dc *in_dc, s
 		break;
 
 	case dml_project_dcn35:
+	case dml_project_dcn351:
 		out->num_chans = 4;
 		out->round_trip_ping_latency_dcfclk_cycles = 106;
 		out->smn_latency_us = 2;
 		out->dispclk_dppclk_vco_speed_mhz = 3600;
 		break;
 
-	case dml_project_dcn351:
-		out->num_chans = 16;
-		out->round_trip_ping_latency_dcfclk_cycles = 1100;
-		out->smn_latency_us = 2;
-		break;
 	}
 	/* ---Overrides if available--- */
 	if (dml2->config.bbox_overrides.dram_num_chan)


