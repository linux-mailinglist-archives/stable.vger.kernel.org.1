Return-Path: <stable+bounces-228912-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKvtAIlYwWnbSQQAu9opvQ
	(envelope-from <stable+bounces-228912-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:13:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CCC2F5FDF
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 273F43324DBB
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB573AA1BB;
	Mon, 23 Mar 2026 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aMP2OWgL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B97395DB5;
	Mon, 23 Mar 2026 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277469; cv=none; b=fgWLJ02dYptcja91o9KENqGI2+95cS5STjVjx3YRSPOryP/ibmX2CQDjorQYw6HwklQxd0pbEBX2XwZv+ocVbYPLEVm+lGY1htVLRCsvvDDNfSwt180WCpjCOikyoVGSTX1e9pCqZtspuJhW3IqOWirumdR/4y/TigVClZrHjdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277469; c=relaxed/simple;
	bh=FjHuroO9fJCkpLTSGg53+bwRMbks4w33TVl5C+jZY4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRgn83Vz0R0EIt3NsEfZb5ssvqamLs5XCoK0CeNZC/lup7Oo1j1sezzkElQmC2SDXUJI4hFNlU2vvnRnycmpVsaPxcNMUCH3b39ai/HZ9MPcdh7AFk9KX+BRFOfsEUrEAhPtHuef/BGVRQO1N6v0+Fz0PS2F86ENpGCH4J+39Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aMP2OWgL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972BEC4CEF7;
	Mon, 23 Mar 2026 14:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277469;
	bh=FjHuroO9fJCkpLTSGg53+bwRMbks4w33TVl5C+jZY4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aMP2OWgLnVIaQv1gX/pCAUCHhPS1KRx5D2qvNkHuBmHf8HbZY8VcsVVC4CW5UXdNf
	 Foyn/MOvPRWIUk9ElGgVPy2HhZi4H7R4Ww37TT+USnHvf0ioZWSNudGdX6KlvBjWDA
	 8nYcr0X2eADQlAz6kqbUkgIyiXDOJZ6MHXpX4bx0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Roman Li <roman.li@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
	Sun peng Li <sunpeng.li@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 451/460] drm/amd/display: Fix DisplayID not-found handling in parse_edid_displayid_vrr()
Date: Mon, 23 Mar 2026 14:47:27 +0100
Message-ID: <20260323134537.665290716@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228912-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 83CCC2F5FDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 2323b019651ad81c20a0f7f817c63392b3110652 ]

parse_edid_displayid_vrr() searches the EDID extension blocks for a
DisplayID extension before parsing the dynamic video timing range.

The code previously checked whether edid_ext was NULL after the search
loop. However, edid_ext is assigned during each iteration of the loop,
so it will never be NULL once the loop has executed. If no DisplayID
extension is found, edid_ext ends up pointing to the last extension
block, and the NULL check does not correctly detect the failure case.

Instead, check whether the loop completed without finding a matching
DisplayID block by testing "i == edid->extensions". This ensures the
function exits early when no DisplayID extension is present and avoids
parsing an unrelated EDID extension block.

Also simplify the EDID validation check using "!edid ||
!edid->extensions".

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:13079 parse_edid_displayid_vrr() warn: variable dereferenced before check 'edid_ext' (see line 13075)

Fixes: a638b837d0e6 ("drm/amd/display: Fix refresh rate range for some panel")
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Jerry Zuo <jerry.zuo@amd.com>
Cc: Sun peng Li <sunpeng.li@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 91c7e6342e98c846b259c57273436fdea4c043f2)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4d508129a5e65..e092d2372a4e6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -12318,7 +12318,7 @@ static void parse_edid_displayid_vrr(struct drm_connector *connector,
 	u16 min_vfreq;
 	u16 max_vfreq;
 
-	if (edid == NULL || edid->extensions == 0)
+	if (!edid || !edid->extensions)
 		return;
 
 	/* Find DisplayID extension */
@@ -12328,7 +12328,7 @@ static void parse_edid_displayid_vrr(struct drm_connector *connector,
 			break;
 	}
 
-	if (edid_ext == NULL)
+	if (i == edid->extensions)
 		return;
 
 	while (j < EDID_LENGTH) {
-- 
2.51.0




