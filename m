Return-Path: <stable+bounces-65192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D32E294404D
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 04:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 965E6B25863
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59091E80B4;
	Thu,  1 Aug 2024 00:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fm12zfbg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11031E80AD;
	Thu,  1 Aug 2024 00:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472812; cv=none; b=ofzms2eepolnWEwIGTDvyrOe0R3PzQlFxwiNvrGof28E3efe0LslcbAxhFaNKYnFFl6XxbcmsYN76HzZk1YeIKku7mz3G5Uu8qV7UbafAYXv1R4ZsckG+cNPn2VWCABkG6BA6XZIxBEKifvCq+nNPCvLgQgfKyf/qBMkF/OoJq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472812; c=relaxed/simple;
	bh=9dYFQBDhFKQmS/da+VPmOP+PDGQyD3EMmRG+Xx/gab8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKokgfV9zY3Z830FrzV6hxNuNfdaQgk5QPOyihyoImofMJxWJ/CojdZHzvLsKc0aTaZuyF7Pr/kEARxd5Sm0y3vCV+jmEOxRXwpk/nFGFIZHx9cPIIUlMOOGD7k959WVkHmmr+XGA8m5nc71SUbEgJ2IEUi75O50VSAuYr8SeF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fm12zfbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C53C4AF0F;
	Thu,  1 Aug 2024 00:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472810;
	bh=9dYFQBDhFKQmS/da+VPmOP+PDGQyD3EMmRG+Xx/gab8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fm12zfbgi6WydCe/Fp+gu+8kKkPDycD6YU3tN6nrEcaoNJKh5+XeICRkp90muQzrE
	 PK8inCCm3oOfPHo5R4JKFWIVQwiIUm6ZlqiP/V27EBKQVJapfLBSEO7nhpSh9enmQc
	 vFvpkTa2KCJbpsbAMoHEF6nI2Spx+4HzqtVr6haZN7sjgVz5fLrcDgnTkJEoYQCREv
	 dpDynesAYRFhVJ4U199QI1h56dQOtarxavMlqtKkMlu2uHuDrPxv31AycPDZPaG8k7
	 0Z5GUl5vYYx1BCOvP9IGyGEqwfvPFOIlxf0oGRmmVUVDuMlkXOcBpFCWUljt0uhNA9
	 JlZDIZWbeRfew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zijun Hu <quic_zijuhu@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 17/22] devres: Initialize an uninitialized struct member
Date: Wed, 31 Jul 2024 20:38:46 -0400
Message-ID: <20240801003918.3939431-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003918.3939431-1-sashal@kernel.org>
References: <20240801003918.3939431-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
Content-Transfer-Encoding: 8bit

From: Zijun Hu <quic_zijuhu@quicinc.com>

[ Upstream commit 56a20ad349b5c51909cf8810f7c79b288864ad33 ]

Initialize an uninitialized struct member for driver API
devres_open_group().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Link: https://lore.kernel.org/r/1719931914-19035-4-git-send-email-quic_zijuhu@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/devres.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 0bbb328bd17f8..4a16c2ea2303b 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -561,6 +561,7 @@ void * devres_open_group(struct device *dev, void *id, gfp_t gfp)
 	grp->id = grp;
 	if (id)
 		grp->id = id;
+	grp->color = 0;
 
 	spin_lock_irqsave(&dev->devres_lock, flags);
 	add_dr(dev, &grp->node[0]);
-- 
2.43.0


