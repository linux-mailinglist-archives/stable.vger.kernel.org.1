Return-Path: <stable+bounces-137025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4CBAA081A
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 388B64818D8
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 10:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063F42BE7C3;
	Tue, 29 Apr 2025 10:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWKj11+b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B995B2BCF5E
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 10:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921309; cv=none; b=Sl8iogFMCOHrmHU8/LZ4VayNWE85uFz4afew2lRd4R1iAX5uI0bFvsdOTeDe0cJXunm6PstZYYlP47iJZtXBPjdN9Xe/rgQ37fGUdEgXoHfLZeTimjn8kjqVpSY7VzX+z7gNrsDHLalEufP/wbj+KAJI9mLpQsaRDM0MvYjl0aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921309; c=relaxed/simple;
	bh=tbTxdQ2CdDlwin67Yp43Z+z8S2EphN4oYl12tlrBOUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tOyZHVvVfh2q+OD99SjBKlqcE3qXT9o8meD8ksWymOKRdV15GmwMbo2CD4pTp//kmCsdCWNBz8m1s8f9WE9dL8Chtw/fne9eBtuiJHCRx8Xwv88LP/OOohjqQqYGYNv8xaH7ZX4zyTafkKX388zu1o6Cl9g+w1KOXhsl0KU0mFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWKj11+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945A5C4CEEA;
	Tue, 29 Apr 2025 10:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745921309;
	bh=tbTxdQ2CdDlwin67Yp43Z+z8S2EphN4oYl12tlrBOUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CWKj11+bAhzub5iaxeoJmDgnX42ceNEX8hZXm2+kRWU1qESCFNLejYkBbImQjgadC
	 HWmF4szfkyr7FQKvrpyZJmzm5vVZ4iBmoUiMafMKCU3LF+bn6ayuehp57XVT3AbdEL
	 LTcQ6IpKchrLSJ7+KOlIyAyGHavHHtu2Fz+i8iry+UvTrzmMoqAjXpenJ+SxBG3Cy1
	 qM+5J5OoOPEvIQEFP7RGKEVFYgsMIwSHi2igVJE6WwN4K8R4ZALZxg0zDrWwNaY0Dm
	 lbiL1wqi1kO/nx6fb6rVTtzUiiQimD4oU/Ib4ySzsZWodlQqpoFVCj0FdWCqRCpOrF
	 aq4a/sa4S4mSQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y v2 2/5] net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
Date: Tue, 29 Apr 2025 12:08:15 +0200
Message-ID: <20250429100818.17101-2-kabel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429100818.17101-1-kabel@kernel.org>
References: <20250429100818.17101-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit 4ae01ec007716986e1a20f1285eb013cbf188830 upstream.

The atu_move_port_mask for 6341 family (Topaz) is 0xf, not 0x1f. The
PortVec field is 8 bits wide, not 11 as in 6390 family. Fix this.

Fixes: e606ca36bbf2 ("net: dsa: mv88e6xxx: rework ATU Remove")
Signed-off-by: Marek Behún <kabel@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20250317173250.28780-3-kabel@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 720ff57c854d..03c94178612c 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5852,7 +5852,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.global1_addr = 0x1b,
 		.global2_addr = 0x1c,
 		.age_time_coeff = 3750,
-		.atu_move_port_mask = 0x1f,
+		.atu_move_port_mask = 0xf,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
 		.pvt = true,
@@ -6311,7 +6311,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.global1_addr = 0x1b,
 		.global2_addr = 0x1c,
 		.age_time_coeff = 3750,
-		.atu_move_port_mask = 0x1f,
+		.atu_move_port_mask = 0xf,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
 		.pvt = true,
-- 
2.49.0


