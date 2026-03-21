Return-Path: <stable+bounces-227768-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADqnKL6cvmnpUQMAu9opvQ
	(envelope-from <stable+bounces-227768-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 14:27:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BADB2E5860
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 14:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75630302616E
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 13:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C2A2C0F95;
	Sat, 21 Mar 2026 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ht+g3xFJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F1338DD3
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774099279; cv=none; b=oYObzf554Ra1aiJAC2dnUlRHrZdDflGSTYO7LRrODD6mUh/KOpnK3kWFehJFmOmbs2A4g++N0tvoecHeX7OgiZLkRIjcqv/tt4CEIdd/tODntQqBo0/Mdb4vjXhONxCFuxaR5ZSSp8Yzuejg3yZDq3ckztlmzTDJR4bZtkOgnoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774099279; c=relaxed/simple;
	bh=U3QvSK25HgeTaD7EB2XR/0E1s0ue9pMvVGgMG7CKxgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qx9myt7Nc9jesOkOXzyUi2SyoXGiYBVZuhLmfey1XtS3usBPDak03VAYbo48BQcgs1ksn7FuQRk0R7N61eXwPCqHJewFanIB6MpCOYQJ5syGdt5GGi8s2vEwJKLhfeDVy3Q5D9ySrkCjUGxUHQBL/uVKpSU+aR4WxMuZIGTAECI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ht+g3xFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373B8C19421;
	Sat, 21 Mar 2026 13:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774099278;
	bh=U3QvSK25HgeTaD7EB2XR/0E1s0ue9pMvVGgMG7CKxgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ht+g3xFJagoJGgNQGSGZSaNONeRFUiEYsO3L4zNG59C6w9D5H8YwKf/e9ecGDdLyE
	 6kbCya3EPcn/Ye0AUcdlJaFjdn4oeMqAlhQIBJssu7GJNOHZByOPzMIfbf+SQCk72M
	 0DXi1HkzX+tM1V0UwrWbvBJ/5xMfCgD+4AEyJI0x4/cW5/7A89kWD32G2E7AYccbii
	 va15VDK+uAG/ZMdlouFE+MFk7dap7xWMll3h6wRihehhMeNuAQFtt79EUCapV5RenO
	 vQO1A0Ksvbc/1qAPKM7jx5Z5FOl2rEr5XF3wp0L1MAQzaal5oznbgSL7rd0yjIDndf
	 SQ69h9m6wCccA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>,
	LiarOnce <liaronce@hotmail.com>,
	Alex Hung <alex.hung@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/amd/display: Wrap dcn32_override_min_req_memclk() in DC_FP_{START, END}
Date: Sat, 21 Mar 2026 09:21:16 -0400
Message-ID: <20260321132116.312356-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026032152-backstage-spool-d8a1@gregkh>
References: <2026032152-backstage-spool-d8a1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[xry111.site,hotmail.com,amd.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-227768-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xry111.site:email,amd.com:email]
X-Rspamd-Queue-Id: 1BADB2E5860
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Xi Ruoyao <xry111@xry111.site>

[ Upstream commit ebe82c6e75cfc547154d0fd843b0dd6cca3d548f ]

[Why]
The dcn32_override_min_req_memclk function is in dcn32_fpu.c, which is
compiled with CC_FLAGS_FPU into FP instructions.  So when we call it we
must use DC_FP_{START,END} to save and restore the FP context, and
prepare the FP unit on architectures like LoongArch where the FP unit
isn't always on.

Reported-by: LiarOnce <liaronce@hotmail.com>
Fixes: ee7be8f3de1c ("drm/amd/display: Limit DCN32 8 channel or less parts to DPM1 for FPO")
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 25bb1d54ba3983c064361033a8ec15474fece37e)
Cc: stable@vger.kernel.org
[ dropped missing `dcn32_override_min_req_dcfclk()` call since ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index f98f35ac68c01..ddc0a444a0545 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1872,7 +1872,9 @@ bool dcn32_validate_bandwidth(struct dc *dc,
 
 	dc->res_pool->funcs->calculate_wm_and_dlg(dc, context, pipes, pipe_cnt, vlevel);
 
+	DC_FP_START();
 	dcn32_override_min_req_memclk(dc, context);
+	DC_FP_END();
 
 	BW_VAL_TRACE_END_WATERMARKS();
 
-- 
2.51.0


