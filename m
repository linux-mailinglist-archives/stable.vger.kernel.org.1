Return-Path: <stable+bounces-137031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D15CFAA0830
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C98B1B6488C
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 10:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114A9277030;
	Tue, 29 Apr 2025 10:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTL9YyZr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A2C24E4AF
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921460; cv=none; b=L7t/mLxuJirycGGX7kqwdzGFQGoDfLuVFXyuYfurNcJ4lRfIRUBURM4akP6hTxuvO96uiDJxLamJ5fsIwvV/OUWtEaE94uis6MH4vXmJ8amAK2hb85jhSfzt3zuMoVsdTEiS+Mv0Y9FvU2c8Owk301osKlv70zQfmYuVovlFQlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921460; c=relaxed/simple;
	bh=NtN8ibL8ifcaytrVP6qTY0F4Uj9X7eE/M3+TIQkpRDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ugjiIRzBNpGeU8QMM+DkOp5jRJ70xfH71XSNmCEsS1GDJoN8GCOKJNm6wHFvn/2VUGg15LIFJt2jGqoMDsNyoOFvxhhxXDa53e/qf/N8yBa8DnH6Us6WE2j+ftDVequAsvErGwYi5ioUD1sZj3c0zOQHr5eSUbS+96S4HaY6Ucc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTL9YyZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAEFC4CEEA;
	Tue, 29 Apr 2025 10:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745921460;
	bh=NtN8ibL8ifcaytrVP6qTY0F4Uj9X7eE/M3+TIQkpRDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CTL9YyZri2EkhrCdTyC3+QDp0JgHL7VUuOmGdnvEzJs68/4fruUDaaQ8yC0F7QdUk
	 mVBsIwAz7ooHFw99qJ4yPsxAVJgDO3YexHBz9yZscXhU3jDFDJoIVIPxEKUBteFn/m
	 ufUgwVgrmvwSlCukfJjCMYO3IyBIOdc6EWCoufZ8O8j22NTbQnLY+k1ZSByQd1eCNl
	 0rl6YajanIrBaGbEY5Ioo3O0rdrRAxMSuYv/oabm/PKYfzpPLMi5llVDTRFm7cBOgp
	 AT6OaUxoG0/KdocMSVFtrzjPtSlABOTmVVJcGsRKkyYUR2j/UH+SyDNNK88deZqNbI
	 0KyAYFE69BhIg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y v2 3/4] net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
Date: Tue, 29 Apr 2025 12:10:49 +0200
Message-ID: <20250429101050.17539-3-kabel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429101050.17539-1-kabel@kernel.org>
References: <20250429101050.17539-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit a2ef58e2c4aea4de166fc9832eb2b621e88c98d5 upstream.

Commit f3a2cd326e44 ("net: dsa: mv88e6xxx: introduce .port_set_policy")
did not add the .port_set_policy() method for the 6320 family. Fix it.

Fixes: f3a2cd326e44 ("net: dsa: mv88e6xxx: introduce .port_set_policy")
Signed-off-by: Marek Behún <kabel@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20250317173250.28780-5-kabel@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index f8ac209e712e..472fe300b196 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5047,6 +5047,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.port_set_rgmii_delay = mv88e6320_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
+	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
 	.port_set_mcast_flood = mv88e6352_port_set_mcast_flood,
@@ -5097,6 +5098,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.port_set_rgmii_delay = mv88e6320_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
+	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
 	.port_set_mcast_flood = mv88e6352_port_set_mcast_flood,
-- 
2.49.0


