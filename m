Return-Path: <stable+bounces-16215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4104A83F1B3
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21FC281BC7
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCF9200A4;
	Sat, 27 Jan 2024 23:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zfgDIQmA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9711B80B
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397366; cv=none; b=MVJPe1Q09oj+TLEf1vOGC+m+c4rOwQ1eFLCGiy3+qrOe9ZhrBdRMxZLMLoBcun/5qLUNtjGzK9xz8GKpNkhSHAph2jq6k1WDIWrL5Kl+MMpb3qX/D1c65IQdp6jWmhY4FRaAnpKcN4/jUoe5Pxkadx9oaADhp/TWrXn/Z5fx90I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397366; c=relaxed/simple;
	bh=cGjgXyZk3unTyJ7GGCTCo2ZWEzIMhiT/PkgiUaFJVYY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Del05SSQwM0J41iMux25mnHPdAF2ZWNltebI23QTuQvQ5LXXVRIVnrTsTt6eQI8w12mVX/xYHiOABxpTC9VGc8DM4TJnTKa3Z0LBKRC/S1WyVY5yop/Tk3i1gXt0rr+YnJaROQ5s6XRzh5YlhThKf2dkQiAQfk41PIYJKuW0aQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zfgDIQmA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB3CC433F1;
	Sat, 27 Jan 2024 23:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706397365;
	bh=cGjgXyZk3unTyJ7GGCTCo2ZWEzIMhiT/PkgiUaFJVYY=;
	h=Subject:To:Cc:From:Date:From;
	b=zfgDIQmARj9t/M6/zTsGzfCExc4nOcXFO7j7Oz8wbTGGOLQ5trbAyBBms9lkAtLvM
	 Eemi+Me24j1AR2To7MQ1dNxN8u487nwmEF250t3nAjpoLvlsM7TYEOJ2S4sGmB8bO8
	 lw6IN/Jp65pZWcaOS3M2QK8yhAa6DAF78N9KrkL4=
Subject: FAILED: patch "[PATCH] drm/amd/display: Init link enc resources in dc_state only if" failed to apply to 6.7-stable tree
To: dillon.varone@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,martin.leung@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:16:05 -0800
Message-ID: <2024012704-overbill-wisdom-c169@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
git checkout FETCH_HEAD
git cherry-pick -x aa36d8971fccb55ef3241cbfff9d1799e31d8628
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012704-overbill-wisdom-c169@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:

aa36d8971fcc ("drm/amd/display: Init link enc resources in dc_state only if res_pool presents")
012a04b1d6af ("drm/amd/display: Refactor phantom resource allocation")
09a4ec5da92c ("drm/amd/display: Refactor dc_state interface")
abd26a3252cb ("drm/amd/display: Add dml2 copy functions")
b719a9c15d52 ("drm/amd/display: Fix NULL pointer dereference at hibernate")
cfab803884f4 ("drm/amd/display: update pixel clock params after stream slice count change in context")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aa36d8971fccb55ef3241cbfff9d1799e31d8628 Mon Sep 17 00:00:00 2001
From: Dillon Varone <dillon.varone@amd.com>
Date: Thu, 28 Dec 2023 21:36:39 -0500
Subject: [PATCH] drm/amd/display: Init link enc resources in dc_state only if
 res_pool presents

[Why & How]
res_pool is not initialized in all situations such as virtual
environments, and therefore link encoder resources should not be
initialized if res_pool is NULL.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 460a8010c79f..56feee0ff01b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -267,7 +267,8 @@ void dc_state_construct(struct dc *dc, struct dc_state *state)
 	state->clk_mgr = dc->clk_mgr;
 
 	/* Initialise DIG link encoder resource tracking variables. */
-	link_enc_cfg_init(dc, state);
+	if (dc->res_pool)
+		link_enc_cfg_init(dc, state);
 }
 
 void dc_state_destruct(struct dc_state *state)


