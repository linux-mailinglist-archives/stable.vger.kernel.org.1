Return-Path: <stable+bounces-139771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5979EAA9F25
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C212F17FF1B
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3017627F73E;
	Mon,  5 May 2025 22:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHXVjgWG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96551922D3;
	Mon,  5 May 2025 22:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483304; cv=none; b=WbJ6E2jEnberzSRkkWILektQCoB4qhBHzQmiJdnnM6hvIdLHAxOJNg0wy+RB0PNrJZ91qharYKtofS/J1GuTDC55HgM3btbDrcsvLh4iXBt5LyUKPeuptR9C748uer605P98EV59BFNTQfEfTgXK/gdS3e/Ai8UlhWYH0mUHmx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483304; c=relaxed/simple;
	bh=acWgzjY+/uQlJhhVA40iUkpL52+iio36j0GL1qXLhSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hcE193n0R99yNoEGkgx6riO4x0dHNE/dhlTuf/6EIPpp3eOaFmPV/oziyXeB/rDlSHlmgKU4bZS3Hxv1cI387tyNsTtDoBiX035CAz8oiACJobUZ1qXfrJSXIRBh2DiztM5w8BAO6ip6H+e7PepTYmNCKgxRvcuauAa5HK7Itx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHXVjgWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FC4C4CEEE;
	Mon,  5 May 2025 22:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483303;
	bh=acWgzjY+/uQlJhhVA40iUkpL52+iio36j0GL1qXLhSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MHXVjgWGpIcEDBqYnuXGsSbHCiQyP8E8zBYWofaNzGnkxfSr/wbEWZR5/gvdwTN1T
	 oJkxu65cvVFke8I1uRFnwd2UDlsUXSHDqf0EzUAplC7CUcdsLgv1ZgGqlq9CyL4bwA
	 hmftXLuCQy+Izy88hWOG4UaZWjHHadOBjNJFwJ0m6wQ6DDB7cn85VAD7wFt2q6LA4/
	 pBlhFt4rVgc9EqfcaNM78U5YRMnD/59uLwiG/WLp6ek9CRoPTdWEaotmNvlloumKLs
	 VHETSlSaGHdKaE7Q3h98g/yBXUTQt+dmnCrufw8+ZY6ZBqhFhDdEechMkfvrABkap4
	 XymoUcUqGLrCA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shixiong Ou <oushixiong@kylinos.cn>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	timur@kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 024/642] fbdev: fsl-diu-fb: add missing device_remove_file()
Date: Mon,  5 May 2025 18:04:00 -0400
Message-Id: <20250505221419.2672473-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Shixiong Ou <oushixiong@kylinos.cn>

[ Upstream commit 86d16cd12efa547ed43d16ba7a782c1251c80ea8 ]

Call device_remove_file() when driver remove.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/fsl-diu-fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index 5ac8201c35337..b71d15794ce8b 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -1827,6 +1827,7 @@ static void fsl_diu_remove(struct platform_device *pdev)
 	int i;
 
 	data = dev_get_drvdata(&pdev->dev);
+	device_remove_file(&pdev->dev, &data->dev_attr);
 	disable_lcdc(&data->fsl_diu_info[0]);
 
 	free_irq(data->irq, data->diu_reg);
-- 
2.39.5


