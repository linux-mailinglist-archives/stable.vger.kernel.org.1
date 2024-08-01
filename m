Return-Path: <stable+bounces-65019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C87943D95
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96BA51C22075
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3051CBE06;
	Thu,  1 Aug 2024 00:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lfv4vnqn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA721CBE00;
	Thu,  1 Aug 2024 00:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471955; cv=none; b=TOEdvlWEX2PAh8ieW6uWsaqE5cFq/1q52vwPQjS7KHfOQeCwzcFlohxT5Pwsg92hiKOjCyYxAxtvpyPer9lyy7sWyjHQ1agOTrHZ9AaTD0eKfpEAu6DOvEFEKEACiJ+Yl0tRpsx0wE8d0YCjDVKNwJxMXAQNm1It4QCM72LfD/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471955; c=relaxed/simple;
	bh=ZlkbVzx6o60TnUXN4lglQyzQ70Wm8UYEBaVCsEAlAJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V0IAB6PcX2duCdn8YCor5D8jhg9NDbt/S2l8qWNb6y4xPtwoCdiUONXTJv7B5S7X5TaSCST5V32ZrysdSTRR9l0/FoIqhB3IykVUw1cV7IB0embfFTtikuSeQoseq1KUO5Q5KESN8p3z+TRAsH8bvypjfdQN5wH/qezHUe/6uOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lfv4vnqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720BFC116B1;
	Thu,  1 Aug 2024 00:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471955;
	bh=ZlkbVzx6o60TnUXN4lglQyzQ70Wm8UYEBaVCsEAlAJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lfv4vnqnBhsAyVjYDJ/b6Sb4/hv34BBkXQGjjinUY0yH3/f9M1n1D48mS16Gnldii
	 5wpQsVE6k5PC821R58l938KGT/uOgEcDCU49UPb/lSgaWQ4m9XEEefSHRG/Q5CzI/W
	 7lG1uqj2virAecyfS+5fwtD+mwnKQtwZO0bL7B7V1+QFHZ5brnUdSVogjgmfN4QONk
	 jx5bMiktprI5k2u5S1PUZQwMDXXkAh/5S2vUfdYrLH7LoCQ6SUeQZhi5iqKS2boUiO
	 oWUdqo/2eJYqRF7Di9z+flxuqqz5hJASo7hrfOTwNUQLdLuoO+eNp5tWGsu6fEzjAG
	 3C5dG+W15+gqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zijun Hu <quic_zijuhu@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 73/83] devres: Initialize an uninitialized struct member
Date: Wed, 31 Jul 2024 20:18:28 -0400
Message-ID: <20240801002107.3934037-73-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index 3df0025d12aa4..3beedeaa0ffca 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -567,6 +567,7 @@ void * devres_open_group(struct device *dev, void *id, gfp_t gfp)
 	grp->id = grp;
 	if (id)
 		grp->id = id;
+	grp->color = 0;
 
 	spin_lock_irqsave(&dev->devres_lock, flags);
 	add_dr(dev, &grp->node[0]);
-- 
2.43.0


