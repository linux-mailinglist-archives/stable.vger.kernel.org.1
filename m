Return-Path: <stable+bounces-205514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E375DCF9E2D
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 18:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7731E318F21D
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 17:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094EC30C368;
	Tue,  6 Jan 2026 17:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XB3YTxkE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA055303C88;
	Tue,  6 Jan 2026 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720946; cv=none; b=dujzv6fvBYt+eq83vMVqEj4M89/4pImbx98jUv+OjbwNO8ghKMnKyd0ZaTCk8tesOuo6vPHnDnbqZujY1hjqzYgDUS1s+yhP1ch8XCCkGKwdCd+8C1XCoHddQap/nrRhLzYtLHRi3kI96MMlm78YIVMlWo+KvoJ067vy6sxFPjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720946; c=relaxed/simple;
	bh=KTb623t+378tl+YSv/Gl0p+53LHFL9008ssj1MIVT7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1BIBtsm+iJPEMJGy04yv/1txn8oPUrjcsyhZlWI2Bh8ih4OXC/iDiZSO3+TGwevzvPPj9W1hge1MpduecAIpylhF+B+H/757oBS3qauL3x8HvurVMTzCXvwTIWR3PtbTqhugDE5g6CqVrTMR0JeXdYFNSNjuxPILP2S1Hjd694=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XB3YTxkE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F273C116C6;
	Tue,  6 Jan 2026 17:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767720946;
	bh=KTb623t+378tl+YSv/Gl0p+53LHFL9008ssj1MIVT7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XB3YTxkEVOlNqCFLiWzupgbDLxaGXlG7ylSw6KTwtldyNIfcM8nvqQhR04bul08Iz
	 5KgCpcGTc3SX03Tlz4Ln8BKuE2InKuM6dmSEu1xoE4F0h8bFTT2WdAxapIVXtFEjjt
	 sDLgK3r9XZq3SV3lu8mNGhyrayUaxDHiC+VMm4l4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sven Peter <sven@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Johan Hovold <johan@kernel.org>,
	Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH 6.12 356/567] iommu/apple-dart: fix device leak on of_xlate()
Date: Tue,  6 Jan 2026 18:02:18 +0100
Message-ID: <20260106170504.502997156@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170451.332875001@linuxfoundation.org>
References: <20260106170451.332875001@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit a6eaa872c52a181ae9a290fd4e40c9df91166d7a upstream.

Make sure to drop the reference taken to the iommu platform device when
looking up its driver data during of_xlate().

Fixes: 46d1fb072e76 ("iommu/dart: Add DART iommu driver")
Cc: stable@vger.kernel.org	# 5.15
Cc: Sven Peter <sven@kernel.org>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/apple-dart.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -790,6 +790,8 @@ static int apple_dart_of_xlate(struct de
 	struct apple_dart *cfg_dart;
 	int i, sid;
 
+	put_device(&iommu_pdev->dev);
+
 	if (args->args_count != 1)
 		return -EINVAL;
 	sid = args->args[0];



