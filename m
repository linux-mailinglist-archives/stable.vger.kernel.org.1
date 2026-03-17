Return-Path: <stable+bounces-225915-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMpII1lOuWnj/wEAu9opvQ
	(envelope-from <stable+bounces-225915-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:51:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 315142AA240
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A45C3020219
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BD53C5DDF;
	Tue, 17 Mar 2026 12:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WYcsZiPR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676543C5DBF
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 12:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773751895; cv=none; b=IyPFOW5c5MRAbpqwq+lY8HHXCBPeBtQWrinkpz9hKNVyULPczV/XxDltm8A3MqKmd7wheXbyIJeJQ0axfXYtaVS4MQZxkcBsRSvz7R4uC3PYPpKv1aNIq4Y/V+EDbo5NR13i3RkjK4ZkEABFxhmNfPTcWr67FRK1+1Wcm5dlz9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773751895; c=relaxed/simple;
	bh=I74dgvMNo+aZHq7Nze5SXJhC9LyrytZzRo77g9fpvI4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=E8hcoqL0VJNZhAxQgEosi3fJLRc+vLMjvXv6aUh0bXtFxCDWAOck0cQvq+QnxpbEBzT/suw3KhbeUMkwWbgVM5T2JdIBDp4timm6wXnjDIrh/1UfMMkcTaZoIlPMt6cKcl4P7FhiGheuMa3mizFZTFlLTJKi7qW09N88JyvrRMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WYcsZiPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAFBC4CEF7;
	Tue, 17 Mar 2026 12:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773751895;
	bh=I74dgvMNo+aZHq7Nze5SXJhC9LyrytZzRo77g9fpvI4=;
	h=Subject:To:Cc:From:Date:From;
	b=WYcsZiPRrY46pDM6sRVnYDC3bA85Al4nbSeWM/3vTPKp7yT9owLMWgoXOC9gpFyyc
	 8w1S7/u4ZZ7+nyfSiHGew3yPK2kvvbi9NnvAeyI7LmlR4jt6/TcH7KrbLKhMOGrAWk
	 trYNqS/ffz3CJ3TnIp1kSyMvthFnPJkdwe1agsE0=
Subject: FAILED: patch "[PATCH] drm/i915/vrr: Configure VRR timings after enabling" failed to apply to 6.18-stable tree
To: ville.syrjala@linux.intel.com,ankit.k.nautiyal@intel.com,bentiss@kernel.org,tursulin@ursulin.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 13:51:32 +0100
Message-ID: <2026031731-washstand-aged-f7fc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225915-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,intel.com:email,linuxfoundation.org:dkim,ursulin.net:email,msgid.link:url,gitlab.freedesktop.org:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 315142AA240
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 237aab549676288d9255bb8dcc284738e56eaa31
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031731-washstand-aged-f7fc@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 237aab549676288d9255bb8dcc284738e56eaa31 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Date: Tue, 3 Mar 2026 11:54:14 +0200
Subject: [PATCH] drm/i915/vrr: Configure VRR timings after enabling
 TRANS_DDI_FUNC_CTL
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 3b8ba8ab76a1..c4246481fc2f 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -1614,7 +1614,6 @@ static void hsw_configure_cpu_transcoder(const struct intel_crtc_state *crtc_sta
 	}
 
 	intel_set_transcoder_timings(crtc_state);
-	intel_vrr_set_transcoder_timings(crtc_state);
 
 	if (cpu_transcoder != TRANSCODER_EDP)
 		intel_de_write(display, TRANS_MULT(display, cpu_transcoder),
diff --git a/drivers/gpu/drm/i915/display/intel_vrr.c b/drivers/gpu/drm/i915/display/intel_vrr.c
index db74744ddb31..bea005752327 100644
--- a/drivers/gpu/drm/i915/display/intel_vrr.c
+++ b/drivers/gpu/drm/i915/display/intel_vrr.c
@@ -597,6 +597,18 @@ void intel_vrr_set_transcoder_timings(const struct intel_crtc_state *crtc_state)
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
@@ -939,6 +951,8 @@ void intel_vrr_transcoder_enable(const struct intel_crtc_state *crtc_state)
 {
 	struct intel_display *display = to_intel_display(crtc_state);
 
+	intel_vrr_set_transcoder_timings(crtc_state);
+
 	if (!intel_vrr_possible(crtc_state))
 		return;
 


