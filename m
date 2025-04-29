Return-Path: <stable+bounces-137037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CF7AA0842
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6D53462FE2
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 10:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BA129DB76;
	Tue, 29 Apr 2025 10:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRXsVqB3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363112798E6
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 10:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921684; cv=none; b=KqjXf6dCvR+3xzMjZ+3b7vPi/fF8shZd68p5MPso8+qcann7iqbQZkdevgWcnWbClhUPSg+0Skz7AUMXPo0MpvTBkm2i6CtnNmU1lJG8aHce/2nfAskOURvX2YvKsdbmIdRbtzujtgFCm27WTD164Jq85WeskfQpaDavherFEGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921684; c=relaxed/simple;
	bh=gTeEyiZrpuZIuaQnS796B6UyODl/TdPoeYvjjqe6S1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aDeUrwisGPRwqyABxSmmadOUiuJ6arDwQxpuR+5ocU1/jp1kTe8/8tIh2BERrrsFXP1oexM/+pQhplMKnpvZcrbcfrI2tdALsRANa+DHrRHBp48PeqdqO2ch+5qJj7O3VNocvANdDc/llBDuNMtMkeTwDF03Yufhp5nHF1EUqos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRXsVqB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD0CC4CEE3;
	Tue, 29 Apr 2025 10:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745921682;
	bh=gTeEyiZrpuZIuaQnS796B6UyODl/TdPoeYvjjqe6S1g=;
	h=From:To:Cc:Subject:Date:From;
	b=WRXsVqB3+sMJ0jN+rJSvFR/HtQmUL91S6AZqH8+pLhPZSOkvwuBk6a0ThdeWFof8Q
	 NRENyZ+SjqWVlVSR8FXK9b1ejp0gIq6lCMqnzlz5PiPZANIHNBUN98abFpT1PQ9HxJ
	 sTCzywjG0pEoZJiEY9xxlXCozKj8FKjGSNHZk4Vj2b+k2cdN78iM9o/KH5KNPhgaYK
	 F2MLnshuj3GMDnZI9i+NigiGccyDTv0QjwJvOKiQQdQKn1nwuzliFD1YFrDHbDyid2
	 PjvcJMd8JHIv3Rq0jjJ4gB3FW94Gu7qkNXrP5g3iJ4+4IOh1M9PXZ5/WcWZWxKKta5
	 8AVVH8+FtRvLg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y v2 1/3] net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
Date: Tue, 29 Apr 2025 12:14:34 +0200
Message-ID: <20250429101436.18669-1-kabel@kernel.org>
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
index 9f7ff54894d4..02bcf5a4b073 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5217,7 +5217,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.global1_addr = 0x1b,
 		.global2_addr = 0x1c,
 		.age_time_coeff = 3750,
-		.atu_move_port_mask = 0x1f,
+		.atu_move_port_mask = 0xf,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
 		.pvt = true,
@@ -5660,7 +5660,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
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


