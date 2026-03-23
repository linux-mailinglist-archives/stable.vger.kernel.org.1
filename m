Return-Path: <stable+bounces-228783-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Bh4BgtpwWmoSwQAu9opvQ
	(envelope-from <stable+bounces-228783-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:23:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8172F8008
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B49D32470DF
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6674E3A9616;
	Mon, 23 Mar 2026 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K4Zt8uzQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B0F33CE9A;
	Mon, 23 Mar 2026 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277112; cv=none; b=TfiBbw3ZwXZLjMDb5Oc7sIady/AHg2aGCbXtowgq601EcGxVbn0yrkEbs9+laVI21F3OY5uq8/NVlan9EgNmx/I6UPdtZCmOhyCNqd288noabdAzxJsPcAa8a2QzygbrP68mPE3vZLDxq/7D7npvY1LdwfI/0Tcu1TrYrc0jr0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277112; c=relaxed/simple;
	bh=Q99zAEX3Uoi+G/F1FPPYu9EDElQfFbMUEfD/bHI/TuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CoV3FI7EkCdjQXhgpJb/bOR8WhFfnOxa7bPK6TO95dyJPhCGtYaOiMP5r3rZAw9w2nKddE9r8wV/+V2FDF2/+aw7uwXWvsk4LHTiPxubIpVrdjum7UUu9bsr+A6fivVK3n+1MfLEBF1z4mssvGSFx+NGiHig5ORlVsjm2H168/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K4Zt8uzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889EFC4CEF7;
	Mon, 23 Mar 2026 14:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277112;
	bh=Q99zAEX3Uoi+G/F1FPPYu9EDElQfFbMUEfD/bHI/TuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K4Zt8uzQWLQzTL0FQaI8l/zs/yAAxSiqK30GxCjlDht/Wzvo5AT+TqFxsrrxYL36n
	 k8WTyNsjKFMSJF/zPSCNCBabHXbtEvkMKF3b7NRBExGddH/9sU4y2IfzP0cvzIZ/84
	 gkGS9q3oPaKL1t42wSoqCUIR+VFU+1xNYINWPIdM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: [PATCH 6.12 324/460] drm/i915/psr: Write DSC parameters on Selective Update in ET mode
Date: Mon, 23 Mar 2026 14:45:20 +0100
Message-ID: <20260323134534.468164645@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-228783-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,ursulin.net:email,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 9E8172F8008
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jouni Högander <jouni.hogander@intel.com>

commit 5923a6e0459fdd3edac4ad5abccb24d777d8f1b6 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/display/intel_psr.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -41,6 +41,7 @@
 #include "intel_psr.h"
 #include "intel_psr_regs.h"
 #include "intel_snps_phy.h"
+#include "intel_vdsc.h"
 #include "skl_universal_plane.h"
 
 /**
@@ -2312,6 +2313,12 @@ void intel_psr2_program_trans_man_trk_ct
 
 	intel_de_write(display, PIPE_SRCSZ_ERLY_TPT(crtc->pipe),
 		       crtc_state->pipe_srcsz_early_tpt);
+
+	if (!crtc_state->dsc.compression_enable)
+		return;
+
+	intel_dsc_su_et_parameters_configure(NULL, encoder, crtc_state,
+					     drm_rect_height(&crtc_state->psr2_su_area));
 }
 
 static void psr2_man_trk_ctl_calc(struct intel_crtc_state *crtc_state,
@@ -2693,6 +2700,10 @@ int intel_psr2_sel_fetch_update(struct i
 	}
 
 skip_sel_fetch_set_loop:
+	if (full_update)
+		clip_area_update(&crtc_state->psr2_su_area, &crtc_state->pipe_src,
+				 &crtc_state->pipe_src);
+
 	psr2_man_trk_ctl_calc(crtc_state, full_update);
 	crtc_state->pipe_srcsz_early_tpt =
 		psr2_pipe_srcsz_early_tpt_calc(crtc_state, full_update);



