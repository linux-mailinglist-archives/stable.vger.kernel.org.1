Return-Path: <stable+bounces-136826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1914A9EB22
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 10:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A46F1769F5
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 08:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9056025D1EC;
	Mon, 28 Apr 2025 08:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSWZUTyF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5116718CC15
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 08:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745830162; cv=none; b=LAaD4iOHqWVI8C7gqX25knEHhqrPZ81P9jndxMRoLrqzU7URLcmo49egX3CgYFpKFQFYPj/jWqn0CJW/5PboC5sycvPINqV5a/OKP+5B55a7WA1I7UEuwng1VUBVvRkPpFp+ktHlmncNTZ6mjA33UiUKpQ62zR1diFXfWGpKas8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745830162; c=relaxed/simple;
	bh=5PEttPBBWdiWw97mHwOoPN5vGQR/9p8erhisZ2BP7Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LFuIkBJAy+S4QETu4SMC/vWSxMTvH34OcjD900+zQFaQEZuDC59hzQfSml3gZug6YE8OG0WpQmB3N7lu4uWjTMWM3YzxFbJwv7FckCTVsvIc2s9rd3m/NZb9JZ0YR3CZ/1w1kGOet+SSnqcNhXL0uA7rZroSNO3Hmo3rH1Mh0jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSWZUTyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52353C4CEE4;
	Mon, 28 Apr 2025 08:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745830161;
	bh=5PEttPBBWdiWw97mHwOoPN5vGQR/9p8erhisZ2BP7Cc=;
	h=From:To:Cc:Subject:Date:From;
	b=RSWZUTyFHUUf7E+JEm8imXkYRCC0tOIy8Hl4NUbHDcZfnyOqw+ZqDJ+yDPjeqsGNt
	 tVKEQbpZA2J6SBfzjhsCYeX2x7I8XxGpXZ3o24Dz2RUHcJ3WhQC/QalJsSXzVYQy5V
	 LTVb70utGLSHkFXk7AwttRz0+CeoB095j7aSpjP7iFqxiigRKuS6XXmsLp/5YZ26g7
	 XfrcoSq8UfGcaZDknZzNl2VbkN8/+wbDOSP/y18upS7+mIIzTzrFBHUnnDtDSVg7Zn
	 GYRZI07OkoIQGeFbskfPTa1MlHCb+Gia7ayp4N38abdiOxQil6JIWFvXqvTrexxmtl
	 Ha1916NJjrenQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 5.15.y 1/3] net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
Date: Mon, 28 Apr 2025 10:49:14 +0200
Message-ID: <20250428084916.8489-1-kabel@kernel.org>
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


