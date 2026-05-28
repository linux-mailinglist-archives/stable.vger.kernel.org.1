Return-Path: <stable+bounces-256058-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCYaNKSqGGoomAgAu9opvQ
	(envelope-from <stable+bounces-256058-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:50:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E25B55F9AD3
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F54430210E7
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E8B197A7D;
	Thu, 28 May 2026 20:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IsstqGbB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976751FC0EA;
	Thu, 28 May 2026 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000637; cv=none; b=enWt9TEFgqBsyLvwuSSp/9k2XA5T2TR05W+gGOQw1HX1cPQLZI0LX1T08k+mayNFlDuwAU/9XTrwwcta9ClN70hXg24VoVOO0GC59qBo+HGbuAKddFvbiA3GVw39dtksVfm8JoWsug3MMdBnccJusyFSfAvVEuULaiX7DW8fFbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000637; c=relaxed/simple;
	bh=CPAMpQr6Mf1tjjGSYoMiR3b5tcqIRS06Wki2iTfq+p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXCqhrcR51OtXMR6JkCco2Dh9++CPwsCrIKltTbgH/Y9LqByJFWZ/5R8uEeJFA52Dri1uZxSxwIhEZUFnk3suXS6lJ+hWsR/M9z2ofs0QXF6nMe/IX6JHBVh75Foof5ITHrv5XjVQ6+A71WVk5Pe9ZC3O8aHwh4r861fZZkkd3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IsstqGbB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007561F000E9;
	Thu, 28 May 2026 20:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000636;
	bh=0gFMIAKUdApU564feko7cVXlewaWO/yCsyNxEPxHIHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IsstqGbBVJLwP3LDVHIMPiUp/IJXao/qT3a3Pxh4zj13rGxV3dmvuvDKqi/PriHnT
	 i1PlmR+5Q7GiSbGWhLoLWRAHXz/lJtnGnFXU1hWZ9voZ+QU/O4T3Q5+Aj1hRsmfvFs
	 jv+335eZtRDsAJQLbMPle1PG3G/WrdtywOViU81Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Alan liu <haoping.liu@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.12 115/272] drm/amdgpu/vpe: Force collaborate sync after TRAP
Date: Thu, 28 May 2026 21:48:09 +0200
Message-ID: <20260528194632.601345297@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256058-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,amd.com:email]
X-Rspamd-Queue-Id: E25B55F9AD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alan Liu <haoping.liu@amd.com>

commit b6074630a461b1322a814988779005cbc43612ea upstream.

VPE1 could possibly hang and fail to power off at the end of commands in
collaboration mode. This workaround adds a COLLAB_SYNC after TRAP to
force instances synchronized to avoid VPE1 fail to power off.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Alan liu <haoping.liu@amd.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5171
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit a8b749c5c5afb7e5daa2bfb95d958fb3c6b8f055)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -556,6 +556,11 @@ static void vpe_ring_emit_fence(struct a
 		amdgpu_ring_write(ring, 0);
 	}
 
+	/* WA: Force sync after TRAP to avoid VPE1 fail to power off */
+	if (ring->adev->vpe.collaborate_mode) {
+		amdgpu_ring_write(ring, VPE_CMD_HEADER(VPE_CMD_OPCODE_COLLAB_SYNC, 0));
+		amdgpu_ring_write(ring, 0xabcd);
+	}
 }
 
 static void vpe_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
@@ -904,7 +909,7 @@ static const struct amdgpu_ring_funcs vp
 	.emit_frame_size =
 		5 + /* vpe_ring_init_cond_exec */
 		6 + /* vpe_ring_emit_pipeline_sync */
-		10 + 10 + 10 + /* vpe_ring_emit_fence */
+		12 + 12 + 12 + /* vpe_ring_emit_fence */
 		/* vpe_ring_emit_vm_flush */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 6,



