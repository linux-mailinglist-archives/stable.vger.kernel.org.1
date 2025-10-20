Return-Path: <stable+bounces-187916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26687BEF51F
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 06:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041941896A61
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 04:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2532C0F7F;
	Mon, 20 Oct 2025 04:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUa6eCTI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EEA29BD90;
	Mon, 20 Oct 2025 04:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760936197; cv=none; b=gtsGUGlYCbu4oG8cCHZzyF4oqcYgIGcc9xsZGMEnra7j+cE5mDzkXMQ3na9rgyjXZLbJ1n6/EmQdd6qfksaZD2DgEwc/4gWghsp2l7pk/SUKc+41TySUtdn8+iUcf/Cm4/yl8ILpCYNO/ykPV6uSUUk99eclZg40n41avTJv2Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760936197; c=relaxed/simple;
	bh=zphBEhYRgWZAxroiGCHNYyuNwE4bWqDyjlGgmN4zMeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sg0Ia8jOl5gu11FMsAW+dzhzor3FCBgIel7Iy0Xt1tha+Lyn4NhZZEEa2tkfrGEDpcLBseafw+f6J64DJch8pcwSonmbMVRwePFpLaK+GB5f22zMmN7fqv5knuZd3TNg6UpOo7lZgx0i+84nkjnDhyEV3yEJe9+DDI5OlY3xbGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUa6eCTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AAABC4CEFB;
	Mon, 20 Oct 2025 04:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760936197;
	bh=zphBEhYRgWZAxroiGCHNYyuNwE4bWqDyjlGgmN4zMeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gUa6eCTIBwfS4ltnJk8WDLY2NvmFlqgOIL6Fo9omcbSKVUxkbgYSRttT+E8SFnxS9
	 ZeBzTk4RvxUvdek0JivuHRFjvCNkcAy/NXnUHKBte1yaYvwmC2iS9p7c1O89Y+DQUc
	 l5zxf2OWSdRCt4Z8+vwzx9sarRR8CfPTKp37oNx7I9wyriW2PkCsfrL6lKHFFORLYI
	 X3vTim9RXMUB5G39SyJ6jREn4JZ5OrEieJh00wBbleZYKyp9MuJm8kXxEPdupiF2Kx
	 id2gpeIRM8BXQBuSo9A7wyxUmtdIG288UolXjJLmsfg8CTVpFYHAeSaMSS09f7G53x
	 hIlvBu11ZjBrg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vAhwm-00000000831-3MyP;
	Mon, 20 Oct 2025 06:56:40 +0200
From: Johan Hovold <johan@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 01/14] iommu/apple-dart: fix device leak on of_xlate()
Date: Mon, 20 Oct 2025 06:53:05 +0200
Message-ID: <20251020045318.30690-2-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251020045318.30690-1-johan@kernel.org>
References: <20251020045318.30690-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken to the iommu platform device when
looking up its driver data during of_xlate().

Fixes: 46d1fb072e76 ("iommu/dart: Add DART iommu driver")
Cc: stable@vger.kernel.org	# 5.15
Cc: Sven Peter <sven@kernel.org>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/iommu/apple-dart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 95a4e62b8f63..9804022c7f59 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -802,6 +802,8 @@ static int apple_dart_of_xlate(struct device *dev,
 	struct apple_dart *cfg_dart;
 	int i, sid;
 
+	put_device(&iommu_pdev->dev);
+
 	if (args->args_count != 1)
 		return -EINVAL;
 	sid = args->args[0];
-- 
2.49.1


