Return-Path: <stable+bounces-94974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BF69D71B8
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8567E1630E6
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0969F1E3791;
	Sun, 24 Nov 2024 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EL6a8sVt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7CE1E3787;
	Sun, 24 Nov 2024 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455457; cv=none; b=ga2CFQ1ht/79+vuR3ieJjEJtbSs/9bprnd/fMifHVd9CHEgQKpaM4LsfThGnGOO7sw3z+BRe1/Q6CPXTC7C+1XJpHnzpmCWkE/wzJ4WPozdxOy7BUlqxKYb1wJzREssghKKo4HkNMX9YiB7gn8k8Alt9glpBCR5xMLJCYlqQgBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455457; c=relaxed/simple;
	bh=EEEbihI3nDaSluEdl9qjTBkV1p/H7rXgZdPCGyFhopA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fffj/ap5bFdnfmXRCXmA1VxiVscRbWwqeP5IhjzdKfcteuUrSaHDGnTsmYjXN3X8fOBr46tph3wMhUSZohfB9gw//rv828sYHcRncZHf40ix0eiZDK25JkC8aZB8oZKXtx0H5C6r5XuRBWS/4Xp4NWLdvxQeIEeHg1YMBq6mfzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EL6a8sVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE88C4CED1;
	Sun, 24 Nov 2024 13:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455457;
	bh=EEEbihI3nDaSluEdl9qjTBkV1p/H7rXgZdPCGyFhopA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EL6a8sVt3c+B+HGdp13bii8UT+5B4pjMgkivnjP4RaPSH1xCHD+CO1ankmuesRJTO
	 HZ6Tj1PCsvyqlfYfByADzT1oJnjst9Bn3/BGhvdODIBP3hEwsrL1weyW5sa1mFa8Wm
	 +6bjqi/zJFFjqQgwOaJqr6dljL7B2Kg06KZ+b4YLm+2EcVGaS9CmvHsKCKsSJ7p2HX
	 ebjHjFs1LuhoVhRe0zFUlBgdMhlTigdk2Qe0AWNytTN6dNRHZQ4297KbTrkyliMDNq
	 Xc/m6PKTW7l6JpsOGbhwvgNn1jrzh7B+d0/+p5sCmuq5HS/3cZLC2RfhYP1g34Yfgd
	 +8svIRvwrHVSg==
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
Subject: [PATCH AUTOSEL 6.12 078/107] drm/panic: Add ABGR2101010 support
Date: Sun, 24 Nov 2024 08:29:38 -0500
Message-ID: <20241124133301.3341829-78-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index 74412b7bf936c..0a9ecc1380d2a 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -209,6 +209,14 @@ static u32 convert_xrgb8888_to_argb2101010(u32 pix)
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
@@ -242,6 +250,8 @@ static u32 convert_from_xrgb8888(u32 color, u32 format)
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


