Return-Path: <stable+bounces-216653-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFhwHV+ikmnqvwEAu9opvQ
	(envelope-from <stable+bounces-216653-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 05:51:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF40C140E2F
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 05:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97C77300C038
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 04:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60BC2DECBF;
	Mon, 16 Feb 2026 04:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBYsMLnd"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5198526056D
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 04:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771217498; cv=none; b=WmZfZMZztT2Kb+oTtN76Zs3qr1fJq/M7Bt4Nr53oNiGqiXl+Bdlly0CfkIG0rXV+dCMp5jRwvR/WfwIpbP/beCqt9m+og4/Y2JrLF6YDjHHKMX17wHebMqHEFOdTB81oYKY2Dhd60VZR9Of5dJHuXh/On/7IMBVeUlaHKyJZm1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771217498; c=relaxed/simple;
	bh=Hfz+oJ1aBM80OSFW15db1tYTLRdf7+8TILGAOyrNlQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YdTepyPbJt9AvkfH2vxh/Aq2UqvFhFnSfX9wuZNIVbMGKGcNrBUBEQalwKS2jSB58NBxc62ooUcgHep4W8Uq6gEEV1fjsHTwzlO6QpS994bSEWfYNJn3YSsG+sC+WWytakGDkmsKcfg8PC/YwJbCf0x+NQJgm80oZ7vFk8iOYow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBYsMLnd; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-482f2599980so30022275e9.0
        for <stable@vger.kernel.org>; Sun, 15 Feb 2026 20:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771217494; x=1771822294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gfbNSZ0Cjv7uEpR3TUvJNrpdOHJt8bEzYAt9jyX7fc4=;
        b=CBYsMLnd6KVKXhOutin9+eBdIsjri4KCr8b3+37jPrOqbW0PYY4leMQWZjB96MbnfV
         AYEm1lNNGOrxqsd43GgK657MSDPKnLnjk7K+JyrUa7zdQjn08oO6dLuYh8POviLs8kkf
         xdPtwIfpzWBRfeNgAaEg487oZsFsWCNPdWjBJXL+rsdzHCIvLKGf0dQ+5PHlZJ1zGti2
         YrmgErg64qXinfQsZ88/HnhPN5DIPuiXhSrgyHs60Cadlz7hNjm9nUHE5zP2R9JH7esR
         aak54jYTibd82rvLhP0b+tyte9V3V0KOtPgmIpap1k1qyp4+folH/+m8LIjAZvbQiSfI
         9Nfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771217494; x=1771822294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfbNSZ0Cjv7uEpR3TUvJNrpdOHJt8bEzYAt9jyX7fc4=;
        b=oBMrtm8sgdd96GNT8W0gbJjwXfWwaxIXt4TBwRFi3vySJADY5ToLOPTOtZ59+fD0iP
         K6uyUki94o3Bm7tR14QTVdyoMAiPL3sFpAf70Tm32/OMbzx4mCC1ifqkjyw7ZJESF/jG
         bxBUkzDJV69nf4UrCxamqGjtAzkVnbPlpWUSE5v4GOm+06OfJdBavoHRcOYVwNyppfeG
         mcpQ2Cnpyq25vS3oiQNR8aKgB8gKPIrLKbG6lBdajqmtzRvlDrJ+VcA4out6uX7hPgpF
         vzyUGG2kab18LrrKvRpdQPvCH0EFwouCI0B3q2rfb/UA7gWiamnGW6AZKPIwwzQauxXL
         we1g==
X-Forwarded-Encrypted: i=1; AJvYcCUezgWPC1JfKIL+dDQc0g7y0HhGTSCNSq0O6ZA7nJBtDukAP6eP8MQJW1HzOBZPE0IVUk5ooyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYkQNUlbwvPE7/OkLjV2ZUABod0eyHYTOAayg5TkzqRoA8UWTX
	mWbma31eu7mZCShHrcbeOjQabTeiyqSAuv+VMee37tGLK7nxYdwMK7F1
X-Gm-Gg: AZuq6aKd5G/8whGsHu+VgSLfZj8VfbvojBnxQg1JRzQj6Ty5xg/yRAHYnNFsDam5sQ9
	Kj/EuTfsfmy6Q//pnvIcPG4Li2/M5fClqPQS1YQ+C05X7lhWVenKQQDhEAFtD3b8hEixJH35MeM
	jwonr8A9iIqZUFBu9JZINT+FPIBXV8l3zNEwH8apn3Q1FJY+2/uuXYYt5QQZ39cYmuAhazBYH2p
	wUmoxSS3DrWJqL0CxCKYOQMWw6fOcuqxDPwBB1Kxw4v+c9pKAHRWAtsRzZ3gfA6JCfAmCPW2SQH
	PkScagqBel9Cg0K7dAF606qXjj3fA/v/MUFBC2eCU85JgwBvt/t+1rvU9dJO6EDHki0Lmm84axX
	ITb2/Rk/9V6IDhqw23JjOqxG+7G4UgsMg6WDIiaVey7OoJGb5+hI4XKvPQtIENDfF65HDuN7FNJ
	U+pPZiQfWxyIQ0oFq3DKIjQgD5h2WO4hiaiuZmWN8LLjZ+AvS2p19rm1VfyDVAGtJrXS/1ZNKxT
	LAIbxhm5GJFQeT5L0oKW71DlARVqG2VMW5abWpbRpVeXXHjjLQLFVbfOg==
X-Received: by 2002:a05:600c:4f4b:b0:477:98f7:2aec with SMTP id 5b1f17b1804b1-48373a160b8mr176746765e9.3.1771217493331;
        Sun, 15 Feb 2026 20:51:33 -0800 (PST)
Received: from groovy.localdomain (dynamic-2a02-3100-6670-3f00-a1f3-fb2e-d2ae-14c6.310.pool.telefonica.de. [2a02:3100:6670:3f00:a1f3:fb2e:d2ae:14c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796acf5b9sm21514219f8f.34.2026.02.15.20.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 20:51:32 -0800 (PST)
From: Mario Kleiner <mario.kleiner.de@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Mario Kleiner <mario.kleiner.de@gmail.com>,
	stable@vger.kernel.org,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Prevent cursor bo's from being pinned to VRAM address zero
Date: Mon, 16 Feb 2026 05:47:35 +0100
Message-ID: <20260216044735.6814-1-mario.kleiner.de@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216653-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,gmail.com,vger.kernel.org,amd.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[mariokleinerde@gmail.com,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF40C140E2F
X-Rspamd-Action: no action

Why?

On some AMD gpu's in some configurations, the start of the VRAM domain, as
reported by amdgpu_ttm_domain_start(adev, AMDGPU_GEM_DOMAIN_VRAM), is
placed at address 0 during GMC init. This is a problem if, during a cursor
plane update, the cursor image bo, which gets always pinned into VRAM,
is placed at offset zero of the VRAM domain, and thereby at the
absolute address afb->address 0.

The display hw apparently doesn't like such a zero start address for at
least native cursor mode, as various checks inside DC are in place, e.g.,
high level dc_stream_check_cursor_attributes(), and lower level DCN
version specific cursor hw programming checks, which do reject cursor
attribute updates with attributes->address.quad_part == 0.

User visible symptoms of this are seriously broken mouse cursors under
both X11 and Wayland (tested with KDE/KWin, GNOME/Mutter, GDM login
manager): Mouse cursor flickers, is invisible, randomly becomes invisible,
or fails to adapt the cursor shape to the context, e.g., when moving from
a text input field to other windows, or window decorations etc. This makes
the cursor irritating and impossible to use.

The drm.debug=4 log shows DRM KMS debug messages of the form
"DC: Cursor address is 0!", and the general syslog prints errors like
"[drm:amdgpu_dm_plane_handle_cursor_update [amdgpu]] *ERROR* DC failed to
set cursor attributes"

I observe this bug on my dual-gpu Apple 2017 MacBookPro since Linux 4.11,
where the kernels early EFI setup force-enables both the Intel iGPU and
AMD dGPU. This leads to the AMD VRAM start being placed at 0x0 and then
causes massive cursor problems. On earlier kernels, only the AMD dGPU was
exposed, the Intel iGPU was disabled / hidden from Linux by EFI firmware.
This caused the AMD gpu to place VRAM start at the non-zero
address 0x000000F400000000, and the mouse cursor worked fine. I confirmed
with umr that the mmMC_VM_FB_LOCATION register of my Polaris 11 gpu indeed
read back 0x0000 in the lower 16 bits in the dual-gpu case, causing
gmc_v8_0_vram_gtt_location() to setup start of VRAM domain at zero.
I don't know what causes the change, but most likely the UEFI firmware
somehow triggers this change before main kernel boot - calling into the
VBIOS, I guess.

There is at least one 8 months old bug report in AMD's issue tracker,
reporting the same symptoms on other AMD setups, cfe.:
https://gitlab.freedesktop.org/drm/amd/-/issues/4302

So unless there is another more clean and reliable way to prevent the
cursor bo from being placed at address zero, or unless the display hw
is actually fine with address zero and those checks in DC are overly
cautious, this needs to be fixed.

Note that simply removing the "zero address -> reject cursor update"
checks worked on my Polaris11 with DCE 11.2 display engine, fixing the
cursor without causing any other obvious trouble. So maybe this is only
a limitation of recent DCN engine versions, or a pointless check.

How?

Add a new AMD bo placement flag which requests bo pinning / placement at
non-zero VRAM address only during amdgpu_bo_pin(). Use this flag for bo's
on the cursor plane during amdgpu_dm_plane_helper_prepare_fb().

I don't know if this is the best approach. It feels hacky, but it is the
only approach I was able to do and it seems to work fine enough.

If this is a good enough fix, it should be backported, but backporting
to earlier than Linux 6.12 might be cumbersome due to changes to the
amdgpu_bo_pin() implementation.

Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
Tested-by: Mario Kleiner <mario.kleiner.de@gmail.com>
Cc: <stable@vger.kernel.org> # v6.12+
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c            | 11 +++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  6 ++++--
 include/uapi/drm/amdgpu_drm.h                         |  7 +++++++
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 1fb956400696..97131fc8fbdf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -975,6 +975,17 @@ int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain)
 		if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS &&
 		    bo->placements[i].mem_type == TTM_PL_VRAM)
 			bo->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
+
+		/* Ensure bo is never pinned at amdgpu_bo_gpu_offset() == 0
+		 * for VRAM allocations, as some of the DC code does not
+		 * like that, e.g., mouse cursor display image bo's.
+		 */
+		if (bo->flags & AMDGPU_GEM_CREATE_VRAM_NON_ZERO_ADDRESS &&
+		    bo->placements[i].mem_type == TTM_PL_VRAM &&
+		    !bo->placements[i].fpfn &&
+		    !amdgpu_ttm_domain_start(adev, TTM_PL_VRAM)) {
+			bo->placements[i].fpfn = 1;
+		}
 	}
 
 	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 394880ec1078..cd7f53d3036c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -959,10 +959,12 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
 		goto error_unlock;
 	}
 
