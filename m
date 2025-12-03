Return-Path: <stable+bounces-199581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF4BCA0A3F
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 18:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75EA0331903A
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FB034574D;
	Wed,  3 Dec 2025 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iaD/hs+9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D6919258E;
	Wed,  3 Dec 2025 16:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764780267; cv=none; b=VoXexZm9j8M8cYNwrNGopBh4sL9XM5pqL8wM0bKSTyd9oIuleeWSHWHgkCTuwBFghEE2Pb66PRkUSE3ohi7RxLeeaThhVRI+nKNacvtgXWYNczFeBodgpYCbWj4D5IuDCvuZ+dyvr+d7lXL8SJOqbE4NWckjxtc4Vsn2l7WMqto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764780267; c=relaxed/simple;
	bh=W2c+uEG7NjV/e7gS9CM0g10G06GC/kWrAQloJSwDu9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZlHFj+ZW1vPITToKXxx2UN5Upp5FKM6ZHWnoJ7n5sXgkhwO1KpwNrNliNQ+70jewfkqVicn55dwVe5ce2FsxKsgGzlCw8/K+MmskIhQcTfpihyvuUscQ3twc/W7uxEWrZ/MvJ0DLuiYy0GN7VzJUFtWwE4g2lBwTV76GX+1tks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iaD/hs+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E22C4CEF5;
	Wed,  3 Dec 2025 16:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764780266;
	bh=W2c+uEG7NjV/e7gS9CM0g10G06GC/kWrAQloJSwDu9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iaD/hs+98fv5xYbp8n+tN0CwixdqYdFR5MH05txSig5JKpP6M7OvRgxEUNyUqM3gi
	 lg64k9Vd+amrp0DRcKZDQmWhE8zECBGrPQNMsrCBf6gMBYGPDGSI2Xyo3cHiStLS7w
	 viRGNgDi+cuiTUJutKkEwXtYAORCySRCB86Juj/0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 506/568] mailbox: mailbox-test: Fix debugfs_create_dir error checking
Date: Wed,  3 Dec 2025 16:28:28 +0100
Message-ID: <20251203152459.246368285@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152440.645416925@linuxfoundation.org>
References: <20251203152440.645416925@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haotian Zhang <vulab@iscas.ac.cn>

[ Upstream commit 3acf1028f5003731977f750a7070f3321a9cb740 ]

The debugfs_create_dir() function returns ERR_PTR() on error, not NULL.
The current null-check fails to catch errors.

Use IS_ERR() to correctly check for errors.

Fixes: 8ea4484d0c2b ("mailbox: Add generic mechanism for testing Mailbox Controllers")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/mailbox-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
index abcee58e851c2..29c04157b5e88 100644
--- a/drivers/mailbox/mailbox-test.c
+++ b/drivers/mailbox/mailbox-test.c
@@ -267,7 +267,7 @@ static int mbox_test_add_debugfs(struct platform_device *pdev,
 		return 0;
 
 	tdev->root_debugfs_dir = debugfs_create_dir(dev_name(&pdev->dev), NULL);
-	if (!tdev->root_debugfs_dir) {
+	if (IS_ERR(tdev->root_debugfs_dir)) {
 		dev_err(&pdev->dev, "Failed to create Mailbox debugfs\n");
 		return -EINVAL;
 	}
-- 
2.51.0




