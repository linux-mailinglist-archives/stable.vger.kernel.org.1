Return-Path: <stable+bounces-84306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB6299CF84
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB331C23320
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFE01AED3F;
	Mon, 14 Oct 2024 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rmxjgDSP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0631B4F08;
	Mon, 14 Oct 2024 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917556; cv=none; b=R9zX5/2TBtrv8ouEdSoxhsYuIXjKp59Dqr9mSnBGJIQoZ0KEB7IApHOqXtDpwmTCKFxKh92fxh7/lv8K6wrEHm92i8qz5K6Q34mDeqvBrAE9JzR35UqYERmhJ0Ar6+JR+z0JIauHKmAmGz4bvby2bfCDmWsF5W8TEtsEqguaxng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917556; c=relaxed/simple;
	bh=lKb4nYVNhiHarocbvSonVmMTHmZwHoMTnNoxhZ5XE24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SrY2CL73xrhN2OesqFf14WpahUQBrHJb1qVINHDb3UO9Q/kQxrdSBJsjOCrZ9zu8Dewj29icZElkxZ7yBcgywyPGzRZMMxMEbhfmg5GXFOylzVzuttqjPC5CMy+IHdfndrpH9olpyOnAV5GFpawxfRZqeg4Bhdoo9e/b21Ag1Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rmxjgDSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3744BC4CEC3;
	Mon, 14 Oct 2024 14:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728917556;
	bh=lKb4nYVNhiHarocbvSonVmMTHmZwHoMTnNoxhZ5XE24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rmxjgDSPg5Z7S2/arUhSqeIgkiZaUNzGJC9rGsEOq9hWy7/2ywawU32NmSuTDZgd7
	 Rs6zAwgGp5ogeJRuaHM66LH0sXrYOb2NTAZ4h5Fp2QtcSyWuJIBNDmmSgX0ZTt7drX
	 pUB2Mkwmu6muwedGivnS5Ky/6BLykvbhi/9eC8LE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Ke <make24@iscas.ac.cn>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 068/798] spi: ppc4xx: handle irq_of_parse_and_map() errors
Date: Mon, 14 Oct 2024 16:10:22 +0200
Message-ID: <20241014141220.611614791@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ma Ke <make24@iscas.ac.cn>

[ Upstream commit 0f245463b01ea254ae90e1d0389e90b0e7d8dc75 ]

Zero and negative number is not a valid IRQ for in-kernel code and the
irq_of_parse_and_map() function returns zero on error.  So this check for
valid IRQs should only accept values > 0.

Fixes: 44dab88e7cc9 ("spi: add spi_ppc4xx driver")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Link: https://patch.msgid.link/20240724084047.1506084-1-make24@iscas.ac.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-ppc4xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index 1179a1115137f..edfe0896046f9 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -411,6 +411,9 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 
 	/* Request IRQ */
 	hw->irqnum = irq_of_parse_and_map(np, 0);
+	if (hw->irqnum <= 0)
+		goto free_host;
+
 	ret = request_irq(hw->irqnum, spi_ppc4xx_int,
 			  0, "spi_ppc4xx_of", (void *)hw);
 	if (ret) {
-- 
2.43.0




