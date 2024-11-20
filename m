Return-Path: <stable+bounces-94408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0A99D3D3C
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 15:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D2DBB2A6DF
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B161B0F0C;
	Wed, 20 Nov 2024 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fweGcA+B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A201A2544;
	Wed, 20 Nov 2024 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111648; cv=none; b=kd/NMiYTNfbrbtXmaCgnKv75Qe3PEEobGLdqtpM8eldfsvxQimHM6/UDHmkm9zKTjF2TbyVoZKr9Ef2HUBFH0J1qOr3Ku7izvBZpZ39BTon6hYz55l2ZzQyKEiPRiDAfcjxWDeiwPnzy6jeGJ4ty6mlMjuCo6MkgMt1eHuG9C/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111648; c=relaxed/simple;
	bh=/TB1kHHP+rypthDwQs6NGJ86gtniVbyKnKgPVrIymHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PuhSMWEI8yKrhEP76WNekny19T+g7/07vjj4NhmoEWcNakxrTTs+itjdNRmEl9yWkWeNsAXbexfczGUegmW9c4tZJioqTZpr/Zdls5tT4GaJdBXXbW7URY4o2QGegNzqURNjE+uTyI58Sm4oYD/JOhSgYrpoSC6h6C1T9sBG0Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fweGcA+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A578C4CECD;
	Wed, 20 Nov 2024 14:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732111646;
	bh=/TB1kHHP+rypthDwQs6NGJ86gtniVbyKnKgPVrIymHQ=;
	h=From:To:Cc:Subject:Date:From;
	b=fweGcA+BdAKbv8bgZscbACwQHjmtE7y7yOCPKNizB43A43uHEHG8bvKkAtrY6pFGi
	 YyMGp0nFC2/E594SXZAJpd1HHWSgisDYPpNSh+l/v0VUkLu1NTNRR0wuuVNr4nvsSV
	 hEskNslSYn8+yqnfk1KVavNhoPCKEApV4W1yZLGsYwYKCgY5wW9HUgR+adeSYV/hbo
	 AgufTmfushPlYjDP29lKIVJFZvD6AUJJMrCszU4hfqkuj19eQr+AVvJgkpmiJPryhg
	 wGGmjiwTnGBr+HmIAVJxeNbhDckEUt7o4ndeKMmw4v5OS3jUfjshFOBEZAjLh8aXGC
	 G1EDoy6kjR4PA==
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
Subject: [PATCH AUTOSEL 6.1 1/6] ASoC: audio-graph-card2: Purge absent supplies for device tree nodes
Date: Wed, 20 Nov 2024 09:07:07 -0500
Message-ID: <20241120140722.1769147-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.118
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
index 8ac6df645ee6c..33f35eaa76a8b 100644
--- a/sound/soc/generic/audio-graph-card2.c
+++ b/sound/soc/generic/audio-graph-card2.c
@@ -249,16 +249,19 @@ static enum graph_type __graph_get_type(struct device_node *lnk)
 
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


