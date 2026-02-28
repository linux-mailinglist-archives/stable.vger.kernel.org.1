Return-Path: <stable+bounces-220940-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOwSO/FMo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220940-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:15:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CCD1C819A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1667732FF71E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC2B32AABE;
	Sat, 28 Feb 2026 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVJMudGQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CECD44CF37;
	Sat, 28 Feb 2026 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301287; cv=none; b=M74nnMPvVxeVWJ78JGU9k/its20/deFDhMylGlfaU/JmRMakSNuUlvThaSJZDmDqyAiP1TfLAmp1G5o2JVjU245aSWABE0C2c3ddyacW2aHJiOdb/CBuZ4qCDAtnlhtTItyd5RwZKXGSSOwrbdaeTYzF5YuRpAmjKCb9Q7nGPqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301287; c=relaxed/simple;
	bh=kV156b6234C9zhtVhVOBCETWGG2U4H/YWhUB6BkccCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UqSUm0fYdAD69mR8GivEQNdRdcPZai0acbu9xE48S9CcTaituiNAYUEV6InNPKAwDHoVqSH6ixrCUpUQcpMcnKbfV2JzVWsxq2wgi5xEqeAGRsMry8DBL3wwqiGMvEhCTRi1knLezgGEoojO4UaJ9NsepP6TiOu/xpRi0v9Xh5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVJMudGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63ADEC19425;
	Sat, 28 Feb 2026 17:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301287;
	bh=kV156b6234C9zhtVhVOBCETWGG2U4H/YWhUB6BkccCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QVJMudGQ0GJTIcj1SyLRvPs+BtmicsJXqDMFdU/O/+RZlW+tn+3CBH8N8ILsrK0Mu
	 3ygSXuqwJtvYpSy9SRtcuKYOO9QUxQOoFUDGnXJbEiou9/UYDqGhhuHkKWzLEDktpi
	 w6M342CrZ28xb8omYMgvz8TFrstvipI1y5qipMzxP9PWB1xINAAjDudf6sB+1jd7Vw
	 y4q1y1f56YrF3b79LqthFNRwCjqYCJWBIG3Zsw0PT8hQMWpZlMZpB2ux2zeOWmrmYu
	 9dSuruxkAhjAMcb6GAbWJiTwrocvlMtNwC2JkMTyzUJVbaGWvpAkKhjLx9vRFvppNs
	 Exweuxwax76YA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 471/752] drm/xe: Fix ggtt fb alignment
Date: Sat, 28 Feb 2026 12:43:02 -0500
Message-ID: <20260228174750.1542406-471-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[igalia.com,linux.intel.com,gmail.com,vger.kernel.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220940-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,igalia.com:email]
X-Rspamd-Queue-Id: 94CCD1C819A
X-Rspamd-Action: no action

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

[ Upstream commit a61bf068f1fe359203f1af191cb523b77dc32752 ]

Pass the correct alignment from intel_fb_pin_to_ggtt() down to
__xe_pin_fb_vma().

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Closes: https://lore.kernel.org/intel-xe/aNL_RgLy13fXJbYx@intel.com/
Cc: Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Fixes: b0228a337de8 ("drm/xe/display: align framebuffers according to hw requirements")
Cc: <stable@vger.kernel.org> # v6.13+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Link: https://patch.msgid.link/20251208181550.6618-1-tursulin@igalia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/display/xe_fb_pin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/display/xe_fb_pin.c b/drivers/gpu/drm/xe/display/xe_fb_pin.c
index 1fd4a815e784b..b18d15cc3c53d 100644
--- a/drivers/gpu/drm/xe/display/xe_fb_pin.c
+++ b/drivers/gpu/drm/xe/display/xe_fb_pin.c
@@ -378,7 +378,7 @@ intel_fb_pin_to_ggtt(const struct drm_framebuffer *fb,
 {
 	*out_flags = 0;
 
-	return __xe_pin_fb_vma(to_intel_framebuffer(fb), view, phys_alignment);
+	return __xe_pin_fb_vma(to_intel_framebuffer(fb), view, alignment);
 }
 
 void intel_fb_unpin_vma(struct i915_vma *vma, unsigned long flags)
-- 
2.51.0