-	if (plane->type != DRM_PLANE_TYPE_CURSOR)
+	if (plane->type != DRM_PLANE_TYPE_CURSOR) {
 		domain = amdgpu_display_supported_domains(adev, rbo->flags);
-	else
+	} else {
 		domain = AMDGPU_GEM_DOMAIN_VRAM;
+		rbo->flags |= AMDGPU_GEM_CREATE_VRAM_NON_ZERO_ADDRESS;
+	}
 
 	rbo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 	r = amdgpu_bo_pin(rbo, domain);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 1d34daa0ebcd..6dee7653c54e 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -181,6 +181,13 @@ extern "C" {
 #define AMDGPU_GEM_CREATE_EXT_COHERENT		(1 << 15)
 /* Set PTE.D and recompress during GTT->VRAM moves according to TILING flags. */
 #define AMDGPU_GEM_CREATE_GFX12_DCC		(1 << 16)
+/* Flag that BO must not be placed in VRAM domain at offset zero if the
+ * VRAM domain itself starts at address zero.
+ *
+ * Used internally to prevent placement of cursor image BO at that location,
+ * as the display hardware doesn't like that for hardware cursors.
+ */
+#define AMDGPU_GEM_CREATE_VRAM_NON_ZERO_ADDRESS (1 << 17)
 
 struct drm_amdgpu_gem_create_in  {
 	/** the requested memory size */
-- 
2.43.0


