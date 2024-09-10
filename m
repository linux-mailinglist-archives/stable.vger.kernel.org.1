Return-Path: <stable+bounces-74949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9778797323D
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D3E1F26ACE
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B19190685;
	Tue, 10 Sep 2024 10:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cpPoNS+H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D1E18F2DB;
	Tue, 10 Sep 2024 10:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963306; cv=none; b=ooDDPTpgM5q0AIufOz1z/Fde7mJPdENWjMVHzCXhxMfOFTvd5QsPsHsDkk/CHKC3A2/wwQw8DEeZtFKAx81VkJmVFOXce1hcfy/65BRsa6P2x4Za31UsM1DSqEhr9isrIJS0XxOh6pT+j4++nCCD5/Rm2qIolzUc476BnV0MGCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963306; c=relaxed/simple;
	bh=gSOoYiEUoy/XC821m9X5Ow4GAFvQOWPuIHOIpVzRRnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJeFZ6+kUsbu3pCFAOhdIthCf0fIyJ9J34JKEm8urCD9v8cx81JgQuVUPBSBCYF0c2KP9m8no6W/oWu9hYIrgnjTxQDUJg0gyq0mo2Rr+VIzVTQH4yH4UYthJl2u5bFF+kSjm9alUzDTlzXKSCNfS3bZhLr+wBW6VpRGLXjcqO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cpPoNS+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6FFC4CEC3;
	Tue, 10 Sep 2024 10:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725963306;
	bh=gSOoYiEUoy/XC821m9X5Ow4GAFvQOWPuIHOIpVzRRnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cpPoNS+HYQFtxvZ9DrnTIiktv7F2XViEbuf9v5P1Z1yO+xu/0vZmsb4C2GcLcQxVE
	 jZZYblCv1bGuanUxjSrpMpoqvvJMpF2OjS5onvnRHcIJnFO+9dYEu4PHH+J41hnZEw
	 YUVTBml56YvRiHFQeMi2YwjdqkaV2SX2ZFJ9pN5A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jesse Zhang <Jesse.Zhang@amd.com>,
	Tim Huang <Tim.Huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 013/214] drm/amd/pm: fix the Out-of-bounds read warning
Date: Tue, 10 Sep 2024 11:30:35 +0200
Message-ID: <20240910092559.266043050@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092558.714365667@linuxfoundation.org>
References: <20240910092558.714365667@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Zhang <jesse.zhang@amd.com>

[ Upstream commit 12c6967428a099bbba9dfd247bb4322a984fcc0b ]

using index i - 1U may beyond element index
for mc_data[] when i = 0.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
index f503e61faa60..cc3b62f73394 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
@@ -73,8 +73,9 @@ static int atomctrl_retrieve_ac_timing(
 					j++;
 				} else if ((table->mc_reg_address[i].uc_pre_reg_data &
 							LOW_NIBBLE_MASK) == DATA_EQU_PREV) {
-					table->mc_reg_table_entry[num_ranges].mc_data[i] =
-						table->mc_reg_table_entry[num_ranges].mc_data[i-1];
+					if (i)
+						table->mc_reg_table_entry[num_ranges].mc_data[i] =
+							table->mc_reg_table_entry[num_ranges].mc_data[i-1];
 				}
 			}
 			num_ranges++;
-- 
2.43.0




