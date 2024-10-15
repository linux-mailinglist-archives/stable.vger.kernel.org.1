Return-Path: <stable+bounces-86086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0848E99EB98
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 15:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B437F1F2692A
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB2A1AF0A9;
	Tue, 15 Oct 2024 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kOVSn5C5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EED61C07FF;
	Tue, 15 Oct 2024 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728997725; cv=none; b=TzAC9MZRxk+VIV7+WLOCWpRkyBzLJkSpO317UVu08YLQqbbvF2KCIiq8biNZ0qJu4BPNIJo2g3dZLBizkQOkInIEvHHULdySGg7HNW6gXdnvMa76Ue1se8R7Uuy3lJLcDnEKBbvPjG1bP9c7fgksJlrJrbUBQCFtA3jghqGIlZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728997725; c=relaxed/simple;
	bh=FguqohK9UnfdjEPCVDcpWkttA3cGUduDFcY4NEg8SkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tk14Ojx4w2j7NfaUfn2xXJXu/QGB0uZaqYjO7ZAceCmzAeDlsbESgCEd/kWqmSf9jvL3lv4eSTxqVCmYAzAib551P1l+dsq4NUv7rPrHZZ7MeE6/WEX/aL1Fhr7H3sx3ZACrV6xb9hGgGfzXj1oJdxvAoq7cBY0JpYHAw+FhkLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kOVSn5C5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA07DC4CEC6;
	Tue, 15 Oct 2024 13:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728997725;
	bh=FguqohK9UnfdjEPCVDcpWkttA3cGUduDFcY4NEg8SkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kOVSn5C5grz0ogo96bbOQNmtmWAhs1RSNNHbWRreqA2CDCjh6zOc03nHygV/BR3M+
	 SXKGLBpsMES5c+lnb+f104kZRzsp59hjS5hL9Vs5eaxpxhDdjR7gGq4c5eG5FjiBi5
	 8DLhanMFZOsf+XmemfkUyZzZiK8AK5O1UFiq6CY8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Liao Chen <liaochen4@huawei.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 266/518] mailbox: rockchip: fix a typo in module autoloading
Date: Tue, 15 Oct 2024 14:42:50 +0200
Message-ID: <20241015123927.260451662@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015123916.821186887@linuxfoundation.org>
References: <20241015123916.821186887@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liao Chen <liaochen4@huawei.com>

[ Upstream commit e92d87c9c5d769e4cb1dd7c90faa38dddd7e52e3 ]

MODULE_DEVICE_TABLE(of, rockchip_mbox_of_match) could let the module
properly autoloaded based on the alias from of_device_id table. It
should be 'rockchip_mbox_of_match' instead of 'rockchp_mbox_of_match',
just fix it.

Fixes: f70ed3b5dc8b ("mailbox: rockchip: Add Rockchip mailbox driver")
Signed-off-by: Liao Chen <liaochen4@huawei.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/rockchip-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/rockchip-mailbox.c b/drivers/mailbox/rockchip-mailbox.c
index 979acc810f307..ca50f7f176f6a 100644
--- a/drivers/mailbox/rockchip-mailbox.c
+++ b/drivers/mailbox/rockchip-mailbox.c
@@ -159,7 +159,7 @@ static const struct of_device_id rockchip_mbox_of_match[] = {
 	{ .compatible = "rockchip,rk3368-mailbox", .data = &rk3368_drv_data},
 	{ },
 };
-MODULE_DEVICE_TABLE(of, rockchp_mbox_of_match);
+MODULE_DEVICE_TABLE(of, rockchip_mbox_of_match);
 
 static int rockchip_mbox_probe(struct platform_device *pdev)
 {
-- 
2.43.0




