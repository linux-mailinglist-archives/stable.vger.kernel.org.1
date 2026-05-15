Return-Path: <stable+bounces-248344-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4I1dG6xVB2oHzAIAu9opvQ
	(envelope-from <stable+bounces-248344-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:19:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02266554D62
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06BB031CBBB0
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08FF2798F3;
	Fri, 15 May 2026 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pva3U/v+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D253B9D84;
	Fri, 15 May 2026 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861493; cv=none; b=YHkoRitI1j6y2OXWhqUu9L2xkX8pAbOveT1LjjDa2eGDceovVsogw3dPuo+XeciX8GavJ9jR4Mz3VM4Ouya8KcskZJgeMqmSe3YEu0lVjSfYjRx7H/hXjF6JNuLrvgJ1mmjTfmTTg1930z5jEPw4B6vS1NA2t15/bjZigQUKvkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861493; c=relaxed/simple;
	bh=7PTKJdzKpF9/22g0Z7eznewFSQ8GxfB5WoNQlwIcGfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NIIxE+7OJvTvmFFGgJyVz4AgBaM76njD9iygvLiHLt0b26vE9NSHK3WACA+Ny8gNoLGUufkBnGRAEk8KT8FVoj36MB7wyUpjZhupn7DhJtxtuIbnl2VFMvK96tZ6iYA2KniWaW/3je0UFyz2BrO8hYKMsmk5jOowmuFcjNDRWaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pva3U/v+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1AEC2BCB0;
	Fri, 15 May 2026 16:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861493;
	bh=7PTKJdzKpF9/22g0Z7eznewFSQ8GxfB5WoNQlwIcGfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pva3U/v+/xrlPB5i7ZRm/OP4eqG9yo+g4GpP/TCt6PZprk+eeqRGPqPr0TbfcWHbs
	 DqXnon9O8f8rYb1EpAUZU/+f0MXVkPXyFMLg61RONJLw+c6cZUuxt0Vk2DZWLUGXR3
	 VOs15zG+N3DLCsbG0sh2DlScy1to/d6OeDrBnUUE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"John B. Moore" <jbmoore61@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.6 351/474] drm/amdgpu/gfx9: drop unnecessary 64-bit fence flag check in KIQ
Date: Fri, 15 May 2026 17:47:40 +0200
Message-ID: <20260515154722.611684352@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 02266554D62
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248344-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,amd.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John B. Moore <jbmoore61@gmail.com>

commit 7bbfb2559bcec39d1a4e1182d931a2046112c352 upstream.

Remove the BUG_ON(flags & AMDGPU_FENCE_FLAG_64BIT) assertion from
gfx_v9_0_ring_emit_fence_kiq().  The KIQ hardware supports 64-bit
fence writes; the 32-bit writeback address constraint is an
upper-layer convention, not a hardware limitation.  The check serves
no purpose and should not be present.

Found by code inspection while investigating related BUG_ON
assertions in the GFX and compute ring emission paths.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: John B. Moore <jbmoore61@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 1b1101a46a426bb4328116bb5273c326a2780389)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5388,9 +5388,6 @@ static void gfx_v9_0_ring_emit_fence_kiq
 {
 	struct amdgpu_device *adev = ring->adev;
 
-	/* we only allocate 32bit for each seq wb address */
-	BUG_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
-
 	/* write fence seq to the "addr" */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
 	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |



