Return-Path: <stable+bounces-220239-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EF3lArg0o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220239-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:32:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B551C5EBB
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B03B2310D26B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FC9372222;
	Sat, 28 Feb 2026 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SClNR+qN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8DB37147D;
	Sat, 28 Feb 2026 17:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300143; cv=none; b=sUh3ywEqO4vXJdMvl5h+j3HNihWgQP2BEDcEibInCenQPIwVblF0meu7F6jekKBqYMJDqAbntjKE27FNrwL0SnzvxaE842BnUboYkwhTQWlXudsMPs59Fhp8qwJcjr25Re6fct2imHDl6yrHTpSVbb7V6VHiDb+lXbnolMut704=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300143; c=relaxed/simple;
	bh=JWeOc0Lbdei6aIrRvm6tRFwtITZbAgHUhPg0VYB4LpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eT/BzlUC3sdrH3mZ7IdyLnsHeqqtuigOKa+wLLffleLJ+k+JYNoHaadyB8Wo/aL7whKYFXGZAjahs824ZwuCMTRFBtOk3lv+SMkG/NLY8OOZExtr4veuLJ6MnGzzVL1sXbbx175p6F586M0b2W/7jpFCOec8hKpT9BgQMifvf/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SClNR+qN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92626C19423;
	Sat, 28 Feb 2026 17:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300143;
	bh=JWeOc0Lbdei6aIrRvm6tRFwtITZbAgHUhPg0VYB4LpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SClNR+qNXfwZp/K1OB6/BxLiTupUizPsG7B2macYcAI1Uk1ijZtN53d2LCZ9tlo39
	 6i0Ahf7N8Hi55R6HuItmsY5ITiirSF0FvD0d9BqZmZvRWWdM/YRU04ofoNOFE3YeuD
	 C24ki0083rL5uJPaysTjSy8ywVnD/zJmGl1bA6s/s37rceNGnnzHZMcC3H92pEyUbI
	 EIdLB5eN3TU1hDwdjxaO9ekOpA/uPLCypNy5tj91CRnMsfPRLeEOAMNbISf3rICvyw
	 DgCPuiLx6fFCVW3OeFwQq3yQD88WBshe2Vm1Cw/EXsHg+yArQTNJaLpQK4vjo/QoyZ
	 18qdHH+YSpQeA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Charlene Liu <Charlene.Liu@amd.com>,
	Mohit Bawa <mohit.bawa@amd.com>,
	Chenyu Chen <chen-yu.chen@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 161/844] drm/amd/display: Fix dsc eDP issue
Date: Sat, 28 Feb 2026 12:21:14 -0500
Message-ID: <20260228173244.1509663-162-sashal@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220239-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 28B551C5EBB
X-Rspamd-Action: no action

From: Charlene Liu <Charlene.Liu@amd.com>

[ Upstream commit 878a4b73c11111ff5f820730f59a7f8c6fd59374 ]

[why]
Need to add function hook check before use

Reviewed-by: Mohit Bawa <mohit.bawa@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c    | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 5896ce5511ab1..9f7087ac41f21 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1797,6 +1797,9 @@ static void disable_vga_and_power_gate_all_controllers(
 	struct timing_generator *tg;
 	struct dc_context *ctx = dc->ctx;
 
+	if (dc->caps.ips_support)
+		return;
+
 	for (i = 0; i < dc->res_pool->timing_generator_count; i++) {
 		tg = dc->res_pool->timing_generators[i];
 
@@ -1873,13 +1876,16 @@ static void clean_up_dsc_blocks(struct dc *dc)
 			/* disable DSC in OPTC */
 			if (i < dc->res_pool->timing_generator_count) {
 				tg = dc->res_pool->timing_generators[i];
-				tg->funcs->set_dsc_config(tg, OPTC_DSC_DISABLED, 0, 0);
+				if (tg->funcs->set_dsc_config)
+					tg->funcs->set_dsc_config(tg, OPTC_DSC_DISABLED, 0, 0);
 			}
 			/* disable DSC in stream encoder */
 			if (i < dc->res_pool->stream_enc_count) {
 				se = dc->res_pool->stream_enc[i];
-				se->funcs->dp_set_dsc_config(se, OPTC_DSC_DISABLED, 0, 0);
-				se->funcs->dp_set_dsc_pps_info_packet(se, false, NULL, true);
+				if (se->funcs->dp_set_dsc_config)
+					se->funcs->dp_set_dsc_config(se, OPTC_DSC_DISABLED, 0, 0);
+				if (se->funcs->dp_set_dsc_pps_info_packet)
+					se->funcs->dp_set_dsc_pps_info_packet(se, false, NULL, true);
 			}
 			/* disable DSC block */
 			if (dccg->funcs->set_ref_dscclk)
-- 
2.51.0


