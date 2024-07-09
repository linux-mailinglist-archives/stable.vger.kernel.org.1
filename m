Return-Path: <stable+bounces-58788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BBD92BFFC
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C3A283FB5
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611741AD9D8;
	Tue,  9 Jul 2024 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcqJf/12"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1431AD408;
	Tue,  9 Jul 2024 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542068; cv=none; b=tMOP7ibOOHVJKXZ/vCAequUrsDPT+StM0evxg7axoT3aWUnDmDY8tMedZ3Lx0FEB27C4stZL0njGVOyEQ65YW/Bh75YW0nbC+mS56m5oC4DHgdCUCEDSoavpCOw23KmVRGdtVNlXNWGkzkwcchJLS3aeq3HZ7Mrpv+MFadsreE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542068; c=relaxed/simple;
	bh=ukUgCDXHGwZvVXxT9f4IygtQrungzLiummqd2TfuMmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qi7AREK4npKKobZPMzGB/mhCh3vD2Ub49wbxrutaChBeVQKpLbUSwfnvenyDAP3k98Lgl11XjyAip3EimrQzp6qI6aCXrHX5eN/3McmV8DnKQOtPASsXYTkWJEWLwf2bz3DROkPKdW2XfPNqTflJM7PQddYG9XpeIzNJ5HAfruI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcqJf/12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1480FC4AF0A;
	Tue,  9 Jul 2024 16:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542068;
	bh=ukUgCDXHGwZvVXxT9f4IygtQrungzLiummqd2TfuMmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qcqJf/12YqJrwq0LkFH1sUWHQUwfQ4Lqua5BUq16piMwxxP0GoslHRtoSa2e6UDwc
	 OLkqtZgDlOlDn2u9wBFeRbBnGCu/fAoOXMP/qGR5ZHjaaFuxfJWgo0+zWSzwX0Q1MD
	 yXlkM8ozv+sAryadB3ynsufikGANZZSocP+V0uuH3620uk6+lGRk/u0vpAt5Abs3ng
	 7qlVkrIhryR3bH52K2EBf7wbVbLer++fG6sUeUHBs8VRC5wC0CtmFgl/32JHRQ1Ee5
	 sYMp0lTsvmLMY7VW8kd/d1f9Pgj4U1FmD3LRLUPGNzj4mgRPKaomwcfG6mSFRZVJV0
	 A6nEG94wR1qUQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	ilpo.jarvinen@linux.intel.com,
	vadimp@nvidia.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 26/40] platform/mellanox: nvsw-sn2201: Add check for platform_device_add_resources
Date: Tue,  9 Jul 2024 12:19:06 -0400
Message-ID: <20240709162007.30160-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162007.30160-1-sashal@kernel.org>
References: <20240709162007.30160-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.8
Content-Transfer-Encoding: 8bit

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit d56fbfbaf592a115b2e11c1044829afba34069d2 ]

Add check for the return value of platform_device_add_resources() and
return the error if it fails in order to catch the error.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Link: https://lore.kernel.org/r/20240605032745.2916183-1-nichen@iscas.ac.cn
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/mellanox/nvsw-sn2201.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/mellanox/nvsw-sn2201.c b/drivers/platform/mellanox/nvsw-sn2201.c
index 3ef655591424c..abe7be602f846 100644
--- a/drivers/platform/mellanox/nvsw-sn2201.c
+++ b/drivers/platform/mellanox/nvsw-sn2201.c
@@ -1198,6 +1198,7 @@ static int nvsw_sn2201_config_pre_init(struct nvsw_sn2201 *nvsw_sn2201)
 static int nvsw_sn2201_probe(struct platform_device *pdev)
 {
 	struct nvsw_sn2201 *nvsw_sn2201;
+	int ret;
 
 	nvsw_sn2201 = devm_kzalloc(&pdev->dev, sizeof(*nvsw_sn2201), GFP_KERNEL);
 	if (!nvsw_sn2201)
@@ -1205,8 +1206,10 @@ static int nvsw_sn2201_probe(struct platform_device *pdev)
 
 	nvsw_sn2201->dev = &pdev->dev;
 	platform_set_drvdata(pdev, nvsw_sn2201);
-	platform_device_add_resources(pdev, nvsw_sn2201_lpc_io_resources,
+	ret = platform_device_add_resources(pdev, nvsw_sn2201_lpc_io_resources,
 				      ARRAY_SIZE(nvsw_sn2201_lpc_io_resources));
+	if (ret)
+		return ret;
 
 	nvsw_sn2201->main_mux_deferred_nr = NVSW_SN2201_MAIN_MUX_DEFER_NR;
 	nvsw_sn2201->main_mux_devs = nvsw_sn2201_main_mux_brdinfo;
-- 
2.43.0


