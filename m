Return-Path: <stable+bounces-137028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B278FAA0821
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1225D5A4437
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 10:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCA92BCF5E;
	Tue, 29 Apr 2025 10:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8HPQkR1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8C325D1F7
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 10:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921316; cv=none; b=BxOTHMWAlgPFFl60zNgQ+XB9qhzJV6SMO6SY3+naTvDC/K3KsZR7BBJe/U5vNnBtCEGI6nKir6Mm+kJ4vxg1zfp/klwgd9blzjC03sqFqMkkVzCZvsQqms+CKEKMsix7S2ysNm5BatEAe85p/kOIgx7ySAezWJ/j8gx77LCmR90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921316; c=relaxed/simple;
	bh=/cS9m9QHxccKF8aN9AlnBlpABn3DYCEuW2tCxql7vl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvjNuheIz61WwAlcggFYWMQc0YoSMl5bbqg01OARvSJN+1VGoaEf267ZZJgQRVX6Zqv7hh1pg6TK74ZAY71KI+TxZyMOCvRtsmBLm7cunfQWQcYhrNPgop1gRLt3pG2t6CIUi5ySxIQSU3vpmif3YGP93i68BDswiTm/5kJngD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8HPQkR1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB4DC4CEE3;
	Tue, 29 Apr 2025 10:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745921315;
	bh=/cS9m9QHxccKF8aN9AlnBlpABn3DYCEuW2tCxql7vl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q8HPQkR1G+1z4BRJ6GUQ7aC8X64a/6zZu7zZqX3WhAM5dxa9e3bdC4tCZg92jnk0c
	 02Gj2XH5m7t07D1uwshL5PrScF1oP9Zn3J3xIAexUagiRF/RsV0zjwd/ZHC7rfUjpE
	 4pUCvb8NLRjhuSWYrmNdcONUQWpCuM9EIuQPYybH/NAB4qjSPgLty5hQu11jL4ZDUy
	 3LGExnG9u6BF8SPlcEmMi4hD6f3fIFvlQmDNNTC/KVoVfb+OlzvsQ29UWB5q0DbBnS
	 O4E43VtekqKcV+tpXWF/UKlXXeLTdFs8EbBA6VhOOAOMVK+UYiCmiOjuyGGPeDRPfa
	 LCMWAQuJ3XH+A==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y v2 5/5] net: dsa: mv88e6xxx: enable STU methods for 6320 family
Date: Tue, 29 Apr 2025 12:08:18 +0200
Message-ID: <20250429100818.17101-5-kabel@kernel.org>
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

commit 1428a6109b20e356188c3fb027bdb7998cc2fb98 upstream.

Commit c050f5e91b47 ("net: dsa: mv88e6xxx: Fill in STU support for all
supported chips") introduced STU methods, but did not add them to the
6320 family. Fix it.

Fixes: c050f5e91b47 ("net: dsa: mv88e6xxx: Fill in STU support for all supported chips")
Signed-off-by: Marek Behún <kabel@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20250317173250.28780-6-kabel@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 4218ed581409..211c219dd52d 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5213,6 +5213,8 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.reset = mv88e6352_g1_reset,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
+	.stu_getnext = mv88e6352_g1_stu_getnext,
+	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
@@ -5263,6 +5265,8 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.reset = mv88e6352_g1_reset,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
+	.stu_getnext = mv88e6352_g1_stu_getnext,
+	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
@@ -6258,6 +6262,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_internal_phys = 5,
 		.num_gpio = 15,
 		.max_vid = 4095,
+		.max_sid = 63,
 		.port_base_addr = 0x10,
 		.phy_base_addr = 0x0,
 		.global1_addr = 0x1b,
@@ -6283,6 +6288,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_internal_phys = 5,
 		.num_gpio = 15,
 		.max_vid = 4095,
+		.max_sid = 63,
 		.port_base_addr = 0x10,
 		.phy_base_addr = 0x0,
 		.global1_addr = 0x1b,
-- 
2.49.0


