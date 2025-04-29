Return-Path: <stable+bounces-137641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E70AA1456
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3B01A83DE6
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610F724466C;
	Tue, 29 Apr 2025 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PEpoIJC9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F22A1DF73C;
	Tue, 29 Apr 2025 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946683; cv=none; b=c0bOFVxsPpG3L/sAxF/K87jBuC2oqb562mNKXF+c3yi2IrqAi8rbYiY+vPU6EY7IQYKe2eaKK2tuY6zruPa2jkZRgRiL5DBZZlTtLiWbOa9xJi6lwgzh33PcPvPmIcP57ei3J/vT7qUL5375Y98nG409y2tP+xVM+Qo6MeqejgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946683; c=relaxed/simple;
	bh=xxyAZyhfDGAiCWMJbCX7XtR2q2ndLPEJ5YfMq1uqXV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddm7waYnTpSDvTouz2vVaNf+4Fq3nvtnaMtins2tvpav4BTxXFb3oZUBfh8zc/7ms8Mp4xNN8C08xy7BwXD9kNFNcu3L+ZXGQifGX9mlhU4slibBr3aG1Bk/F7Q4n2cJfavVvS4d7WWIyVBT8atfk0c/Ppnc2jtrLyjCLpxd1w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PEpoIJC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F578C4CEE3;
	Tue, 29 Apr 2025 17:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745946682;
	bh=xxyAZyhfDGAiCWMJbCX7XtR2q2ndLPEJ5YfMq1uqXV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PEpoIJC9k4icAw3e02l/U2+4OoCR7moAGRPYOhoKkIcoBoWPBcu6EZDhXDVYF34Fv
	 hGsMn+Iyrly70ovjEwM64tColjzJNHlwCRws6QJ8YjoZ91mZvqhzOiiN5Xk+f8MNQZ
	 ck8GCmvMu/hSIK458fjNkvGz8xwLwr/q4INia35k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 006/286] ata: sata_sx4: Add error handling in pdc20621_i2c_read()
Date: Tue, 29 Apr 2025 18:38:30 +0200
Message-ID: <20250429161108.120415991@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161107.848008295@linuxfoundation.org>
References: <20250429161107.848008295@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit 8d46a27085039158eb5e253ab8a35a0e33b5e864 ]

The function pdc20621_prog_dimm0() calls the function pdc20621_i2c_read()
but does not handle the error if the read fails. This could lead to
process with invalid data. A proper implementation can be found in
/source/drivers/ata/sata_sx4.c, pdc20621_prog_dimm_global(). As mentioned
in its commit: bb44e154e25125bef31fa956785e90fccd24610b, the variable spd0
might be used uninitialized when pdc20621_i2c_read() fails.

Add error handling to pdc20621_i2c_read(). If a read operation fails,
an error message is logged via dev_err(), and return a negative error
code.

Add error handling to pdc20621_prog_dimm0() in pdc20621_dimm_init(), and
return a negative error code if pdc20621_prog_dimm0() fails.

Fixes: 4447d3515616 ("libata: convert the remaining SATA drivers to new init model")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/sata_sx4.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index 7b28334aa26a2..20b73e0d835a3 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -1124,9 +1124,14 @@ static int pdc20621_prog_dimm0(struct ata_host *host)
 	mmio += PDC_CHIP0_OFS;
 
 	for (i = 0; i < ARRAY_SIZE(pdc_i2c_read_data); i++)
-		pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
-				  pdc_i2c_read_data[i].reg,
-				  &spd0[pdc_i2c_read_data[i].ofs]);
+		if (!pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
+				       pdc_i2c_read_data[i].reg,
+				       &spd0[pdc_i2c_read_data[i].ofs])) {
+			dev_err(host->dev,
+				"Failed in i2c read at index %d: device=%#x, reg=%#x\n",
+				i, PDC_DIMM0_SPD_DEV_ADDRESS, pdc_i2c_read_data[i].reg);
+			return -EIO;
+		}
 
 	data |= (spd0[4] - 8) | ((spd0[21] != 0) << 3) | ((spd0[3]-11) << 4);
 	data |= ((spd0[17] / 4) << 6) | ((spd0[5] / 2) << 7) |
@@ -1290,6 +1295,8 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
 
 	/* Programming DIMM0 Module Control Register (index_CID0:80h) */
 	size = pdc20621_prog_dimm0(host);
+	if (size < 0)
+		return size;
 	dev_dbg(host->dev, "Local DIMM Size = %dMB\n", size);
 
 	/* Programming DIMM Module Global Control Register (index_CID0:88h) */
-- 
2.39.5




