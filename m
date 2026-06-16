Return-Path: <stable+bounces-264868-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a65mOD9/MWqCkwUAu9opvQ
	(envelope-from <stable+bounces-264868-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:52:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 416F669287C
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:52:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=rjGQZwfj;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264868-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-264868-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70B0B306CC7D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBE647A0D4;
	Tue, 16 Jun 2026 16:45:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDA0477E57;
	Tue, 16 Jun 2026 16:45:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628312; cv=none; b=pcXGiRgmFohKy1bY/vIFwoEgm4GOhGHOrw2vDcgiFd2iWq/0sZuxbKulHyIHG6kHuhWHz30Jo2TUtgdPMog13VyvPMOs38en3bBBEn5XKax2PfrHuCP8nWuMAPscjge/fqh3+mmXFkSRUHbyK3dsYyZPuEkyunzbUu5a0tL3/lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628312; c=relaxed/simple;
	bh=/OMyJllvC27mDpmUL8w+XqsRzbDJGeGA0ZQ4Ycm6Hfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPgslVs9mlk1wlW3N77oPJhxlW+FiyuS4NWAPUrUg46Gjn7enr69wXPILFATG39LtReFdjnm1OF6OiwVGHxFPsEOBmFL4WIstI4kv5OsVusbeEaZ3fK2UVby2BkbZ6gaQntX39jSw1XLBt+CFZpkAbmj93Y3v1jhTY42AtikQ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rjGQZwfj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64AE31F000E9;
	Tue, 16 Jun 2026 16:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781628311;
	bh=vNWhpDAFEiOUwMFfYJDZyhRU//Hvhj3qwoVZVH23C94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rjGQZwfjnUx9t9upFTEwNmvBATDHt0QXOVprhPpzA03Y2zm9LAgcwxX50GESf2Mgf
	 rWXE3Lf4PpZuMDvEZnkdXqQ6KuR4dUHe0RY5M/GRo17e5vMc7v/Fd9sQuoQKsNJcT4
	 63zZTePPfXHiUc5CwQphEaLXBSwTEU6ntzxSlps8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 070/452] drm/i915/psr: Read Intel DPCD workaround register
Date: Tue, 16 Jun 2026 20:24:57 +0530
Message-ID: <20260616145121.605118652@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264868-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jouni.hogander@intel.com,m:suraj.kandpal@intel.com,m:tursulin@ursulin.net,m:sashal@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url,ursulin.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 416F669287C

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jouni Högander <jouni.hogander@intel.com>

commit f30bece421a4ae34359254e1dc2a187a42b6af9b upstream.

Read Intel DPCD workaround register and store it into
intel_connector->dp.psr_caps. psr_caps was chosen as currently it contains
only PSR workaround for PSR2 SDP on prior scanline implementation.

Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Link: https://patch.msgid.link/20260515095756.2799483-3-jouni.hogander@intel.com
(cherry picked from commit c48ff24d0f4ab7ad696b2d35ad64ce7e049c668c)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_display_types.h | 1 +
 drivers/gpu/drm/i915/display/intel_psr.c           | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 1c23b186aff20c..3a228cfb1550f2 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1719,6 +1719,7 @@ struct intel_dp {
 	u8 lttpr_phy_caps[DP_MAX_LTTPR_COUNT][DP_LTTPR_PHY_CAP_SIZE];
 	u8 fec_capable;
 	u8 pcon_dsc_dpcd[DP_PCON_DSC_ENCODER_CAP_SIZE];
+	u8 intel_wa_dpcd;
 	/* source rates */
 	int num_source_rates;
 	const int *source_rates;
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index b0818dc8480edb..49842f7877f435 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -31,6 +31,7 @@
 #include "intel_de.h"
 #include "intel_display_types.h"
 #include "intel_dp.h"
+#include "intel_dpcd.h"
 #include "intel_dp_aux.h"
 #include "intel_hdmi.h"
 #include "intel_psr.h"
@@ -528,6 +529,12 @@ void intel_psr_init_dpcd(struct intel_dp *intel_dp)
 			intel_dp_get_su_granularity(intel_dp);
 		}
 	}
+
+	if (intel_dp->psr.sink_psr2_support)
+		drm_dp_dpcd_read(&intel_dp->aux,
+				 INTEL_DPCD_INTEL_WA_REGISTER_CAPS,
+				 &intel_dp->intel_wa_dpcd,
+				 sizeof(intel_dp->intel_wa_dpcd));
 }
 
 static void hsw_psr_setup_aux(struct intel_dp *intel_dp)
-- 
2.53.0




