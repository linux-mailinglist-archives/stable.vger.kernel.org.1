Return-Path: <stable+bounces-65083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3051943E2D
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E681C219B8
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81251B9935;
	Thu,  1 Aug 2024 00:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tinS98f1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E141B992F;
	Thu,  1 Aug 2024 00:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472281; cv=none; b=fjinJRGERCpVsQN9EBEIeYvwxhORLJGYkeYb7Po9JilfbpWY8yARe6TlJtnecX98GeQtKvB6FA0FxqdCcgVjngUVm03X+zbLMNU8LE5vFrUfIYkutC+t+7UWP3Bjk3rCJ9m+dCGf2Ow5LUvWZBr9CnNuvOXA2NCYz5AuziKgPds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472281; c=relaxed/simple;
	bh=erig8TDr2I5zgzpYnGNLpFp3MCmGTMX+b1zQl5HKx6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSb6nFUAl7j2kBuIUcDNN/hKUd+1u2HyNxRjgzWHsS+jyr1G5xokzRsSCmL47kK94xxUfos0UVY+6RYoamimAvxI49bHqm8ephP+IfujLr40kEPjm/+DXc0aOIWz97oQqTXL1pjxc76G2b9YjoGrM+13DdST4XGUrKbiwTL12Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tinS98f1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F9CC116B1;
	Thu,  1 Aug 2024 00:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472281;
	bh=erig8TDr2I5zgzpYnGNLpFp3MCmGTMX+b1zQl5HKx6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tinS98f1/tCy8krH/LAzQlX+PusaRME7/hmTyCcmKeZnSGhmQsvc31DpeGTslzL/3
	 N7VQOTnZZsTOQzHxuBUs53KMB2smbIOCzAr+WcxmcsiPJmVRt/qGzvJk2cZGRgRmqe
	 t3oe+pUtUTY/DiugS1hrio24I8TELS3pUWdUcHYUiR230hXPFQ1/hGN7UskNjQfODE
	 9pGIgcpvEuDJkW2+YbXhgiffpTwEr+mX1M2nc/6tM+a5P3hR4rG4ZbbEbgCIRM3qEQ
	 V/vJ4K0IBMKDp+U3H3uk51cdIZ6vbtxwxcuGpl9cnmZrK3km7IYhuTWJvU4xlSVXBZ
	 6lzVVYk36MZEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zijun Hu <quic_zijuhu@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 54/61] devres: Initialize an uninitialized struct member
Date: Wed, 31 Jul 2024 20:26:12 -0400
Message-ID: <20240801002803.3935985-54-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
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
index 4ab2b50ee38f4..6595a9194539f 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -564,6 +564,7 @@ void * devres_open_group(struct device *dev, void *id, gfp_t gfp)
 	grp->id = grp;
 	if (id)
 		grp->id = id;
+	grp->color = 0;
 
 	spin_lock_irqsave(&dev->devres_lock, flags);
 	add_dr(dev, &grp->node[0]);
-- 
2.43.0


