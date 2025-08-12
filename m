Return-Path: <stable+bounces-168920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6649FB2374E
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5994188AE94
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6DC2F5338;
	Tue, 12 Aug 2025 19:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MV3dh3Os"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AAF26FA77;
	Tue, 12 Aug 2025 19:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025779; cv=none; b=SoK5ZYnaaRlIKZyFVshN0a9xV2oN8tQ0m5DvzgKHEDTJUvgvFTltGQZfGQrVcg1F0mwhkxXe237noVDVeU1KXUajr034l5eaDRjwF2FDBXcRyXnGOPYaoc2G6BGxtgpYbzN7UNGOJaB7E43htxEnm/uaMy6oZ3yygq0sDBHGDcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025779; c=relaxed/simple;
	bh=LElX4a7j8CyydMwyvFp2T/63NIXHduojvla/ddlCDlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWlJ0P0nCiYtrTePNb9hTISS0wUCUF5P/o4NjM5J1Z47SldcWSNhUjjHmWsiwLA8CDPpIe1cf8WhyC29MCNz8v4Uh8qKdSBIeQFUIjhKE9QQ+n9NEb5R3jnfkcwH55CqgNu45N1HJURqej+TLvozIzF9ZhZfbzsSckRAvIptXD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MV3dh3Os; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CE5C4CEF1;
	Tue, 12 Aug 2025 19:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755025779;
	bh=LElX4a7j8CyydMwyvFp2T/63NIXHduojvla/ddlCDlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MV3dh3OsTTKiZnVFmkEA85sf5FXthkPa9LtkxTUgjiHmtywpbYkXON/Bc+c0vreP1
	 UtqMZH60uzHoP4GKBT9DUWtq399aaJ+JF5hlT+46D2LeUwa+xXgP24U6ELTMt8HzTN
	 BM4b7ynwf38i3M+YsJDLJBOYRGOTdfAHDE8CrAx0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 141/480] drm/amd/pm/powerplay/hwmgr/smu_helper: fix order of mask and value
Date: Tue, 12 Aug 2025 19:45:49 +0200
Message-ID: <20250812174403.338750728@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fedor Pchelkin <pchelkin@ispras.ru>

[ Upstream commit a54e4639c4ef37a0241bac7d2a77f2e6ffb57099 ]

There is a small typo in phm_wait_on_indirect_register().

Swap mask and value arguments provided to phm_wait_on_register() so that
they satisfy the function signature and actual usage scheme.

Found by Linux Verification Center (linuxtesting.org) with Svace static
analysis tool.

In practice this doesn't fix any issues because the only place this
function is used uses the same value for the value and mask.

Fixes: 3bace3591493 ("drm/amd/powerplay: add hardware manager sub-component")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
index 79a566f3564a..c305ea4ec17d 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
@@ -149,7 +149,7 @@ int phm_wait_on_indirect_register(struct pp_hwmgr *hwmgr,
 	}
 
 	cgs_write_register(hwmgr->device, indirect_port, index);
-	return phm_wait_on_register(hwmgr, indirect_port + 1, mask, value);
+	return phm_wait_on_register(hwmgr, indirect_port + 1, value, mask);
 }
 
 int phm_wait_for_register_unequal(struct pp_hwmgr *hwmgr,
-- 
2.39.5




