Return-Path: <stable+bounces-82831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 325DF994F5A
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C426BB24E2E
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF1D1DEFDD;
	Tue,  8 Oct 2024 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vYguxPRS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F041F1DE89F;
	Tue,  8 Oct 2024 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393572; cv=none; b=G8oq2KA27DaK82h99G3I2nBTbXgjRphcm6UvDTc5JwDSS5yiQE6OUM7sc2vIYI0fQm9/p4h5T71kscc8PAnO/NaBsR6wa9TYILTIZ6ozUfHLn/4htDaYLLMCh/VZ9oJuwUF+OrFVAeDAWMqu0qbEYb6/4F7kOVH8rvoyubluXwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393572; c=relaxed/simple;
	bh=PVbFAeyDgk+9tNtRzy47Nst0AaRHd2vMljCfkvQQ06w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q30Lu8T3MNNWAvzUQEztH/ZqLkCONGpdR6BI9HbW1G3m1xXzdvYhbfy/ADAqViUfE7MfaKcKYw1fLlt3IFy5bIiwLyRldFl3Gchb/uM9lyIpoMLbJ696UMPLXKbFopXNCdEEmOI42M8df6F1VJpcyrfmZgsdt5Phrn1afCrXBBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vYguxPRS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E103C4CEC7;
	Tue,  8 Oct 2024 13:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728393571;
	bh=PVbFAeyDgk+9tNtRzy47Nst0AaRHd2vMljCfkvQQ06w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vYguxPRSEvC03i9girq7dZHBShtAEv+9ajx24GCBackzYOzubged+l0BB22P7MV+M
	 IaPd4Nxba5l0wZogKAn98lzqZbyz/noJFir8vbEmLy/H9vOdej8i3Q8e8f29grwaoo
	 A+v5eDGAxHGv6yeWJNoxhPcDCimMUOZ4H5fpkluc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 160/386] drm/amd/display: Initialize get_bytes_per_elements default to 1
Date: Tue,  8 Oct 2024 14:06:45 +0200
Message-ID: <20241008115635.721696921@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115629.309157387@linuxfoundation.org>
References: <20241008115629.309157387@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 4067f4fa0423a89fb19a30b57231b384d77d2610 ]

Variables, used as denominators and maybe not assigned to other values,
should not be 0. bytes_per_element_y & bytes_per_element_c are
initialized by get_bytes_per_element() which should never return 0.

This fixes 10 DIVIDE_BY_ZERO issues reported by Coverity.

Signed-off-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c | 2 +-
 .../gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
index 0fc9f3e3ffaef..f603486af6e30 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
@@ -78,7 +78,7 @@ static void calculate_ttu_cursor(struct display_mode_lib *mode_lib,
 
 static unsigned int get_bytes_per_element(enum source_format_class source_format, bool is_chroma)
 {
-	unsigned int ret_val = 0;
+	unsigned int ret_val = 1;
 
 	if (source_format == dm_444_16) {
 		if (!is_chroma)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
index 618f4b682ab1b..9f28e4d3c664c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
@@ -53,7 +53,7 @@ static void calculate_ttu_cursor(
 
 static unsigned int get_bytes_per_element(enum source_format_class source_format, bool is_chroma)
 {
-	unsigned int ret_val = 0;
+	unsigned int ret_val = 1;
 
 	if (source_format == dm_444_16) {
 		if (!is_chroma)
-- 
2.43.0




