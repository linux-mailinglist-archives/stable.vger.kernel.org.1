Return-Path: <stable+bounces-226786-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HRsGJOTuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226786-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:46:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E46332B020F
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12B23335311E
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6EB331A64;
	Tue, 17 Mar 2026 17:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S0SJqW2P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8141129DB88;
	Tue, 17 Mar 2026 17:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768191; cv=none; b=RAydDEEbcQVB+OikmwiGZy4JSJlmHIkDNx+FurIu1vzJhCXOWY9jlwm7a1YDrSohR+OCHYMxayBWVdaSzt/lXjXbr1s2AdA1lNMN3TPtrKMqjWWzhs9Z69BDRIpBXe/7izy5CxeFYyY4AjEVSZPq34oiJFPrIuD5d9eRjtXRYEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768191; c=relaxed/simple;
	bh=n9dTfo0zXUV8m9mpoUsH4+Z1PWYKUumpbcyLfxrzKvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UnXvA1XfpBYNkSis+rqRlCzrIk3PbOAn/tOFvti1iKbYISWJQo/03hmP81b3iepx7fwDSvRQ0/mencGIb1spzHheGO6uePuqNHiok3ZCbQqX+iA76/9WqqCbkutSzRlZM6AxuFyrWOtD0ayF/gEBME2/6OfEQ3nf7OPDDbAdCSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S0SJqW2P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9154CC4CEF7;
	Tue, 17 Mar 2026 17:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768191;
	bh=n9dTfo0zXUV8m9mpoUsH4+Z1PWYKUumpbcyLfxrzKvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S0SJqW2PFI0vSL0NV6oRxWNz7tK40s7pRJuKWNr52Ug4QjQvd7oVyACaKj22qiof5
	 LJ2uzarJl5Bj8AQuz6r9bLhg+GAvu+g4hvHpLlRaNdPOJM5tTWEAKPkvK+WlSaA3jX
	 ZjYzKg8IZdM7q+yQta01qLmWs/QAtdjsW5tiUkf0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Deucher <alexander.deucher@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.18 253/333] drm/amd: Fix NULL pointer dereference in device cleanup
Date: Tue, 17 Mar 2026 17:34:42 +0100
Message-ID: <20260317163008.750874490@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-226786-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: E46332B020F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

commit 062ea905fff7756b2e87143ffccaece5cdb44267 upstream.

When GPU initialization fails due to an unsupported HW block
IP blocks may have a NULL version pointer. During cleanup in
amdgpu_device_fini_hw, the code calls amdgpu_device_set_pg_state and
amdgpu_device_set_cg_state which iterate over all IP blocks and access
adev->ip_blocks[i].version without NULL checks, leading to a kernel
NULL pointer dereference.

Add NULL checks for adev->ip_blocks[i].version in both
amdgpu_device_set_cg_state and amdgpu_device_set_pg_state to prevent
dereferencing NULL pointers during GPU teardown when initialization has
failed.

Fixes: 39fc2bc4da00 ("drm/amdgpu: Protect GPU register accesses in powergated state in some paths")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit b7ac77468cda92eecae560b05f62f997a12fe2f2)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3375,6 +3375,8 @@ int amdgpu_device_set_cg_state(struct am
 		i = state == AMD_CG_STATE_GATE ? j : adev->num_ip_blocks - j - 1;
 		if (!adev->ip_blocks[i].status.late_initialized)
 			continue;
+		if (!adev->ip_blocks[i].version)
+			continue;
 		/* skip CG for GFX, SDMA on S0ix */
 		if (adev->in_s0ix &&
 		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX ||
@@ -3414,6 +3416,8 @@ int amdgpu_device_set_pg_state(struct am
 		i = state == AMD_PG_STATE_GATE ? j : adev->num_ip_blocks - j - 1;
 		if (!adev->ip_blocks[i].status.late_initialized)
 			continue;
+		if (!adev->ip_blocks[i].version)
+			continue;
 		/* skip PG for GFX, SDMA on S0ix */
 		if (adev->in_s0ix &&
 		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX ||



