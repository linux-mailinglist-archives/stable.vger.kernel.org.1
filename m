Return-Path: <stable+bounces-56160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F5891D50F
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 02:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDC13281422
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 00:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AA61C33;
	Mon,  1 Jul 2024 00:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zqj5S3hy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AD415CB;
	Mon,  1 Jul 2024 00:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792803; cv=none; b=FqA3xgVV/u5pXNQ8qReb4SWJr8Ase0jY8i/hSsLGEYCL3p7YK7itianRLjICtrCuvHWmgRjZ4oYbtCvmOCHY9EKYiehenYPy5qEHLyIqJTBxY63SU6YXShg9R+lmwqNeITniVoafkHR30IHvLH4DqPMKh+/GiqoD+qo5CcXChnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792803; c=relaxed/simple;
	bh=IAq7xDNMP1R0gk9ekXQMviFD/fkhMz8+rN6FL9poJzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=axg7jaqvTWewpuk3JUbHlu08ISTkga9R9ToZ+Q9bcdNB4rHd7iJt5F7nmfEXfpqlAQSWEw/fQaJeQwE9eysGVPbcxJMaoLTRmNLwIu8T/MIswHVZbPLWIUYvtp5YBMfrD70eTO9wQvtEy6HEZu/PNmlIcc5TGtr8y4FwD5jH0O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zqj5S3hy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33298C32786;
	Mon,  1 Jul 2024 00:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792803;
	bh=IAq7xDNMP1R0gk9ekXQMviFD/fkhMz8+rN6FL9poJzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zqj5S3hyarBQQd5/Ui+knstpoK7ySNcFc48tnSvCgS+6NJOpatwZ24yB2MhURR4OP
	 PHCdIMulKk05Tglrb52KzJKAP4z2aHQBl4Iu02H+trnmmQ1mLCqyIal2zgn+P8Z0oN
	 jMbDXB5cI66KxPVC90/K0PT+LQVVkF+Zt2zWqsVvbuxOjjA/NGzoqr6/jteJ8EaF1H
	 /xvL5Msqv5p/rsk9NISLOx+jkyvktOd9pPwhEwTxYxYMoDVDVZYkFL2UiI3aqtqwNl
	 YSvVxARVonjnTtqPnIywgX9tnAxUeuP+kT/u0kU5XlpvTDLaHcotlBMDJezNew0pIu
	 PcOmlTDMUGgKA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Likun Gao <Likun.Gao@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Hawking.Zhang@amd.com,
	lijo.lazar@amd.com,
	asad.kamal@amd.com,
	kevinyang.wang@amd.com,
	candice.li@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.9 17/20] drm/amdgpu: init TA fw for psp v14
Date: Sun, 30 Jun 2024 20:11:22 -0400
Message-ID: <20240701001209.2920293-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701001209.2920293-1-sashal@kernel.org>
References: <20240701001209.2920293-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.7
Content-Transfer-Encoding: 8bit

From: Likun Gao <Likun.Gao@amd.com>

[ Upstream commit ed5a4484f074aa2bfb1dad99ff3628ea8da4acdc ]

Add support to init TA firmware for psp v14.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
index 78a95f8f370be..238abd98072ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
@@ -32,7 +32,9 @@
 #include "mp/mp_14_0_2_sh_mask.h"
 
 MODULE_FIRMWARE("amdgpu/psp_14_0_2_sos.bin");
+MODULE_FIRMWARE("amdgpu/psp_14_0_2_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_3_sos.bin");
+MODULE_FIRMWARE("amdgpu/psp_14_0_3_ta.bin");
 
 /* For large FW files the time to complete can be very long */
 #define USBC_PD_POLLING_LIMIT_S 240
@@ -64,6 +66,9 @@ static int psp_v14_0_init_microcode(struct psp_context *psp)
 	case IP_VERSION(14, 0, 2):
 	case IP_VERSION(14, 0, 3):
 		err = psp_init_sos_microcode(psp, ucode_prefix);
+		if (err)
+			return err;
+		err = psp_init_ta_microcode(psp, ucode_prefix);
 		if (err)
 			return err;
 		break;
-- 
2.43.0


