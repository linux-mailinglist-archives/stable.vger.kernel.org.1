Return-Path: <stable+bounces-58784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A391592BFE4
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B42D1F2396D
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874381AC42B;
	Tue,  9 Jul 2024 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qudDfgjV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4321A1AC257;
	Tue,  9 Jul 2024 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542059; cv=none; b=pFDea7ivSvdkhaJ3QNWErl9A73R9pq9AbE5iG8uWDpLdrErfSjBNXzr5tVIQ/v2yD3jY/GdpnCRBJ2x0jUp7ZIXxZoYM9RU3W62q0IYFfP86iXo0x61jZGeIaBPiMxH8PG/Zd8iyA4vR0X2JK+Ej21d4Oi5ZSPKPfQi46Za4ULM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542059; c=relaxed/simple;
	bh=ltzp66YNsRQRGlipLvLRGkZPtJ0zdwbYYRgDT6ylc6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=il+WeUMyE+8uv3v50YewC2o5iThOfQP+SnH+SCtrp3G2eXBvctv389sT4WuCUIonVBt7SDkJ8/+A5MZRV8SDxANv2FKv82mJbVUwSjTM3QsQROPvfr6yaUkmi39qHUNlryCeCuVH4LC7K6q2o85hSNh56sdMA3Fz4UtSkkfAPIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qudDfgjV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DE0C4AF07;
	Tue,  9 Jul 2024 16:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542059;
	bh=ltzp66YNsRQRGlipLvLRGkZPtJ0zdwbYYRgDT6ylc6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qudDfgjVVd9qF9Afav/lagqntuTGQGRCD7UaZE23pPP9IvOpERdMjSvpY6rZ9tqaV
	 nZgiiriDO8lHpIKNpIb12F9tht0rNXFpDyWxVandgsjcsp4vnEfPAaWTXxRe4Vxh24
	 tdY0nHSY+8d2nXwtBdTIg/1EDADnokj2L3KqDP0B8we5BD71WnmjMLf9niSYmyaGwV
	 JluT/g2z+Pl3Zusa2CpNodnhTy37CGE0JXq0d0yMnOZnvk41g79uEjAOSOSGQb7410
	 NDftpzrVzDM7T8rJCqsAv8skmF8tqN2PbVZHRJPPgWLpJWBsQB896fusFrNl5vdL95
	 Hsrs87Ri1HOrA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	marcin.s.wojtas@gmail.com,
	linux@armlinux.org.uk,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 22/40] net: mvpp2: fill-in dev_port attribute
Date: Tue,  9 Jul 2024 12:19:02 -0400
Message-ID: <20240709162007.30160-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162007.30160-1-sashal@kernel.org>
References: <20240709162007.30160-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.8
Content-Transfer-Encoding: 8bit

From: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>

[ Upstream commit 00418d5530ca1f42d8721fe0a3e73d1ae477c223 ]

Fill this in so user-space can identify multiple ports on the same CP
unit.

Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index cebc79a710ec2..6340e5e61a7da 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -6906,6 +6906,7 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 	/* 9704 == 9728 - 20 and rounding to 8 */
 	dev->max_mtu = MVPP2_BM_JUMBO_PKT_SIZE;
 	device_set_node(&dev->dev, port_fwnode);
+	dev->dev_port = port->id;
 
 	port->pcs_gmac.ops = &mvpp2_phylink_gmac_pcs_ops;
 	port->pcs_gmac.neg_mode = true;
-- 
2.43.0


