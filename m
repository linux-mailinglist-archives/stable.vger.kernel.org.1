Return-Path: <stable+bounces-204373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71656CEC3D9
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 17:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6175A30069BA
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 16:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C641284B2F;
	Wed, 31 Dec 2025 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZX+nWDRE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5AE1EFF9B
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767198571; cv=none; b=MvmrI43f6HTXYB4nCzWLIdpFvc6cbE5wKQ2rVq/spQVKGz9WpTxVxZBMA4ubAnir+BEPDCsnwcdz3e4uvC6CrmvIjEJTYh5gArW82KB094FZXm4ENjhnh8HHAed1f9N7REEIlchUhGll09mPvz5gx77Dksdr5fRYJ4HUQzzXGYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767198571; c=relaxed/simple;
	bh=18RlXgveDBAD3r7nZjP79q8MXo67cTVj0Fjb6lEDXno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ewozh4CRaYXlZryFQIhZLc9dlnpqdaC3Vl7ePZswssGpLd1P3uvfx1wFzOoMuDSsz9dUSWJhEUHsS9m6WnsTboHo7WT7j0rEDza5IQPOe1qXZCGaBjI51QJ8nvBawHvttgwgDj/W8JIDfXqqpHb34wljYI8DMeUxU51+cnpMR/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZX+nWDRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654B4C19421;
	Wed, 31 Dec 2025 16:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767198571;
	bh=18RlXgveDBAD3r7nZjP79q8MXo67cTVj0Fjb6lEDXno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZX+nWDREcjY9jjxHnusRuGo2yr2oxoZaaF3H52d5W/vCQ3o2N1eOIzhhEDqSEo79y
	 uNfp/dOTKJ9rCCthhygYMEQvP7J9SZ62KszUCrorv2p005wUiqPxXbLkXC6vZWsqsn
	 /BnDOxBOryP9qy4TZj0t5R/rw0KetCAgj+rTRn7DGo3R6mgCMNG0guLjUv+ZhkqvrW
	 7lH9UjCzOqVoIoqAypBiwjVXQbPi223UoRcW9Mfvw4Q4srj6aqu7Tp4dUao0z68cwK
	 4y02o/+ZZZ2yivvpkzwl3u1/vYR3si4p3S4HZ70ShqEGxP3Jsc4klq2bAmYv7llTmw
	 4IHpqEkaVenoQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	=?UTF-8?q?Tiago=20Martins=20Ara=C3=BAjo?= <tiago.martins.araujo@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] drm/edid: add DRM_EDID_IDENT_INIT() to initialize struct drm_edid_ident
Date: Wed, 31 Dec 2025 11:29:25 -0500
Message-ID: <20251231162926.3267905-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251231162926.3267905-1-sashal@kernel.org>
References: <2025122954-stony-herring-2347@gregkh>
 <20251231162926.3267905-1-sashal@kernel.org>
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
index eaac5e665892..e9e7c9d14376 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -333,6 +333,12 @@ struct drm_edid_ident {
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


