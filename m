Return-Path: <stable+bounces-226792-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6N+jOdSOuWnQKQIAu9opvQ
	(envelope-from <stable+bounces-226792-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:26:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B27C32AF8EF
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E16E7304CA5E
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9753793C9;
	Tue, 17 Mar 2026 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qNL19uSS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4182A36EABC;
	Tue, 17 Mar 2026 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768214; cv=none; b=lV7PLl1JNrvrRVjv449rumQ5c3hVV5gO1uuXGdmddLNjcCrHopVRNcMsJ9Aq25RFM2cmhdYxy/8BJ+IIC2e72xzJLCOZ/amUup/05whkASpI7NffguypIAHr7jglasM5i1Q2YyzWVYSxIS7MXnHKOwSlOTvTnY7dcURrPITG0o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768214; c=relaxed/simple;
	bh=TW50JkB5zydTbsiLTm7aQp7GLIm3cpZDg9BHaggENTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6d/nnrjgXJi1nShBGunyniAiMNC7CZT3ZP00vIweL39I4j+SbjCt5rcLrg8xneWEI+JqADzLvtVnmHscMdtdxfi4lDiyV4SjdOy9fxJVVBhuP8uyzD6b/2mweR2DlqdCEB4ognVqg2VtKDfKlfK/N0N1gz1ZBNlyCCq9L0zf5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qNL19uSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71DEC4CEF7;
	Tue, 17 Mar 2026 17:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768214;
	bh=TW50JkB5zydTbsiLTm7aQp7GLIm3cpZDg9BHaggENTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qNL19uSSHwyXY6Q6ymd4oiLLK3LAK3AhAPGkTdkCCiwZg7XuQrk/cTHNbuEyanAuv
	 8shpwrAuSS8E8yALh81pcuryFN/DcyST2cWCWETgaZ79x83FTPl4bWBjAK8/jLeHii
	 tcLIjEljO14IGtxJJX8nIR8guEUitPFfXrX23UBc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Deucher <alexander.deucher@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.18 259/333] drm/amd: Fix a few more NULL pointer dereference in device cleanup
Date: Tue, 17 Mar 2026 17:34:48 +0100
Message-ID: <20260317163008.975448294@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226792-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B27C32AF8EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

commit 72ecb1dae72775fa9fea0159d8445d620a0a2295 upstream.

I found a few more paths that cleanup fails due to a NULL version pointer
on unsupported hardware.

Add NULL checks as applicable.

Fixes: 39fc2bc4da00 ("drm/amdgpu: Protect GPU register accesses in powergated state in some paths")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit f5a05f8414fc10f307eb965f303580c7778f8dd2)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3625,6 +3625,8 @@ static int amdgpu_device_ip_fini_early(s
 	int i, r;
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (!adev->ip_blocks[i].version)
+			continue;
 		if (!adev->ip_blocks[i].version->funcs->early_fini)
 			continue;
 
@@ -3687,6 +3689,8 @@ static int amdgpu_device_ip_fini(struct
 		if (!adev->ip_blocks[i].status.sw)
 			continue;
 
+		if (!adev->ip_blocks[i].version)
+			continue;
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC) {
 			amdgpu_ucode_free_bo(adev);
 			amdgpu_free_static_csa(&adev->virt.csa_obj);
@@ -3713,6 +3717,8 @@ static int amdgpu_device_ip_fini(struct
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
 		if (!adev->ip_blocks[i].status.late_initialized)
 			continue;
+		if (!adev->ip_blocks[i].version)
+			continue;
 		if (adev->ip_blocks[i].version->funcs->late_fini)
 			adev->ip_blocks[i].version->funcs->late_fini(&adev->ip_blocks[i]);
 		adev->ip_blocks[i].status.late_initialized = false;



