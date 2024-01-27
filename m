Return-Path: <stable+bounces-16216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D62C683F1B5
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67267B225A1
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5551200AD;
	Sat, 27 Jan 2024 23:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O61NfLg3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8741D200AC
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397367; cv=none; b=agWaRkXjG6sIyxjy8jqr5HS/NIQh4yC3Wsv3m1zrDP/kZHrE1EGP8iSQieI+lXzPR0NGfE5HouGh535eZnPZPGxWDpg7i0cKscVoGjDvIGcmA1+4ms6kz6beBVb5Tg9XNe4NffSYDpyLwZK80FnaJrrEIxgtA8GgxQPrHXiKg0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397367; c=relaxed/simple;
	bh=64RTAS/9B1i6rOJUpy5Q13YFFsRn+e+sN6k8OuuWYhI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dLmqcvQy86nP5/bHnM/J+V/krWYTroWD4nNg25pGVqP7SPEkpelVsEKjkziRLDE6Gsd0QpHUlguatP8nHYRJPCI/Np7tzpZzLWKMTYR302Id8S4iKT08o3W3657N7CvrTARRsKUPH4OABzjlCGBMzNN3gXevGwW92BXMJlcPJak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O61NfLg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6DCC433C7;
	Sat, 27 Jan 2024 23:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706397367;
	bh=64RTAS/9B1i6rOJUpy5Q13YFFsRn+e+sN6k8OuuWYhI=;
	h=Subject:To:Cc:From:Date:From;
	b=O61NfLg3/bIf30q/KWd4oo2eTdOvQNhPvzDATf0JURMc5CE1w+Ivb44jDtn8F4Tgj
	 ghSRkL8fPDHxlUye69U/3jvEXEM/PdE1uLTXFGc9Y0WGPwpzGSKLt/UN/D3g1s5ZOY
	 uXNnkkxu4isvbE02a5GFakSUiZA4L3WaogG3A8cM=
Subject: FAILED: patch "[PATCH] drm/amd/display: Init link enc resources in dc_state only if" failed to apply to 6.6-stable tree
To: dillon.varone@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,martin.leung@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:16:06 -0800
Message-ID: <2024012705-headboard-stoic-61c6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x aa36d8971fccb55ef3241cbfff9d1799e31d8628
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012705-headboard-stoic-61c6@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

aa36d8971fcc ("drm/amd/display: Init link enc resources in dc_state only if res_pool presents")
012a04b1d6af ("drm/amd/display: Refactor phantom resource allocation")
09a4ec5da92c ("drm/amd/display: Refactor dc_state interface")
abd26a3252cb ("drm/amd/display: Add dml2 copy functions")
b719a9c15d52 ("drm/amd/display: Fix NULL pointer dereference at hibernate")
cfab803884f4 ("drm/amd/display: update pixel clock params after stream slice count change in context")
ed6e2782e974 ("drm/amd/display: For cursor P-State allow for SubVP")
fecbaa0a79ad ("drm/amd/display: save and restore mall state when applying minimal transition")
f583db812bc9 ("drm/amd/display: Update FAMS sequence for DCN30 & DCN32")
06ad7e164256 ("drm/amd/display: Destroy DC context while keeping DML and DML2")
ddd5298c63e4 ("drm/amd/display: Update cursor limits based on SW cursor fallback limits")
7966f319c66d ("drm/amd/display: Introduce DML2")
6e2c4941ce0c ("drm/amd/display: Move dml code under CONFIG_DRM_AMD_DC_FP guard")
13c0e836316a ("drm/amd/display: Adjust code style for hw_sequencer.h")
1ca965719b5b ("drm/amd/display: Change dc_set_power_state() to bool instead of int")
7441ef0b3ebe ("drm/amd: Propagate failures in dc_set_power_state()")
1288d7020809 ("drm/amd/display: Improve x86 and dmub ips handshake")
ad3b63a0d298 ("drm/amd/display: add new windowed mpo odm minimal transition sequence")
177ea58bef72 ("drm/amd/display: reset stream slice count for new ODM policy")
c0f8b83188c7 ("drm/amd/display: disable IPS")

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


