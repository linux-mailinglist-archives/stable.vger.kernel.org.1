Return-Path: <stable+bounces-44313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F738C5235
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A4D1C21754
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562633F9D2;
	Tue, 14 May 2024 11:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LrX1QEup"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7D8200BF;
	Tue, 14 May 2024 11:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715685642; cv=none; b=NlCZQuO3Rj7OHJdoLytpN61HNh4Xo2KxDXEbVyvL5318+l7Wt6dNBL2FLTpEkVshpIK1XIhA5WSeN6sKlc7W7ku4hub4oM94TmPFiAI1xvMVfmrbxX3gm2bhpyL2aV290tjOpTbguMBs10V0wM2u4QS9y4pwxXEJXw6gMkUChxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715685642; c=relaxed/simple;
	bh=/BPfDOjSsmQJV1pgll8WJJ9DaX0UwBssix0JmYg0lNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCHeu16lu8/f0f9abOmPbegHgzIs4G0NFFqY5/23jJSp9mNcm1Xavn4zOIEjdP4qzJwG9zn6N8k3DK4vq8ySYHrYPJqt0HS/O50I3wYkrtMK3jKT7ukvhiebJ24nQUBT+QlTNl9opnUj2nQmR4148yvZwKOh6Od7zHZUiPsN1Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LrX1QEup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE6EC2BD10;
	Tue, 14 May 2024 11:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715685641;
	bh=/BPfDOjSsmQJV1pgll8WJJ9DaX0UwBssix0JmYg0lNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LrX1QEuplyMbcRj3sq+lL0sApv+LdivKKm5Uwma7Q4wr1Y5q1zvMOUyBVvOs/Fya3
	 uMccOW5F2t0L9hYN2sQRAY3uSGc5dBBIG91u2A5KxIBNCJO+ItWAyLB/PiViXp930y
	 UBCBtLgYR8Mxthjm5ybG6m6Ebs6RHByHRitGLsxY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Gabe Teeger <gabe.teeger@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 219/301] drm/amd/display: Atom Integrated System Info v2_2 for DCN35
Date: Tue, 14 May 2024 12:18:10 +0200
Message-ID: <20240514101040.526629230@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101032.219857983@linuxfoundation.org>
References: <20240514101032.219857983@linuxfoundation.org>
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
index 4c3c4c8de1cfc..93720cf069d7c 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -2961,6 +2961,7 @@ static enum bp_result construct_integrated_info(
 				result = get_integrated_info_v2_1(bp, info);
 				break;
 			case 2:
+			case 3:
 				result = get_integrated_info_v2_2(bp, info);
 				break;
 			default:
-- 
2.43.0




