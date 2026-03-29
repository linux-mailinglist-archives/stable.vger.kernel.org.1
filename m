Return-Path: <stable+bounces-230829-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BcoEGetyGmvogUAu9opvQ
	(envelope-from <stable+bounces-230829-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 06:41:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BD2350A6C
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 06:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC6113019BAA
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 04:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1044A27A133;
	Sun, 29 Mar 2026 04:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3mET+3/"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6664126FD97
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 04:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774759224; cv=none; b=SasI/xS/iZWXC5EbWCrKwXN8r5e14WtSBkBXFyc3YeFvjpQxgFBW5Q/gSZ4w20PZySf+jOkdBhek/Ao0jEbJkgG+XPL/a/zp/mgedD22R+9jKe4KjWQzgBbzko97BhKB2fbAO1lwc8YZLD0WFfbHNe9V85GBYWiDszq7NDOVz04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774759224; c=relaxed/simple;
	bh=48LDLkt9O2haLCuQepiOxMtVAceFCJAgEBfgH2EDxwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eyVP6YHhYY4rcZxNQDSrHsDclaerJQvGc5VyLQ0Blcw80txoEmtdYejQWBOLw//GOhGOvWAHHioC+xgI3wzV4M7lyZJMlnc6vQyVD+gjKJ7uIdNbNO6GYZ0BnbQld/OMRcAuf3bsiUxeyAKm6gvDL4okeYO/TiWfF84o+j3WPWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3mET+3/; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38a23dd61c1so29889821fa.1
        for <stable@vger.kernel.org>; Sat, 28 Mar 2026 21:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774759222; x=1775364022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mk52gQWQ3YwbPCH+HI+PLYhISpoSwXiTg6BTfM8lBMw=;
        b=h3mET+3/2l8/ScTQ5xuv6f0vwv/K3lPlJ00x5fTU2LJTi6Tk8oBvTXZ3v1M4BPYc5G
         YSD4YVCYzHIoS9jpfpQw+RvSek1MgwR3C6wItq2qN1y3xz+VU8AIjQmOreEJ8l7B8sqg
         50lD9y9vBude7Z54Y+Q6cSdiZ62LOdnrqOoWArwrIwbbhXqV6tpnY3hDiPK6bb4EtzkB
         aR8wQF6p9QUOolQ9snn0snAS4g+blnGrKb4nmDraGjcr86Ttm/oY4h+U5GN38O2mNl6g
         8EMHpgsmiNGVEsmhXA+OfmYO+qbZLC9thzG1AvpFsD5IShRu952XrLwSx1ijIacEPC+n
         L2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774759222; x=1775364022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mk52gQWQ3YwbPCH+HI+PLYhISpoSwXiTg6BTfM8lBMw=;
        b=JpuxWTji6I7WAcZpeUxRULkNCk86qkEDyRmMh1Hx/jqi9Pa8lEdfOEwzmUqe0uIYZH
         /BhXXXwV2r6C8cavCWkPenRQdws8zpw9mPeMGHEqLMCu1BN7XR5kpl7XpgOXKJNxjCDZ
         i9iYGz1sdegxm1p1UQHBhvtV19+s95u8v1kNcQU98nLIftloMOvTz/RvEvvxvby+fu1k
         YawwIfko5OefreIXw5UrJ4mTYECfD8O/ApA9AGkU0wO0jCRr5HuQQXHLe/2cS6f7Tx++
         A1b0MGcuuHgJhtd//7ou9zex8Xn6+qiqiG2ShvqExbAv5Ie3i1KYAS3yAbbANMrADsev
         pmEA==
X-Forwarded-Encrypted: i=1; AJvYcCVvfBzsC4DJW9CFn4489ufmfQuN2Mmv/RTc+AjCC0tZ64+lovZ3q2TMoB8l75ryB+C8fItWlxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxttovWI+BG743uQPzkNAfS6jE+7gu6eX1A7H83Pvg029EjWzzR
	ughDugxKnyBgQ6RqHMLlV8fWhc1pO1Fu515vfpltmRRatn+sXYD0Id4=
X-Gm-Gg: ATEYQzzm4fiHaw2FBJKpAuA5DlwaaMDKA09v5zvIwmLF8//t8l3Hy7vKeVSLtUQTdHK
	KS+T62Fklu4Z/qvMZFG5fJXuKcl7kAImK+OFPZL5FMxo39ehEg+0DpJdwE+8EK8NbefQKaC58Rg
	APTQtXFy3FmAzevHa+vU9ghVnmZCDEIag03NFYWNv+DP1qcNmwsrfkpTfjfzIS0tsH1yDoNj+MQ
	47IIbAMkvAZktqIS3MPwsHq+3ukEOc2SknD5W+W10s8uJinZ00oCZ3X8DG17q/vYM4Vah4UfyXr
	cy7pYz3RWjcBXQNsTNHdurUHwj2icJOTQjqsvBLe4XDSSZWqLlkfyn0hXN3ggFFeShEIUd1M3nu
	+AKMrB5qNyCXnnJDY5xqPJyXmQVID38eMagFjBGUKaPn+9PFiWYKpT1GGX8FB9wLXRcjhF53xVu
	JkQOR8a0KOYsR9BoIHT6Ir50Yi6/Y=
X-Received: by 2002:a05:6512:4022:b0:5a1:5725:6194 with SMTP id 2adb3069b0e04-5a2ab930326mr2715163e87.34.1774759221442;
        Sat, 28 Mar 2026 21:40:21 -0700 (PDT)
Received: from fedora.localdomain ([2a11:3805:0:93::1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2b145772fsm836212e87.71.2026.03.28.21.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 21:40:21 -0700 (PDT)
From: Sbenazar <voroninan95ton@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com,
	Sbenazar <voroninan95ton@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/4] drm/amd/display: reset sr_skip_count on non-fast updates
Date: Sun, 29 Mar 2026 07:40:05 +0300
Message-ID: <20260329044014.30276-2-voroninan95ton@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329035830.21953-1-voroninan95ton@gmail.com>
References: <20260329035830.21953-1-voroninan95ton@gmail.com>
 <20260329044014.30276-1-voroninan95ton@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230829-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[voroninan95ton@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: B1BD2350A6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sr_skip_count is initialized to AMDGPU_DM_PSR_ENTRY_DELAY (5) at stream
creation time but is never reset when a non-fast (MEDIUM/FULL) update
occurs. After the first 5 fast commits following stream creation, the
counter permanently stays at 0.

This means that after any full-frame update that disables Panel Replay or
PSR (e.g., a workspace switch), the very next fast update will set
allow_sr_entry = true (because !0 == true), allowing self-refresh to be
re-enabled immediately — potentially in the middle of an ongoing
animation.

Fix this by resetting sr_skip_count to AMDGPU_DM_PSR_ENTRY_DELAY
whenever a non-fast update occurs, ensuring that at least 5 fast commits
must happen before self-refresh features are re-enabled.

Cc: stable@vger.kernel.org
Signed-off-by: Sbenazar <voroninan95ton@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9854,6 +9854,12 @@ static void amdgpu_dm_enable_self_refresh(struct amdgpu_crtc *acrtc_attach,
 	bool vrr_active = amdgpu_dm_crtc_vrr_active(acrtc_state);

 	if (acrtc_state->update_type > UPDATE_TYPE_FAST) {
+		/*
+		 * Reset skip count after non-fast updates to prevent
+		 * self-refresh from being re-enabled too soon during
+		 * ongoing animations (e.g., workspace switch).
+		 */
+		aconn->sr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
 		if (pr->config.replay_supported && !pr->replay_feature_enabled)
 			amdgpu_dm_link_setup_replay(acrtc_state->stream->link, aconn);
 		else if (psr->psr_version != DC_PSR_VERSION_UNSUPPORTED &&
--
2.48.1


