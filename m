Return-Path: <stable+bounces-137033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D7DAA083B
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56021891F4A
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 10:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD69E221726;
	Tue, 29 Apr 2025 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhcjiVL5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C76B21ADD1
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921589; cv=none; b=HLmN7J60QImi7aJkZ8iLgOgygi+kx0J0WeEx/Jsw/xhOJ5YmBZDnVDpp1dSbMgeAjKIGrV4aFvvhSk3BGcEkhrsOcX/Uqb2quNRtyEpQzKhRYMgnA/hzlaNdySXfJN/4mNpE63R9U3yV8tvZm9VGnUsoGPsXq2sdRc2uUdj8784=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921589; c=relaxed/simple;
	bh=abnczp2/o+TXtumVI4dgKYjW6Fu6pS3TCjsetgyBiq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lX6x77SZvnwyZIFF//KXotsBAl/inb7tNl1PM1AKb39dtwMOibhfSR54UVm5v1ibRpk0oJsuECTz669v3Z7krHnewgJBNW/TujAqFpFnjb4dC9ywWw/JXeu83lTCU/WKAdlKblujoKjb9LB6mQD2qMIhMXYwUHZ2t8acaolTp58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhcjiVL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DB2C4CEE3;
	Tue, 29 Apr 2025 10:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745921588;
	bh=abnczp2/o+TXtumVI4dgKYjW6Fu6pS3TCjsetgyBiq8=;
	h=From:To:Cc:Subject:Date:From;
	b=XhcjiVL5LKWPQFTJ+vmiW8/+GHX6Mvmj2GDwmDTWqJZ0rWZZtsX+JfdcXKw8Avr+m
	 O+8M7bXHfOvWYKhfw6GK2EpIpi+64Eu9wQnjrwbwHJ7xCwiYlBZTlwoUuBkIQawSIQ
	 AFpOvElj2iMR1nUfS7oH1MjaOqOXWWoTY/yH2yV9dVsnHFqa4+WL407EcMQTjmi3K/
	 gez1c6x582W8mPz3dMeEhx08A1FlzRCcQe+ZkR2V0YwVyk7JdEjJ8TwV832hcPBkBH
	 CZTle89lPK3KOFWJbBGJUcMyvQ0Y+RtAGFBFFTfMkZMiLO8UP4IPYlwB0BozRwS4SQ
	 T63Nhpl0MsHRw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y v2 1/4] net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
Date: Tue, 29 Apr 2025 12:13:00 +0200
Message-ID: <20250429101303.18190-1-kabel@kernel.org>
X-Mailer: git-send-email 2.49.0
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
index 0541c9a7fc49..b5e06f66cd38 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5813,7 +5813,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.global1_addr = 0x1b,
 		.global2_addr = 0x1c,
 		.age_time_coeff = 3750,
-		.atu_move_port_mask = 0x1f,
+		.atu_move_port_mask = 0xf,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
 		.pvt = true,
@@ -6272,7 +6272,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
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


