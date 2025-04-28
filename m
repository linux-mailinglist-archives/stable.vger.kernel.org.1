Return-Path: <stable+bounces-136818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6977CA9EA8C
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 10:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F8C17A8D4F
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 08:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A48F20D4E9;
	Mon, 28 Apr 2025 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KL5Nu8RM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A501A94A
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 08:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745828341; cv=none; b=JoHnjgaKj1YIvRUr7heyO20CTzZnf+WScmMStmrssTReEZfSSfkIeHMZRkBaXhKxUfBymper9u1iT3tyOSyu//xSs4KclCjsBef1UXj9XN6L853auGnc3dEnHQwqsrIafwa6hHt0JHeJQjyrhTk8YqF9ypki3faxmv9LZ/Ij4xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745828341; c=relaxed/simple;
	bh=x9VCrzurYpKyndnvXnf4lznNDWo8D6rPdzPvPvXbuvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TdHuBXPzGNaWB+poGEgPXZ2saWi2V0gLSU/DFsClIAnCGzUPeMdpLCAmBDZ70luSFkTI957KvTZnc8IyIDYXRzyQ5HvimIvsUsGYXEz4loMTbgfU0tEqDpvV8LIX5UOlpXCy6SB4m3/dfhQ5aqYx7Poov492azF9xztUAPF0C+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KL5Nu8RM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EFAC4CEE4;
	Mon, 28 Apr 2025 08:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745828340;
	bh=x9VCrzurYpKyndnvXnf4lznNDWo8D6rPdzPvPvXbuvg=;
	h=From:To:Cc:Subject:Date:From;
	b=KL5Nu8RM0EwyKFF1tFVh5OyRtf+BQ1G2/eJKfZQq+3dHWxsRRVAmk8cfvq6PPJCxG
	 veE7WqSNmF2JakSjg8vRedEY9oRzlGq1dUYQjR2m9gP9rfOjLkDQoiqrfN+vwRvbdH
	 Xzna8dg+pQo1vceTW2DVvi+MWUwGhWRbTpZNb+a6zTM2jCx/2CocTaTf+qpLdgEmOi
	 BLCxvUjpW/TC4PHLD1ojTdVvFie4jB9shSph3OTmX4z4XgA4gaC6oPxYFhI+bWHgFg
	 ZW3KM9bE2SB840UV3mV0spX4LaQkcvh3OF0DTdnO1gaNDGeMasLj1E0ZYMcAH9q96Y
	 5nzTKMenY6syQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 6.6.y 1/4] net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
Date: Mon, 28 Apr 2025 10:18:51 +0200
Message-ID: <20250428081854.3641-1-kabel@kernel.org>
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


