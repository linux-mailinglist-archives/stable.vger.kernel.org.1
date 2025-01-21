Return-Path: <stable+bounces-110014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1FEA18518
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD7DC7A7090
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 18:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365161F756A;
	Tue, 21 Jan 2025 18:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N9InRLET"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DCE1F55E3;
	Tue, 21 Jan 2025 18:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737483093; cv=none; b=iyur8HGoWtxJ1Jg97t387G/z+Q34VV8FCsuD+L0ta7ek90Gn4H1iGU9J1HwMJv0NlR+5X8reon2G10KX7fHX7j5FAwx17tuXVPzZfDgbIEwZw5/ttBoTxOPzLCXAlZHymrjLu+UAARLcMoLcpi68hILOtwtEz/KsFBjWBQplea4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737483093; c=relaxed/simple;
	bh=zewHS3UO1ukO5CMf315GD0T+QXhex1tri2mM06zYCXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOZLDZYy+GG8tBQLqNM4MvSSShGMDEK9mImFftPHVFOdQDfiusaSqXKm/LnmrOsmmbOn6SqDMD2IedUjrj4KwfsCeprEkk9sIlSMGP7gUWOtf0r/2XyBQOwxwJ9vHNofWmwIc3Ri6cqdyWv/LV4vA/CSay7js2bxQYWK+Jo3szM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N9InRLET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B879C4CEDF;
	Tue, 21 Jan 2025 18:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737483092;
	bh=zewHS3UO1ukO5CMf315GD0T+QXhex1tri2mM06zYCXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N9InRLETj6I3zyJuoP8nDeU2MDFPZzVXdowl0vS6NtleZaQyDfYh0KAuIfKqh3vYT
	 wMj8ahpSQ0Nw3ZNSX0NCXP5F6TwvqBUHCKdNiICJZyS8jld5UdzAB0yv+XrTCeI78x
	 14kl1Kv8f3AcKTQI5T11DRYDiJ/SzdMP67f9dVqg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sagar Ghuge <sagar.ghuge@intel.com>,
	Nanley Chery <nanley.g.chery@intel.com>,
	Xi Ruoyao <xry111@xry111.site>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: [PATCH 5.15 114/127] drm/i915/fb: Relax clear color alignment to 64 bytes
Date: Tue, 21 Jan 2025 18:53:06 +0100
Message-ID: <20250121174534.042588688@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250121174529.674452028@linuxfoundation.org>
References: <20250121174529.674452028@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 1a5401ec3018c101c456cdbda2eaef9482db6786 upstream.

Mesa changed its clear color alignment from 4k to 64 bytes
without informing the kernel side about the change. This
is now likely to cause framebuffer creation to fail.

The only thing we do with the clear color buffer in i915 is:
1. map a single page
2. read out bytes 16-23 from said page
3. unmap the page

So the only requirement we really have is that those 8 bytes
are all contained within one page. Thus we can deal with the
Mesa regression by reducing the alignment requiment from 4k
to the same 64 bytes in the kernel. We could even go as low as
32 bytes, but IIRC 64 bytes is the hardware requirement on
the 3D engine side so matching that seems sensible.

Note that the Mesa alignment chages were partially undone
so the regression itself was already fixed on userspace
side.

Cc: stable@vger.kernel.org
Cc: Sagar Ghuge <sagar.ghuge@intel.com>
Cc: Nanley Chery <nanley.g.chery@intel.com>
Reported-by: Xi Ruoyao <xry111@xry111.site>
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/13057
Closes: https://lore.kernel.org/all/45a5bba8de009347262d86a4acb27169d9ae0d9f.camel@xry111.site/
Link: https://gitlab.freedesktop.org/mesa/mesa/-/commit/17f97a69c13832a6c1b0b3aad45b06f07d4b852f
Link: https://gitlab.freedesktop.org/mesa/mesa/-/commit/888f63cf1baf34bc95e847a30a041dc7798edddb
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241129065014.8363-2-ville.syrjala@linux.intel.com
Tested-by: Xi Ruoyao <xry111@xry111.site>
Reviewed-by: José Roberto de Souza <jose.souza@intel.com>
(cherry picked from commit ed3a892e5e3d6b3f6eeb76db7c92a968aeb52f3d)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/display/intel_fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/display/intel_fb.c
+++ b/drivers/gpu/drm/i915/display/intel_fb.c
@@ -795,7 +795,7 @@ int intel_fill_fb_info(struct drm_i915_p
 		 * arithmetic related to alignment and offset calculation.
 		 */
 		if (is_gen12_ccs_cc_plane(&fb->base, i)) {
-			if (IS_ALIGNED(fb->base.offsets[i], PAGE_SIZE))
+			if (IS_ALIGNED(fb->base.offsets[i], 64))
 				continue;
 			else
 				return -EINVAL;



