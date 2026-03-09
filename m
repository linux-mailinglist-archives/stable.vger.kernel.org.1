Return-Path: <stable+bounces-223558-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BD3Biagrmm2GwIAu9opvQ
	(envelope-from <stable+bounces-223558-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:25:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E996237008
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83FF530470DD
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 10:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEABB38F225;
	Mon,  9 Mar 2026 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hXqtJQ0G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93118256C84
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773051899; cv=none; b=uZp3c+SNHyyM04jeOJiv3k8jzhupMAyMhC3d+sA9Qu8lQM9K8XQH25KFDnP4O00gF+OrxftEsO6YLx0mwijFO1r41YWEOh3i9BNg+9EDX7Q3aUQEsgboFDzaj2qB42gls7cGkyKXWEer7VsqAByBf23QOIjWi02f6NMK4ATkRPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773051899; c=relaxed/simple;
	bh=unjDxagnTlG+w5xZdMvl17BHwt/yiRu8p7+3V7MFC74=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qcuEP/ywpaei2DGIfmS1eFnEivNKXBtfitAH/MA4CT9pZNPNW6uIlEt1fB4wDZT6kIfKmJ0Fs682IyTW84swU1WwvfdXWMkNVtxY1BkROIwtfnRfH8M9UE10YJBXneStOiNh6brX6/DDNjZRX876JAGJKhO0J1II9p9Fhb/uGUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hXqtJQ0G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47CBC4CEF7;
	Mon,  9 Mar 2026 10:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773051899;
	bh=unjDxagnTlG+w5xZdMvl17BHwt/yiRu8p7+3V7MFC74=;
	h=Subject:To:Cc:From:Date:From;
	b=hXqtJQ0GowS0c2KBMHCsDtkXZ3mWL3/eLGKY5r76WEa15ARUs1xB2l8wcsC6HXb8d
	 lftXlJ3UBH2mkrQxO/twKjGdqzaoufFE+6IBIMiya9LyBosuujFXfhvVAzKAHrd0cz
	 EdAJ6RiIXkEMe8Uux1Arrupj5nYS7esxv5B9f9xs=
Subject: FAILED: patch "[PATCH] drm/amd/display: Use GFP_ATOMIC in dc_create_stream_for_sink" failed to apply to 6.6-stable tree
To: natalie.vock@gmx.de,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 09 Mar 2026 11:24:46 +0100
Message-ID: <2026030946-swarm-showy-e429@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9E996237008
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223558-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmx.de,amd.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.238];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email,gmx.de:email,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 28dfe4317541e57fe52f9a290394cd29c348228b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026030946-swarm-showy-e429@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 28dfe4317541e57fe52f9a290394cd29c348228b Mon Sep 17 00:00:00 2001
From: Natalie Vock <natalie.vock@gmx.de>
Date: Mon, 23 Feb 2026 12:45:37 +0100
Subject: [PATCH] drm/amd/display: Use GFP_ATOMIC in dc_create_stream_for_sink

This can be called while preemption is disabled, for example by
dcn32_internal_validate_bw which is called with the FPU active.

Fixes "BUG: scheduling while atomic" messages I encounter on my Navi31
machine.

Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit b42dae2ebc5c84a68de63ec4ffdfec49362d53f1)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 246893d80f1f..baf820e6eae8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -170,11 +170,11 @@ struct dc_stream_state *dc_create_stream_for_sink(
 	if (sink == NULL)
 		goto fail;
 
-	stream = kzalloc_obj(struct dc_stream_state);
+	stream = kzalloc_obj(struct dc_stream_state, GFP_ATOMIC);
 	if (stream == NULL)
 		goto fail;
 
-	stream->update_scratch = kzalloc((int32_t) dc_update_scratch_space_size(), GFP_KERNEL);
+	stream->update_scratch = kzalloc((int32_t) dc_update_scratch_space_size(), GFP_ATOMIC);
 	if (stream->update_scratch == NULL)
 		goto fail;
 


