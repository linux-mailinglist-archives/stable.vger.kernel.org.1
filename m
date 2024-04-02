Return-Path: <stable+bounces-35651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C9889601F
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 01:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F3D1F20C9E
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 23:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E515F45008;
	Tue,  2 Apr 2024 23:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GZ9dr5Of"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B8444366
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 23:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712100506; cv=none; b=B1R3TxvvQw/u+/GeXbje3tbrBsOWGjnZMPe95TT3lilaUa/34sOfznN2R2ZtlXr0DE5bds/rXjQoU4k4Mc15vkoS5rqPnKeajUCUk8FPC1/o74hSXCIZSmYuXPmo7rRN8PiC4ujpRD5IWFIThsQGfdiXTB8lhfcjZhP+nRgl3tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712100506; c=relaxed/simple;
	bh=XvYFNfhrpUWvW/BgF1d9clll5zWPxZWQChJVAt0RDgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vt0uUO4qTKZn8g/eCvES4XWffLyQr4Sg/8yjjx/JLtEeb07+7MZU1jKlBXrWfSIiB+3wP53R5V7UTJ2+gUetz/DADNSngfc0vT7CIajVZ37N0mNSmcr4PomMgtqxQIbp8iil9QSLDgvzodSJntn5jQ9yIGfOGlNJIjLFG/YnDWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GZ9dr5Of; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ea8ee55812so5748285b3a.0
        for <stable@vger.kernel.org>; Tue, 02 Apr 2024 16:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712100504; x=1712705304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uom5XV5QmkXR9aOb9X9fb+taSwN23XFnrrLT5o0XDnE=;
        b=GZ9dr5OfsJWH6vaJZPZJ8zH41nWrA8VhgkFMx2PHyN74O9P7bCUZurrnrgSxP1uiBm
         rYf+62oTR3rBTX41n9pGwMVRjSS4BFiKK04ZGRyt0Kf09Ir5Z+vGsoY6NSBqioCY68ay
         WRgYKcmgqG0dvVSk2UhulF1CE5t/x/jOBXtJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712100504; x=1712705304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uom5XV5QmkXR9aOb9X9fb+taSwN23XFnrrLT5o0XDnE=;
        b=LEFsjCjmTgfKWEtmJZCg6mjI9OiAah/mhSYkAwkOZ6aPH2LcWMAlOwf2CU3jcuJjJA
         ZxGxTcU2Q+CVVGUmmNeNOtkBgmwZh+Ti7X3KR31cmF2tCiXYCMCTeXSwcwPlZksu558T
         hagjphdiw1r87Zx7qdlMYnPZ2Q70AFWDuZmgFyaNcDDbzLdjEeCkssXLHsv4u7Kz8fAF
         JzHC+b79ACv74OEvL3zIvREGeep56OmhFtRhYZdnwkQiFoxq9Sv6JMC0LNm3VVcEkfiw
         g46SW+VA0rYbtuPub0/Se90OoIUE9RvgoXwbQtOdxbY7zENDAFCfrU/cVIP3p+Iesi04
         dgYg==
X-Forwarded-Encrypted: i=1; AJvYcCWFIVs676GsDJ03ioWuXrT+qEfp6Ir6iTtjShwRnYBzDWzcIhot8qo5pwDhNTInj3qGzd4sROQ4XgueOdGnlm9GvKzLuwm+
X-Gm-Message-State: AOJu0YzeDQvSZtw501zs9OsZrggYvJTC4GxLWyhwYxNi4lcd0+27eUlZ
	SDX1aKZX86WNNppAEksM3GRy/Npx5Bf6zJ/QzhozaVhthL/fxsZRl5FNu7itvQ==
X-Google-Smtp-Source: AGHT+IHB6Be3b7W1U4HByTSESH06WY7FXOUNJlc+l0jWf/r1B74Q5/1wv7eEeEmtCwQ0gxXCyyXGXw==
X-Received: by 2002:a05:6a00:179a:b0:6ea:b818:f499 with SMTP id s26-20020a056a00179a00b006eab818f499mr16689794pfg.19.1712100504510;
        Tue, 02 Apr 2024 16:28:24 -0700 (PDT)
Received: from vertex.vmware.com (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id i21-20020aa787d5000000b006eaada3860dsm10385121pfo.200.2024.04.02.16.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 16:28:24 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	ian.forbes@broadcom.com,
	martin.krastev@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/5] drm/vmwgfx: Fix crtc's atomic check conditional
Date: Tue,  2 Apr 2024 19:28:12 -0400
Message-Id: <20240402232813.2670131-5-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240402232813.2670131-1-zack.rusin@broadcom.com>
References: <20240402232813.2670131-1-zack.rusin@broadcom.com>
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


