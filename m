Return-Path: <stable+bounces-244278-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMqNA/pu+mngOwMAu9opvQ
	(envelope-from <stable+bounces-244278-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 00:28:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 525CF4D4536
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 00:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 422E7301CF6A
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 22:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7174A13A7;
	Tue,  5 May 2026 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IKdg95Ep"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B093ED5A7
	for <stable@vger.kernel.org>; Tue,  5 May 2026 22:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778020081; cv=none; b=fTDrfIgfbOFVvMEkIYj6Hp5NhTfBdET3xVxKaKQV9zJ80mwOF6U/SLd4bFq6JKGd+LYjKvSZ/w1ndXpAThXYJEqBJOkgFjnj/WbdMQ2kEWMo9sJVIBQjhW/HIirfM+hDaOaH1+C4rX7Vz3twV8aZsnUZH4oTR1gCnKmPWl9IGRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778020081; c=relaxed/simple;
	bh=1LZUwtC5MCIjrk2rF9/uFaO56ngy3oLvs96maAycBpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApnSdhiG/9DVWwaph2q1znZXpXS/DvsRJGqayq7XtEwaMDxhT3VMgQSFyiuvrvZBcfsaLMxu/X6QMiw+0847lgeX5ES+ImAq883Kws05uDBt2G1TBsNxhYMZkyJ5G2UjXklr3ISs2pYqWXpwO75zhHIVU4A7S4Q654KVWZZpYWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IKdg95Ep; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-82735a41920so2097106b3a.2
        for <stable@vger.kernel.org>; Tue, 05 May 2026 15:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778020080; x=1778624880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i3244wkMCmDcTJccTCigzocf3AM8KFp/Jq6GbvQEdxQ=;
        b=okq928WY1E75aNaLm+3uFIVqWyuwPJqkCkVrAn6nSdCr078nTi8bj+viOLvbEJl27Z
         j3mx9JJnVx2dQsieKpqzZL0hLO6GcoMO6rARnExOmzN50YlmPxv3jGvt+MjVvJifRlzG
         +vA+YuaNIZzoh/Vo28DTps0OsK1BZlVMRwzHA7GeaQrsrYNSxq56hZNqMjc9xrmAYR9H
         G9k6XJcmsMZGzuJ77iqeF27BUqSxg3cPNcowHWtuTQLV6DBibNA2+ERVy1xSCUTlMYVe
         EFI9ZT0XMAMCAoZBqbXf6g/4TPoCiIJuqXJ31Ya8PM3kBgZ1zaJ7YTGaytmrht7ItqiE
         Z+/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+tR5eWnQra45bqWN1Frt1a4nzGUk0XxTLQ7ew9riYxvpzrfViNIwinFA+yyZZouoepoYt70eI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIAYXv7wDIJXOqCFNatwywrHP86njnTXhh2gYhqJ9Box44HtNa
	mCX22z9A9uClbIoWJ8Ae5oa/bB6QHMgOQgh8PpZK/+/msIePlC3nq2s0pbPXmZh/btdRJp9JXAm
	XcHF6tNrSC3wG5ayDpRBur08Pmyt8ZZfMGUUOjcvlRJx1I+NVZHey+jhVZCxPg0SVKuKan/OqYA
	1JYeT3/ea+0phyLy5pqbaqkd7Q/KqL2paQPVsWpg7NsjkBVbNvU6k87kJyoW4/HtCZYq+knv0UE
	H2KsGji
X-Gm-Gg: AeBDietGQeywuduFIfCYvD2L18PFnnrekbJChljg2lqz5QeCZ+3mYyWsHNSN1dlFdPp
	wjTKmzsiHhvgwqP2I7s2Opu+tnOHRjBiTJ/jFlyNcL1hrrujMEkh1u8A9IRJOXKo2Li06uKajc4
	GPQweEiW7myOonWM9f1LgObHiE9uKBtDn9ubN/NFWY6ISjmubrG2FX+jQNrPrZ2SYcAhk7PT+R3
	FjcDA5sLPPd9JUl/lrmIa4txs3GTRNvYBusHL+MZOdnvGQpJQhCZeA2LPVLTtTBLLB0u1VTXWX6
	T7kS8QbK4G5qxVMZpsb7gvEL5l48qut5sXTNyFhSwXHWAyO7MXmjRRtQ3UI/4bVVjm+u4MPIn3a
	yz4CxDGdzqNi40fkuhNVTVxd4n8avsaepl0pkuGnE0cSegIb7PXDZmWohams5Q82d00aST5JRL3
	J4oHmCfPuyo2yZtdf6p6VcK4/hLNBEVnx2EgeNGfOcEYusH/7chee0zdjplGDIP5gYDWs=
X-Received: by 2002:a05:6a00:1805:b0:829:8942:2c93 with SMTP id d2e1a72fcca58-83a5b2d570emr644965b3a.9.1778020079642;
        Tue, 05 May 2026 15:27:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-839675cbe49sm339864b3a.5.2026.05.05.15.27.58
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2026 15:27:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8bc5ab12bb5so2340236d6.3
        for <stable@vger.kernel.org>; Tue, 05 May 2026 15:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778020077; x=1778624877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3244wkMCmDcTJccTCigzocf3AM8KFp/Jq6GbvQEdxQ=;
        b=IKdg95EpB3tiSATPOSvd1gK+eb8kJ87spEx4tgiYQxa+tcHDDTH4ULfovfelqwXgGg
         SUlab960Ndkk/XWozWIOJ3Ag1AHIheX0MJ830h26uPgVB+HbZTolAyu9tZ5SEr192tCz
         0+cumhcNHt+N1cY0S6eWSqRxLWCT/dwZ/xB9o=
X-Forwarded-Encrypted: i=1; AFNElJ8FUVaAxSf7RbnV7Gh7fgQtfqKCOzQ9ui0w//Z/9eHSGjTldlLeIHO35IJLkp8vY+MzL+aHRaE=@vger.kernel.org
X-Received: by 2002:a05:6214:23c9:b0:8ac:a154:e156 with SMTP id 6a1803df08f44-8bc443d1957mr12240966d6.29.1778020077593;
        Tue, 05 May 2026 15:27:57 -0700 (PDT)
X-Received: by 2002:a05:6214:23c9:b0:8ac:a154:e156 with SMTP id 6a1803df08f44-8bc443d1957mr12240386d6.29.1778020077161;
        Tue, 05 May 2026 15:27:57 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b539aa6f5fsm162692886d6.21.2026.05.05.15.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 15:27:56 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: ian.forbes@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH 09/12] drm/vmwgfx: enforce cursor size limits for MOB cursors
