Return-Path: <stable+bounces-65131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94E9943EFB
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06CC71C22B63
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B251A8C0A;
	Thu,  1 Aug 2024 00:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmS+ZPPV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42AB1A8BE5;
	Thu,  1 Aug 2024 00:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472528; cv=none; b=Y9I7HOuGb/3HIHFusteadGnCgMQ1NkTsjqdAGn5EgzM5h3mL3GpGUsZtFTFiJ3KygJgpDYKuaXIApbQlodoQ8/7DnWkBgT+hcUEwhhNasjddNyjqBFNNAyVr1XeL12zJ91yKsaBGSPN6bCTgQIepeWEiiewlf7734UEVEApy0f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472528; c=relaxed/simple;
	bh=JoVm6UvX9GQa4Dbv0RE8IiSN50QaP0nWqPaBHXqWIMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RlP5hxQlyi1RMsrA0l7d0KaTE25uR37UcEVgouUpOOCjpySt2eEiiz4HdDb3rHhTxWmB7f9Eap6FZDii9crOB0wu0PYJgt5d/jP6QtIq+BjIdxmaVQ1LUx8phEuJWenikYHhmTwwC6eDcPg9vCcxdCdxLOPF/yqhKaKqfyOBzJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmS+ZPPV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89EEC32786;
	Thu,  1 Aug 2024 00:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472528;
	bh=JoVm6UvX9GQa4Dbv0RE8IiSN50QaP0nWqPaBHXqWIMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JmS+ZPPVkDSy2w5Y6p/0LZKudMMkQolfZFEc0i2uujw4idKUimofyYVkgS6euswQa
	 x8EmTjiKKIFR+Yqixy3bJi23Q1rl9kmnkhF02W3yIGK9KpK1f5r9arWKVUVxHEoYl0
	 weKT0nIidyXFPqSZgADx2IFdhL/DFMTdr+GKpO9et7Gcn8QbvgRPvK1lGBV1OTnaOe
	 WakRbq39k/+ogKNrls/0nQgIJ01wepcwEOtx6UslTIwiZRBVi2i/tg804AXlvFdcV0
	 8M8YZVUYmYu+341lyb47I5wT0qSwN4w3/vVtHxLvGKf1M5H0IpYcUkXa2pMookZisQ
	 UVHy6q6CRxiiA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zijun Hu <quic_zijuhu@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.15 41/47] devres: Initialize an uninitialized struct member
Date: Wed, 31 Jul 2024 20:31:31 -0400
Message-ID: <20240801003256.3937416-41-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index eaa9a5cd1db9d..8dcd79263b291 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -562,6 +562,7 @@ void * devres_open_group(struct device *dev, void *id, gfp_t gfp)
 	grp->id = grp;
 	if (id)
 		grp->id = id;
+	grp->color = 0;
 
 	spin_lock_irqsave(&dev->devres_lock, flags);
 	add_dr(dev, &grp->node[0]);
-- 
2.43.0


