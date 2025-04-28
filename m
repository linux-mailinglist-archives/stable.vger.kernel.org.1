Return-Path: <stable+bounces-136810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DE1A9EA22
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 09:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27AB71720ED
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 07:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6536A1DEFDC;
	Mon, 28 Apr 2025 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFQLFkGA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26364212B3F
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745827099; cv=none; b=IG++egXz8FVJQ7qkfQ1xgNaPvEGiJ8AKVn4qriTHnrhS3ibBw88D2HGYES+ROX5MfXSqFW1ieNlsyouRqbBad+MgDpA6NTBqj2G+9z2j3r2yYplJb0j+lr4gXh1ODbV/eOmERmiOYCt2d7qoyrSTtnFHy18BWv5acIihJxHAsMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745827099; c=relaxed/simple;
	bh=GiNIZpAiooM4WvBLlhadc5kWXXq8ISi3k+90qXppeZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tfRseR72JizY7LTBPziArn1c6uoOM0tcFCbJmXDlGVu81n6kzHzuoSp6GbI3/5cDlIF9rjmkwjSz+d5jdjowYgTKOvJna2HZnOLI63wQba+toPza8Cq6acHL4QTkPt16aPzckP+0VYBJkT8NsjF6oWABT4aJRsXIV4co8oPBksY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFQLFkGA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3404EC4CEE4;
	Mon, 28 Apr 2025 07:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745827098;
	bh=GiNIZpAiooM4WvBLlhadc5kWXXq8ISi3k+90qXppeZA=;
	h=From:To:Cc:Subject:Date:From;
	b=rFQLFkGA/RSG5sAK5MYU1x2fk4QktVJ60EahK/jNzWHT2lG11h4vB9a8PRrFRtXrX
	 Ws13QtWL81VlwQjOe7gBRTYpqhZ+yD0X5WmrWxMsko+0flYPjlSfovLJsBmcbdGVBE
	 r+UecPEPIWW9O+WvGDAwdOurOhIz8PvAFjS7Yxrf/mVf3uCA3QVxuHfHh3s/yBORIW
	 SOVHj5jYocN4bj5OmN1/jn9RUpMLnb5R26SWLRLa/Ii5xDicbO5I4DiWDPRT7qvOMh
	 xLRsklcPGu/hjnZhjiVeNT5Dlrbc16AZjwbteoAWq5r8k4p775zl+w+VoIHBgzNN8t
	 Unxi82D/pb8fg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 6.12.y 1/5] Revert "net: dsa: mv88e6xxx: fix internal PHYs for 6320 family"
Date: Mon, 28 Apr 2025 09:58:09 +0200
Message-ID: <20250428075813.530-1-kabel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This reverts commit 2b27df6852444b76724f5d425826a38581d63407.

For stable 6.12 it was misapplied to wrong entries of the
`mv88e6xxx_table` array: instead of the MV88E6320 and MV88E6321 entries
it was applied to the MV88E6240 and MV88E6352 entries.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 28967a338aa9..720ff57c854d 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -6182,8 +6182,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_databases = 4096,
 		.num_macs = 8192,
 		.num_ports = 7,
-		.num_internal_phys = 2,
-		.internal_phys_offset = 3,
+		.num_internal_phys = 5,
 		.num_gpio = 15,
 		.max_vid = 4095,
 		.max_sid = 63,
@@ -6377,8 +6376,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_databases = 4096,
 		.num_macs = 8192,
 		.num_ports = 7,
-		.num_internal_phys = 2,
-		.internal_phys_offset = 3,
+		.num_internal_phys = 5,
 		.num_gpio = 15,
 		.max_vid = 4095,
 		.max_sid = 63,
-- 
2.49.0


