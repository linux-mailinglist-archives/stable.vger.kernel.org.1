Return-Path: <stable+bounces-186833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D17BEA1D9
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32096221CF
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABEF258ECA;
	Fri, 17 Oct 2025 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yrCn7pSz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BA2337117;
	Fri, 17 Oct 2025 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714364; cv=none; b=pIswmLz5dEqkxM1PhXpullJgexzIl4YpDlB2lLJo9nIUbBJqGlELLb1g8iku2Cz79yoTkqqrPyaZrUVMzAfqKMnoqFaVSuonsSO7bkE7GzOseAJ/fpkNo8BGTIoFtRZM6pmpPHoXXfoQlBDQTGWeCkCdPoYd8/maAehklQQcmVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714364; c=relaxed/simple;
	bh=/A23npCBNbGC/UtHjVeTkd8mEloDSVDHVdtUWcJlCxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SsOJ4SSGbX/p3ergVVBAlw/FZumUvXojvLWmfNKqHzOPA0YXdTsr1MdeNeFIYi8JLPpgkXJVU1XTRQvI59SlRgskBStMHF3ybumuoLFA/134+TF0Bguiz4mC94sEYFMkgPuGBuCct8DKazNPsOFcnDVNJb0qYqPo1kt7eLo5onU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yrCn7pSz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9DAC4CEE7;
	Fri, 17 Oct 2025 15:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760714364;
	bh=/A23npCBNbGC/UtHjVeTkd8mEloDSVDHVdtUWcJlCxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yrCn7pSzm+hww8WaUGAKM8m8RPCVg5pgxgb4vrWORgxMT7+n9vKGT9DnVG37ZEq8c
	 ydn70oeOZrKqEW/t3wgJdYq4lRt5v6VAF8el7nE2zqkuAiXbkyO/XdFBZ+r9LAp4mL
	 V+kjcaEC7268f0pvnDsUyX9Q8lYhW7btAiKX8X/4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Fangzhi Zuo <Jerry.Zuo@amd.com>,
	Alex Hung <alex.hung@amd.com>
Subject: [PATCH 6.12 119/277] drm/amd/display: Enable Dynamic DTBCLK Switch
Date: Fri, 17 Oct 2025 16:52:06 +0200
Message-ID: <20251017145151.471225261@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145147.138822285@linuxfoundation.org>
References: <20251017145147.138822285@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

commit 5949e7c4890c3cf65e783c83c355b95e21f10dba upstream.

[WHAT]
Since dcn35, DTBCLK can be disabled when no DP2 sink connected for
power saving purpose.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2027,6 +2027,10 @@ static int amdgpu_dm_init(struct amdgpu_
 
 	init_data.flags.disable_ips_in_vpb = 0;
 
+	/* DCN35 and above supports dynamic DTBCLK switch */
+	if (amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 5, 0))
+		init_data.flags.allow_0_dtb_clk = true;
+
 	/* Enable DWB for tested platforms only */
 	if (amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 0, 0))
 		init_data.num_virtual_links = 1;



