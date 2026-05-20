Return-Path: <stable+bounces-251795-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEbrAG4BDmo95QUAu9opvQ
	(envelope-from <stable+bounces-251795-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:46:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F928597330
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E93903250029
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827EC3EC2DB;
	Wed, 20 May 2026 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DS42pHQu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A27E36D9EA;
	Wed, 20 May 2026 17:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298910; cv=none; b=UrPpGQ56UK36FPsBLEA1betzkK36M1ZhH9wJjLQ2IIPXKtLJyzQt71Umlcd1tWYxAMopKIwFEPal2rR7oEHDKKTpEdee8JfWW1G7sIL8OSRrvF4YQJFzoK9dVVr5tL/3PlHVU6kSjDFEVylDOcsWWM2E7SbfUnMl9tst8O9kDgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298910; c=relaxed/simple;
	bh=qiFzu6eRzwSsOh4cQc9AJsS0XkOErEA0+Mbh0+F+3ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gg4AeA8l7LKo4iV3isHNZULPQkbL9IP+gF4v4efWAFjLN1ry5KCzuxdEGCyAa23ZTVKRY4/EHIR3BPpYk8zFJtGngPyUzCLJZ4HL96/aEt+KO1yz7YGX9PkSMhaTXE/LK7HF23NGfulsh8eMTXsOzuxtV415fL2QaypKbe1RNGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DS42pHQu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2C21F000E9;
	Wed, 20 May 2026 17:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298909;
	bh=VrR41/bRoWqE5KQi54+JJgxjBgRGrSe8MCeXFrIIkg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DS42pHQu7C4XdJMXWXP4DBIFe/8bHWzbxNlc+xmJRWD4zaUhIjUCoMfyE3uDoyDPj
	 GHvZYrVx00QJ6M2lH7Uzw8CuUws5gzHI99FACf+HrjAG1FdJ1TtbiJ51Ry+TTIB4UE
	 VF2g9VygO1JwcB0cNSw8lHrqkkXTEwe6cW9fT1rI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Vinod Govindapillai <vinod.govindapillai@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 591/957] drm/i915/wm: Verify the correct plane DDB entry
Date: Wed, 20 May 2026 18:17:54 +0200
Message-ID: <20260520162147.347473311@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251795-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: 2F928597330
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

[ Upstream commit a97c88a176b6b8d116f4d3f508f3bd02bc77b462 ]

Actually verify the DDB entry for the plane we're looking
at instead of always verifying the cursor DDB.

Fixes: 7d4561722c3b ("drm/i915: Tweak plane ddb allocation tracking")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patch.msgid.link/20260324134843.2364-5-ville.syrjala@linux.intel.com
Reviewed-by: Vinod Govindapillai <vinod.govindapillai@intel.com>
(cherry picked from commit f002f7c7439de18117a31ca84dc87a59719c3dd6)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/skl_watermark.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/skl_watermark.c b/drivers/gpu/drm/i915/display/skl_watermark.c
index d74cbb43ae6fb..a5862998bf144 100644
--- a/drivers/gpu/drm/i915/display/skl_watermark.c
+++ b/drivers/gpu/drm/i915/display/skl_watermark.c
@@ -3935,8 +3935,8 @@ void intel_wm_state_verify(struct intel_atomic_state *state,
 		}
 
 		/* DDB */
-		hw_ddb_entry = &hw->ddb[PLANE_CURSOR];
-		sw_ddb_entry = &new_crtc_state->wm.skl.plane_ddb[PLANE_CURSOR];
+		hw_ddb_entry = &hw->ddb[plane->id];
+		sw_ddb_entry = &new_crtc_state->wm.skl.plane_ddb[plane->id];
 
 		if (!skl_ddb_entry_equal(hw_ddb_entry, sw_ddb_entry)) {
 			drm_err(display->drm,
-- 
2.53.0




