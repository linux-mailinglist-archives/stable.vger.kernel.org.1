Return-Path: <stable+bounces-221571-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ObpADWXo2neHgUAu9opvQ
	(envelope-from <stable+bounces-221571-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:32:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBCE1CAE87
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C79E23030FDE
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6900E27F017;
	Sun,  1 Mar 2026 01:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjYFQDZ8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2228F259C80
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328608; cv=none; b=A+POCL/yDqVEw8v/7v77hpKj+WvWrS6k0UAuLVpg8Ilxa2NCewqz54gJQVRtjueOpBmIijWQ2h/LJpNS+cbsZ4BKUsFzxw/htvOdkoSrcxkQnE6uQxM7I6Izgi0U/bCqnUO83SJDAFTr7by1vQovVRnCstkLGSV//NUkMuKWneE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328608; c=relaxed/simple;
	bh=jtPjgZotmkGjkEoVrFy4o7JD5HiRCQMyZAzh2CSCv5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MqvZEtV1HjilenLw1iqTH4IRtprljJePlehVzI7Cpr9p1U+xNkZjBXubmWQjCIkUJPAK9wjZKvs7/MrmrCeAFS2RifLqqteH+8VD27cw1FlTDhF3/739IqyvoiEkyEbLjE+A0LDF+VGO99635Z9XWcmFDiD+3FcHmkxJPL/V+DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjYFQDZ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD31C19421;
	Sun,  1 Mar 2026 01:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328607;
	bh=jtPjgZotmkGjkEoVrFy4o7JD5HiRCQMyZAzh2CSCv5A=;
	h=From:To:Cc:Subject:Date:From;
	b=DjYFQDZ8oeVJ8ffM8riltlLa5dgib0Zo/+aLlA3YzOsW0oFriiLrwXIrwB+vtuKvv
	 TlPogMURh3xUP+yYkaLagoU/iqhdUrYGReDpWpxDNdarYoontSDsfE7Bs8uL4dNjY5
	 poB48xq5n3IF+h+L6cDKyjleC5E+w0dESRg11nuD+Vs/6kH0d2Y8VN+BbD08RmBxJW
	 0vwm8x5ATi4JtnEYccu4YygttwqEnxrjhwUYOKiy1TlVCBF6nvT5gHqjeHyPKmRpYZ
	 urltV36X8fsI4mIZrLG7/5D8+x6rL5FYYcIN1rccAi1rehcpzxbqKfk89mqxKlfkQv
	 d0dv9/0fOJTvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ville.syrjala@linux.intel.com
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "drm/i915/psr: Reject async flips when selective fetch is enabled" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:30:05 -0500
Message-ID: <20260301013005.1688048-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-221571-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 9EBCE1CAE87
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a5f0cc8e0cd4007370af6985cb152001310cf20c Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Date: Wed, 5 Nov 2025 19:10:15 +0200
Subject: [PATCH] drm/i915/psr: Reject async flips when selective fetch is
 enabled
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The selective fetch code doesn't handle asycn flips correctly.
There is a nonsense check for async flips in
intel_psr2_sel_fetch_config_valid() but that only gets called
for modesets/fastsets and thus does nothing for async flips.

Currently intel_async_flip_check_hw() is very unhappy as the
selective fetch code pulls in planes that are not even async
flips capable.

Reject async flips when selective fetch is enabled, until
someone fixes this properly (ie. disable selective fetch while
async flips are being issued).

Cc: stable@vger.kernel.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patch.msgid.link/20251105171015.22234-1-ville.syrjala@linux.intel.com
Reviewed-by: Jouni Högander <jouni.hogander@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display.c | 8 ++++++++
 drivers/gpu/drm/i915/display/intel_psr.c     | 6 ------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 6c8a7f63111ec..7aff2785521b7 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -6002,6 +6002,14 @@ static int intel_async_flip_check_uapi(struct intel_atomic_state *state,
 		return -EINVAL;
 	}
 
+	/* FIXME: selective fetch should be disabled for async flips */
+	if (new_crtc_state->enable_psr2_sel_fetch) {
+		drm_dbg_kms(display->drm,
+			    "[CRTC:%d:%s] async flip disallowed with PSR2 selective fetch\n",
+			    crtc->base.base.id, crtc->base.name);
+		return -EINVAL;
+	}
+
 	for_each_oldnew_intel_plane_in_state(state, plane, old_plane_state,
 					     new_plane_state, i) {
 		if (plane->pipe != crtc->pipe)
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 00ac652809cca..08bca45739749 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -1301,12 +1301,6 @@ static bool intel_psr2_sel_fetch_config_valid(struct intel_dp *intel_dp,
 		return false;
 	}
 
-	if (crtc_state->uapi.async_flip) {
-		drm_dbg_kms(display->drm,
-			    "PSR2 sel fetch not enabled, async flip enabled\n");
-		return false;
-	}
-
 	return crtc_state->enable_psr2_sel_fetch = true;
 }
 
-- 
2.51.0





