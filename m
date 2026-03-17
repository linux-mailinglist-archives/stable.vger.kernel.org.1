Return-Path: <stable+bounces-226013-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFp0JE1WuWnYAgIAu9opvQ
	(envelope-from <stable+bounces-226013-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:25:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D652AACF3
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15DE130774E7
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E493CB2EA;
	Tue, 17 Mar 2026 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1gK0xVL7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C45B3CB2C3
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773753845; cv=none; b=XCjEsBEY5B6o17TVp34cS3ntx2VsYoNn99scz+AflcTP4cMds2YhoRofVSUBO/IQ0KsvO2Cg2T1OA0+8iRMwvT5Uvt4PZGUDsdNHTUibq21EoDeh5gsgeGDn/IWExBQPdon7xaA8dfM7Ejzumz8U5dCHjXYqyszrgypM3fuIZ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773753845; c=relaxed/simple;
	bh=sSYgA3nAmktQXG2xBEPKnGK7z5pFaYVfx4e/SThqzm8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=l0NuTPUXw+PyNmRj8y2zok1r3Z7xY4UrNlN/JFI9+sIoI3U11cS0OiBFoihDAy0ArP2D4XiHYoemIT6mLewr8bjzAlVBcASYKhTfamNxzmyOMaCEYh3bcywkpNqBn35jL0nxlSFAXSypSjD8XdcAknxdHarLfvYT8EPiQzFfwMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1gK0xVL7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6A6C19425;
	Tue, 17 Mar 2026 13:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773753845;
	bh=sSYgA3nAmktQXG2xBEPKnGK7z5pFaYVfx4e/SThqzm8=;
	h=Subject:To:Cc:From:Date:From;
	b=1gK0xVL7xDjdwt+JEaPK+gu6lbpuG7VmtSkghX3DmULD4KnAVcu86fy9IZUTPdTFd
	 Sk4l0DV3qAl8aAvvvPwfPr9WlPUHXnvbG2wrXJS7Pn5deEcQSNS1Ieu2ZZVxPNtV73
	 b92w+od9RwVwMACwO47AdHBcFlEbBtCWrdIQg6Qk=
Subject: FAILED: patch "[PATCH] drm/i915/psr: Write DSC parameters on Selective Update in ET" failed to apply to 6.18-stable tree
To: jouni.hogander@intel.com,ankit.k.nautiyal@intel.com,stable@vger.kernel.org,tursulin@ursulin.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 14:23:59 +0100
Message-ID: <2026031759-ravine-derived-5582@gregkh>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226013-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[gregkh:query timed out];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[ursulin.net:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 32D652AACF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 5923a6e0459fdd3edac4ad5abccb24d777d8f1b6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031759-ravine-derived-5582@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5923a6e0459fdd3edac4ad5abccb24d777d8f1b6 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
Date: Wed, 4 Mar 2026 13:30:11 +0200
Subject: [PATCH] drm/i915/psr: Write DSC parameters on Selective Update in ET
 mode
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There are slice row per frame and pic height parameters in DSC that needs
to be configured on every Selective Update in Early Transport mode. Use
helper provided by DSC code to configure these on Selective Update when in
Early Transport mode. Also fill crtc_state->psr2_su_area with full frame
area on full frame update for DSC calculation.

v2: move psr2_su_area under skip_sel_fetch_set_loop label

Bspec: 68927, 71709
Fixes: 467e4e061c44 ("drm/i915/psr: Enable psr2 early transport as possible")
Cc: <stable@vger.kernel.org> # v6.9+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Link: https://patch.msgid.link/20260304113011.626542-5-jouni.hogander@intel.com
(cherry picked from commit 3140af2fab505a4cd47d516284529bf1585628be)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 3848cd4fba0e..b7302a32ded4 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -2619,6 +2619,12 @@ void intel_psr2_program_trans_man_trk_ctl(struct intel_dsb *dsb,
 
 	intel_de_write_dsb(display, dsb, PIPE_SRCSZ_ERLY_TPT(crtc->pipe),
 			   crtc_state->pipe_srcsz_early_tpt);
+
+	if (!crtc_state->dsc.compression_enable)
+		return;
+
+	intel_dsc_su_et_parameters_configure(dsb, encoder, crtc_state,
+					     drm_rect_height(&crtc_state->psr2_su_area));
 }
 
 static void psr2_man_trk_ctl_calc(struct intel_crtc_state *crtc_state,
@@ -3040,6 +3046,10 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 	}
 
 skip_sel_fetch_set_loop:
+	if (full_update)
+		clip_area_update(&crtc_state->psr2_su_area, &crtc_state->pipe_src,
+				 &crtc_state->pipe_src);
+
 	psr2_man_trk_ctl_calc(crtc_state, full_update);
 	crtc_state->pipe_srcsz_early_tpt =
 		psr2_pipe_srcsz_early_tpt_calc(crtc_state, full_update);


