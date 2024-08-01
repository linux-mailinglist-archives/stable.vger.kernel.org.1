Return-Path: <stable+bounces-65207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDA7943FB6
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1509D1C21007
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBCD1C9EAD;
	Thu,  1 Aug 2024 00:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcQX29QZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4FE1C9EA6;
	Thu,  1 Aug 2024 00:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472861; cv=none; b=kBNEJ8rI/IyqzH+Ubc28tlo8QOH4bBKAiB8d/k+P5xfuEOWy3MEC8LMlr808beoYgoZrSlea2DzOz/7eRQ5PFMfQ3tiDG7tdGRbDtP0TzhGwRPjDfqb7zsXBOqcmMKOWJp0ni7ZiOWsUf0JvlZoHin2lRNT0cj/cGqbtFAX41LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472861; c=relaxed/simple;
	bh=LXY1ChACaRW/JFf9taziPwuLmcyGRYuXodyqs4IrAdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=beFLv9ZzkNuquDzaZ0g4iDJQp7rf1Ndw4Ugxkg7sbuWetv948iI1XD53PQKFiK0IzXhx5f3wQiC75bL+ehJHgQJW1lftF602AgsibAQyaXEVjgCOh1mmhT8AwxC3jgJrNXhoOaEHqiaTDb8QqlZq9Ibtt7l3efkGcccXfL2is4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcQX29QZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CE4C32786;
	Thu,  1 Aug 2024 00:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472861;
	bh=LXY1ChACaRW/JFf9taziPwuLmcyGRYuXodyqs4IrAdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QcQX29QZGoVd24mQwzbz7r5AtDArWZWkWtRl5rDus3fshz+FsoZFZqNnkmSILc8uB
	 tGFiCj9ZbOc5ysRFJrIpWUZT30T37lTUZKIkEzFzFro1i7TelFkDJqRgosw7CFCdaf
	 cxNTFrTW35458dIe1YvD7QWPCgrkjlL5g4sITr27Vv5tFHjPWUjyP0l7+vKWhpckV8
	 jwv/UFTbO1Cx8Orc7ViTjUuXYYL62ZMPgODfXPUQGSwHqOyNlSb3OCy6lRglp71oSi
	 TmD6lbRckk6ie0fZ8Xwc0O7YmNWmGcu1Lr7RNlU/wSSa2n89mICzb5pLRVqI/f56gc
	 6LDjY8cyOLisg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zijun Hu <quic_zijuhu@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 10/14] devres: Initialize an uninitialized struct member
Date: Wed, 31 Jul 2024 20:40:18 -0400
Message-ID: <20240801004037.3939932-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801004037.3939932-1-sashal@kernel.org>
References: <20240801004037.3939932-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.319
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
index d68b52cf92251..299d58a96a7b7 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -559,6 +559,7 @@ void * devres_open_group(struct device *dev, void *id, gfp_t gfp)
 	grp->id = grp;
 	if (id)
 		grp->id = id;
+	grp->color = 0;
 
 	spin_lock_irqsave(&dev->devres_lock, flags);
 	add_dr(dev, &grp->node[0]);
-- 
2.43.0


