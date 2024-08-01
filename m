Return-Path: <stable+bounces-64933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BB6943CBE
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4CD2899A8
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CBA1CB339;
	Thu,  1 Aug 2024 00:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alIHr3GT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AC31CB32E;
	Thu,  1 Aug 2024 00:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471488; cv=none; b=HRlYBGQ93AjC69bVwF2W0fPPA/VtTZND/b/PjE1ItDQe41Uisrj3ykioy3YonLlomaYjbNt2v4V38Iw0fg37vyWsudW6xhNBTMUbfYaKKguWLc4ncMDfheIS4Wc6GOs+aWnDc2vFuG34y3IRauobPEnFeBgf42szEuDRbBjmNpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471488; c=relaxed/simple;
	bh=ZlkbVzx6o60TnUXN4lglQyzQ70Wm8UYEBaVCsEAlAJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDtgE6tBk/SG1yLJxVGTMAep3xDzbUjrmw+drZ1h1INFEXmcfxBETmdABjDDtHeoatMOfUVfahk8HrUSzyPNxVFlDkG/5cRvMAAja6X0nKNTnxQOoGNa/pP73AJ+/QViumRS98oO7FpGoOsPF3/woCGscpEXSgfvl+m/fV6tj/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alIHr3GT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DD9C32786;
	Thu,  1 Aug 2024 00:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471488;
	bh=ZlkbVzx6o60TnUXN4lglQyzQ70Wm8UYEBaVCsEAlAJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=alIHr3GTaLzuma8NjnEG5RGDQUC7dlaq3WamkvHUF1vbes4i+WxaVsp4w6NEmlHFT
	 cJCQmXgYA+Art5j4bipPiqD2nl2bvtU5RgQ4KwNSvRXM0wvuSqRPL8iT5BCACO3wef
	 nHh32ZIXKBTBUkSF6mP/QVDbkQYM30kARMVdfloWS6Lzkpth6zwuvnUd6NxsFVCUAJ
	 Kxupflgd6HCEeuM3dWrPMwmab7c9Sdv1/NFtvyvc/tftuc69T0fbbiQcNYaiew5iGa
	 voNWydGWz4eM7rm3b0f78Ul9zokeT4zMxtTTp1FwvcBO/hC5a9YDjowtdqhBvwTRaW
	 fNkjf/u0/ArLQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zijun Hu <quic_zijuhu@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.10 108/121] devres: Initialize an uninitialized struct member
Date: Wed, 31 Jul 2024 20:00:46 -0400
Message-ID: <20240801000834.3930818-108-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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


