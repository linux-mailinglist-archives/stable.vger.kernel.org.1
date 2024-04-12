Return-Path: <stable+bounces-39249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE68B8A23F4
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 04:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5001C21FCF
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 02:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E716911198;
	Fri, 12 Apr 2024 02:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T+kb2tgD"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7A91759F
	for <stable@vger.kernel.org>; Fri, 12 Apr 2024 02:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712890527; cv=none; b=NogL8PyHlWY0zyoep/GIvF/3SZOjnPCBLC9AWLzGemZ1LvaeiJBNnNKbIlUK8T/stcRZWgLZei0d74td+MAa7o8f+rfcDQUMhRlL80EJHJJguHbR6CyJUFBYeYhYNXaWANPdzah9Rj1jaIyCzvPfO4H+Yj1Heg4KbVly9GPAbLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712890527; c=relaxed/simple;
	bh=6oCPIVjbGhC7VEONazteSmwSzk8ELK/fwkCfdCe0Pdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZRu/Q3v0bmKStkYZjWEVcNztA+ZlGv246ADy+6Ai3Ef6y6VBft46lFV+KGdXHTdKYHlrfgxacCazRpRJFi+9cZR4ddVLqBbTppH5ZqvJ085qsuobukhsndKLk2k7x8gvxUFr/ENBRVEEZ1mn1Hkcddh0RGZ1lyYe/9Ffx+x6S9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T+kb2tgD; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-434a6024e2fso4189321cf.0
        for <stable@vger.kernel.org>; Thu, 11 Apr 2024 19:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712890525; x=1713495325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7LNQXEEzm9LDbWvu8yomhruLgVkKy5JUtfa3p+eNBw=;
        b=T+kb2tgD1wNmwoZIkHGz2emHg3pmnTO7E5asxezz6giAaFNH0zv89FcabSJueH8XFe
         O4vNLchYWg7pGMOyPHPvE9g4sFTSWIcKD0BouM9aQOVIgtLqcjNIOswvKJWNQSPZjCVQ
         4Rari00pL9TawOjlyxV/hUcINGQUygsWRMwPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712890525; x=1713495325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7LNQXEEzm9LDbWvu8yomhruLgVkKy5JUtfa3p+eNBw=;
        b=AyFogEX/JCdAlRabDXwKvz1Amc4VfOf0A9rvCJSbMMzP6cFr9z107W1FnnpnQPJdaT
         v4xqFJPpXIb2gAt3OLdiG4yPFwHdDDdAyRSoWyKc5kMIDUtE9PiFsqjaN329DY7gtzJ9
         3B5FWuF5D/qMwK19GURyOWm+S+uUDH1ZY4HQEUiZyltIUVXFnY3W5Bg538KN9L8CTdX3
         sio2BY170wfgRyc3Pi8UW5D8/43SThwM+p5s03v26Izv5wgWg0F4Kg3pY9EXlAJw6jqu
         Ud18DsoMlGynH7TQrWpoOGn656r8lAJmQKZxkJY5BYLN27TyRp0Oih2hOew29PbunAEt
         qzxA==
X-Forwarded-Encrypted: i=1; AJvYcCXUa1S9iGyflS2dayw42puWq0OejWlfs7n4cCSAMaqG7BTW8dsMvSCSZHv6BggVnOnOPzJCcIfz90uk+ghLXuJ9Dd8Z5K+Z
X-Gm-Message-State: AOJu0Yzxf2EEkGHz9SQMMT7gE7KPg/TpNPm7goE8OEBkb/J+Z4TCXjfB
	q99AMto70l2KRHVQ85yHjjLNkstnT+d8OQmbXXXwne7SxOWStnv0M+Xaa+5myA==
X-Google-Smtp-Source: AGHT+IHZWDcP9MRbfRYATS08KajxXKW2RYUhJ9M0HnfkT9ercovhwYxoYcQ/TRKNFvrlHpwO4SxKxw==
X-Received: by 2002:a05:622a:8b:b0:436:9202:9b35 with SMTP id o11-20020a05622a008b00b0043692029b35mr607955qtw.21.1712890525013;
        Thu, 11 Apr 2024 19:55:25 -0700 (PDT)
Received: from vertex.vmware.com (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id t12-20020ac865cc000000b00434ab3072b0sm1682174qto.40.2024.04.11.19.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 19:55:24 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	ian.forbes@broadcom.com,
	martin.krastev@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 4/5] drm/vmwgfx: Fix crtc's atomic check conditional
Date: Thu, 11 Apr 2024 22:55:10 -0400
Message-Id: <20240412025511.78553-5-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240412025511.78553-1-zack.rusin@broadcom.com>
References: <20240412025511.78553-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The conditional was supposed to prevent enabling of a crtc state
without a set primary plane. Accidently it also prevented disabling
crtc state with a set primary plane. Neither is correct.

Fix the conditional and just driver-warn when a crtc state has been
enabled without a primary plane which will help debug broken userspace.

Fixes IGT's kms_atomic_interruptible and kms_atomic_transition tests.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Fixes: 06ec41909e31 ("drm/vmwgfx: Add and connect CRTC helper functions")
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v4.12+
Reviewed-by: Ian Forbes <ian.forbes@broadcom.com>
Reviewed-by: Martin Krastev <martin.krastev@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index e33e5993d8fc..13b2820cae51 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -931,6 +931,7 @@ int vmw_du_cursor_plane_atomic_check(struct drm_plane *plane,
 int vmw_du_crtc_atomic_check(struct drm_crtc *crtc,
 			     struct drm_atomic_state *state)
 {
+	struct vmw_private *vmw = vmw_priv(crtc->dev);
 	struct drm_crtc_state *new_state = drm_atomic_get_new_crtc_state(state,
 									 crtc);
 	struct vmw_display_unit *du = vmw_crtc_to_du(new_state->crtc);
@@ -938,9 +939,13 @@ int vmw_du_crtc_atomic_check(struct drm_crtc *crtc,
 	bool has_primary = new_state->plane_mask &
 			   drm_plane_mask(crtc->primary);
 
-	/* We always want to have an active plane with an active CRTC */
-	if (has_primary != new_state->enable)
-		return -EINVAL;
+	/*
+	 * This is fine in general, but broken userspace might expect
+	 * some actual rendering so give a clue as why it's blank.
+	 */
+	if (new_state->enable && !has_primary)
+		drm_dbg_driver(&vmw->drm,
+			       "CRTC without a primary plane will be blank.\n");
 
 
 	if (new_state->connector_mask != connector_mask &&
-- 
2.40.1


