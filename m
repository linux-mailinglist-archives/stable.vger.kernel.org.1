Return-Path: <stable+bounces-253146-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBdjJXouDmoK7wUAu9opvQ
	(envelope-from <stable+bounces-253146-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:58:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEFD59B8A6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C62793968412
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5F934EEF7;
	Wed, 20 May 2026 18:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="btPf7cFw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8363E2AAD;
	Wed, 20 May 2026 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302526; cv=none; b=mTzmKtzJuJbbE0OmNvvv8wLUzBOap4zhsuJ/oqucSOpob6G0f4JWPgA56TiT6GSp7tQAGvIAd4Z3diBuqZmt/1hRjSe8QoBZsxVcAWhzBAVWdta0/3anr+UkqipZzu+wvFWqjelb4Fo+yVlNJDuSFXtB5Vk8ILZhmQfxumoPFk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302526; c=relaxed/simple;
	bh=OjQvy2iIlVdOrFAqp06mTNPH2HpYI1lyG/M37Ouo9t4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1UqjwPSOSybw9lhrAJUeYusmpgZr3eHJvYNynbTu15dIVwOBPmcfZxyAM5qs6Pq9uOXFdOtt+M6BlsQpkvMAtOYYUz3miJtXwuHDGNkcLnM5S/A2h2RmdqTMzN1W8PbmwQ1eF/ZX+2GYfVzex0k7ommN/eI3/cNFMWfzvX3240=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=btPf7cFw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855B91F000E9;
	Wed, 20 May 2026 18:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779302525;
	bh=Iz9BOoduRC9kAB8p5fGsywAHSakMOxD9rN/7941skmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=btPf7cFwJB3aLJo3YJi0HHLZeOxTP1QccR9YaJABZF5tUPIVl5p8h862ogJbCGjeJ
	 S+IYX1T1VEaeRD0RJr4dz6WLNH/Njv1wR8PUQv+liB53nb9MbpIqvVPEt1xQv3sJfO
	 mkukpFrN4GW1wZ9dPW+Rt572Fm5+SbNJEBCwGcJw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Uma Shankar <uma.shankar@intel.com>,
	Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 298/508] drm/i915: Loop over all active pipes in intel_mbus_dbox_update
Date: Wed, 20 May 2026 18:22:01 +0200
Message-ID: <20260520162105.100165862@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253146-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 1EEFD59B8A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>

[ Upstream commit e8333ab22cd8c750b7c14d3da7c0eef3ba85527f ]

We need to loop through all active pipes, not just the ones, that
are in current state, because disabling and enabling even a particular
pipe affects credits in another one.

Reviewed-by: Uma Shankar <uma.shankar@intel.com>
Signed-off-by: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240402155016.13733-6-ville.syrjala@linux.intel.com
Stable-dep-of: a97c88a176b6 ("drm/i915/wm: Verify the correct plane DDB entry")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/skl_watermark.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/skl_watermark.c b/drivers/gpu/drm/i915/display/skl_watermark.c
index 6c657ef8b45b4..9653ed8726935 100644
--- a/drivers/gpu/drm/i915/display/skl_watermark.c
+++ b/drivers/gpu/drm/i915/display/skl_watermark.c
@@ -3582,10 +3582,8 @@ void intel_mbus_dbox_update(struct intel_atomic_state *state)
 {
 	struct drm_i915_private *i915 = to_i915(state->base.dev);
 	const struct intel_dbuf_state *new_dbuf_state, *old_dbuf_state;
-	const struct intel_crtc_state *new_crtc_state;
 	const struct intel_crtc *crtc;
 	u32 val = 0;
-	int i;
 
 	if (DISPLAY_VER(i915) < 11)
 		return;
@@ -3629,12 +3627,9 @@ void intel_mbus_dbox_update(struct intel_atomic_state *state)
 		val |= MBUS_DBOX_B_CREDIT(8);
 	}
 
-	for_each_new_intel_crtc_in_state(state, crtc, new_crtc_state, i) {
+	for_each_intel_crtc_in_pipe_mask(&i915->drm, crtc, new_dbuf_state->active_pipes) {
 		u32 pipe_val = val;
 
-		if (!new_crtc_state->hw.active)
-			continue;
-
 		if (DISPLAY_VER(i915) >= 14) {
 			if (xelpdp_is_only_pipe_per_dbuf_bank(crtc->pipe,
 							      new_dbuf_state->active_pipes))
-- 
2.53.0




