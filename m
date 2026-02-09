Return-Path: <stable+bounces-215076-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPRvJS3wiWn4EQAAu9opvQ
	(envelope-from <stable+bounces-215076-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:33:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A771106CC
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F8FC3003BF9
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0581DE8AD;
	Mon,  9 Feb 2026 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AXYuJ2UX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42989285060;
	Mon,  9 Feb 2026 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647593; cv=none; b=YIFvztWc9PD+AbV2VTo7M7WSu6WN/sJYLZIj374eRgS37ZUJrehlKxw5hHimDPI5jqGTcShOk4dbqyTEYq8yexfOSMl8h5Stj+mFLTUmigIAA+XLAnsKcyZ01G8QBuz7IdsO5CWtAOJFFlPOOPsTtROMKfgkhX1fsWATS2hEs7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647593; c=relaxed/simple;
	bh=NZmr/9qI4fD1TMr9R3rjqnmxjQuRF25GoYuKqmxlYV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omXjl8hlcliHDp0O+oq9SZ5a3ZU9FpQi5jDPp2AtBhmtI0DecApihFOCFLZ1kjuMTnq9Tr8fCKv9MYZZp3j1g9lJnUpdr4I+j1mDATORJMrcp2I88mGOhF7Cj1N5p4Pt4nUTXfSoKhLXoydz7XZF0+JB8w3wVYlHuCgzufS0ax8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AXYuJ2UX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA6CC116C6;
	Mon,  9 Feb 2026 14:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647593;
	bh=NZmr/9qI4fD1TMr9R3rjqnmxjQuRF25GoYuKqmxlYV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AXYuJ2UXo1H4w+hwySshmPHX/xUNK2YNh7vL2M3ClyRd1IkH1ncDHrHA4e9fvQAWt
	 yag/ds4XRxAgH2bk51d8Km7N+Qie2R1nE7z7pztGasG7cKXjsbcdWHagTxDle26GdW
	 s6pS4rOwNMLfBdXMjCB7Vdy/b5ePy/C6woeAGymE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
	Melissa Wen <mwen@igalia.com>,
	Alex Hung <alex.hung@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 146/175] drm/amd/display: fix wrong color value mapping on MCM shaper LUT
Date: Mon,  9 Feb 2026 15:23:39 +0100
Message-ID: <20260209142325.756539270@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
References: <20260209142320.474120190@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215076-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,amd.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B2A771106CC
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Melissa Wen <mwen@igalia.com>

[ Upstream commit 8f959d37c1f2efec6dac55915ee82302e98101fb ]

Some shimmer/colorful points appears when using the steamOS color
pipeline for HDR on gaming with DCN32. These points look like black
values being wrongly mapped to red/blue/green values. It was caused
because the number of hw points in regular LUTs and in a shaper LUT was
treated as the same.

DCN3+ regular LUTs have 257 bases and implicit deltas (i.e. HW
calculates them), but shaper LUT is a special case: it has 256 bases and
256 deltas, as in DCN1-2 regular LUTs, and outputs 14-bit values.

Fix that by setting by decreasing in 1 the number of HW points computed
in the LUT segmentation so that shaper LUT (i.e. fixpoint == true) keeps
the same DCN10 CM logic and regular LUTs go with `hw_points + 1`.

CC: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Fixes: 4d5fd3d08ea9 ("drm/amd/display: PQ tail accuracy")
Signed-off-by: Melissa Wen <mwen@igalia.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 5006505b19a2119e71c008044d59f6d753c858b9)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
index 0690c346f2c52..a4f14b16564c2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
@@ -163,6 +163,11 @@ bool cm3_helper_translate_curve_to_hw_format(
 			hw_points += (1 << seg_distr[k]);
 	}
 
+	// DCN3+ have 257 pts in lieu of no separate slope registers
+	// Prior HW had 256 base+slope pairs
+	// Shaper LUT (i.e. fixpoint == true) is still 256 bases and 256 deltas
+	hw_points = fixpoint ? (hw_points - 1) : hw_points;
+
 	j = 0;
 	for (k = 0; k < (region_end - region_start); k++) {
 		increment = NUMBER_SW_SEGMENTS / (1 << seg_distr[k]);
@@ -223,8 +228,6 @@ bool cm3_helper_translate_curve_to_hw_format(
 	corner_points[1].green.slope = dc_fixpt_zero;
 	corner_points[1].blue.slope = dc_fixpt_zero;
 
-	// DCN3+ have 257 pts in lieu of no separate slope registers
-	// Prior HW had 256 base+slope pairs
 	lut_params->hw_points_num = hw_points + 1;
 
 	k = 0;
-- 
2.51.0




