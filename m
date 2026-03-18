Return-Path: <stable+bounces-227118-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HgfAiffumk3cwIAu9opvQ
	(envelope-from <stable+bounces-227118-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 18:21:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 601C32C0287
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 18:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B9893363C35
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C103F87E3;
	Wed, 18 Mar 2026 16:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fD0HNyhY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67BF3DE424
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773850464; cv=none; b=pk0+olby+P2NIsl3BAbcuBL2dOt7L07Cz1ImaziLz/umoMJN51o6Yg51b3mNN4NbZ7xkNIe2zXy8jtC3OH+2/OYttBAxYRFhoBzCBzR7wTmD9xOPiBrT6cBVDxJ2tqubNH8vmIHa6p6ikXJyRCfrcYuapOh4L5my90ksLRPTjGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773850464; c=relaxed/simple;
	bh=wUWxgoLDSgR8Ts7939fvINacoY5NX30fXrO02Rr8ZeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0TT0Xpc2fyHPi2NPdrHR7L6q5VffFxysbGFeRSEmajvy1XZUoT2iZqY8Cg45JAs5UmRCPY3X17L18gNknXQRyJIN/FCeFcUnm/BZfRGcG0Y0JJ8BpAnb20nTyqilY50cQSC1KOxa3arMKpyX3+lDD+0uhYhv6okTAtBwKouYzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fD0HNyhY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD9AC19421;
	Wed, 18 Mar 2026 16:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773850464;
	bh=wUWxgoLDSgR8Ts7939fvINacoY5NX30fXrO02Rr8ZeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fD0HNyhY9kG3BpjxmLZpZfLNV0qDJ2PK9NQ7cjtsJdZNHWURHdmK8dSnUdmzxaGg3
	 K7IJz9NN9oWeG4uwFIguW2MSXV54Deo/sJuNLsqpfAA2Ut5ZdINW0vZ1KPt0PSD5pI
	 7QSxkF31j5Y9Rx3QtURxtE4ZMA8i94vohOoQ4TCM/R5SEbZ6XxRXizQYyhRlQ9r6MC
	 ZsSKk22+nb4YnCeMVB4x9DekJiAs8Ww9H6DUxmKQ7i99aOB4gCZBlqxVEIhyKtJVGv
	 fZzHqrZeqXRW6ifXCAedQ5gwK2GqMyFCoAEM1JkkGoC1gEY/zKIg+FvnCB9hge57Ia
	 kzd1Fi1nKOM5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] drm/i915/vrr: Move HAS_VRR() check into intel_vrr_set_transcoder_timings()
Date: Wed, 18 Mar 2026 12:14:16 -0400
Message-ID: <20260318161417.911716-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031731-washstand-aged-f7fc@gregkh>
References: <2026031731-washstand-aged-f7fc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227118-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 601C32C0287
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

[ Upstream commit 78ea8eb5b6235b3ef68fa0fb8ffe0b3b490baf38 ]

Reduce the clutter in hsw_configure_cpu_transcoder() a bit by moving
the HAS_VRR() check into intel_vrr_set_transcoder_timings().

Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20251020185038.4272-18-ville.syrjala@linux.intel.com
Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Stable-dep-of: 237aab549676 ("drm/i915/vrr: Configure VRR timings after enabling TRANS_DDI_FUNC_CTL")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_display.c | 3 +--
 drivers/gpu/drm/i915/display/intel_vrr.c     | 3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 0d527cf228666..b0614f680c74a 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -1642,8 +1642,7 @@ static void hsw_configure_cpu_transcoder(const struct intel_crtc_state *crtc_sta
 	}
 
 	intel_set_transcoder_timings(crtc_state);
-	if (HAS_VRR(display))
-		intel_vrr_set_transcoder_timings(crtc_state);
+	intel_vrr_set_transcoder_timings(crtc_state);
 
 	if (cpu_transcoder != TRANSCODER_EDP)
 		intel_de_write(display, TRANS_MULT(display, cpu_transcoder),
diff --git a/drivers/gpu/drm/i915/display/intel_vrr.c b/drivers/gpu/drm/i915/display/intel_vrr.c
index 3eed37f271b02..98819890d8d90 100644
--- a/drivers/gpu/drm/i915/display/intel_vrr.c
+++ b/drivers/gpu/drm/i915/display/intel_vrr.c
@@ -461,6 +461,9 @@ void intel_vrr_set_transcoder_timings(const struct intel_crtc_state *crtc_state)
 	struct intel_display *display = to_intel_display(crtc_state);
 	enum transcoder cpu_transcoder = crtc_state->cpu_transcoder;
 
+	if (!HAS_VRR(display))
+		return;
+
 	/*
 	 * This bit seems to have two meanings depending on the platform:
 	 * TGL: generate VRR "safe window" for DSB vblank waits
-- 
2.51.0


