Return-Path: <stable+bounces-201225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BCFCC225C
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 588093075C07
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AF533D6DE;
	Tue, 16 Dec 2025 11:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i02CTFBt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68793233EE;
	Tue, 16 Dec 2025 11:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765883945; cv=none; b=kBmfNlBAH8B9zBQLr/2FPKnam6nQdiyHFV2ll/MmlhpsWIPae3Lij7jjqKlagdczeGMXglIRjF1+G8j1puSVbdM4KdgwCITUdiV17y60vUDMaY832a6f6pVFXwQ2nWxRRHmYlZeDRyrZ+ovcmVaCbzTH17laLSwTQouROzHEZxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765883945; c=relaxed/simple;
	bh=Fx4q+PBVj6NOh45lJklUVYh3wx1dgqwwkxnJJUIv/cA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NL/QUFRq99fpAMMEmDqfN80zdEVQouDnxkaiwrkqveVjlSUHzduSENmbupLXBR8pBPvHb310OBZ3qeouiYYvfhI8GNDqjF0lfp5wcHC4m5uleH3C81Re75BcLAK9OOo6BkaAltPOXH68tyTDfVkzGnrSwIa/uBplPQlbc4HxIdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i02CTFBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D11C4CEF1;
	Tue, 16 Dec 2025 11:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765883945;
	bh=Fx4q+PBVj6NOh45lJklUVYh3wx1dgqwwkxnJJUIv/cA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i02CTFBtODuM45x8msjdqnefWIIE5/NxTPNxqRbWSpDDi+MqovT2qd5SfnVflI2Dc
	 RbRPdhZxzuLh3f4Am/R8lPgqn0nBgiIxS+/Ahp/MNH0kPhedebw1y+yc1xsK0/dOZ3
	 +2SdNsswxbePUWxWwEWYHMLrswxJ6kGoNzBCjNEs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Francesco Lavra <flavra@baylibre.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 046/354] iio: imu: st_lsm6dsx: Fix measurement unit for odr struct member
Date: Tue, 16 Dec 2025 12:10:13 +0100
Message-ID: <20251216111322.583893590@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111320.896758933@linuxfoundation.org>
References: <20251216111320.896758933@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Francesco Lavra <flavra@baylibre.com>

[ Upstream commit c6d702f2b77194b62fb2098c63bb7f2a87da142d ]

The `odr` field in struct st_lsm6dsx_sensor contains a data rate
value expressed in mHz, not in Hz.

Fixes: f8710f0357bc3 ("iio: imu: st_lsm6dsx: express odr in mHZ")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index b4c6c31df837e..e9af7881e190d 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -383,7 +383,7 @@ enum st_lsm6dsx_fifo_mode {
  * @id: Sensor identifier.
  * @hw: Pointer to instance of struct st_lsm6dsx_hw.
  * @gain: Configured sensor sensitivity.
- * @odr: Output data rate of the sensor [Hz].
+ * @odr: Output data rate of the sensor [mHz].
  * @samples_to_discard: Number of samples to discard for filters settling time.
  * @watermark: Sensor watermark level.
  * @decimator: Sensor decimation factor.
-- 
2.51.0




