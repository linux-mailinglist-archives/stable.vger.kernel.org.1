Return-Path: <stable+bounces-128656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 917C2A7EA60
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5297169F41
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BE425EF80;
	Mon,  7 Apr 2025 18:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="copwI5gC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1C125E809;
	Mon,  7 Apr 2025 18:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049610; cv=none; b=YmSRSG8ZwIU9uvP8XwJUZeT0kSOd4MLG+9sC/SS5foPypBvDqqwcm32p/ZOBZiHqSdJCMlkNU47mSYKsTU8SK/mUQHYstZxp47lTW+efzW9QzXtOkCc+hJjFdfKIMKd29K9qlNZChhoAP7loHcwqfhCBi2/61GLmk8sLZoGPQRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049610; c=relaxed/simple;
	bh=hBaaj1nTo1SgjcQoM2Q/Cyz2eZC7bi2TFJb0w4ZXLo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QH+G9oI8nrX2CZaEsl7xALfeCOxOdZjCOR2RhIo3fba5JijdrvZij9t7Sj0KPVXeQGGI77VwljdtrOvzbELJ5YL7wTOAMhN378aj6EMDgDfqHXPSEVZJPDRJ3ZhPdW8zrjDzNrsPK3WDiV1UREjK5JLfoH7KKLvL5Et5QYhJD4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=copwI5gC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1058AC4CEEC;
	Mon,  7 Apr 2025 18:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049610;
	bh=hBaaj1nTo1SgjcQoM2Q/Cyz2eZC7bi2TFJb0w4ZXLo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=copwI5gCAOI73PoW/anzH0VwJ/OqzbQPC0NmvfoMWX2YKfwsTo1eY8WO/ZQIRrNaA
	 hsOk2HTsQc+lY80g345tgOwCzYtApZslfruAo02gXhaOSDQLb+AGgqPDK26Rmi/j1W
	 nM7KgyBjevCZlIf58flbjSLar2ctX+s7DWqQgOxpxvgD1HFBUBF37FmAOvM1doSGLR
	 LtP9yxOvung6Hb3g0fg+Cy/86zb2WafVRbovwdhAsmGXZvjYSixw3Y9IDhwz0jMRdV
	 fk4/667G3mXxQv70hTa5DxJanqvoSvmDbqYT8j5c45ZsYBHTigMCVbLs9wHauwnU5y
	 SBxeko2mFYMnA==
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
Subject: [PATCH AUTOSEL 6.13 27/28] objtool, regulator: rk808: Remove potential undefined behavior in rk806_set_mode_dcdc()
Date: Mon,  7 Apr 2025 14:12:17 -0400
Message-Id: <20250407181224.3180941-27-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181224.3180941-1-sashal@kernel.org>
References: <20250407181224.3180941-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.10
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


