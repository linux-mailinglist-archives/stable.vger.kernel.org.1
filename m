Return-Path: <stable+bounces-95066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DAB9D72C5
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B79B02835E8
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F8A206066;
	Sun, 24 Nov 2024 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sh9GrTYP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEB82040B7;
	Sun, 24 Nov 2024 13:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455865; cv=none; b=UbiZKoC7CZzMFBrlgeo1/JFQHDI51uKhOu5RFJWn10z0nBAmIEIrQvGK8bw0UPThGYboAPUvKZIwu0DXla5y1YJfZ5RWTGL+Pvpsr7lQYw7AsaUQRBTAtiVKFfJI432JZQYbQooP9DPEw5Ql6beO3aVQkoilQPRkd3bMbRv3aBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455865; c=relaxed/simple;
	bh=dvgtB6yA56MRVlRsQXpEbTxd6TeHhGwoaTh1DklfroY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cChMUyGvGxWskPaDm7dPMXQUA0221wb44/kBS6qyAc0j4KooJ9P6pJCOJ4aDF3MGlWZwrJ+w4+0ew7HSydb36pOR0SrQvVRHEVSjkGlM1pou3so4OJdSN71lb/1Jh69BHwOh5ykAlD5sE7+aM4FVv86c1CV5OOdYbqPZdZ8IN5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sh9GrTYP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9669CC4CED6;
	Sun, 24 Nov 2024 13:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455864;
	bh=dvgtB6yA56MRVlRsQXpEbTxd6TeHhGwoaTh1DklfroY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sh9GrTYPC5RfJN1qkY0YG0xm58nDxGcPnzyTHR+iT0huIyP7X8zug96ZCiSknu0lb
	 GgGcftGAcb3m+sEsK01p6DLHOz9wNzGiUdBYI3q+032PazVDhWHHkn4cw9PHbYiAQ4
	 ZLLh8Aw7muQ2cCmjrEyiTRvS0ZQ2qL2//RPIwoQjzc8kp3N8h0RMDsK8a93pIxTsMR
	 icUbNFfxvMS3oF+AKDBe5OB5Qn0R7TZTrDZ4Vu6Q0Cu0PEmYKhcr2ite1H0erofE8d
	 v42tWG6JE29G65W9kDOAdB9vUWE2wXVl4VuLWvmfTvrpkgAYW79aKJ2dI/1mIRYRqf
	 wkgFFUeQ7q4Jg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 63/87] drm/panic: Add ABGR2101010 support
Date: Sun, 24 Nov 2024 08:38:41 -0500
Message-ID: <20241124134102.3344326-63-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Jocelyn Falempe <jfalempe@redhat.com>

[ Upstream commit 04596969eea9e73b64d63be52aabfddb382e9ce6 ]

Add support for ABGR2101010, used by the nouveau driver.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241022185553.1103384-2-jfalempe@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panic.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 948aed00595eb..f762d7a2a9b43 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -198,6 +198,14 @@ static u32 convert_xrgb8888_to_argb2101010(u32 pix)
 	return GENMASK(31, 30) /* set alpha bits */ | pix | ((pix >> 8) & 0x00300C03);
 }
 
+static u32 convert_xrgb8888_to_abgr2101010(u32 pix)
+{
+	pix = ((pix & 0x00FF0000) >> 14) |
+	      ((pix & 0x0000FF00) << 4) |
+	      ((pix & 0x000000FF) << 22);
+	return GENMASK(31, 30) /* set alpha bits */ | pix | ((pix >> 8) & 0x00300C03);
+}
+
 /*
  * convert_from_xrgb8888 - convert one pixel from xrgb8888 to the desired format
  * @color: input color, in xrgb8888 format
@@ -231,6 +239,8 @@ static u32 convert_from_xrgb8888(u32 color, u32 format)
 		return convert_xrgb8888_to_xrgb2101010(color);
 	case DRM_FORMAT_ARGB2101010:
 		return convert_xrgb8888_to_argb2101010(color);
+	case DRM_FORMAT_ABGR2101010:
+		return convert_xrgb8888_to_abgr2101010(color);
 	default:
 		WARN_ONCE(1, "Can't convert to %p4cc\n", &format);
 		return 0;
-- 
2.43.0


