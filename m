Return-Path: <stable+bounces-250365-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uB6ID0wPDmrB5wUAu9opvQ
	(envelope-from <stable+bounces-250365-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:45:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F04598B38
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3D29320FC8F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CDB363C59;
	Wed, 20 May 2026 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I4u7u8iH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40C9221F2F;
	Wed, 20 May 2026 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295223; cv=none; b=p9laQ7E+pzcS6VE6dJGZqPY2cAKT+ig/oV8lvEfhv0HCleqgtPRicvmut0x+IOiXICSlfDyl+XSA+Cmsbfh4PMqiP21tA3L05dnBG9CaD6T6s01MWqLF+EijszJ9meKw6FfuNhp7wzzg1CfrfIYxIwigPdRF9B1WK7O5alpzlF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295223; c=relaxed/simple;
	bh=WV0QRIl1cFvpi6pdqaNkaBW4EarKKTsBQHzCdJFQLzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/77RtsPYQ+EJL2EDn9Z8WPPbg5VxBrsF2BPX2npxGbsAn/TJerXcRvt02ijEnuP87silRAS+YwA4Sd9346VfWY9CvA12ZVIT3DzrjptzdtD3sRpXWlfYGujLBXHsi8VI4mfWzGIa3lVR3adszOHZ7Q/DLrGaIOnE6WiP4O8XMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I4u7u8iH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D03C1F000E9;
	Wed, 20 May 2026 16:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295221;
	bh=NHaI3Kh4NrVrqOHO3ot8vr3L1uoPglVoffT0soSddpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I4u7u8iHUZU7k8YOQSuONmRqRS3vTco9KBbFmwJ1LZX7NutIC4GQFsGNGDVF7wPR/
	 NO40lWjKmiaceAs34wleKd287R/0qh0U8Jsfywcvb23o2y7e7zaOfELUgPvRiyEMnQ
	 93LvIslPJfLEv0qirLIGMUtRq7YYcuB+NqmN/Tjo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Roman Li <roman.li@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0336/1146] drm/amd/display: Avoid NULL dereference in dc_dmub_srv error paths
Date: Wed, 20 May 2026 18:09:46 +0200
Message-ID: <20260520162155.805579497@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250365-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email,linaro.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: B1F04598B38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 4ae3e16f4b3bf64140f773629b765d605ee079a9 ]

In dc_dmub_srv_log_diagnostic_data() and
dc_dmub_srv_enable_dpia_trace().

Both functions check:

  if (!dc_dmub_srv || !dc_dmub_srv->dmub)

and then call DC_LOG_ERROR() inside that block.

DC_LOG_ERROR() uses dc_dmub_srv->ctx internally. So if
dc_dmub_srv is NULL, the logging itself can dereference a
NULL pointer and cause a crash.

Fix this by splitting the checks.

First check if dc_dmub_srv is NULL and return immediately.
Then check dc_dmub_srv->dmub and log the error only when
dc_dmub_srv is valid.

Fixes the below:
../display/dc/dc_dmub_srv.c:962 dc_dmub_srv_log_diagnostic_data() error: we previously assumed 'dc_dmub_srv' could be null (see line 961)
../display/dc/dc_dmub_srv.c:1167 dc_dmub_srv_enable_dpia_trace() error: we previously assumed 'dc_dmub_srv' could be null (see line 1166)

Fixes: 2631ac1ac328 ("drm/amd/display: add DMUB registers to crash dump diagnostic data.")
Fixes: 71ba6b577a35 ("drm/amd/display: Add interface to enable DPIA trace")
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index b15360bcdacf7..b3cedaa596c02 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -958,7 +958,10 @@ void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv)
 {
 	uint32_t i;
 
-	if (!dc_dmub_srv || !dc_dmub_srv->dmub) {
+	if (!dc_dmub_srv)
+		return;
+
+	if (!dc_dmub_srv->dmub) {
 		DC_LOG_ERROR("%s: invalid parameters.", __func__);
 		return;
 	}
@@ -1163,7 +1166,10 @@ void dc_dmub_srv_enable_dpia_trace(const struct dc *dc)
 {
 	struct dc_dmub_srv *dc_dmub_srv = dc->ctx->dmub_srv;
 
-	if (!dc_dmub_srv || !dc_dmub_srv->dmub) {
+	if (!dc_dmub_srv)
+		return;
+
+	if (!dc_dmub_srv->dmub) {
 		DC_LOG_ERROR("%s: invalid parameters.", __func__);
 		return;
 	}
-- 
2.53.0




