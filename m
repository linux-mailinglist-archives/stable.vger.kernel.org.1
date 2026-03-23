Return-Path: <stable+bounces-228198-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGnlMA5RwWnLSAQAu9opvQ
	(envelope-from <stable+bounces-228198-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:41:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4ED2F4FBA
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAA643036773
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875BD3B3BFC;
	Mon, 23 Mar 2026 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cDopCB7W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7E33B38B5;
	Mon, 23 Mar 2026 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274421; cv=none; b=ZTjoua7xuJYP2UNb8xk2RPilcOlwa4VVJWnN/zjYpiwMRZtay92t+aYpqbgq0lZXkeapJ/EvJy4D87keHSMvjVpVUgTQSBuCKbpvCsyqsIwqdERZHTvbOaa+fr/YYP9UH9s+sYdKfA3KI3P2RgKAaZWewICpWs+9ZCT5iKAIk7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274421; c=relaxed/simple;
	bh=F4U/ANmC2TlyFx6U4PP8DtU1YWKlUg326IOcwr6z/e0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=giHYYD/Au6ZBKQRc+leTTkqjI/MxX3fO+w8SthJJy3dKb+D19gacVT5ftOyeiXXKNqVdZQkufXS001bFycBc8fttelPdL/oCnzBZbPGievE/5sUQZHJiud5KOIHp3v6+Bk4Dgnh/j4cu5U71Hxf2wyFR279itLTs9aYXsVPzU9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cDopCB7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2655C4CEF7;
	Mon, 23 Mar 2026 14:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274421;
	bh=F4U/ANmC2TlyFx6U4PP8DtU1YWKlUg326IOcwr6z/e0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cDopCB7W/hQOIKyiQWwd3qEcL5hHZr+h25f+hqqmeGCb/P3dDlmEC/Jec713QqFMW
	 W7CaVwXb7HDjB2faj1KY5ajZhnTn50JtLGcOTUcUjcjBsWQ4XxwGDd9zuYNEVfE4tL
	 exSEExGXDihF3QOaNBPf2t7yAUJju7U/Km+WvxXg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Nguyen <theofficialflow1996@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 210/220] drm/amd: fix dcn 2.01 check
Date: Mon, 23 Mar 2026 14:46:27 +0100
Message-ID: <20260323134511.180177882@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-228198-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,amd.com,kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1E4ED2F4FBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Nguyen <theofficialflow1996@gmail.com>

[ Upstream commit 39f44f54afa58661ecae9c27e15f5dbce2372892 ]

The ASICREV_IS_BEIGE_GOBY_P check always took precedence, because it includes all chip revisions upto NV_UNKNOWN.

Fixes: 54b822b3eac3 ("drm/amd/display: Use dce_version instead of chip_id")
Signed-off-by: Andy Nguyen <theofficialflow1996@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 9c7be0efa6f0daa949a5f3e3fdf9ea090b0713cb)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 15cf13ec53026..c450feae5fa5b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -255,6 +255,10 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 			BREAK_TO_DEBUGGER();
 			return NULL;
 		}
+		if (ctx->dce_version == DCN_VERSION_2_01) {
+			dcn201_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
+			return &clk_mgr->base;
+		}
 		if (ASICREV_IS_SIENNA_CICHLID_P(asic_id.hw_internal_rev)) {
 			dcn3_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
 			return &clk_mgr->base;
@@ -267,10 +271,6 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 			dcn3_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
 			return &clk_mgr->base;
 		}
-		if (ctx->dce_version == DCN_VERSION_2_01) {
-			dcn201_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
-			return &clk_mgr->base;
-		}
 		dcn20_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
 		return &clk_mgr->base;
 	}
-- 
2.51.0




