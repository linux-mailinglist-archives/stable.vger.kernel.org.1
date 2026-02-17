Return-Path: <stable+bounces-217111-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAJWFAHVlGnnIAIAu9opvQ
	(envelope-from <stable+bounces-217111-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:52:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1035D1506C9
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C4E73057686
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1EC29A1;
	Tue, 17 Feb 2026 20:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xm04mFAd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05F1266581;
	Tue, 17 Feb 2026 20:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771361459; cv=none; b=UT0BjfLgMrpSD2bGzvSrjYdjLRfUH3fRL5HBvN7NIojK/HOwDTt3LZLspfZ30lU1u2+nOeBVVZupdMcu+Ku87affOZZcQsHjby4rCdBfmo2m92gPlESY5b8mtEH3utvM5hXhEeQPfolTGFUbTGLs21OluStPgSMXbVeFpyiGZrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771361459; c=relaxed/simple;
	bh=kh36k6uwXlPuLEkLpu4gMoY5fh0chWaJzRQTvICcIGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HD1OnMz7rIU3BEqKs2Syy1ve2nXpe50aB3fuqVlOIarTmeqLuR3W7XRb1I1uqZgheI2k3NQpig0SrssaSE8UoI52ow4N+kHUZbX/m02MbcisKx13OtPUrws5F60RqiN6HGyK02URgc8mejdjtXmbi5mpnmfd8jQib14OcmeuUEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xm04mFAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB16C4CEF7;
	Tue, 17 Feb 2026 20:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771361459;
	bh=kh36k6uwXlPuLEkLpu4gMoY5fh0chWaJzRQTvICcIGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xm04mFAdEWGeUjy27Nzgn1xREXpOw/OjgKnoBEVS/uRzJ4U/UWaFXKvXPX2VIjZo3
	 6juhsLYRj1Y9+6cMhPGe3KxWZ5jbPgPzSthNy5lXwfZs4vEYoYlFkAhGLmk3uLJas9
	 XL9+k4hidICiHkL9PndHGeWwgRdlju6LZkJCKzf4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Melissa Wen <mwen@igalia.com>,
	Alex Hung <alex.hung@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 22/43] drm/amd/display: remove assert around dpp_base replacement
Date: Tue, 17 Feb 2026 21:32:02 +0100
Message-ID: <20260217200007.317450434@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217200006.470920131@linuxfoundation.org>
References: <20260217200006.470920131@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217111-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1035D1506C9
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Melissa Wen <mwen@igalia.com>

[ Upstream commit 84962445cd8a83dc5bed4c8ad5bbb2c1cdb249a0 ]

There is nothing wrong if in_shaper_func type is DISTRIBUTED POINTS.
Remove the assert placed for a TODO to avoid misinterpretations.

Signed-off-by: Melissa Wen <mwen@igalia.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 1714dcc4c2c53e41190896eba263ed6328bcf415)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 30bb5d8d85dc2..c6fde355ac823 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -502,7 +502,6 @@ bool dcn32_set_mcm_luts(
 		lut_params = &plane_state->in_shaper_func.pwl;
 	else if (plane_state->in_shaper_func.type == TF_TYPE_DISTRIBUTED_POINTS) {
 		// TODO: dpp_base replace
-		ASSERT(false);
 		cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
 							&plane_state->in_shaper_func,
 							&dpp_base->shaper_params, true);
-- 
2.51.0




