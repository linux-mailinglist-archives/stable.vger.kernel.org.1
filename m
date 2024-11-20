Return-Path: <stable+bounces-94402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D226E9D3D1B
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 15:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D9011F23C21
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECA61B5337;
	Wed, 20 Nov 2024 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/MpBRbY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CAA1AB537;
	Wed, 20 Nov 2024 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111610; cv=none; b=G7fsctv+gNBoCZX9+EW3JldwZSfwWkJiwMeqQIYh5TcDr7OeMFLzeWNpGp7Uc6uAu4Ec30al64j5kBi2QAGX7gF2Hz7FxYLb6UlxNbwErhQw90dwSTNJAqeJ4tRY6brKN/fVk5sROWhQGPQzrKR9kAVME5XQx5OPOdGKefKWVPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111610; c=relaxed/simple;
	bh=HUV36OgjxW0lmpNUuMDqEWIzPdX1PmYizO/IW/fPj80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qaeBuUh4eTor5fYmbgEtSscOQtqDkZpTbNSDUPGhuWNbT78Pu0IrQU6+xk+2podM49KrRStCQeuar1fP5DDPoRT8E5YZFDTskkIXsTmu/I987fJLW+94nt3WIHXTuaP+DdFNzjGKQe9C1cHIOoUUmmvkSHY69jnG4ulyylmf0vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/MpBRbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E042C4CECD;
	Wed, 20 Nov 2024 14:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732111610;
	bh=HUV36OgjxW0lmpNUuMDqEWIzPdX1PmYizO/IW/fPj80=;
	h=From:To:Cc:Subject:Date:From;
	b=p/MpBRbYcK8SwT1AZLPB22GniHbUWM5CC/lXn6/MLlLhhtVdrNb5OQYayq393rr+R
	 oX5KCiPcY4xdpBICbm5gUdJWML8Fj4ONFj5v5kc6ODAXeD1aLJ9wWnlbVHlGugk2wB
	 ud3i7AbRurRRpxz5egXwZusIrlyPECadARqkXBFMt7MNAB4QsuzApAohroaB8A8UZ/
	 O9lmO6sz5dMZ3PUIYXvvlAnGBGfE1PpHn9fxAE23hps1XveJ9Ff3Q+Mu9o/V8MC3fz
	 yCGx+5uj6imKpBn6mrvwJLUg7iSdAfy918DLGoFZvpo3felPdxOmDT0zG6GQtTgcQe
	 PUbN6zJFMI42w==
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
Subject: [PATCH AUTOSEL 6.6 1/6] ASoC: audio-graph-card2: Purge absent supplies for device tree nodes
Date: Wed, 20 Nov 2024 09:06:31 -0500
Message-ID: <20241120140647.1768984-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.62
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
index b1c675c6b6db6..686e0dea2bc75 100644
--- a/sound/soc/generic/audio-graph-card2.c
+++ b/sound/soc/generic/audio-graph-card2.c
@@ -261,16 +261,19 @@ static enum graph_type __graph_get_type(struct device_node *lnk)
 
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


