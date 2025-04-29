Return-Path: <stable+bounces-137029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E24AA082E
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6553B415C
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 10:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E9B29B77F;
	Tue, 29 Apr 2025 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGCyiWVa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E7C25D1F7
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921455; cv=none; b=PxMx3XnFnJDbUKi7SsIk2VtkBT8oAQdrdmgNzekgYUpmnmNB/NsuTJYq+FXcxiBj5+IBt6PVEzv0oY8jP6/49wIunXy4ZkWoDlGYmWignU0xEfmS9oLO0YeH4p+Aif89SR3+k9yEh1XrLpte2mDj2YqkibMRa9OcdttrmCQ3yOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921455; c=relaxed/simple;
	bh=plxYukdQTBcJDJpQSB5tyKbPj010NAZ0RDdyqlgWTsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DuJs2P7XHwkFstn4zFzsBm791o6xEd0qpsoTS0pXip/oS/oakcHG5ODvHUC7FmDN51/CjD7iS+wwxGn50zwWFiMxCZXlNc8dexmU1f+yGastg6+ll3JgLeyKMMU1SGwWMaZKSVpudyK1SJTIoMA/2YiWJFldlnmrRhD5KPAIglE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGCyiWVa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD88C4CEE3;
	Tue, 29 Apr 2025 10:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745921455;
	bh=plxYukdQTBcJDJpQSB5tyKbPj010NAZ0RDdyqlgWTsQ=;
	h=From:To:Cc:Subject:Date:From;
	b=EGCyiWVaPEPEwgwUR2aEI7ooF6X/fO4udabLrynvAQ6/lfLleV4+9kutnez4dTgRL
	 BVXXDh2Nn1PBOCSKz1u+PYScHknqnoXMVBZD6TFwE085ib45826hMPI6G9+8H7QBpp
	 MUBKHaHSKyLeXE5McUyjgKBMFVjSd4IMBkQT1wHxnP56HZ2YfEH4U28+hlY1TFkQIC
	 m//4GDhu0qtjnVioH6exk0uSwnWuWczi+kPULQWPv4neHbNawIl3MGWTXKvgJ1skHK
	 6MAA45zr1PJDRWcTCqZSZOX3FnCx5ngRSZI6HogrUuI7ONyBWCptA7NBsLj1neUBtC
	 +zT5NDHFGGmWw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y v2 1/4] net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
Date: Tue, 29 Apr 2025 12:10:47 +0200
Message-ID: <20250429101050.17539-1-kabel@kernel.org>
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
index bf93d700802b..be42de54e7df 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5713,7 +5713,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.global1_addr = 0x1b,
 		.global2_addr = 0x1c,
 		.age_time_coeff = 3750,
-		.atu_move_port_mask = 0x1f,
+		.atu_move_port_mask = 0xf,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
 		.pvt = true,
@@ -6174,7 +6174,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
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


