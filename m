Return-Path: <stable+bounces-258957-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KnLLectG2qU/wgAu9opvQ
	(envelope-from <stable+bounces-258957-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:35:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E7361207B
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 49D3E3008FC9
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CCE33E36A;
	Sat, 30 May 2026 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MJHj3Q/Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4361E2EF652;
	Sat, 30 May 2026 18:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780166113; cv=none; b=tjU+5NdpeXt87V3Yho3LG31bdG/YlX44ZYt38Dv09eH/ONgBrlh3WL569ba+BbaoB5rk0mmxknpjXg98h57jCF1j6AiaGwmtEwMQw7Z7laWbxHgollbcEZ3VZLnbI16umqMVRNnvcPaLPxKwv/vS46cgBbXiV6SgnW+FlZ2AGBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780166113; c=relaxed/simple;
	bh=vlm829tCfVfZ/avFjur2nQ/irr6Cs8d178bs2LWzKbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j6t9gom/BuxBgwv4YGDmCslMUL7hPk8a4vVQ3JQa0FhsMOiX13oehOsEWsYVgJiYzsCgkRlbN8luqaSlQ+ZmVNVQHy7DfyS3oXjGYSnXj4ja2N17whUNdrBVeDPeuI79vdcSdjprq3BsDsOtG6rgTAd7uItIggfD9fOwqLCeqUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MJHj3Q/Y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E0E1F00893;
	Sat, 30 May 2026 18:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780166112;
	bh=GBSyGFi+7T3pGhUqxYs1beEFUv65TF5S7iehGBPqbsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MJHj3Q/Yf3pDNK4Jg1XMbOc2zw4Q+hJLdnxQJsJA0H5UAE/G0DbVymrSMmHN5oppp
	 u7tgGZWnkFPvac37PyOVFyZmSc9erU3qOtDkoXraBmsv1snNinDc248jyF0EUx/Usy
	 7N6I+YdgCDSvtdEEEAIY7iJMMFUXWNM+DNKVBc7w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"John B. Moore" <jbmoore61@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.10 276/589] drm/amdgpu/gfx9: drop unnecessary 64-bit fence flag check in KIQ
Date: Sat, 30 May 2026 18:02:37 +0200
Message-ID: <20260530160232.223477785@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258957-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,amd.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,amd.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B7E7361207B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5433,9 +5433,6 @@ static void gfx_v9_0_ring_emit_fence_kiq
 {
 	struct amdgpu_device *adev = ring->adev;
 
-	/* we only allocate 32bit for each seq wb address */
-	BUG_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
-
 	/* write fence seq to the "addr" */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
 	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |



