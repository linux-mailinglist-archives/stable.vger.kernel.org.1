Return-Path: <stable+bounces-119214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6233FA42546
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 16:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1750189BA02
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54421A2393;
	Mon, 24 Feb 2025 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u9ARQ9Dg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714EE27701;
	Mon, 24 Feb 2025 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408706; cv=none; b=Smn8Azg6Cgzg+YK0VghMVCI6Garr+1e+r61/rvQlhNz7lNxi8w1doxn/uayMzMcv9XURo71JjBqGz5Som1THRS29ZcU87++vWGbfhat2Z22mAdLuAvpo0o2Bg0T80VkPSP4J6NEUsBByUHsL32+DzZF+xFTEepsdyJ4l+GOQJXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408706; c=relaxed/simple;
	bh=xZ4hU6OvAKqgPUrXR4TAn4VV7fKIdQSLMpdf6kco97A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fgQ+vyUJcsuAdYJS4suu4S0MrVnlFVe8mgGqrGOJWXKXSYhRltm33KCXHyYMLxYCobmJFNZzOPqJTnOdfK7cz9zS+PRUzEkjU2hq+PJ35/AgayTsiPF4SGYIQ8+Ca+kAb6/xyAZ5UUCt6RtdN5JzBxzJXsDCTHqrwIp2Lk52V7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u9ARQ9Dg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7C9C4CED6;
	Mon, 24 Feb 2025 14:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740408706;
	bh=xZ4hU6OvAKqgPUrXR4TAn4VV7fKIdQSLMpdf6kco97A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u9ARQ9DgkzSmlYgBnjULVhrJqwdFknCldIm0ImonLrVLczdBMWyJuWeXtRjfr5q/z
	 yREKH0BQRNQRt9RxTxM2Ka/aXndKqyRNI8Wdw2noYloxmWF7IzXr+Ko9eSLqOBXI5m
	 BMZNkFpeMsI+n5aIweOrLGtAnHW4w50oqPunj93E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	=?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Subject: [PATCH 6.12 137/154] mtd: spi-nor: sst: Fix SST write failure
Date: Mon, 24 Feb 2025 15:35:36 +0100
Message-ID: <20250224142612.414165290@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224142607.058226288@linuxfoundation.org>
References: <20250224142607.058226288@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>

commit 539bd20352832b9244238a055eb169ccf1c41ff6 upstream.

'commit 18bcb4aa54ea ("mtd: spi-nor: sst: Factor out common write operation
to `sst_nor_write_data()`")' introduced a bug where only one byte of data
is written, regardless of the number of bytes passed to
sst_nor_write_data(), causing a kernel crash during the write operation.
Ensure the correct number of bytes are written as passed to
sst_nor_write_data().

Call trace:
[   57.400180] ------------[ cut here ]------------
[   57.404842] While writing 2 byte written 1 bytes
[   57.409493] WARNING: CPU: 0 PID: 737 at drivers/mtd/spi-nor/sst.c:187 sst_nor_write_data+0x6c/0x74
[   57.418464] Modules linked in:
[   57.421517] CPU: 0 UID: 0 PID: 737 Comm: mtd_debug Not tainted 6.12.0-g5ad04afd91f9 #30
[   57.429517] Hardware name: Xilinx Versal A2197 Processor board revA - x-prc-02 revA (DT)
[   57.437600] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   57.444557] pc : sst_nor_write_data+0x6c/0x74
[   57.448911] lr : sst_nor_write_data+0x6c/0x74
[   57.453264] sp : ffff80008232bb40
[   57.456570] x29: ffff80008232bb40 x28: 0000000000010000 x27: 0000000000000001
[   57.463708] x26: 000000000000ffff x25: 0000000000000000 x24: 0000000000000000
[   57.470843] x23: 0000000000010000 x22: ffff80008232bbf0 x21: ffff000816230000
[   57.477978] x20: ffff0008056c0080 x19: 0000000000000002 x18: 0000000000000006
[   57.485112] x17: 0000000000000000 x16: 0000000000000000 x15: ffff80008232b580
[   57.492246] x14: 0000000000000000 x13: ffff8000816d1530 x12: 00000000000004a4
[   57.499380] x11: 000000000000018c x10: ffff8000816fd530 x9 : ffff8000816d1530
[   57.506515] x8 : 00000000fffff7ff x7 : ffff8000816fd530 x6 : 0000000000000001
[   57.513649] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
[   57.520782] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0008049b0000
[   57.527916] Call trace:
[   57.530354]  sst_nor_write_data+0x6c/0x74
[   57.534361]  sst_nor_write+0xb4/0x18c
[   57.538019]  mtd_write_oob_std+0x7c/0x88
[   57.541941]  mtd_write_oob+0x70/0xbc
[   57.545511]  mtd_write+0x68/0xa8
[   57.548733]  mtdchar_write+0x10c/0x290
[   57.552477]  vfs_write+0xb4/0x3a8
[   57.555791]  ksys_write+0x74/0x10c
[   57.559189]  __arm64_sys_write+0x1c/0x28
[   57.563109]  invoke_syscall+0x54/0x11c
[   57.566856]  el0_svc_common.constprop.0+0xc0/0xe0
[   57.571557]  do_el0_svc+0x1c/0x28
[   57.574868]  el0_svc+0x30/0xcc
[   57.577921]  el0t_64_sync_handler+0x120/0x12c
[   57.582276]  el0t_64_sync+0x190/0x194
[   57.585933] ---[ end trace 0000000000000000 ]---

Cc: stable@vger.kernel.org
Fixes: 18bcb4aa54ea ("mtd: spi-nor: sst: Factor out common write operation to `sst_nor_write_data()`")
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Bence Csókás <csokas.bence@prolan.hu>
[pratyush@kernel.org: add Cc stable tag]
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
Link: https://lore.kernel.org/r/20250213054546.2078121-1-amit.kumar-mahapatra@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/spi-nor/sst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index b5ad7118c49a..175211fe6a5e 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -174,7 +174,7 @@ static int sst_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
 	int ret;
 
 	nor->program_opcode = op;
-	ret = spi_nor_write_data(nor, to, 1, buf);
+	ret = spi_nor_write_data(nor, to, len, buf);
 	if (ret < 0)
 		return ret;
 	WARN(ret != len, "While writing %zu byte written %i bytes\n", len, ret);
-- 
2.48.1




