Return-Path: <stable+bounces-223670-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EIvESzVrmlhJAIAu9opvQ
	(envelope-from <stable+bounces-223670-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 15:11:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F4E23A4F5
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 15:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFE72302BB8F
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 14:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449323CE49E;
	Mon,  9 Mar 2026 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1Si0BSh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A5A39E176
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773065499; cv=none; b=Yq+Ork6jqC+MI2bnsLBwlQ5rASAQVRSTyzAIiPYdgXDtFwm1p90Jdtmv0Yey06e5wprqGOZ9/PSS8D+8aBFc+y5Iq8FJuvRdYgkKSUn8cCKohxmvaytoQHB5WbIQkyrHRmUbnCgWQkvBio2fgKCsLhd2SgVRsqopxfrlPd+ShV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773065499; c=relaxed/simple;
	bh=mUfsZtQnNA0/dWfy6/YCjfKRarbOhiYzI8dg5IWTt94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6rflMUhgUBS3yGYlqLI6nilnHH5E21/xbW4/kn+QbV9f6agLmnf7eEoxe6vH7lsV6OwWqaoG8F/z0loVhQmB3sPEz7hF+FeKfosHY16tnsX1cKGatli66YMKdjeEOOFE9DwxTuLtSTEYXZm+SmJFMCcUUBNspVXQEANiE2gWDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1Si0BSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15831C4CEF7;
	Mon,  9 Mar 2026 14:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773065498;
	bh=mUfsZtQnNA0/dWfy6/YCjfKRarbOhiYzI8dg5IWTt94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D1Si0BShvUh5P/Lxnvt26nOZ0sD7NMPn3btleUxobYyeAaolFxJCNgjsPgs11E/Pn
	 PateiNnvZ8oVMPCPl9w6O5F6e38A1POaGz3uvEVT68sbI7yZRspcRaD24YBBQthxmi
	 BbCpnjfFzAJLMMIi1HeX0yd3cR6WZfuHIUgoTvTBL0rzv5xfVzfGNfvZcafAOf0bv1
	 SVHJvrDavRssNHpp4tjI9Re5NIgvxtKiBB2urd5cl4k9mZCtVZMSpOkoYjHBitmn1R
	 Tdsf+u1WgrC+28vClc/pSvoPGAciix8hsE+sIlhCSeTvsUIY7lGTKV3jrMUUuexU6n
	 dZVrdlk0dzAGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Natalie Vock <natalie.vock@gmx.de>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/amd/display: Use GFP_ATOMIC in dc_create_stream_for_sink
Date: Mon,  9 Mar 2026 10:11:36 -0400
Message-ID: <20260309141136.1105798-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026030946-swarm-showy-e429@gregkh>
References: <2026030946-swarm-showy-e429@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B7F4E23A4F5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmx.de,amd.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223670-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,amd.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Natalie Vock <natalie.vock@gmx.de>

[ Upstream commit 28dfe4317541e57fe52f9a290394cd29c348228b ]

This can be called while preemption is disabled, for example by
dcn32_internal_validate_bw which is called with the FPU active.

Fixes "BUG: scheduling while atomic" messages I encounter on my Navi31
machine.

Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit b42dae2ebc5c84a68de63ec4ffdfec49362d53f1)
Cc: stable@vger.kernel.org
[ Context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 0e210407131e7..41da88d355886 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -164,7 +164,7 @@ struct dc_stream_state *dc_create_stream_for_sink(
 	if (sink == NULL)
 		return NULL;
 
-	stream = kzalloc(sizeof(struct dc_stream_state), GFP_KERNEL);
+	stream = kzalloc(sizeof(struct dc_stream_state), GFP_ATOMIC);
 	if (stream == NULL)
 		goto alloc_fail;
 
-- 
2.51.0


