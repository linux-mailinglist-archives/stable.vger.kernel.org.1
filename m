Return-Path: <stable+bounces-220511-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMXYNmY6o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220511-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:56:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C831C66F5
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 41DBF32B2FF7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C813CAF99;
	Sat, 28 Feb 2026 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETgk1PxZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAB13CAF90;
	Sat, 28 Feb 2026 17:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300395; cv=none; b=M5hP6LxYmqEKDA2KuXWtiR79WJbi+Dt27K/hZH7zh/0ArAeWkQ7UidcKspPHx/YrZTnProUJilGolmfNPaZTZcQyhIuNkDaYP7yhWoLIkSpiFtnoFHX/6axURP4HJGl3QjyNJ63T236oSQza+LKCajKC1dqUWmAda3G0ruKg4aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300395; c=relaxed/simple;
	bh=tdLRcPDYUfZm78vFyiDv0xPCoGYLygU2PRZY3oEzq2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2sPdSh9F8ukkZHG9Yww8QQICplenvNqPg1CFJ2eIdmkPIFebH8Jsa6NM3KxPuoq5oNGPrRQw+EAOq+xFRrS5UWoIKPuwtIeKvCnq+1apjbQ4FrGjIdIxi4+LhDURJysioh23A61IqadVLJBl5DTty6VRociKHGoIh8WkUAzB0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETgk1PxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54B2C116D0;
	Sat, 28 Feb 2026 17:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300395;
	bh=tdLRcPDYUfZm78vFyiDv0xPCoGYLygU2PRZY3oEzq2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ETgk1PxZPbX4ztyxDSm1j/gCSVubOvIZmaBen2YyS+kD38mDXYgKskq2UvTfX3LSh
	 vVcgoXUnTKNDMgA2ug5zyBEe4w7PB2doT/qpvlWKFTwM7Ihi8wsigCtxh8Cacqb4Rh
	 fGrzIdxx7i5p5ivvxAX7QA4NrFHIr62PwuJAVyYtP8gsOU1bgX8xK7WehP81HY4gyE
	 1fqGH5wIsrSzUDxi1ZA82mplwb+uPUv1YAtSppv0Qc8c6/MdlDB3jHdj3tvP33mYzV
	 1sMn1Pe2y7zqMJdsgoNHvFf240bAjuswchYSg3oVUWgonQB9Vxjooxv44gt5+xY6Nr
	 4dOi+tGRxAx2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Clay King <clayking@amd.com>,
	Aric Cyr <aric.cyr@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 432/844] drm/amd/display: bypass post csc for additional color spaces in dal
Date: Sat, 28 Feb 2026 12:25:45 -0500
Message-ID: <20260228173244.1509663-433-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220511-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 78C831C66F5
X-Rspamd-Action: no action

From: Clay King <clayking@amd.com>

[ Upstream commit 7d9ec9dc20ecdb1661f4538cd9112cd3d6a5f15a ]

[Why]
For RGB BT2020 full and limited color spaces, overlay adjustments were
applied twice (once by MM and once by DAL). This results in incorrect
colours and a noticeable difference between mpo and non-mpo cases.

[How]
Add RGB BT2020 full and limited color spaces to list that bypasses post
csc adjustment.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Clay King <clayking@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  | 21 ++++++++++++++++---
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h  |  4 ++++
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.c    |  6 +++---
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
index ef4a161171814..c7923531da83d 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
@@ -376,10 +376,10 @@ void dpp3_cnv_setup (
 
 		tbl_entry.color_space = input_color_space;
 
-		if (color_space >= COLOR_SPACE_YCBCR601)
-			select = INPUT_CSC_SELECT_ICSC;
-		else
+		if (dpp3_should_bypass_post_csc_for_colorspace(color_space))
 			select = INPUT_CSC_SELECT_BYPASS;
+		else
+			select = INPUT_CSC_SELECT_ICSC;
 
 		dpp3_program_post_csc(dpp_base, color_space, select,
 				      &tbl_entry);
@@ -1541,3 +1541,18 @@ bool dpp3_construct(
 	return true;
 }
 
+bool dpp3_should_bypass_post_csc_for_colorspace(enum dc_color_space dc_color_space)
+{
+	switch (dc_color_space) {
+	case COLOR_SPACE_UNKNOWN:
+	case COLOR_SPACE_SRGB:
+	case COLOR_SPACE_XR_RGB:
+	case COLOR_SPACE_SRGB_LIMITED:
+	case COLOR_SPACE_MSREF_SCRGB:
+	case COLOR_SPACE_2020_RGB_FULLRANGE:
+	case COLOR_SPACE_2020_RGB_LIMITEDRANGE:
+		return true;
+	default:
+		return false;
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h
index d4a70b4379eaf..6a61b99d6a798 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h
@@ -644,4 +644,8 @@ void dpp3_program_cm_dealpha(
 
 void dpp3_cm_get_gamut_remap(struct dpp *dpp_base,
 			     struct dpp_grph_csc_adjustment *adjust);
+
+bool dpp3_should_bypass_post_csc_for_colorspace(
+		enum dc_color_space dc_color_space);
+
 #endif /* __DC_HWSS_DCN30_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c
index 96c2c853de42c..2d6a646462e21 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c
@@ -206,10 +206,10 @@ void dpp401_dpp_setup(
 
 		tbl_entry.color_space = input_color_space;
 
-		if (color_space >= COLOR_SPACE_YCBCR601)
-			select = INPUT_CSC_SELECT_ICSC;
-		else
+		if (dpp3_should_bypass_post_csc_for_colorspace(color_space))
 			select = INPUT_CSC_SELECT_BYPASS;
+		else
+			select = INPUT_CSC_SELECT_ICSC;
 
 		dpp3_program_post_csc(dpp_base, color_space, select,
 			&tbl_entry);
-- 
2.51.0


