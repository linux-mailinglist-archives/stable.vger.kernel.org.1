Return-Path: <stable+bounces-128598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE19A7E9B7
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FCA43AA4C8
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6902D221703;
	Mon,  7 Apr 2025 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IazVlB9o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D52D2192EC;
	Mon,  7 Apr 2025 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049460; cv=none; b=hEKql3bEs8jl9Mp2uRL1ZNCnvNRQTtAljHX+Ta7VbH5yhWcxs7lW6UUqGfA62c22Bu0qaxE6F/B6Fnhu/2hZvG2nN8rgxtrg/rKPMm5FbmOleab34UzmNR9wov8xRhFbmR6d9hGlMC9lr79xOKTDpqoWQiKyGUS+5VcRGyN/pNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049460; c=relaxed/simple;
	bh=1n8w72QUH2UGgtG9x7UIbDqk/81YUoHFqZ/HuioKmpw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hrGcqYjq4NUGgfbAaswXFTJD6id6slNTxc41TmnsgBzSwaqJMPY3PgJ47mRJmW/3NKJiu8NVNymwMpbLCOO/MGBkL8ijOxQre4us/iBnuk9Bwrkifo8UTN8nKuPn31DaK4xPmH0m9HOw2gnzBQCIAaFvcUXnp0SfwCR/0GR1930=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IazVlB9o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79174C4CEE9;
	Mon,  7 Apr 2025 18:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049459;
	bh=1n8w72QUH2UGgtG9x7UIbDqk/81YUoHFqZ/HuioKmpw=;
	h=From:To:Cc:Subject:Date:From;
	b=IazVlB9ooZbzKQmBkVvfMj6eRbS3l6G7+I1qu+SV4NIjHzNyYa0IeUu7NTrxms4me
	 jrIoM03huOfwwqidkrxoyApQ4pvhTw6mMKu8FuNsP+BYJkSeU/j+aE2fEOsx2j9B5T
	 4CNbQoZAqmJo7ekqZ2ginu4YC0duY/9Sff2/rvqTNcuIxeJlgIW6dQAon9bh5F3iRo
	 fuqE+fwF/pktDXc4kyUAh+95k7F9ZWgGrd2R2b+bFSe/aaeZuD5nEjgjGg++98Kd6m
	 z5yKncHarxdjj/cgOAy5DBVRx3ry04Cvyrsu3Qkr87KhXxuiztS96ZtFrfbSb6SXHN
	 SHqRjTLXD/AYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Julia Lawall <julia.lawall@inria.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	dan.carpenter@linaro.org,
	arnd@arndb.de,
	salwansandeep5@gmail.com,
	roheetchavan@gmail.com,
	matchstick@neverthere.org,
	linux-staging@lists.linux.dev
Subject: [PATCH AUTOSEL 6.14 01/31] staging: gpib: Use min for calculating transfer length
Date: Mon,  7 Apr 2025 14:10:17 -0400
Message-Id: <20250407181054.3177479-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
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

From: Dave Penkler <dpenkler@gmail.com>

[ Upstream commit 76d54fd5471b10ee993c217928a39d7351eaff5c ]

In the accel read and write functions the transfer length
was being calculated by an if statement setting it to
the lesser of the remaining bytes to read/write and the
fifo size.

Replace both instances with min() which is clearer and
more compact.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/r/202501182153.qHfL4Fbc-lkp@intel.com/
Signed-off-by: Dave Penkler <dpenkler@gmail.com>
Link: https://lore.kernel.org/r/20250120145030.29684-1-dpenkler@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/gpib/agilent_82350b/agilent_82350b.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
index 3f4f95b7fe34a..0ba592dc98490 100644
--- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
+++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
@@ -66,10 +66,7 @@ int agilent_82350b_accel_read(gpib_board_t *board, uint8_t *buffer, size_t lengt
 		int j;
 		int count;
 
-		if (num_fifo_bytes - i < agilent_82350b_fifo_size)
-			block_size = num_fifo_bytes - i;
-		else
-			block_size = agilent_82350b_fifo_size;
+		block_size = min(num_fifo_bytes - i, agilent_82350b_fifo_size);
 		set_transfer_counter(a_priv, block_size);
 		writeb(ENABLE_TI_TO_SRAM | DIRECTION_GPIB_TO_HOST,
 		       a_priv->gpib_base + SRAM_ACCESS_CONTROL_REG);
@@ -200,10 +197,7 @@ int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size_t leng
 	for (i = 1; i < fifotransferlength;) {
 		clear_bit(WRITE_READY_BN, &tms_priv->state);
 
-		if (fifotransferlength - i < agilent_82350b_fifo_size)
-			block_size = fifotransferlength - i;
-		else
-			block_size = agilent_82350b_fifo_size;
+		block_size = min(fifotransferlength - i, agilent_82350b_fifo_size);
 		set_transfer_counter(a_priv, block_size);
 		for (j = 0; j < block_size; ++j, ++i) {
 			// load data into board's sram
-- 
2.39.5


