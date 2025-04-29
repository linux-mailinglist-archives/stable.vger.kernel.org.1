Return-Path: <stable+bounces-137039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F92AA0844
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBDAB4641F6
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 10:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5520C2BE7D2;
	Tue, 29 Apr 2025 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOM5IA0z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1649184D02
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921687; cv=none; b=MyoIyUTs9PPw4cghnAAPSPf+ZkWCBWAcRQzvTAp2ePcSwxMdot5/zMoedNXCjrPF6sD/P+9bVpUPmGl508tbu9VqGBjI2T0jhRGK/UF4qZ1ueGjJDa2Nc1t78U+fTy7e5Em+bLTy+sU2uPJFmt3Ips8D35Iy30DZAWjgY/xTo5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921687; c=relaxed/simple;
	bh=+45x3a1NPhA2cvWYrmoyYbl1E1FmatIKgC6/K3i0gN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZbGiOwHAbXJAbUCyDds5O/jrtIyganAMK/xqVmOodbvy2zmSfW3AyAsZ7b7esYX6fP8cq44cgLzVBGdNHj0PHGnRKVmU/31nOmix1KEKYAlJgm6oQIcoKjyK0rXbWoxNQwI8U1QI6GYfmyy1wjJ+jhFV8Thjk2wB0HXhm7B2IZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOM5IA0z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447BFC4CEE3;
	Tue, 29 Apr 2025 10:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745921686;
	bh=+45x3a1NPhA2cvWYrmoyYbl1E1FmatIKgC6/K3i0gN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DOM5IA0zw3bGP2ukt7VBQ7Y5QfhILNHLpo48UITFJLrldSNbnX1rjhyOT345Wj7Aa
	 JW01LoBAA44uubKnHm3iThA/DlztRawviKiHnlQ+/mY70n6JiNGDL+DlxcTmicMfFR
	 ca7HfH67p8ITedXXsjbK558+/U95YObbxIrIJdLjsJDBqXBc6sIb3sFaZWlafPTSuZ
	 vxZTZmv1sOJDDCduaTbtDi+hwVk8IbMfbTY2AHdazTo4oaiz/B94/rRTUDSwuH2B93
	 YdfhMeLTrMbRe/8IuE/l9OHivCNRhCt3vF64fkSOSg+rZDu4/JzNwgV7p9dsfZ+yIc
	 +SyPFvKVzrj+g==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y v2 3/3] net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
Date: Tue, 29 Apr 2025 12:14:36 +0200
Message-ID: <20250429101436.18669-3-kabel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429101436.18669-1-kabel@kernel.org>
References: <20250429101436.18669-1-kabel@kernel.org>
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
index 06ae3440c785..2d1d60dbe7f0 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4597,6 +4597,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
+	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
 	.port_set_mcast_flood = mv88e6352_port_set_mcast_flood,
@@ -4644,6 +4645,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.port_sync_link = mv88e6xxx_port_sync_link,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
+	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
 	.port_set_mcast_flood = mv88e6352_port_set_mcast_flood,
-- 
2.49.0