Date: Tue,  5 May 2026 18:22:30 -0400
Message-ID: <20260505222728.519626-10-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505222728.519626-1-zack.rusin@broadcom.com>
References: <20260505222728.519626-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 525CF4D4536
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-244278-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zack.rusin@broadcom.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

vmw_cursor_plane_atomic_check() bounds cursor width and height only
on the legacy update path; the SVGA_CAP2_CURSOR_MOB path -- the
default on modern hosts -- accepts any size.  When the requested size
exceeds SVGA_REG_CURSOR_MAX_DIMENSION or SVGA_REG_MOB_MAX_SIZE,
vmw_cursor_mob_get() returns -EINVAL and leaves vps->cursor.mob NULL.
Its return value is then discarded in vmw_cursor_plane_prepare_fb(),
so the subsequent vmw_cursor_update_mob() calls
vmw_bo_map_and_cache(NULL) and oopses inside
vmw_bo_map_and_cache_size() on the tbo.base.size load.

Reachable from any DRM master via DRM_IOCTL_MODE_CURSOR2 with a
sufficiently large width or height (e.g. cursor_max_dim + 1).

Reject oversized cursors in atomic_check for both MOB-backed cursor
update types.  The MOB byte-size limit only applies to the
SVGA_CAP2_CURSOR_MOB path (vmw_cursor_mob_size() returns 0 for
GB_ONLY); compute the required MOB size in 64-bit to avoid overflow
when very large dimensions are requested.

