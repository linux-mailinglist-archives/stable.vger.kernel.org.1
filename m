Return-Path: <stable+bounces-220241-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMqQF+gxo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220241-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:20:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C2F1C5ADE
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 952A131092A9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E08E373122;
	Sat, 28 Feb 2026 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owG+kbLM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C435F341077;
	Sat, 28 Feb 2026 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300145; cv=none; b=RoAieJgIsPqPr9afxGlNfgbTZuonqfFl626EIxzQwwFu3WfZsde1Y+ZG7I6d2XkDdfrd4PsqvKmBfR9afriwahkJV9LGg6eDumgMWmvK81cdjna+TJya7KCskNEe4gWGvBiygCvJmijc13WphQAbIgN7yavnaeVe8/lo8rZipLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300145; c=relaxed/simple;
	bh=oS4fknAdcl5oosDLqZRQcGl5uEH4C80criT2DF/0Hyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2ocRD9BjJBU6zUZm5iHGlcd6bYBWyYR5GtdamvyHWrNsfBvrifnus/xLNlA2iQKiwBl/C/9mz/9/S8W9ZTZXp8KIdubqyjGLMKQgxPFA1xGYoX1dtnYGslggNF/f5Yeolb+Io02fDcTcY1FMGYHw4hoeiXfOI1E+T1tCzCEeD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owG+kbLM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9FDC2BC87;
	Sat, 28 Feb 2026 17:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300145;
	bh=oS4fknAdcl5oosDLqZRQcGl5uEH4C80criT2DF/0Hyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=owG+kbLM5GOz/jEwiIaA8MKMuhA/XhGphl1VVZCpWKWP2aNJcWmWHFz600tWpgsfJ
	 TjkPr+QyTkfArfDCayMauMGdUB4ClEl5Mi/HJTiUtz5ztZAXwGnhmgcmy1DUSAR8+u
	 cw7vBVTgyyuTkbudmXJQNvACB+m9emJZ0uJa+c/T3UzI5xCM0Lko0OzGkS6He2oVMh
	 80Eu7ZgDFmfhoHrJl/NGAg9ULXCujZI+okHW17XLpATOldsvJy0LmpPUlMWXbjAFyo
	 vvmW5EML5RB4pAqIdjtcYkHZzTaLgQPKErpHWIbABrCCr+zTgOyXe7Vsb6MUEx9EYO
	 jr+pbQNhqkuKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
	Chenyu Chen <chen-yu.chen@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 163/844] drm/amd/display: Add signal type check for dcn401 get_phyd32clk_src
Date: Sat, 28 Feb 2026 12:21:16 -0500
Message-ID: <20260228173244.1509663-164-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220241-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C9C2F1C5ADE
X-Rspamd-Action: no action

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

[ Upstream commit c979d8db7b0f293111f2e83795ea353c8ed75de9 ]

Trying to access link enc on a dpia link will cause a crash otherwise

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index e1f5b1a34cde8..f04cbdb3d3814 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -916,10 +916,10 @@ static void dcn401_enable_stream_calc(
 			pipe_ctx->stream->link->cur_link_settings.lane_count;
 	uint32_t active_total_with_borders;
 
-	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx))
+	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
 		*dp_hpo_inst = pipe_ctx->stream_res.hpo_dp_stream_enc->inst;
-
-	*phyd32clk = get_phyd32clk_src(pipe_ctx->stream->link);
+		*phyd32clk = get_phyd32clk_src(pipe_ctx->stream->link);
+	}
 
 	if (dc_is_tmds_signal(pipe_ctx->stream->signal))
 		dcn401_calculate_dccg_tmds_div_value(pipe_ctx, tmds_div);
-- 
2.51.0


