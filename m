Return-Path: <stable+bounces-81822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDFF994998
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0791C24A11
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E1A1DF989;
	Tue,  8 Oct 2024 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kzVKH5N7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7C11DED48;
	Tue,  8 Oct 2024 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390249; cv=none; b=Gb+T8zmPNOqfoOp3xLQJer23EpsPo4ZF7ztq6X+u0E/3rpJPDqZUmG0rcOWKHlSmqNFdqTqSU2hHa3oYqLhaWyZpDqmDaZKipWlm6lkUoS2eANYaqs5MjBjWTXQO5vFC9FJvnKwk1u2C6djvdNFl/hAD7CMZvz6ok+xqoNyzqE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390249; c=relaxed/simple;
	bh=jOM8plu4yiXwlhcSumQS2t9GU8Ja3zcdA+yMYcqbECM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4GmMRGPydTJEulFGYkoCIM6RH9YmE6ZzcjA6kF7lwmFFCgZo0WUZ3NuPn7jEzkOrloQJqpoeW90V2/SLM9s9U3hz4+K1cXs5m2l5hrZQQkuqFoicuHN9rJ0sBN4847jqEFxDnW3B2tXqkUBAQTb9XioFQvNFuvIC9RGo2Mvbzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kzVKH5N7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA9BC4CECD;
	Tue,  8 Oct 2024 12:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728390248;
	bh=jOM8plu4yiXwlhcSumQS2t9GU8Ja3zcdA+yMYcqbECM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kzVKH5N70TqBKS99Q1NwMb8/3toneUOvjeoQLqgDHmpt0jbquAE5rkozfxnwBJFn8
	 MRuiY/jr0Zk1blZ4gxN5N7tkJ8Wdu3ZPARyNcs5+E7m9U/aLPq+lZZGLOankItVoKz
	 qPe/OjVfiWlcLyhTrNG7RFFkBy18K6l/gOWYZTuQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tim Huang <tim.huang@amd.com>,
	Jesse Zhang <jesse.zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 235/482] drm/amd/pm: ensure the fw_info is not null before using it
Date: Tue,  8 Oct 2024 14:04:58 +0200
Message-ID: <20241008115657.547003045@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tim Huang <tim.huang@amd.com>

[ Upstream commit 186fb12e7a7b038c2710ceb2fb74068f1b5d55a4 ]

This resolves the dereference null return value warning
reported by Coverity.

Signed-off-by: Tim Huang <tim.huang@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
index 5794b64507bf9..56a2257525806 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
@@ -1185,6 +1185,8 @@ static int init_overdrive_limits(struct pp_hwmgr *hwmgr,
 	fw_info = smu_atom_get_data_table(hwmgr->adev,
 			 GetIndexIntoMasterTable(DATA, FirmwareInfo),
 			 &size, &frev, &crev);
+	PP_ASSERT_WITH_CODE(fw_info != NULL,
+			    "Missing firmware info!", return -EINVAL);
 
 	if ((fw_info->ucTableFormatRevision == 1)
 	    && (le16_to_cpu(fw_info->usStructureSize) >= sizeof(ATOM_FIRMWARE_INFO_V1_4)))
-- 
2.43.0




