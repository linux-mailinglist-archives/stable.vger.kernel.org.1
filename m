Return-Path: <stable+bounces-238674-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKYFFlaD5Wn0kgEAu9opvQ
	(envelope-from <stable+bounces-238674-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 03:37:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B81AB42607B
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 03:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28467300B3D7
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 01:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9255374E76;
	Mon, 20 Apr 2026 01:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3+LFlKC"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CEC21FF2A
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 01:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776649039; cv=none; b=pwp62wTQwYnea4VbKDRpRTwB9HicFNpyVGZ/brQdr2OYIA3A+Dh7a/9NfeqEsLR8end9w7xRR8BNGUmxBiRgR6ctR/gcoRXk+we0K92xRsfmYoFjACg8QAEcLug3+pq0Nt6MOeEaSr1ySsjAt9WW/vwdKzEped7anpAezsjL92o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776649039; c=relaxed/simple;
	bh=bEu+schdl3H87Rb4LAH9J3MCpCQdId0KAn+oSl3OdAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UaQd41QYYD3l7gddCmfGBjpGId2leAxo8VBQ94yqmmwk1tF4tWO9aOfDZg2Rv4duPCiTVtLHnFBI7Alv2fM4le3TKmY334rdLfBNcD4UFAm6dptSG68LS17LVsnol+O6/F1rLDgBKldtDMUQ/ARpkWa9YDkgY54EOGq6io9qOWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3+LFlKC; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-793fdbb8d3aso22482897b3.3
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 18:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776649037; x=1777253837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKU11ok0UdmISqg+TyGzbe+U8sWE0AZJ6IK5DjOXMLY=;
        b=m3+LFlKC3LSVSnRvUeBWEj8CjTaHyPrTgQNubUOs014Wq/mhMl4D4y7SVbOeZkFVNx
         IcweaJN4hMt4Son1OsZfsrmF6V+s54wwPfyuOTzelAK9AID9h6KWzW2Vhj5xPBZDiQ/w
         iKj8nuJM1SGdGDA+dqyJqrEtI83FTMbQ2rg36j6amYZxnncESx3NlbttdZZ8YVqpl/4Z
         70nfQC85RVGG9HlZ1tAOuBnHMT38htIu7+KgXn0/bNxeFEbVleoefLWlVZ++I+HVUeu+
         Qy6WdW1mC1p52I4ZAREIbkUOnE7OoQrbA0/lkpt+1DaTZIJgiIGl5ejlaRbGviAM1cE/
         xX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776649037; x=1777253837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PKU11ok0UdmISqg+TyGzbe+U8sWE0AZJ6IK5DjOXMLY=;
        b=CkOGzhdwWWSDxpl3l+tGBo79wkxeGFnpiYoRkqu5Cx/NVYewPxvwYGdppF1KQN0zD7
         L+VUoHfvE1dhQSEX1dT3kbHZHxzvWoK4gamdHnWz5gMz9H1dBuriWQqlfGhCoJy/ykQp
         qFvFxrq3Ppz5Y6vvNFO0fOS3Ax78/xTvtLV0eUypNYMLXX4h6EKx2MPk77yt/y64Fihg
         k5iyudLIa5AAPZHy+EOlq8N2IWouftyT88u0nFKtRAxGWHFXNud01/JHgfszNo5SDRmB
         YSsD1lDN6F6ABfpzhHtW7DNzYN+LJCk2HMNZQ9fJCuHhZobjljWHNrdQx0k5u9enO7vW
         EZYQ==
X-Forwarded-Encrypted: i=1; AFNElJ+osH4xY2kr7dp8dl8Np1R8o/lyc8rI2bH7N04k58ilDZNzcKC8n9JKEbeXfn1+24Jh8WsMBWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlLWmuF4KYgMP0+dLwyjNOpJf4Bs+yRgXgpRPHoXzPkpixzk64
	RQnYIytFSf/9GhC/IMqJGxGKjZucXF2euWfj7LNDg1l6BeI64YYkXcae
X-Gm-Gg: AeBDiev7aFDdfmbPfV/LbMNayNbH0bw1uv2ZgKMOWBbQXkqkcdrktl8iutYc/L09pCK
	g5ZSHXLBbbKdcCcfmhy6CB6c9Dn9qyJcg9XIRzMBn9aQgZTgHBf6hP++6JUtMsViNsyBTA0s3R1
	aKdTJB9mF3iB0XzC4FQnH553lZm0hMdk4K5K7BBGv0ezT0A0rGlXBC9RWhCfH5zFdAQ0nwSinw3
	fgmRessjB8zvBGRmgnDlao9pHrfxaSZt98+cCzgY6VOWgz4yxhCmKcpxviX+d9R/AUYUWtqRZ/O
	74fCDuexv2XzOWHjL5IEF6yqZwF0IpBOUDnv6PUeCJjyQhtzITh3tml1vNx1c0iq3Aar3TgQn1W
	W3seCgvLYwQLVD20dzYmdaBcmG71X1EzCy53NepMAt8fFzP6DsfskaHpm4OxJcOKpd8vu7zrDq+
	C/IJqPuWeC7uM/64MBXSCtaD7OaRgtIBwGG1xdsCB6crT0vi6NoDUhWLkGoza9FnrDhjfZPQpAh
	2zgHh009xi5emPt/MVskqbtlQqCvF8HdhkzDs0=
X-Received: by 2002:a05:690c:9:b0:7a2:7b00:67e6 with SMTP id 00721157ae682-7b9ecee8228mr133713637b3.21.1776649037367;
        Sun, 19 Apr 2026 18:37:17 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee9b1c4dsm37350767b3.33.2026.04.19.18.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 18:37:16 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH v2] drm/gem: Fix inconsistent plane dimension calculation in drm_gem_fb_init_with_funcs()
