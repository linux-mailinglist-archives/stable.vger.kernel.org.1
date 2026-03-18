Return-Path: <stable+bounces-227119-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDXGBi7VummfcAIAu9opvQ
	(envelope-from <stable+bounces-227119-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 17:39:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 628892BF6AD
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 17:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25BB0305092E
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B98A3FAE08;
	Wed, 18 Mar 2026 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVO3wG9i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF2C3EBF3F
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 16:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773850465; cv=none; b=bSloR7EkOcWWbexjRV5JtJRSKE7ZSRQlTnrPLpZcmWEySqRq2OjYO/0719CE2FKYaL4R5dr5oggPXOAmc8sWXs3kqYsFFsqu9MbUMXliJ1ynxlbDG6QZ7Vy48+WDP6k6Cwj3DB/0tXCATNFZc+/K4rikP/nGKQviHJXefKSGKvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773850465; c=relaxed/simple;
	bh=GPhIOa7o9CPlygP4I/A3uXloHclOKBiiHJvV4FbFfvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hFJHESIoEEkKBDNIjPLQ0yxMwJJi7c9FSZfZkuod+3En+LciXsD+l+uL25ekmVFd5Jbwf8wFiTJ950Ux+VkyF+W0ecOvkKj3fIEkGvkj8ZsFMXdQe7I/G5sAAvUrdGfe/bOT6z08IPhnPSBvrJrc34KpK4phSn6OSExT5IjZdxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVO3wG9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73782C2BCB1;
	Wed, 18 Mar 2026 16:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773850465;
	bh=GPhIOa7o9CPlygP4I/A3uXloHclOKBiiHJvV4FbFfvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FVO3wG9ilNZF2pux6BTbU1saL/CeMP1b1dE3kO829uE7HyRw88KHWOw96Tl/dc7Z4
	 CdkoEDOiA87QwlQS/ABEYdRvQabJSQ4da8vilThRdq2N9jRTYd7IgdF8B7El9g2zM7
	 Njn6xizNS68Dg+kpxThn/wlEnj00b2C2owVv3vlDwbxCLJdJ6OnywRX0L3LzNm9Z6Q
	 NKG3ZzTGYhZxw/F6+KH3lIx9NBRnrtMaHgCsiJKlMtX5mo74fAlPXkEe+YSnAhNJCT
	 IQbBbJvVXfUH37R/AG8GZkXEGwcmSGpBY/oomvwa3XRE0wmn2ceiOnnC/8oWQQiAWB
	 +h3Prbbv6qNFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] drm/i915/vrr: Configure VRR timings after enabling TRANS_DDI_FUNC_CTL
Date: Wed, 18 Mar 2026 12:14:17 -0400
Message-ID: <20260318161417.911716-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260318161417.911716-1-sashal@kernel.org>
References: <2026031731-washstand-aged-f7fc@gregkh>
 <20260318161417.911716-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227119-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,intel.com:email,ursulin.net:email,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: 628892BF6AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

[ Upstream commit 237aab549676288d9255bb8dcc284738e56eaa31 ]

Apparently ICL may hang with an MCE if we write TRANS_VRR_VMAX/FLIPLINE
before enabling TRANS_DDI_FUNC_CTL.

Personally I was only able to reproduce a hang (on an Dell XPS 7390
2-in-1) with an external display connected via a dock using a dodgy
type-C cable that made the link training fail. After the failed
link training the machine would hang. TGL seemed immune to the
problem for whatever reason.

BSpec does tell us to configure VRR after enabling TRANS_DDI_FUNC_CTL
as well. The DMC firmware also does the VRR restore in two stages:
- first stage seems to be unconditional and includes TRANS_VRR_CTL
  and a few other VRR registers, among other things
- second stage is conditional on the DDI being enabled,
  and includes TRANS_DDI_FUNC_CTL and TRANS_VRR_VMAX/VMIN/FLIPLINE,
  among other things

So let's reorder the steps to match to avoid the hang, and
toss in an extra WARN to make sure we don't screw this up later.

BSpec: 22243
Cc: stable@vger.kernel.org
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Reported-by: Benjamin Tissoires <bentiss@kernel.org>
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/15777
Tested-by: Benjamin Tissoires <bentiss@kernel.org>
Fixes: dda7dcd9da73 ("drm/i915/vrr: Use fixed timings for platforms that support VRR")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patch.msgid.link/20260303095414.4331-1-ville.syrjala@linux.intel.com
Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
(cherry picked from commit 93f3a267c3dd4d811b224bb9e179a10d81456a74)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_display.c |  1 -
 drivers/gpu/drm/i915/display/intel_vrr.c     | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index b0614f680c74a..decb9f3dd71cb 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -1642,7 +1642,6 @@ static void hsw_configure_cpu_transcoder(const struct intel_crtc_state *crtc_sta
 	}
 
 	intel_set_transcoder_timings(crtc_state);
-	intel_vrr_set_transcoder_timings(crtc_state);
 
 	if (cpu_transcoder != TRANSCODER_EDP)
 		intel_de_write(display, TRANS_MULT(display, cpu_transcoder),
diff --git a/drivers/gpu/drm/i915/display/intel_vrr.c b/drivers/gpu/drm/i915/display/intel_vrr.c
index 98819890d8d90..04a2ea086fb2e 100644
--- a/drivers/gpu/drm/i915/display/intel_vrr.c
+++ b/drivers/gpu/drm/i915/display/intel_vrr.c
@@ -464,6 +464,18 @@ void intel_vrr_set_transcoder_timings(const struct intel_crtc_state *crtc_state)
 	if (!HAS_VRR(display))
 		return;
 
+	/*
+	 * Bspec says:
+	 * "(note: VRR needs to be programmed after
+	 *  TRANS_DDI_FUNC_CTL and before TRANS_CONF)."
+	 *
+	 * In practice it turns out that ICL can hang if
+	 * TRANS_VRR_VMAX/FLIPLINE are written before
+	 * enabling TRANS_DDI_FUNC_CTL.
+	 */
+	drm_WARN_ON(display->drm,
+		    !(intel_de_read(display, TRANS_DDI_FUNC_CTL(display, cpu_transcoder)) & TRANS_DDI_FUNC_ENABLE));
+
 	/*
 	 * This bit seems to have two meanings depending on the platform:
 	 * TGL: generate VRR "safe window" for DSB vblank waits
@@ -658,6 +670,8 @@ void intel_vrr_transcoder_enable(const struct intel_crtc_state *crtc_state)
 	if (!HAS_VRR(display))
 		return;
 
+	intel_vrr_set_transcoder_timings(crtc_state);
+
 	if (!intel_vrr_possible(crtc_state))
 		return;
 
-- 
2.51.0


