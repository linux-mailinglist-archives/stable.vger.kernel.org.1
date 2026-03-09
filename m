Return-Path: <stable+bounces-223559-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAOHMiegrmm2GwIAu9opvQ
	(envelope-from <stable+bounces-223559-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:25:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5681123700F
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AA5630495E4
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 10:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661F036BCE6;
	Mon,  9 Mar 2026 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2ftdw9/k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D8438F921
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773051902; cv=none; b=Crf7xiZmNQvElHG9MYF9Aca4Ukjpxp7KE1+445HOyvsn/Ekjar4WcsC6Wp/E/Pr/m+teXC0Vd7R/aTyeR0FcxkF9HNPKaTCwnrOKJGMACCu4EpkQdICQ9CDbw7HQXn0DRE5omrmKE737jkCcgcK2T8DFsTtE+ODm3u9H55Lwfyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773051902; c=relaxed/simple;
	bh=y+u9pJaPsHV5+GJ96wjjMEns1fcf9fwq88Pjgki2EKM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CkYRu9FDTpTZ2679NHYh+prOCndsVqxXqIGSSUzsRrULrYE02pzFt4BucxLfGBoNTYNKOQzMZV50xKBXishbwPVHC7RkAq+CnG9L+wytawUA7X5b4rsGdRTVyRm1MxG0+BUVv2SmXpdq6t3yKC/wuJi7ITQZvJ+JsdPjLT3T3Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2ftdw9/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91493C4CEF7;
	Mon,  9 Mar 2026 10:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773051901;
	bh=y+u9pJaPsHV5+GJ96wjjMEns1fcf9fwq88Pjgki2EKM=;
	h=Subject:To:Cc:From:Date:From;
	b=2ftdw9/kFq4AHk4e26mkZYzlbGI2DSlK5glqwmhmqEIQZdNhUOYgSN8ojKFifIyP5
	 w3kPs1DQIVBRc6iCD7k0bw+z1rvZtnYs8w6fvqbhxf+chivz1ssaj4hn0b+vwWKO0f
	 hQ2cATZ3hdn2TP6fLytnMkqED14wGGYWkv/Qatlw=
Subject: FAILED: patch "[PATCH] drm/amd/display: Use GFP_ATOMIC in dc_create_stream_for_sink" failed to apply to 6.18-stable tree
To: natalie.vock@gmx.de,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 09 Mar 2026 11:24:46 +0100
Message-ID: <2026030946-antitoxic-bullring-b15f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5681123700F
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
	TAGGED_FROM(0.00)[bounces-223559-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmx.de,amd.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.134];
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 28dfe4317541e57fe52f9a290394cd29c348228b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026030946-antitoxic-bullring-b15f@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

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
 


