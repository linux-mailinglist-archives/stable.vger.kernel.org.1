Return-Path: <stable+bounces-137024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 110F5AA081B
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A368E188DEDC
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 10:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DB829B77F;
	Tue, 29 Apr 2025 10:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNhZ0mu0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A531025D1F7
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 10:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921307; cv=none; b=S5fyDbWq8W99dPvStwfAL9lZcOr4c8/jKGy6uOgP4jiX95DvG9tbVE3p1UYZ9z+6mIJ79moRFC5K9ThU9u1ooLVeWhqF+3c2DCBzNRfS54c1jJYzcJdjgjCndlhwml9bEuLgrTwNbf2RtGE2UjDvEPooJeLu1tYGVZNdmUPCuho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921307; c=relaxed/simple;
	bh=GiNIZpAiooM4WvBLlhadc5kWXXq8ISi3k+90qXppeZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TprHYiPL6Cn7OMS0q1KSILonEjavW3tqeKEkqSwV3NGUXITmSI3OTP/XWC3NzkBhTH1WNFqiyX1okEHfFWwjYdnqSGLJF14n2m9jVjeTPkaJXWC2BC35eCbA1wrvWzTH2rI2JXGQXnCCKeXkoq/lYf1SRioM8zk8MnwFUYIROp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNhZ0mu0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989C6C4CEE3;
	Tue, 29 Apr 2025 10:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745921307;
	bh=GiNIZpAiooM4WvBLlhadc5kWXXq8ISi3k+90qXppeZA=;
	h=From:To:Cc:Subject:Date:From;
	b=rNhZ0mu0p/uQ6ANHTCt5v0F6dxXN1Jz6k/aklhHWUxzsl3j6rX/6HmSIS4GdRYtKU
	 ps70Re+0kkSmWpLo9fY6ljVMltkNfx/peA368RXrdg1xOPbg3O3edmq3PqH0s2InO+
	 e7ZreoVOBS3U/FgRm9qV0gRP6HO1fpnWoOwaoNjNtlM80k1M2e+JuTkjwUj34dBYaO
	 ho/V3yW8vFAZdINgGIxWY+uzkPqvyk0v7UQ5XrdCW5SlcqqS5lrKCXSRh0ZE/4L8zY
	 K5mxHituyzIpwIbfmGSNM0dT77LjB1KVE61piUpB8+cqeAB9mx+WSaSalqBr6JBgQx
	 1FdfkgDDaT98g==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 6.12.y v2 1/5] Revert "net: dsa: mv88e6xxx: fix internal PHYs for 6320 family"
Date: Tue, 29 Apr 2025 12:08:14 +0200
Message-ID: <20250429100818.17101-1-kabel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This reverts commit 2b27df6852444b76724f5d425826a38581d63407.

For stable 6.12 it was misapplied to wrong entries of the
`mv88e6xxx_table` array: instead of the MV88E6320 and MV88E6321 entries
it was applied to the MV88E6240 and MV88E6352 entries.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 28967a338aa9..720ff57c854d 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -6182,8 +6182,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_databases = 4096,
 		.num_macs = 8192,
 		.num_ports = 7,
-		.num_internal_phys = 2,
-		.internal_phys_offset = 3,
+		.num_internal_phys = 5,
 		.num_gpio = 15,
 		.max_vid = 4095,
 		.max_sid = 63,
@@ -6377,8 +6376,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_databases = 4096,
 		.num_macs = 8192,
 		.num_ports = 7,
-		.num_internal_phys = 2,
-		.internal_phys_offset = 3,
+		.num_internal_phys = 5,
 		.num_gpio = 15,
 		.max_vid = 4095,
 		.max_sid = 63,
-- 
2.49.0


