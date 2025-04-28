Return-Path: <stable+bounces-136825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F79AA9EACA
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 10:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BBE5164D15
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 08:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AC61FFC45;
	Mon, 28 Apr 2025 08:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jf7q0ZVn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B718525E809
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745829007; cv=none; b=e0+MMTyk8y4/cvK1EJQ7q54KQTxc8kJchM2k7ANKdktNjLYoa5ly/uY7tul5VZROc+MFcVK7IhcLgji42vdvxY59ctyVWeeLegtGvpWi8CqVxsjiiTbqZJyFoPpvEIGcc6HWuWF2xGHcmfUHAVIcXweEzCpuXmjCslTsO6tZ9gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745829007; c=relaxed/simple;
	bh=lbgINWoF21ct3GW2/uejWim6pYrsX86gTy0aL6hTN0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=echqnSF1h7Ff5WBS9po1bUO5lW5QPL3TDYWqfKDg6P+OYMG7DEoZMTIBjzxdy/rXTLBVYH2RHmPxxLExCoqtkiyLCvvzdHh38caz7OhObRugZoKq9rRA+inGPOUSmqnmj6FHTSo+LqeP/zV/E1udIcYMst9e4xe1CcU7jk5zZVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jf7q0ZVn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB4EC4CEE4;
	Mon, 28 Apr 2025 08:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745829007;
	bh=lbgINWoF21ct3GW2/uejWim6pYrsX86gTy0aL6hTN0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jf7q0ZVnj9gwAHD/uDOH/hHSiq9gubCS7BGRNyOuawlN7CIjgyuyr/v1jN+IR+6jQ
	 16xu19fhnFExtRVy6WOoAtrQc4Vzz6j4F+rVrJbOJdLH7w5USc3deN/+JWcATWFQ6E
	 Mc0LKI5JbjzYMewaUuL5llEhjlhMbrGtQIWPAadtkNby4Zbuo9B+0pSZaESGLfkrlj
	 vnrf0zmdWG9V1lfCZhg9WaDBmuq6qLtGuYPlSnlD7rUEDOzGKRuo42QmRjBQYMY5pV
	 RrvkLedgNi3OKFCNVzdufwMm3942ozx7gtbCZF0E5f/q/xbw9bWRIa6DHGsymZDqa8
	 djUyCVZbRYG8A==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 6.1.y 4/4] net: dsa: mv88e6xxx: enable STU methods for 6320 family
Date: Mon, 28 Apr 2025 10:29:56 +0200
Message-ID: <20250428082956.21502-4-kabel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428082956.21502-1-kabel@kernel.org>
References: <20250428082956.21502-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit 1428a6109b20e356188c3fb027bdb7998cc2fb98 upstream.

Commit c050f5e91b47 ("net: dsa: mv88e6xxx: Fill in STU support for all
supported chips") introduced STU methods, but did not add them to the
6320 family. Fix it.

Fixes: c050f5e91b47 ("net: dsa: mv88e6xxx: Fill in STU support for all supported chips")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 96b989e336ae..29e4c94c8405 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5200,6 +5200,8 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.reset = mv88e6352_g1_reset,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
+	.stu_getnext = mv88e6352_g1_stu_getnext,
+	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
@@ -5248,6 +5250,8 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.reset = mv88e6352_g1_reset,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
+	.stu_getnext = mv88e6352_g1_stu_getnext,
+	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
@@ -6218,6 +6222,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.internal_phys_offset = 3,
 		.num_gpio = 15,
 		.max_vid = 4095,
+		.max_sid = 63,
 		.port_base_addr = 0x10,
 		.phy_base_addr = 0x0,
 		.global1_addr = 0x1b,
@@ -6244,6 +6249,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.internal_phys_offset = 3,
 		.num_gpio = 15,
 		.max_vid = 4095,
+		.max_sid = 63,
 		.port_base_addr = 0x10,
 		.phy_base_addr = 0x0,
 		.global1_addr = 0x1b,
-- 
2.49.0


