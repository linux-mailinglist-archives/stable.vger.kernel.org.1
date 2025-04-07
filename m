Return-Path: <stable+bounces-128757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 679DFA7EBB5
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DCC4444DFA
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA6425744D;
	Mon,  7 Apr 2025 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxNQuE5m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D909B27C170;
	Mon,  7 Apr 2025 18:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049879; cv=none; b=rfdLHRCAy6/KuHBoQbycJjKKHSbuvgWrpkF1TeXIxShZn1VM4a66v+k7pjjPAfkTgrFpxl29aOq4BTQux5r3zd/NMrluq/Rkucxp087k3UaMvB8axXV0q/NV+ROZDJbSr4q+SjoaK+aRZSBocXvL/Y756Ii2EwAmgbTKT5431Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049879; c=relaxed/simple;
	bh=3dRAWaIhUYe20KaiwXM/RdfhGXJbFvsyoJAF+ag+kYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DrNjAXjmo8iZJbToN/qKt9h7u2c2DsVfWX6cb3uNwK7omHEvaHJFkR7kGNjrhSxd/JTZff9e3okopBcgmzz+iVOcMEaBo5dU8PzhDhiyWfsvp1h/QaDSz1rYgAp0Ty+hiE0nbacpVtOgiemqCfz06YbVnVdvsZkpjJEezOm5fxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxNQuE5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67039C4CEDD;
	Mon,  7 Apr 2025 18:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049878;
	bh=3dRAWaIhUYe20KaiwXM/RdfhGXJbFvsyoJAF+ag+kYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jxNQuE5mv9DJ5bgIZNJE7K6IgcLAEVSENGKVjheAjTdaGbIdbsXWVj87tjsoWUMX3
	 6F9sUIWIuYj8zXNrjjAmufYZiOw+1KPsVStH7j1t14qB8cRnhWRO1YdFXNwLvGkZC+
	 P2B/cBfB6EeuJ518vWR4x/RDvafyrM/yVV5/xw1vK+y1JKMoa0harxSGDSrt/N4s90
	 IXLUh2Er9hJQZuFgm+D3FvsIzXyT8xgbN4JapHITtnbwxEUKEumL3lo3E6yS5W7NoY
	 ncE0SaHjOMzRnIFssb7cDPhGmjiTCL6qOKYsAdFm7SFZ+BGPUYOwdjnF/qudMntAuz
	 /HDg3lt3bXI2Q==
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
Subject: [PATCH AUTOSEL 6.1 3/5] ntb_hw_amd: Add NTB PCI ID for new gen CPU
Date: Mon,  7 Apr 2025 14:17:46 -0400
Message-Id: <20250407181749.3184538-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181749.3184538-1-sashal@kernel.org>
References: <20250407181749.3184538-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.133
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
index 730f2103b91d1..9c8dd5dea2733 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -1323,6 +1323,7 @@ static const struct pci_device_id amd_ntb_pci_tbl[] = {
 	{ PCI_VDEVICE(AMD, 0x148b), (kernel_ulong_t)&dev_data[1] },
 	{ PCI_VDEVICE(AMD, 0x14c0), (kernel_ulong_t)&dev_data[1] },
 	{ PCI_VDEVICE(AMD, 0x14c3), (kernel_ulong_t)&dev_data[1] },
+	{ PCI_VDEVICE(AMD, 0x155a), (kernel_ulong_t)&dev_data[1] },
 	{ PCI_VDEVICE(HYGON, 0x145b), (kernel_ulong_t)&dev_data[0] },
 	{ 0, }
 };
-- 
2.39.5


