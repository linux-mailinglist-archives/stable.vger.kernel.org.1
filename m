Return-Path: <stable+bounces-128627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3F6A7E9FB
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 229FF189B5EE
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559E6259498;
	Mon,  7 Apr 2025 18:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKxBU7Re"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B769258CFE;
	Mon,  7 Apr 2025 18:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049536; cv=none; b=Uba2b/Y1gwie5iddkQ4/akqIsvIqS11rn6gFCGH9/EmodEdr4DQIzp+gu0MpDobuoi3rwg9XwpIgzM11ztgpqfdT3HAO9qupzLxGsoYGDfs7MhTFFu3qHEMK7DEYNc0Mti/RMNUPojpTi1vfZBM7pm9vKs3Yg6r5B7D9Frt+i5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049536; c=relaxed/simple;
	bh=hBaaj1nTo1SgjcQoM2Q/Cyz2eZC7bi2TFJb0w4ZXLo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CElIBZw0zvlyohXW5Oi48D2tvFrjaAZevWMKb4t1xPu7MILWkv9pJvehoE9kcpk9/Qovwq9eRdSbwxtg5Tz0xmwPFTDcXk2xKruBirWI4/8wQ76DW4am66ViwqJrt3ZMsN7dOe38mOsf9zZ4jgaLkkMFt7yiNcsTkHnw/Er561Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKxBU7Re; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFCAC4CEE7;
	Mon,  7 Apr 2025 18:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049535;
	bh=hBaaj1nTo1SgjcQoM2Q/Cyz2eZC7bi2TFJb0w4ZXLo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VKxBU7Re2NWpw7gpWnplcO32uRHb+QbrQuBYNGqpwkuEuy0ztFU4vAyfeXVXYEr2t
	 2gOBI0gw0VHgDtf/8FfexUC2R6+L8D38ZdyJLHJNBgSt96BQMdSGzTXRsWcWWDYY6z
	 TNkr4fSbt6FeVODChdRstoUBW7cs8cMYkkVfh3SAXemCvvNfyK31ObN/kGwy94i6i4
	 69hIsDt9mjTi14WFfrH3/4LwS0WztrUyg15w0X55SfoY6FBylICh9royry3g+ZPWqL
	 Jv6HLSE1yHy4SpyeEoecGBYipqgy9x6Pus9rkvWjConwr8Zh4jEPsmn0epsruu+xnm
	 kwrDOtZiqELCA==
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
Subject: [PATCH AUTOSEL 6.14 30/31] objtool, regulator: rk808: Remove potential undefined behavior in rk806_set_mode_dcdc()
Date: Mon,  7 Apr 2025 14:10:46 -0400
Message-Id: <20250407181054.3177479-30-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181054.3177479-1-sashal@kernel.org>
References: <20250407181054.3177479-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.1
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
index 7d82bd1b36dfc..1e8142479656a 100644
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


