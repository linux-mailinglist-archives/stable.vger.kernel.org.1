Return-Path: <stable+bounces-137027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B46AAA081D
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493C61B61F48
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 10:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3342BE7BB;
	Tue, 29 Apr 2025 10:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdNmQ16I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA612BCF4E
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 10:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921313; cv=none; b=Wk9q945rmpUbgMjJb8olZh4lOv+3WWQ/VWy1XKJ5qEwpAESjl+D31Dg7bse7hi8kkyfqEnUiBNbnedC51ISDlm7jDUlR+VGgJDoLJDPw2x943T8dIqTuMC4d9mlEJbVRdyiaNJrLnwrfwT+uSKdBsi+EKXBY13N8SXiEbaui+GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921313; c=relaxed/simple;
	bh=NS8Z+1awNI8FrQI5HSbYVn1WArLZJ3Nr2Rx8TvJqAdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gh3+JuKXnMxwazvNVYxsyvdT86GQSUMFDpWq0sHL46ZfcaEYtwoOxKii7bbGXkY6qH2nviU+2/UFqxp8O4NRD3TLTIS97dI0Kt0cpDdR1NsBqbl1kj/STZ6R8I14pl+wjyMSgS1iaodwK2fnQPjzIjVZStXRWSsSD0ZuN/rBLzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdNmQ16I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB1DC4CEE3;
	Tue, 29 Apr 2025 10:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745921313;
	bh=NS8Z+1awNI8FrQI5HSbYVn1WArLZJ3Nr2Rx8TvJqAdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YdNmQ16Ij7xSvLdNA6Ob40j2c1t/4/7M7xmeatwOyHj70HB2/U3cUUwxT+ZNYZZfs
	 zeMlFfOvVDlbjfBXlX5G/BqRQoTcLmrqNZeYKI2nfQtbedJLtRrdgsZYK8eqKRWgW/
	 L6ECYYeAMhnyFB8aFvqN+/6x72zxaDoOFmB+7Zg12w0TPbRjINX10bXyx0wRpi+M9Z
	 bv+L32FCr36uGXSwI51GWRQiB8vdP/uK7QBAw2cWxGPA+iQQwmY3VX3Pwn53iTD93Q
	 UG+EXZPB+SdbHM4pG0otdUiy4q1CEqoEiN1O5G+NcPpQ86AkGb8vEoRnO3i91idi63
	 o49hzWDcZeMQw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y v2 4/5] net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
Date: Tue, 29 Apr 2025 12:08:17 +0200
Message-ID: <20250429100818.17101-4-kabel@kernel.org>
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
index a56b1d5a0cd0..4218ed581409 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5186,6 +5186,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.port_set_rgmii_delay = mv88e6320_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
+	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
 	.port_set_mcast_flood = mv88e6352_port_set_mcast_flood,
@@ -5236,6 +5237,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.port_set_rgmii_delay = mv88e6320_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
+	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
 	.port_set_mcast_flood = mv88e6352_port_set_mcast_flood,
-- 
2.49.0