Date: Mon, 20 Apr 2026 01:36:37 +0000
Message-Id: <20260420013637.457751-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2f9cd84b-0642-418b-a4ed-7863716a8531@suse.de>
References: <2f9cd84b-0642-418b-a4ed-7863716a8531@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238674-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B81AB42607B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

drm_gem_fb_init_with_funcs() computes sub-sampled plane dimensions
using plain integer division:

  unsigned int width  = mode_cmd->width  / (i ? info->hsub : 1);
  unsigned int height = mode_cmd->height / (i ? info->vsub : 1);

However, the ioctl-level framebuffer_check() in drm_framebuffer.c uses
drm_format_info_plane_width/height() which round up dimensions via
DIV_ROUND_UP(). This inconsistency corrupts the subsequent GEM object
size check for certain pixel format and dimension combinations.

For example, with NV12 (vsub=2) and a 1-pixel-tall framebuffer the
GEM size validation path sees height=0 instead of height=1. The
expression (height - 1) then wraps to UINT_MAX as an unsigned int,
causing min_size to overflow and wrap back to a small value. A tiny
GEM object therefore passes the size guard, yet when the GPU accesses
the chroma plane it will read or write memory beyond the object's
bounds.

Fix by replacing the open-coded divisions with drm_format_info_plane_width()
and drm_format_info_plane_height(), which use DIV_ROUND_UP() and match
the calculation already used in framebuffer_check().

Fixes: 4c3dbb2c312c ("drm: Add GEM backed framebuffer library")
Cc: stable@vger.kernel.org # v4.14+
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
V1 -> V2: add Fixes: tag, Cc: stable@vger.kernel.org, incorporate
  Reviewed-by from Thomas Zimmermann.

Link: https://lore.kernel.org/dri-devel/20260409164156.2235189-1-ashutoshdesai993@gmail.com/

 drivers/gpu/drm/drm_gem_framebuffer_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_framebuffer_helper.c b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
index 9166c353f131..88808e972cc1 100644
--- a/drivers/gpu/drm/drm_gem_framebuffer_helper.c
+++ b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
@@ -172,8 +172,8 @@ int drm_gem_fb_init_with_funcs(struct drm_device *dev,
 	}
 
 	for (i = 0; i < info->num_planes; i++) {
-		unsigned int width = mode_cmd->width / (i ? info->hsub : 1);
-		unsigned int height = mode_cmd->height / (i ? info->vsub : 1);
+		unsigned int width = drm_format_info_plane_width(info, mode_cmd->width, i);
+		unsigned int height = drm_format_info_plane_height(info, mode_cmd->height, i);
 		unsigned int min_size;
 
 		objs[i] = drm_gem_object_lookup(file, mode_cmd->handles[i]);
-- 
2.34.1


