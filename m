Return-Path: <stable+bounces-125286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 185EBA6902E
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2037E7AD5B5
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78AB21764B;
	Wed, 19 Mar 2025 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NdHFaBhg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962AF215F78;
	Wed, 19 Mar 2025 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395082; cv=none; b=haDYzDxuUK4ZHN9k/aGaF4PXHEedOlr+Wdki0K386K2wHOc9w4uZGTsvflEICMnoJqoDEO1Q2l8ZRlj53vF2jHuBaaLjoFWvLr36kZA78s+Yb/PGcMN2YVeX3c1VxDH1h5Y6aO5QLfKwXOdwcE6NcTpSKI/KXcuYrF1XmNQ9XC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395082; c=relaxed/simple;
	bh=Gro3hXV9cCAsY14nJHbqeQqZb/cd2vqcz27sxc1kYsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXKp+NwYp6TEt+IFTpuCYl2yE1aAvXEo4zglq4xGc2OOmPGL6S92ptL9OnXiK3LNTIcSlgtwWDezX5F0AnwUySOEoxhhcUSbTLuKKz6oYviu+HuPBUvdSwH3KiOYZYldpzRLsvMdfPsbliBPwkI4aUBC0qvP3p4xiIIRIKyXXHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NdHFaBhg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2FBC4CEE8;
	Wed, 19 Mar 2025 14:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742395082;
	bh=Gro3hXV9cCAsY14nJHbqeQqZb/cd2vqcz27sxc1kYsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NdHFaBhglpEEhUbK1b6x4Efvx1LEjoCfVgSB+IBOOVMpl66EMHpe9k+HXILTCB7jv
	 XLWAQpan0KehL1YEO4SEsWm44gTuY5X0saJaiInx6C480qK+qfY5S2CWRs406eUKlo
	 u4QWQVWqILwBY/uTuvk3ep4PWN33UrZv+yXA/CpA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hector Martin <marcan@marcan.st>,
	Neal Gompa <neal@gompa.dev>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 123/231] apple-nvme: Release power domains when probe fails
Date: Wed, 19 Mar 2025 07:30:16 -0700
Message-ID: <20250319143029.879913644@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143026.865956961@linuxfoundation.org>
References: <20250319143026.865956961@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Hector Martin <marcan@marcan.st>

[ Upstream commit eefa72a15ea03fd009333aaa9f0e360b2578e434 ]

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Reviewed-by: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/apple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index b1387dc459a32..df054cd38c3e3 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1518,6 +1518,7 @@ static struct apple_nvme *apple_nvme_alloc(struct platform_device *pdev)
 
 	return anv;
 put_dev:
+	apple_nvme_detach_genpd(anv);
 	put_device(anv->dev);
 	return ERR_PTR(ret);
 }
@@ -1551,6 +1552,7 @@ static int apple_nvme_probe(struct platform_device *pdev)
 	nvme_uninit_ctrl(&anv->ctrl);
 out_put_ctrl:
 	nvme_put_ctrl(&anv->ctrl);
+	apple_nvme_detach_genpd(anv);
 	return ret;
 }
 
-- 
2.39.5




