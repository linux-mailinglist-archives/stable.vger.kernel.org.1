Return-Path: <stable+bounces-43317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F30DC8BF1AC
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC616281EB2
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25F8145358;
	Tue,  7 May 2024 23:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVSW0Eap"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F41A135A69;
	Tue,  7 May 2024 23:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123367; cv=none; b=cDbo3S9L0OGMHG6BPkE+4gWrOFAeMtP1QV1kVlyAHhV6V2WkQ05BKlzwqsKrEvHh9/UStIUEkM6cuxiVpOrJ6nQ97CvX4LADjGZwN9MAU2TesXr6+V+eMS9q0KuiH72/rP7Qq2hpyfwuu81xT5mEd085qf5huLbx1CMYedsLYSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123367; c=relaxed/simple;
	bh=A6ZtLxN52DVlUn5pmJLAX5JU2rQmZsA9I6/M18sPrV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bg8qUPujkFSAe4VH2y6B4WCWkY2Au3nAS7mnCSkDB9EmNhQtnO3FqQmw57m+YAlcFeerIsxEJ0VnhrL4o22Lm2fc7+HB9LkfTUnAqnKGaJfjVs8sC9t78XkcEbQEejWkPrXm00DZoonSmC+j06CyiSD84zh9VLiBK9CSxUoZpx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVSW0Eap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A99C4AF63;
	Tue,  7 May 2024 23:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123367;
	bh=A6ZtLxN52DVlUn5pmJLAX5JU2rQmZsA9I6/M18sPrV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OVSW0EapK5ji8MuwCN6bsre/Qrn4VfIexUgUtKkUAU5mzAGln6b+FZwHcn60BZKZi
	 SDjdKKi0OWLpFcYarWvadM2w4dR5w9mZ45EA0B17E96WABHisfg+bqccoUoMOqkBho
	 aaCvl5OaOngAG69Dt68yMPWFTA5bykpl1lHzA4RegdQhScs0NhqhsyzWGV5aZ5gto9
	 iGG2yicdg+syIDdyjUPabNgO9lHnC68Li9JUH3iCGiTjAGpiyC3KNaVy7agR8x85zn
	 a2MN2+URShaZxhLE9BEvjFZK0Dzaf/QbBTO0SoWSLnBYXZt9407PlTvOavN1v+4IxP
	 A/FiqJOg6D4nQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gabe Teeger <gabe.teeger@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	wayne.lin@amd.com,
	alvin.lee2@amd.com,
	charlene.liu@amd.com,
	sohaib.nadeem@amd.com,
	sunran001@208suo.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 38/52] drm/amd/display: Atom Integrated System Info v2_2 for DCN35
Date: Tue,  7 May 2024 19:07:04 -0400
Message-ID: <20240507230800.392128-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit

From: Gabe Teeger <gabe.teeger@amd.com>

[ Upstream commit 9a35d205f466501dcfe5625ca313d944d0ac2d60 ]

New request from KMD/VBIOS in order to support new UMA carveout
model. This fixes a null dereference from accessing
Ctx->dc_bios->integrated_info while it was NULL.

DAL parses through the BIOS and extracts the necessary
integrated_info but was missing a case for the new BIOS
version 2.3.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 05f392501c0ae..ab31643b10969 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -2948,6 +2948,7 @@ static enum bp_result construct_integrated_info(
 				result = get_integrated_info_v2_1(bp, info);
 				break;
 			case 2:
+			case 3:
 				result = get_integrated_info_v2_2(bp, info);
 				break;
 			default:
-- 
2.43.0


