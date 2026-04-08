Return-Path: <stable+bounces-235153-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAs5Hpir1mmZHAgAu9opvQ
	(envelope-from <stable+bounces-235153-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:25:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF133C2EFC
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2575530E7723
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18163357A20;
	Wed,  8 Apr 2026 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vsM/X2Yt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01D53176E4;
	Wed,  8 Apr 2026 18:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674705; cv=none; b=CFZCBvL/8jkWzK9aUnxQJaeQXZ0tLQ2vAGVHuARNTzZ/zdObbjCqeB1MMAQCTBbJBccL3orjYktXrGsaGC50nBJDylqmHwtNL7abJIFasm7BDABxstBzhOvNf5ew/mnHikmbDHuY9avr28oVeaaChMWLMPJQGNekX0b8cEY74hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674705; c=relaxed/simple;
	bh=CDPUHbJbj4CFn+8npsgRtLW2Qv8hveX5SIKJ1Rt//TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dmb9MS59dFt5/y2MJZ6Nlb7CbBk7W1ceURufA9LTGyKAUCDpJa70KGXz3YB4Ep4iTzP3gSDxahAamBaScQEbDaDSYJWxf9DqgSu6bd1JqDNbMDPhh/WjBCeDtNoAvQogiNclsVeLuC9tprOWpa3V/y/z6a/h9e/Fzto3Z2qw/ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vsM/X2Yt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E61C2BC87;
	Wed,  8 Apr 2026 18:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674705;
	bh=CDPUHbJbj4CFn+8npsgRtLW2Qv8hveX5SIKJ1Rt//TA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vsM/X2Yt5MFXFJ0xV8uWdjtg5A5rpAOEnUioXJ8f7nBlhxoxh8YBD5hPfI6moXAxA
	 lRJwnCdTL5A9n5FqfauzBXVceLoNAnyK5OBn+cGww0mIOzS7Qi76Ibnk8sPVG81nCE
	 iOx2+7g4wsNvZxtAAy3pFuxPBG2tOAyAekoNyWyE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	=?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 6.19 201/311] drm/i915/dp: Use crtc_state->enhanced_framing properly on ivb/hsw CPU eDP
Date: Wed,  8 Apr 2026 20:03:21 +0200
Message-ID: <20260408175946.916548142@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235153-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: DEF133C2EFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 9c9a57e4e337f94e23ddf69263fd0685c91155fb upstream.

Looks like I missed the drm_dp_enhanced_frame_cap() in the ivb/hsw CPU
eDP code when I introduced crtc_state->enhanced_framing. Fix it up so
that the state we program to the hardware is guaranteed to match what
we computed earlier.

Cc: stable@vger.kernel.org
Fixes: 3072a24c778a ("drm/i915: Introduce crtc_state->enhanced_framing")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patch.msgid.link/20260325135849.12603-3-ville.syrjala@linux.intel.com
Reviewed-by: Michał Grzelak <michal.grzelak@intel.com>
(cherry picked from commit 799fe8dc2af52f35c78c4ac97f8e34994dfd8760)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/display/g4x_dp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/display/g4x_dp.c
+++ b/drivers/gpu/drm/i915/display/g4x_dp.c
@@ -137,7 +137,7 @@ static void intel_dp_prepare(struct inte
 			intel_dp->DP |= DP_SYNC_VS_HIGH;
 		intel_dp->DP |= DP_LINK_TRAIN_OFF_CPT;
 
-		if (drm_dp_enhanced_frame_cap(intel_dp->dpcd))
+		if (pipe_config->enhanced_framing)
 			intel_dp->DP |= DP_ENHANCED_FRAMING;
 
 		intel_dp->DP |= DP_PIPE_SEL_IVB(crtc->pipe);



