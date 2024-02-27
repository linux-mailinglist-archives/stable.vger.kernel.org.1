Return-Path: <stable+bounces-24233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3787869345
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310821F24AD7
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32D513B2B3;
	Tue, 27 Feb 2024 13:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jw67w981"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824BC13A25D;
	Tue, 27 Feb 2024 13:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041402; cv=none; b=aZTHxRkX9CmXkJ2MXym1gBMixtXwWGVvRJP15dZ5hGjl/Hf+1cs0mK+0NSHZDCWhlm6/VsNygmvRVdunGYzVP/7TUYoSyTpp1eXpizFJbSNVS11Me0rbHW8CuyT6T5tcF6UyoVC4nGZUfS2oMjS3Q63OfOKbc6oObf/REjGm8ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041402; c=relaxed/simple;
	bh=L/9l6GhrxLHrth2WGJ+M7JsV5Pa5YxNpdCnP4TZRW1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4zF0al5zOIIKFzz06ys1mcaj9N7pcEnOuIR/7NCmPzdy/gfzutMYCB6b7eYEsTOsknym6JYhnx23Q8CJ4CDyGmh3gITAlDohRcjP1C8HZYfvIvrbs2Kb9XgS7JC6iRrW6peMetxZ6FgeaHgJ24QnmjINjG7DrRmYr4cENgBhaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jw67w981; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FB0C433F1;
	Tue, 27 Feb 2024 13:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709041402;
	bh=L/9l6GhrxLHrth2WGJ+M7JsV5Pa5YxNpdCnP4TZRW1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jw67w981nGSk1JcZNQoHEb4gN31bdGOC4cJV9K/E6KYGk8EPOwv5CIHZ1B3YHQIjA
	 SMPypyO3jfCeqxh6O3xBrs/dS+2uz8BvQtJ9EQhfrTz54Ej6Qwj44RFfpFevZQmeXz
	 h/qdP3BbYiWRavNr8ozFC29cKl2Y60MIPRLJDWuM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Armin Wolf <W_Armin@gmx.de>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 327/334] drm/amd/display: Fix memory leak in dm_sw_fini()
Date: Tue, 27 Feb 2024 14:23:05 +0100
Message-ID: <20240227131641.686561443@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit bae67893578d608e35691dcdfa90c4957debf1d3 ]

After destroying dmub_srv, the memory associated with it is
not freed, causing a memory leak:

unreferenced object 0xffff896302b45800 (size 1024):
  comm "(udev-worker)", pid 222, jiffies 4294894636
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 6265fd77):
    [<ffffffff993495ed>] kmalloc_trace+0x29d/0x340
    [<ffffffffc0ea4a94>] dm_dmub_sw_init+0xb4/0x450 [amdgpu]
    [<ffffffffc0ea4e55>] dm_sw_init+0x15/0x2b0 [amdgpu]
    [<ffffffffc0ba8557>] amdgpu_device_init+0x1417/0x24e0 [amdgpu]
    [<ffffffffc0bab285>] amdgpu_driver_load_kms+0x15/0x190 [amdgpu]
    [<ffffffffc0ba09c7>] amdgpu_pci_probe+0x187/0x4e0 [amdgpu]
    [<ffffffff9968fd1e>] local_pci_probe+0x3e/0x90
    [<ffffffff996918a3>] pci_device_probe+0xc3/0x230
    [<ffffffff99805872>] really_probe+0xe2/0x480
    [<ffffffff99805c98>] __driver_probe_device+0x78/0x160
    [<ffffffff99805daf>] driver_probe_device+0x1f/0x90
    [<ffffffff9980601e>] __driver_attach+0xce/0x1c0
    [<ffffffff99803170>] bus_for_each_dev+0x70/0xc0
    [<ffffffff99804822>] bus_add_driver+0x112/0x210
    [<ffffffff99807245>] driver_register+0x55/0x100
    [<ffffffff990012d1>] do_one_initcall+0x41/0x300

Fix this by freeing dmub_srv after destroying it.

Fixes: 743b9786b14a ("drm/amd/display: Hook up the DMUB service in DM")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d83c4128fa165..88ca985603de5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2245,6 +2245,7 @@ static int dm_sw_fini(void *handle)
 
 	if (adev->dm.dmub_srv) {
 		dmub_srv_destroy(adev->dm.dmub_srv);
+		kfree(adev->dm.dmub_srv);
 		adev->dm.dmub_srv = NULL;
 	}
 
-- 
2.43.0