In prepare_fb only call vmw_cursor_mob_get()/_map() for
VMW_CURSOR_UPDATE_MOB -- the GB_ONLY path uses bo->map.virtual
directly and would otherwise be silently downgraded to NONE on hosts
without SVGA_CAP2_CURSOR_MOB (where vmw_cursor_mob_get() always
returns -EINVAL).  Degrade the update to NONE if vmw_cursor_mob_get()
or vmw_cursor_mob_map() fails so the update path does not run with a
NULL backing MOB.

Fixes: 965544150d1c ("drm/vmwgfx: Refactor cursor handling")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 49 ++++++++++++++++++--
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
index c46f17ba7236..c53bb9376b36 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
@@ -432,6 +432,7 @@ vmw_cursor_mob_map(struct vmw_plane_state *vps)
 	u32 size = vmw_cursor_mob_size(vps->cursor.update_type,
 				       vps->base.crtc_w, vps->base.crtc_h);
 	struct vmw_bo *vbo = vps->cursor.mob;
+	void *map;
 
 	if (!vbo)
 		return -EINVAL;
@@ -446,11 +447,15 @@ vmw_cursor_mob_map(struct vmw_plane_state *vps)
 	if (unlikely(ret != 0))
 		return -ENOMEM;
 
-	vmw_bo_map_and_cache(vbo);
+	map = vmw_bo_map_and_cache(vbo);
+	if (!map) {
+		vmw_bo_unmap(vbo);
+		ret = -ENOMEM;
+	}
 
 	ttm_bo_unreserve(&vbo->tbo);
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -663,9 +668,15 @@ int vmw_cursor_plane_prepare_fb(struct drm_plane *plane,
 			    !vmw_cursor_buffer_changed(vps, old_vps)) {
 				vps->cursor.update_type =
 					VMW_CURSOR_UPDATE_NONE;
-			} else {
-				vmw_cursor_mob_get(vcp, vps);
-				vmw_cursor_mob_map(vps);
+			} else if (vps->cursor.update_type ==
+				   VMW_CURSOR_UPDATE_MOB &&
+				   (vmw_cursor_mob_get(vcp, vps) ||
+				    vmw_cursor_mob_map(vps))) {
+				/*
+				 * Reset the cursor to avoid crashes later.
+				 */
+				vps->cursor.update_type =
+					VMW_CURSOR_UPDATE_NONE;
 			}
 		}
 	}
@@ -732,6 +743,34 @@ int vmw_cursor_plane_atomic_check(struct drm_plane *plane,
 				 "surface not suitable for cursor\n");
 			return -EINVAL;
 		}
+	} else if (update_type == VMW_CURSOR_UPDATE_GB_ONLY ||
+		   update_type == VMW_CURSOR_UPDATE_MOB) {
+		u32 cursor_max_dim =
+			vmw_read(vmw, SVGA_REG_CURSOR_MAX_DIMENSION);
+
+		if (new_state->crtc_w > cursor_max_dim ||
+		    new_state->crtc_h > cursor_max_dim) {
+			drm_warn(&vmw->drm,
+				 "Cursor dimensions (%d, %d) exceed device max %u\n",
+				 new_state->crtc_w, new_state->crtc_h,
+				 cursor_max_dim);
+			return -EINVAL;
+		}
+
+		if (update_type == VMW_CURSOR_UPDATE_MOB) {
+			u32 mob_max_size =
+				vmw_read(vmw, SVGA_REG_MOB_MAX_SIZE);
+			u64 mob_size = (u64)new_state->crtc_w *
+				       new_state->crtc_h * sizeof(u32) +
+				       sizeof(SVGAGBCursorHeader);
+
+			if (mob_size > mob_max_size) {
+				drm_warn(&vmw->drm,
+					 "Cursor MOB size %llu exceeds device max %u\n",
+					 mob_size, mob_max_size);
+				return -EINVAL;
+			}
+		}
 	}
 
 	return 0;
-- 
2.51.0


