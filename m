Return-Path: <stable+bounces-128679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EB2A7EAC3
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6697E3BB1DD
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D30264F96;
	Mon,  7 Apr 2025 18:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPDP/btP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45E1264F8C;
	Mon,  7 Apr 2025 18:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049653; cv=none; b=E+Pva6bZUiHBfh02VVewSfWesr6QqdTc5BLsU9bXwSPK+6047BTBCrjjEViwCHy3KVb2Pw3/r2zfHc27G8HYqT+dpm0428uxFFeAj2r2u4ACiNAdghVFt9eqWNpZWuV/kB6y7qBtMYwwqAZwkALLSMOws0dMXxkYn1XzvV6TxLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049653; c=relaxed/simple;
	bh=Yk5EVY6E2bB8THsuHW5DZrTErkIlJ64imF/RTteQeBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nIVZwKwboA9tiGIaADj9zliOJdOfvxFhMU+jNvcPXtc2NAm0SGh4aQzDimWHBTUHz8xEfWBq0BXdjCNO1hsRF1nSgFZydXV9rPVexRobr4loQm2+g9xH3FUPta9E+9lZs23BpysXeE9tgU2woL6+wqq2orytgdx3Xrk7KuheNcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPDP/btP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B09C4CEDD;
	Mon,  7 Apr 2025 18:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049653;
	bh=Yk5EVY6E2bB8THsuHW5DZrTErkIlJ64imF/RTteQeBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BPDP/btPGm16FTbfo37nbN17O1JT/86bdWzIvqeoEnWhzElBmG/biFz3mxnHi7T8/
	 g8JULbU9ZxCMTXdLAoXY3dM0LT8OINZgA6Nx8Jh1/OK0l5J4PveXRpMyUaEtqoSa9+
	 0kZeSwlkilys5OMQMab581vDwe3qfdX51K+fWT2D7uGZBWNidu754skVe0My/4CHHb
	 n36w0t8MUUJN9l9TMcyQ5HQH3SMa8kXcwffhR/59FSmBQhZ1H5EbxZKC2x2IyebI6D
	 J7nnAh92xbPjrpRSufOuxuyQB9Ld8hwPHg3kjruUxB9wPfXg/kQvua8+EEMTwPf9Ax
	 m8GAXNG5saCCg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.12 21/22] objtool, regulator: rk808: Remove potential undefined behavior in rk806_set_mode_dcdc()
Date: Mon,  7 Apr 2025 14:13:31 -0400
Message-Id: <20250407181333.3182622-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181333.3182622-1-sashal@kernel.org>
References: <20250407181333.3182622-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.22
Content-Transfer-Encoding: 8bit

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit 29c578c848402a34e8c8e115bf66cb6008b77062 ]

If 'ctr_bit' is negative, the shift counts become negative, causing a
shift of bounds and undefined behavior.

Presumably that's not possible in normal operation, but the code
generation isn't optimal.  And undefined behavior should be avoided
regardless.

Improve code generation and remove the undefined behavior by converting
the signed variables to unsigned.

Fixes the following warning with an UBSAN kernel:

  vmlinux.o: warning: objtool: rk806_set_mode_dcdc() falls through to next function rk806_get_mode_dcdc()
  vmlinux.o: warning: objtool: .text.rk806_set_mode_dcdc: unexpected end of section

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/2023abcddf3f524ba478d64339996f25dc4097d2.1742852847.git.jpoimboe@kernel.org
Closes: https://lore.kernel.org/oe-kbuild-all/202503182350.52KeHGD4-lkp@intel.com/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/rk808-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index 37476d2558fda..72df554b6375b 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -270,8 +270,8 @@ static const unsigned int rk817_buck1_4_ramp_table[] = {
 
 static int rk806_set_mode_dcdc(struct regulator_dev *rdev, unsigned int mode)
 {
-	int rid = rdev_get_id(rdev);
-	int ctr_bit, reg;
+	unsigned int rid = rdev_get_id(rdev);
+	unsigned int ctr_bit, reg;
 
 	reg = RK806_POWER_FPWM_EN0 + rid / 8;
 	ctr_bit = rid % 8;
-- 
2.39.5


