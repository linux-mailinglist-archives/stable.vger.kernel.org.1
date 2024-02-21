Return-Path: <stable+bounces-22771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A26885DDCA
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E0D283C48
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629A981AB1;
	Wed, 21 Feb 2024 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nG7Lijr1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206BB81AAE;
	Wed, 21 Feb 2024 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524459; cv=none; b=uknZTDsMTAUeWUJWSjYkB11y3TWQtYURwdyXJ6FkWbU2bFA+dh2aTwkWzIX2ifXzaJz/cP3yCBQZej+dqS6QRkKBvewiThVdvm3uFeIERoduX89SPXwAmCcudJUn+LuUfRZ5f8RaEsbMO9C2bw2pxfCQwo+Mo/5JVx4LSOwKrLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524459; c=relaxed/simple;
	bh=p9+JhdxkoE2cQw33eAFST2av7kbaSPQSP9q+6sgTCP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FTcvvBDJo9Ik4W2pUrzDq42r6OU6LEP1KFWizxub2Vn6UHNobGoUAM7c1kq/A3cUj0Q1P6n8oPzKRWi86X/Djk0HZqqpX8CWVZJKbzPrwa2c4oWOo6Buiwc0cNb61lU9gaF2JdEJh60YFV2p2IjDIIE4ft+VsloUUm9NI5ZbZes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nG7Lijr1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DFAC43399;
	Wed, 21 Feb 2024 14:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708524459;
	bh=p9+JhdxkoE2cQw33eAFST2av7kbaSPQSP9q+6sgTCP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nG7Lijr1QjUe2H1DE7iHRzzqlavTbhmQcy4/tf/EkvxCqRr5mM9GoQ1qYBcFjJowr
	 c/6n1cA/hbwcWii9qtyog0DwEF7WWSKBt8nhXPNLCp+50ccqcoMa+ErjNIqITBtKLv
	 Hv/URbrhfMZNkRml9r0IETlS02LXmX6PI1ZyTT7Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 222/379] drm: using mul_u32_u32() requires linux/math64.h
Date: Wed, 21 Feb 2024 14:06:41 +0100
Message-ID: <20240221130001.467539146@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125954.917878865@linuxfoundation.org>
References: <20240221125954.917878865@linuxfoundation.org>
User-Agent: quilt/0.67
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Rothwell <sfr@canb.auug.org.au>

[ Upstream commit 933a2a376fb3f22ba4774f74233571504ac56b02 ]

Some pending include file cleanups produced this error:

In file included from include/linux/kernel.h:27,
                 from drivers/gpu/ipu-v3/ipu-dp.c:7:
include/drm/drm_color_mgmt.h: In function 'drm_color_lut_extract':
include/drm/drm_color_mgmt.h:45:46: error: implicit declaration of function 'mul_u32_u32' [-Werror=implicit-function-declaration]
   45 |                 return DIV_ROUND_CLOSEST_ULL(mul_u32_u32(user_input, (1 << bit_precision) - 1),
      |                                              ^~~~~~~~~~~

Fixes: c6fbb6bca108 ("drm: Fix color LUT rounding")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231219145734.13e40e1e@canb.auug.org.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/drm/drm_color_mgmt.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgmt.h
index 54b2b2467bfd..ed81741036d7 100644
--- a/include/drm/drm_color_mgmt.h
+++ b/include/drm/drm_color_mgmt.h
@@ -24,6 +24,7 @@
 #define __DRM_COLOR_MGMT_H__
 
 #include <linux/ctype.h>
+#include <linux/math64.h>
 #include <drm/drm_property.h>
 
 struct drm_crtc;
-- 
2.43.0




