Return-Path: <stable+bounces-250956-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FRUD//rDWrM4gUAu9opvQ
	(envelope-from <stable+bounces-250956-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:14:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDFD593240
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFEA63117224
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3BE3E0C70;
	Wed, 20 May 2026 17:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mrUdHnwO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA20A231842;
	Wed, 20 May 2026 17:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296728; cv=none; b=eibPm2+pIr7ogJHx75mbAegdpFxVXQA5t+HPJXY1BJl3uOt7yGPe/URcU4k9+KI21uvqwbWIQ9Zx/SbZTGbN1e5GkgOCt4vwI5znb78XVPOZU5+PNaPVTcoHW2mUM8fnzPv3hs8t3fzwrCltqTdVBbdcCE+60oWXAmKg9r94E6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296728; c=relaxed/simple;
	bh=/wysthc/L5s9AbUtPoCj/UzEDdpXIueNT0UsycbB9YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdD9HCaW6r/QUudiWlqQ/+MY4nt8RCdUUHWof9AZoMtI4Fr9pRdiOJGDoGG5bj1KRedQORGPykZASqD+/b9NHXXxeInQiViK0vNXFMVnCWPat283tSmwhY/fITLPemMy565OPt4XAffh6tyawzRFb+W+G7aqna42+mx2RsJrEoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mrUdHnwO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9611F000E9;
	Wed, 20 May 2026 17:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296727;
	bh=41vfFKGhz3Yunj5V16+bDZRcBrXnvX3MQn6KpbOkK+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mrUdHnwOX2l54YLFLtTbvhafH3Lq+HSPjvMLNHYDeLtJ9XE54eWM+V/JdoUTnJmsV
	 RK7LMaFCez42rze26QaKaG8cJNp+g8SAa7/hNFGr6eCF2bmkTWbAkbYAq1/XWDerCO
	 4vy49tO5Kr1CLumHgzbg4+zn7zF2cfd/cVdJh1Gg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kent Russell <kent.russell@amd.com>,
	Tao Zhou <tao.zhou1@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0907/1146] drm/amdgpu: Only send RMA CPER when threshold is exceeded
Date: Wed, 20 May 2026 18:19:17 +0200
Message-ID: <20260520162208.766179082@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250956-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: AFDFD593240
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kent Russell <kent.russell@amd.com>

[ Upstream commit b56922fc37454633b831a2a04a1537616742977d ]

According to our documentation, the RMA should only occur when the
threshold has been exceeded, not met.

Fixes: 5028a24aa89a ("drm/amdgpu: Send applicable RMA CPERs at end of RAS init")
Signed-off-by: Kent Russell <kent.russell@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 8bc09a7d0e90ec45a0b4865661cf45cbbce1c3d7)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 6fba9d5b29ea6..ee271f43d5ad0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1939,7 +1939,7 @@ void amdgpu_ras_check_bad_page_status(struct amdgpu_device *adev)
 	if (!control || amdgpu_bad_page_threshold == 0)
 		return;
 
-	if (control->ras_num_bad_pages >= ras->bad_page_cnt_threshold) {
+	if (control->ras_num_bad_pages > ras->bad_page_cnt_threshold) {
 		if (amdgpu_dpm_send_rma_reason(adev))
 			dev_warn(adev->dev, "Unable to send out-of-band RMA CPER");
 		else
-- 
2.53.0




