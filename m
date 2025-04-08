Return-Path: <stable+bounces-129797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A674A80109
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B4847A82DD
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1CD2676DE;
	Tue,  8 Apr 2025 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rCQ9oeKq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B77926658B;
	Tue,  8 Apr 2025 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112005; cv=none; b=YjbRMUrcM2GewhfcMeUO9ejOze+aqIvciFE+i1cN0MTuGKbdCgBVFdg1Z2diM8Mqzp++u+BIzcdJs9xpkYvqH4AjWOHt/7qelzy97+vOiNSBmp/5QWz4jp4WEnz13uO//5+7YF+Rw+T0gQwfmwS7XV+foHhGzyBF6qQpGqkw96E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112005; c=relaxed/simple;
	bh=hRJ7WE9per4BhrkMe2NPFKEGH4WQkTDIhXKUcKH/PXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoHf/gW6nOkEwxMkBwLLVX4XtuyWwLdoflM2tsBKWNct1e9BfnkIa2Xgi3X/R7osgSHAu/FIy7b249/pFzhru+9VuJ15qyT4HU8iPECms7o+GB2sGH8VT8D7rDbnebHzByGnm8jXeZ/H2u4oEKTLg48nHvMO1MpBNjmQhhM28c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rCQ9oeKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB059C4CEE5;
	Tue,  8 Apr 2025 11:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744112005;
	bh=hRJ7WE9per4BhrkMe2NPFKEGH4WQkTDIhXKUcKH/PXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rCQ9oeKqXtMFNmjuwenb7WXKRcMtOBLoLfP/8UuSZv4MC+yX2XnCGnwjvgKNSGyl8
	 HxAb2WNZgzjk+QV/7/nmK0ey3HtepBPm8rStNKz7pZ2cVE8S8/dbHkR2f+3E2LwR+Q
	 Wuon6MKYY2fQscZjkPoF+NNGZgFX/1eYFYthJWBI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 601/731] spi: cadence: Fix out-of-bounds array access in cdns_mrvl_xspi_setup_clock()
Date: Tue,  8 Apr 2025 12:48:18 +0200
Message-ID: <20250408104928.252201645@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit 7ba0847fa1c22e7801cebfe5f7b75aee4fae317e ]

If requested_clk > 128, cdns_mrvl_xspi_setup_clock() iterates over the
entire cdns_mrvl_xspi_clk_div_list array without breaking out early,
causing 'i' to go beyond the array bounds.

Fix that by stopping the loop when it gets to the last entry, clamping
the clock to the minimum 6.25 MHz.

Fixes the following warning with an UBSAN kernel:

  vmlinux.o: warning: objtool: cdns_mrvl_xspi_setup_clock: unexpected end of section .text.cdns_mrvl_xspi_setup_clock

Fixes: 26d34fdc4971 ("spi: cadence: Add clock configuration for Marvell xSPI overlay")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503282236.UhfRsF3B-lkp@intel.com/
Link: https://lore.kernel.org/r/gs2ooxfkblnee6cc5yfcxh7nu4wvoqnuv4lrllkhccxgcac2jg@7snmwd73jkhs
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/h6bef6wof6zpjfp3jbhrkigqsnykdfy6j4qmmvb6gsabhianhj@k57a7hwpa3bj
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-cadence-xspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index aed98ab143346..6dcba0e0ddaa3 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -432,7 +432,7 @@ static bool cdns_mrvl_xspi_setup_clock(struct cdns_xspi_dev *cdns_xspi,
 	u32 clk_reg;
 	bool update_clk = false;
 
-	while (i < ARRAY_SIZE(cdns_mrvl_xspi_clk_div_list)) {
+	while (i < (ARRAY_SIZE(cdns_mrvl_xspi_clk_div_list) - 1)) {
 		clk_val = MRVL_XSPI_CLOCK_DIVIDED(
 				cdns_mrvl_xspi_clk_div_list[i]);
 		if (clk_val <= requested_clk)
-- 
2.39.5




