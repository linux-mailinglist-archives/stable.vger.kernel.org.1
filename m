Return-Path: <stable+bounces-223664-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIIVIlbTrmlhJAIAu9opvQ
	(envelope-from <stable+bounces-223664-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 15:04:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 177F223A3D4
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 15:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 237AF304E0D7
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 14:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2BA3B5846;
	Mon,  9 Mar 2026 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+XJvqpH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EE83A9620
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 14:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773065000; cv=none; b=YxQiylabxPfwp8YUd3msudVABkOAjFzSr2rHu026x3Gd9WQca71Ideor1t71m6taTJqUnm4qZsZdSBkpSVtTyuk1jPmhe5+igyVq3kTldZ28EHJE0e+d4rlz/y6jxRsBwmHjGI87xcsYDVrLW3oLtLS+wDfdHKLQ2vlxnD8j75s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773065000; c=relaxed/simple;
	bh=ARK22JMZQZzQW0kfQjocPOdLoP8Vync59umAvi32e+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqTRZ3EjQyPEGgkErDwx40IaRXMVUpGsUapgIxXQsyQbO4YMCLOaImZKtDNM3Z+1F4RZOTSXPT0FEnWNYIroGwBSdP6qfO1hQ9UGRQAwhOY14A84G3LhNdln7AXe/PdPBeP3bBjxqXsz1qKPgMG0fuuAmasVe0bN5+IEthxG34c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+XJvqpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269E5C4CEF7;
	Mon,  9 Mar 2026 14:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773064999;
	bh=ARK22JMZQZzQW0kfQjocPOdLoP8Vync59umAvi32e+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O+XJvqpHpyWQqNYM0G+DXcfXGg5ht8nTHqv+RrLpgX7oq5D/BmDXJTz6z7dhsOBWG
	 IXh7EFZ/cRPEulfQCwpbF8aw0ivJobkd0qIPEo50Fm21kLtlFB5IqvgpjYl/P1QMkM
	 9O5gJ8u0U+XrlUyhnA0ut/tPUCYDCOX/epu+X5Bp1V1RkLeAKNRY7/9BNC9hnvScG1
	 KDuVcBLK257w2yWXv+zG84Gz33VONjaIs67lLdLWepf77dFynLvWBK8mprnN35kzcY
	 D33bvKiQWPDthDxxYA3tBDKjYmG5+pPd8YqJF/qdKEHrseiQUNc7DxqxWACvBqhnAW
	 7T22oM7dhMKpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Natalie Vock <natalie.vock@gmx.de>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/amd/display: Use GFP_ATOMIC in dc_create_stream_for_sink
Date: Mon,  9 Mar 2026 10:03:17 -0400
Message-ID: <20260309140317.1076863-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026030946-pusher-booted-ffde@gregkh>
References: <2026030946-pusher-booted-ffde@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 177F223A3D4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmx.de,amd.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223664-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,gmx.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
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
index 85fb028b5d437..0a0e485078952 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -167,7 +167,7 @@ struct dc_stream_state *dc_create_stream_for_sink(
 	if (sink == NULL)
 		return NULL;
 
-	stream = kzalloc(sizeof(struct dc_stream_state), GFP_KERNEL);
+	stream = kzalloc(sizeof(struct dc_stream_state), GFP_ATOMIC);
 	if (stream == NULL)
 		goto alloc_fail;
 
-- 
2.51.0


