Return-Path: <stable+bounces-128736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9899A7EB6A
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF9717AA57
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7739D26FA6B;
	Mon,  7 Apr 2025 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvBK/0oy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB9426FA60;
	Mon,  7 Apr 2025 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049828; cv=none; b=NCMfHZ91ITAO8DXSDRrMYvlXr+NpZnASR82IGuY704bpqOeVhr803+nIt93rqluVV5y+uSfcP+uI6sBjVT1tKa5a4mH9NyaksznUVHlRqESRZOL6UVGUni8NZTVOvgSz6R4b20lc1Ue2A2lHMC6fkD79nvSOwKFSApQY/cWckfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049828; c=relaxed/simple;
	bh=EeNyzSPVB15bkTHwbGNE4TC98r6iZP9QZnHs4daBLNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J/LfuTxHtyDRGpP0DuKiJAkLP4RAXZS96NJEqH7JO38W4x+azkFIHtZkeQXG1O5X5OaY1CR28Xd6v0+cjukCsjQC7LrgXYjzocegMH6AywLyuj5QPgrBh0WNi2HWEFQB+sMovdZsBa4aVmddyNmfi66n60f9FjvzP27XTynN1d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvBK/0oy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A92C4CEDD;
	Mon,  7 Apr 2025 18:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049828;
	bh=EeNyzSPVB15bkTHwbGNE4TC98r6iZP9QZnHs4daBLNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SvBK/0oyvQYTMhddCi3lgzig0eGiSeTuccsPSz9KVH4B8E61VyodG7xgmJbDEn2jq
	 9/g/bVOvVg1wNWw5UQKJ5Cspf+HDoYNwpiJqZAVqaTje6Ngq4H2m4tCtQLUD5fOhVg
	 zaHSsHOs//qE4EMbJhjPCsBx7N4tYrGtDgVhxIcIADOmiexiNcxKtXnb2EECmww2JR
	 zvKRdUtZyj7c46ZarNoO/1BQv3C+h2E6GH/HCxhKXKU3GGWw4Ovu8HPjjcuy2iZLom
	 s+E2PCTAruSEq1t2v6Jryh2xbe/yVtCj2ovvBj/2qfGWkwCcBxgSGpZPk48tFLjzPN
	 PTYSeKTnheqfQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Jon Mason <jdmason@kudzu.us>,
	Sasha Levin <sashal@kernel.org>,
	Shyam-sundar.S-k@amd.com,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	ntb@lists.linux.dev
Subject: [PATCH AUTOSEL 6.13 3/8] ntb_hw_amd: Add NTB PCI ID for new gen CPU
Date: Mon,  7 Apr 2025 14:16:53 -0400
Message-Id: <20250407181658.3184231-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181658.3184231-1-sashal@kernel.org>
References: <20250407181658.3184231-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.10
Content-Transfer-Encoding: 8bit

From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

[ Upstream commit bf8a7ce7e4c7267a6f5f2b2023cfc459b330b25e ]

Add NTB support for new generation of processor.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index d687e8c2cc78d..63ceed89b62ef 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -1318,6 +1318,7 @@ static const struct pci_device_id amd_ntb_pci_tbl[] = {
 	{ PCI_VDEVICE(AMD, 0x148b), (kernel_ulong_t)&dev_data[1] },
 	{ PCI_VDEVICE(AMD, 0x14c0), (kernel_ulong_t)&dev_data[1] },
 	{ PCI_VDEVICE(AMD, 0x14c3), (kernel_ulong_t)&dev_data[1] },
+	{ PCI_VDEVICE(AMD, 0x155a), (kernel_ulong_t)&dev_data[1] },
 	{ PCI_VDEVICE(HYGON, 0x145b), (kernel_ulong_t)&dev_data[0] },
 	{ 0, }
 };
-- 
2.39.5


