Return-Path: <stable+bounces-220299-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOtGBqA0o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220299-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:32:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7783D1C5E81
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DBF130B6D7B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213F847DFB8;
	Sat, 28 Feb 2026 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TK8tI5Ws"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79D23446B0;
	Sat, 28 Feb 2026 17:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300202; cv=none; b=FFbCMDkAD28DJq6sain1ZyT8u++ZVeGYkXKiShDQaaZ5x6QjC1Qb9YVHmpmWTkLdwIvOZyCUovYKmjd82vpqecVLAPBAdc04DkkwbRMyieHbqzIaG9rTjPQjZAKLnvrNHCCzKNLlTf039m9KjDKtQbBzuzgk9tvIyZH8dxKGv6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300202; c=relaxed/simple;
	bh=WG4TbpCWRD+5HcgHU/xkY1XnNJlL/COPZe4l64ukqVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZr+P8xGvRq9H8fooOvNvPfnSlv89R5arrdsAN6Y4pnVEbNSeVw07bHHBsvhfYOnMEFT0dDV+pVDqetkTO9wC1wEKrC3I53rVXvpffA9CBLusKF+uQnjpjLnSLNNKO0lPDJ+GLmPCciV4n0dbB4vJC1Rpmgc1266F3qZmHqCwGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TK8tI5Ws; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3988C116D0;
	Sat, 28 Feb 2026 17:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300202;
	bh=WG4TbpCWRD+5HcgHU/xkY1XnNJlL/COPZe4l64ukqVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TK8tI5WsZYiQ3tVh/ExT6ZpOEEHchijcYIrt6Ac7ztpchlFwkCbvU+C12e+Hj5ciV
	 0fzJosvg6R3btKkx/Cb/kASy6dRvpyF+/fx32uwkayD3SI0Ti6RcszggYde9Jol7zx
	 TSSXlBDCRiMKJTbp2fyCwiELnozcduQvkFItxlv7lqmm6ibkJcsu3Qy9A+St1Jdr2I
	 0Ulcaihb83lxCfaQh/ujeld+s6JMNzTQGsuHQWB63Ca8EyQ6mxeZIO/XloE+IGXEQx
	 yF35+Gdby5J4U9SE2Cq08iBuG5ZuBanuNYJLtzpQLqvit4+wVZHPNqyOFDZ8hlglzM
	 lL6fYXM9V99/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhongwei <Zhongwei.Zhang@amd.com>,
	Wenjing Liu <wenjing.liu@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 221/844] drm/amd/display: avoid dig reg access timeout on usb4 link training fail
Date: Sat, 28 Feb 2026 12:22:14 -0500
Message-ID: <20260228173244.1509663-222-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220299-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7783D1C5E81
X-Rspamd-Action: no action

From: Zhongwei <Zhongwei.Zhang@amd.com>

[ Upstream commit 15b1d7b77e9836ff4184093163174a1ef28bbdd7 ]

[Why]
When usb4 link training fails, the dpia sym clock will be disabled and SYMCLK
source should be changed back to phy clock. In enable_streams, it is
assumed that link training succeeded and will switch from refclk to
phy clock. But phy clk here might not be on. Dig reg access timeout
will occur.

[How]
When enable_stream is hit, check if link training failed for usb4.
If it did, fall back to the ref clock to avoid reg access timeout.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Zhongwei <Zhongwei.Zhang@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c  | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index c8ff8ae85a030..517d4c08d34c4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -3058,9 +3058,17 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 			dccg->funcs->enable_symclk32_se(dccg, dp_hpo_inst, phyd32clk);
 		}
 	} else {
-		if (dccg->funcs->enable_symclk_se)
-			dccg->funcs->enable_symclk_se(dccg, stream_enc->stream_enc_inst,
+		if (dccg->funcs->enable_symclk_se && link_enc) {
+			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA
+				&& link->cur_link_settings.link_rate == LINK_RATE_UNKNOWN
+				&& !link->link_status.link_active) {
+				if (dccg->funcs->disable_symclk_se)
+					dccg->funcs->disable_symclk_se(dccg, stream_enc->stream_enc_inst,
 						      link_enc->transmitter - TRANSMITTER_UNIPHY_A);
+			} else
+				dccg->funcs->enable_symclk_se(dccg, stream_enc->stream_enc_inst,
+						      link_enc->transmitter - TRANSMITTER_UNIPHY_A);
+		}
 	}
 
 	if (dc->res_pool->dccg->funcs->set_pixel_rate_div)
-- 
2.51.0


