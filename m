Return-Path: <stable+bounces-136822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BECBBA9EAC7
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 10:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432B3189C7B6
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 08:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5552925D53E;
	Mon, 28 Apr 2025 08:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0Zl5P71"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166FB22FE11
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 08:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745829002; cv=none; b=lC/Gk94sEWQtrtbUx1RkRIyHX3/hFrLkb5pnhpRDrYKeqImRDlCEoxff/+Vkli85TY8U4sWCwcYIXEWN/RKNzP5Znp3jLFVWqCDl2nHHvJmFM5vGLEXwPj3lnmNiuPD4r0Kv/bv/2uR0/zAIFUW4JfqI6fnP4pj9kqYO3tihz8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745829002; c=relaxed/simple;
	bh=g4zNs12NTs6BIAEjyOswJs+9JZYQTbiDq/MjPjhFozo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kAzVLNfZ+6ztgEn0qFcV6PjLM/1Z7OSXRIidMBklqH1LOd8sO5Z7aqt2dip/JiDhtky3TojKcTJLAucwEtuDAYhogBQD4kHnX27vPl+G5hZMlTGE/R5Lj8Uatv6qn8zQTFgdBMQqOWOOXmbP4+mKIFbRRzJb65HWwRGYJGHIgjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0Zl5P71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C34CC4CEE4;
	Mon, 28 Apr 2025 08:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745829001;
	bh=g4zNs12NTs6BIAEjyOswJs+9JZYQTbiDq/MjPjhFozo=;
	h=From:To:Cc:Subject:Date:From;
	b=F0Zl5P71Rydfi4WcbdgXXHWKMSbluNEKLaUoF1wbDQNUp9MpQ9/RpdDwmuhLYwI+j
	 NG68qF6IlRp2c2bh8z/9hbCq0VTQybicvNfSJwIyazwRqX+1ywhuh5FfN3GmxrYwN8
	 vOGIDVNK9oicaUyic1oJ/9bJDdt5rVLX6jriXRUZ/7Tl3AOkdiV7lmWcpYK3rSI5zr
	 OweoopJkzRSTM74uV6z+07hZl2JfLhRtt2K1zwYcw/7UZjuN9YQDz5jQoZXHyrHJhf
	 dNOKatwpczRQMraOmwJXXvhZ+t0dNjoIon36gW5TKuXzyWwvEmMOZcv0BgAj8p3ifP
	 RY9LrnP/evY9w==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 6.1.y 1/4] net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
Date: Mon, 28 Apr 2025 10:29:53 +0200
Message-ID: <20250428082956.21502-1-kabel@kernel.org>
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


