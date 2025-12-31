Return-Path: <stable+bounces-204370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F283CEC388
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 17:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50D9730071B3
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 16:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9DE280CD2;
	Wed, 31 Dec 2025 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kG8saADY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0CC2798F3
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767197940; cv=none; b=kbUxKw5WVPnJd6h7s12y0ZvScC1M++Esb5ivLlO/aCWx+ZmAPb0LU7oc+dL16ZbcsPunDtKWfd2zkoTi60K6jO0UBgbUQoISnKHIChLrh01BDjLQ30srB8lvuwZIvl5L08/GSjAy2MRwZ+OOEiNzAQZBiOFqRDo5PlltrBhj0P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767197940; c=relaxed/simple;
	bh=IOuaSQmjF5OZeUPSMtLOr4rp5QFKqShdUbDuF04ndYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n08uMvZWyo2Y03FxK08TYoKjKFwcjqckZyL2TgCewf7tCHTn+JkxdbQa8C2JwC9UkINhlBuE7o78Q0ji4E67a/31Hz3++VUk4IJ1iCwrOv/nJWeoysCJLIDg3vuMIXGuaFFZPOD/506U/Z9d0BeB/AxmS4+TBUm5QndE7olnrKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kG8saADY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E62EC116B1;
	Wed, 31 Dec 2025 16:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767197939;
	bh=IOuaSQmjF5OZeUPSMtLOr4rp5QFKqShdUbDuF04ndYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kG8saADYo9LIzmJv7mMM59LdszbvDo992KV8XpcLKzeYQjj8841VOivErefgMQjeK
	 bjppJgsvIRdYxlUpFzrDGvdbcPa4UAroqB0jJfi5xjMAlh0/s2/RJID6EDSUpt0PbQ
	 gkOlCfw2dzlOxd1rEzYUIrhh9CKiD7bCmteugYVkU8n9neGUDdxRjnIvfz4BvWwCSN
	 5NqdvCbe7JjhgWfaXvCx24KspS4Y+bZfD2TbyprOR70QH5AZam317W37ok6vg+Sj6v
	 qlTxH7izfoSXPXSCPrdM2x7Z+JTOYO5fE3DpMkhdEAQh6GjWKCPa7g276KCDiKGt2l
	 nFttONyeBK8bQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	=?UTF-8?q?Tiago=20Martins=20Ara=C3=BAjo?= <tiago.martins.araujo@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] drm/edid: add DRM_EDID_IDENT_INIT() to initialize struct drm_edid_ident
Date: Wed, 31 Dec 2025 11:18:55 -0500
Message-ID: <20251231161856.3237284-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251231161856.3237284-1-sashal@kernel.org>
References: <2025122944-trimester-congrats-2c82@gregkh>
 <20251231161856.3237284-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jani Nikula <jani.nikula@intel.com>

[ Upstream commit 8b61583f993589a64c061aa91b44f5bd350d90a5 ]

Add a convenience helper for initializing struct drm_edid_ident.

Cc: Tiago Martins Araújo <tiago.martins.araujo@gmail.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Tested-by: Tiago Martins Araújo <tiago.martins.araujo@gmail.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/710b2ac6a211606ec1f90afa57b79e8c7375a27e.1761681968.git.jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Stable-dep-of: 83cbb4d33dc2 ("drm/displayid: add quirk to ignore DisplayID checksum errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/drm/drm_edid.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index 3d1aecfec9b2..04f7a7f1f108 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -340,6 +340,12 @@ struct drm_edid_ident {
 	const char *name;
 };
 
+#define DRM_EDID_IDENT_INIT(_vend_chr_0, _vend_chr_1, _vend_chr_2, _product_id, _name) \
+{ \
+	.panel_id = drm_edid_encode_panel_id(_vend_chr_0, _vend_chr_1, _vend_chr_2, _product_id), \
+	.name = _name, \
+}
+
 #define EDID_PRODUCT_ID(e) ((e)->prod_code[0] | ((e)->prod_code[1] << 8))
 
 /* Short Audio Descriptor */
-- 
2.51.0


