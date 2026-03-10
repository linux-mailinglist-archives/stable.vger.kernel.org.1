Return-Path: <stable+bounces-224500-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMjeJCsZsGlAfwIAu9opvQ
	(envelope-from <stable+bounces-224500-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 14:14:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF5324FC8A
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 14:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20B9831A42F3
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EDE3C3445;
	Tue, 10 Mar 2026 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nNRdXXdt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D614F3B6345
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 11:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143870; cv=none; b=uoMXhkQVE8I5RHZ7QkUqFmLMYrOIq7jKxEFRcOziyKvL9qiENUTos0rL7JHAy/L+d2Ro0OacSFtqzy6ivEbD2LeRbQ4R/JpFFtO5q1sv1ZUqNiHqroemR1Y7n/4E7ggm2FQnk+iwRpUwvqfaauhipfeY8sn+1UevSV9KehE05Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143870; c=relaxed/simple;
	bh=GMuRZsIcDPYzUmK3hRLnUVbGlgh6ZtOMDCxtj9c841Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QTJX2V+JrjiMy2+vWZ45N8u+djy6BxVd+nQ27alNShkX/sBfpOL0gqs6fWYQP7U+ROTXu/mTHdUpPnW0auV52Up4VRn6CrEyU3Mul3b9xj7Cdd8ZMeWEgdpP4G5HF3e6EZI82CRObaKDkd2ob5CHVj/XDfVq3bfwa0yuLnftC6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nNRdXXdt; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773143867; x=1804679867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GMuRZsIcDPYzUmK3hRLnUVbGlgh6ZtOMDCxtj9c841Y=;
  b=nNRdXXdt4G3Ok99DFekRHre0G9NO/tf9iDqptRHGCuhhAtiaT9SWk8vS
   6WJ58HMlNpyWhje5u5m6Ard4tfyaFffwmd4yUM2OCwWSBgoco9g2Ltw19
   Sh0gYR2d2kU0ugWEmL2r8+ufqFS0xGIPGG+/bKF9Y9Fa3CXjDTs/to522
   iqKFWXzUjXjzQdfWt/xSLDOENzoxCajj1E3wwoh1wmyeJeQQArTsa69u3
   EPufDgn0TA0+ySF4bWI0ZQrNj+qMirp01j1jcWAgRRWf84HujmYloViPN
   QibCkWduLTVYeL3F2Et2OTsXm5WGnX3wl8ylu5BHNJI3T57CqOusMclP5
   g==;
X-CSE-ConnectionGUID: aAvnP54PRqasMyE1q5/v3g==
X-CSE-MsgGUID: C8d7X+DUTWm23Ghh/TgZcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="84897896"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="84897896"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 04:57:46 -0700
X-CSE-ConnectionGUID: T899SoHYTtWxDo7ymnwV6Q==
X-CSE-MsgGUID: +Gs3nQC3SKybWqfT0s/xBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="224773048"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
  by fmviesa005.fm.intel.com with ESMTP; 10 Mar 2026 04:57:42 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: contact@emersion.fr,
	alex.hung@amd.com,
	harry.wentland@amd.com,
	daniels@collabora.com,
	mwen@igalia.com,
	sebastian.wick@redhat.com,
	uma.shankar@intel.com,
	ville.syrjala@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	jani.nikula@intel.com,
	louis.chauvet@bootlin.com,
	stable@vger.kernel.org,
	chaitanya.kumar.borah@intel.com
Subject: [PATCH v2 2/2] drm/atomic: Add affected colorops with affected planes
Date: Tue, 10 Mar 2026 17:02:38 +0530
Message-Id: <20260310113238.3495981-3-chaitanya.kumar.borah@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260310113238.3495981-1-chaitanya.kumar.borah@intel.com>
References: <20260310113238.3495981-1-chaitanya.kumar.borah@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0BF5324FC8A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224500-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chaitanya.kumar.borah@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action

When drm_atomic_add_affected_planes() adds a plane to the atomic
state, the associated colorops are not guaranteed to be included.
This can leave colorop state out of the transaction when planes
are pulled in implicitly (eg. during modeset or internal commits).

Also add affected colorops when adding affected planes to keep
plane and color pipeline state consistent within the atomic
transaction.

v2: Add affected colorops only when a pipeline is enabled

Fixes: 2afc3184f3b3 ("drm/plane: Add COLOR PIPELINE property")
Cc: <stable@vger.kernel.org> #v6.19+
Reviewed-by: Uma Shankar <uma.shankar@intel.com> #v1
Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
---
 drivers/gpu/drm/drm_atomic.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 04925166df98..dd9f27cfe991 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1587,6 +1587,7 @@ drm_atomic_add_affected_planes(struct drm_atomic_state *state,
 	const struct drm_crtc_state *old_crtc_state =
 		drm_atomic_get_old_crtc_state(state, crtc);
 	struct drm_plane *plane;
+	int ret;
 
 	WARN_ON(!drm_atomic_get_new_crtc_state(state, crtc));
 
@@ -1600,6 +1601,12 @@ drm_atomic_add_affected_planes(struct drm_atomic_state *state,
 
 		if (IS_ERR(plane_state))
 			return PTR_ERR(plane_state);
+
+		if (plane_state->color_pipeline) {
+			ret = drm_atomic_add_affected_colorops(state, plane);
+			if (ret)
+				return ret;
+		}
 	}
 	return 0;
 }
-- 
2.25.1


