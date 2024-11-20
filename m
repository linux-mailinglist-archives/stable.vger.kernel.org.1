Return-Path: <stable+bounces-94393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8197C9D3D07
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 15:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B8D2833DB
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1360E174EDB;
	Wed, 20 Nov 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QubNXRpY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA041AAE31;
	Wed, 20 Nov 2024 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111561; cv=none; b=pGw8+Rzj4VHcf+ZBLFUoBTzndKOUu+FBb3sCX5w6tChD6mXKImmN21CIy6fSpMCj2UGD2d0ptOzqxgYMhQLa6/ksYXGo1wY1FQQCRtmhEk5TZ7hG/k3jqi3VQ7y2OwXWdg1eN3+zFz7MC+FESM3gm3mneH73raKYVyrvHMMu0ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111561; c=relaxed/simple;
	bh=V7RyWEwUV+VacJNIxd3b1TT4O4dL85UAFNy8W0PHDkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ls+jiAT1d//UP3UFSaBZBIDofVq610AkwSOt/Mdb3DcBo2+XVoJYxS8WjBejsqujSKTnUipHcV5zHEhx4u4j0hIBq1GHpADtpZuldjAK+M7nEtGVyGcrhOs2XfrY65qT0YrN3dR+mHq2MfDXx93t49XPFrM+betYVg7/7uDkdmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QubNXRpY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255D8C4CECE;
	Wed, 20 Nov 2024 14:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732111561;
	bh=V7RyWEwUV+VacJNIxd3b1TT4O4dL85UAFNy8W0PHDkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QubNXRpY0ev9VXsH5TlThDR2qhHxugzvRpK0ByHDpnepGD7WW0rVKcoUZuFz648k8
	 HFEw9QDCuCgnXKEOzC7IkAd0hCcXgpPqAPfKxVGP/CXSZZNpUz1rV1z9hGhBioGzJE
	 0tes8Xa4hGZBHXCDWXnalZUbRiBrzMCy+ZDCIwrtSmnU8ibRm6xqsDcKio8yyxG30c
	 Lr7vb1kR39IRUirQGuvTnq2WzGBaZG9a1NbIROkreqb7MrBFpoZ24BQP6G/wWOceUu
	 Hk11Jgh1crDu0YLgvvMqRm76BrVXEEbTdsDobDynFYvKdDPPFtlcwu5NyzSMYjhPJK
	 3nMI16XlPbpFQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Watts <contact@jookia.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 02/10] ASoC: audio-graph-card2: Purge absent supplies for device tree nodes
Date: Wed, 20 Nov 2024 09:05:27 -0500
Message-ID: <20241120140556.1768511-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120140556.1768511-1-sashal@kernel.org>
References: <20241120140556.1768511-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.9
Content-Transfer-Encoding: 8bit

From: John Watts <contact@jookia.org>

[ Upstream commit f8da001ae7af0abd9f6250c02c01a1121074ca60 ]

The audio graph card doesn't mark its subnodes such as multi {}, dpcm {}
and c2c {} as not requiring any suppliers. This causes a hang as Linux
waits for these phantom suppliers to show up on boot.
Make it clear these nodes have no suppliers.

Example error message:
[   15.208558] platform 2034000.i2s: deferred probe pending: platform: wait for supplier /sound/multi
[   15.208584] platform sound: deferred probe pending: asoc-audio-graph-card2: parse error

Signed-off-by: John Watts <contact@jookia.org>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://patch.msgid.link/20241108-graph_dt_fix-v1-1-173e2f9603d6@jookia.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/generic/audio-graph-card2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/generic/audio-graph-card2.c b/sound/soc/generic/audio-graph-card2.c
index 56f7f946882e8..68f1da6931af2 100644
--- a/sound/soc/generic/audio-graph-card2.c
+++ b/sound/soc/generic/audio-graph-card2.c
@@ -270,16 +270,19 @@ static enum graph_type __graph_get_type(struct device_node *lnk)
 
 	if (of_node_name_eq(np, GRAPH_NODENAME_MULTI)) {
 		ret = GRAPH_MULTI;
+		fw_devlink_purge_absent_suppliers(&np->fwnode);
 		goto out_put;
 	}
 
 	if (of_node_name_eq(np, GRAPH_NODENAME_DPCM)) {
 		ret = GRAPH_DPCM;
+		fw_devlink_purge_absent_suppliers(&np->fwnode);
 		goto out_put;
 	}
 
 	if (of_node_name_eq(np, GRAPH_NODENAME_C2C)) {
 		ret = GRAPH_C2C;
+		fw_devlink_purge_absent_suppliers(&np->fwnode);
 		goto out_put;
 	}
 
-- 
2.43.0


