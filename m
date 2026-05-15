Return-Path: <stable+bounces-248811-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAuLA9ZUB2pIygIAu9opvQ
	(envelope-from <stable+bounces-248811-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:16:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E40F554B4C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2A0731676DF
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA803F6C39;
	Fri, 15 May 2026 16:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kbwUq/BC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2179F3F44E4;
	Fri, 15 May 2026 16:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862692; cv=none; b=S6tg6xrTRSSx9CY7XMV2oSfg6DtHFLtxyTKN57RGZ/SBkCMxnWVzPUDbBaOETO+4eOAARVADPdb3zhiJvS+DytFRhQjnsVe6sHkOo7zgWZz4wEZ2nX1H4wYg7XK64C8xmmh44azPFTn01TYTBv9gGtCn3Y5CuTEYkx5c7K+7zWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862692; c=relaxed/simple;
	bh=4CFEq1RwosnZv4zJrcn5N77lxpDguNW9+R+e1GwimXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfaJJohpUAmRc+iAsVE93Ie1ZYnThDUIrdD5flXElYHlYTRcqAKjnYF6rQJqxpBNPDJAq5nqgNp9ZJNSkLxgPabhwAI332rmO1xjM0pgaxblAe4c4iTtP+XkfzI/sNEKCbv5GK00g/mx87cyuhvfkOTgJnkD6aIqNJRPpJSUy6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kbwUq/BC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1733C2BCC7;
	Fri, 15 May 2026 16:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862692;
	bh=4CFEq1RwosnZv4zJrcn5N77lxpDguNW9+R+e1GwimXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kbwUq/BCp1ihBMuwXK26TfoF6zmMcdrCOGyi3IOZxV5uYvDHKE0xxBr1LzMU1fmO9
	 QAbYsnkfR6qa6D4yzmXYXgxKZsbKidm875GX38AaWsGkB5qHdGwdoZUtJdgwT086fV
	 ol3ZEWn9oHPJSsEtQgtSmAFt0CHpD4qiTivMRXqw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Deucher <alexander.deucher@amd.com>,
	Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
Subject: [PATCH 7.0 147/201] drm/amdgpu: Avoid reset in AMDGPU unload path for APUs with GFX V11 and higher.
Date: Fri, 15 May 2026 17:49:25 +0200
Message-ID: <20260515154701.754293621@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
References: <20260515154658.538039039@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 6E40F554B4C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248811-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>

commit 47776ac1e3f4a2aefcf7fe7c7e4a11151b676222 upstream.

GFX V11 has GC block as default off IP.
Every time AMDGPU driver sends a request to PMFW
to unload MP1, PMFW will put GC in reset and
power down the voltage.Hence, skipping reset
for APUs with GFX V11 or later to avoid reset
related failures.

Fixes: 34355e61835e ("drm/amdgpu: Fix GFX hang on SteamDeck when amdgpu is reloaded")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit d0a8cadffc818f51d05bc234d8da1af228bc59a3)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3539,8 +3539,12 @@ static int amdgpu_device_ip_fini_early(s
 	 * that checks whether the PSP is running. A solution for those issues
 	 * in the APU is to trigger a GPU reset, but this should be done during
 	 * the unload phase to avoid adding boot latency and screen flicker.
+	 * GFX V11 has GC block as default off IP. Every time AMDGPU driver sends
+	 * a request to PMFW to unload MP1, PMFW will put GC in reset and power down
+	 * the voltage. Hence, skipping reset for APUs with GFX V11 or later.
 	 */
-	if ((adev->flags & AMD_IS_APU) && !adev->gmc.is_app_apu) {
+	if ((adev->flags & AMD_IS_APU) && !adev->gmc.is_app_apu &&
+		amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(11, 0, 0)) {
 		r = amdgpu_asic_reset(adev);
 		if (r)
 			dev_err(adev->dev, "asic reset on %s failed\n", __func__);



