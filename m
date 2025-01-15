Return-Path: <stable+bounces-109129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 895B6A1228A
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 12:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCBD7188EB97
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E658B1EEA5F;
	Wed, 15 Jan 2025 11:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="f6f9iEGe"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEE01E9910
	for <stable@vger.kernel.org>; Wed, 15 Jan 2025 11:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736940498; cv=none; b=mUwoWkWpDK5wPlKIPspEM6qFa4GgwO+E3sf2S0SWSyNbbeGaNGnqWtOItT0Gc6N4uXkUk3VTUw7et8DZW445U35cG5ZHcAsR5Ko5Xd3heCDsW36Y1alzaeYPoqvbeT49uWimzsh8DW0hFp8Xhf6jk58uX2CDEGcnEpOkYODVYVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736940498; c=relaxed/simple;
	bh=oB7udLPL30IO659T41Bgn8a12hkKyiXIMEJp5/vfgZQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=gXLVtyLIfcF8tRINyqUOuc0JPtriEa8bghlI6UglfpR+gmVTUEmOChfgy7r0KU+rmzx0klCFN40J0TI41QhzhvGsMYOAuhsETR8vd5T3xoADlqM8v7oPFx+3a28j3JK0TzpJ0GEDyZD/9CNhZzuaIlSv7knYDytruA5zXpHrAfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=f6f9iEGe; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736940184; bh=GT2YRhEBNK6XLXso2yAEHT9wHS+FTpk4KK5cpVL08TM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f6f9iEGeaFigzGjIttsKq/SAnWNFKdHVWExZCSi0pErLy6hqAyC48FyIx45VN81gh
	 9FH7bFgKv2hEmV4+cKCTPDVssPn/LJ6NW+QOP30oC+Gr6j5s+nrNrKo4dg6/CRqgsq
	 +Jse6L+5EeuzS+49JqNTdOZV0coATyp+l4sd/Qe8=
Received: from pek-blan-cn-l1.corp.ad.wrs.com ([120.244.194.130])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 5B38F078; Wed, 15 Jan 2025 19:22:51 +0800
X-QQ-mid: xmsmtpt1736940171tzj1938as
Message-ID: <tencent_D8E19A36BCE6EAA35572DF7A17470906AD05@qq.com>
X-QQ-XMAILINFO: M5WvXNp9ZPrQPKGM+FDFPuV+FFynVo0WuvtTeBswgD0gC5gqfbp53br1Wgn7QI
	 XWt+xvZQAqvutVf1IuHYlLJJA0NLXLA/xwzvdIMH9Bw8FDvaxsMIjZQqH+S/TsxktqgYtPLgqDOV
	 lFPBPFQJ/oJZTjh2vTCGe5NvXJkLExPtmwOJZvLalStXt/0pvF6un4BBSAxcjnq+1+tlJHFjcKZS
	 1SHjSC0O3t+QZVoHPFm4Womer4RqCq3Y+BTqGpmnx4bZVsmNr3bJZyOrXwDEdtTvB5EyqPaSBREW
	 VCnAOZPHEZFvbc2b/VAu+diBd0Y4rjsbPgzaRXc8Dpcs9gE+lVXDKZHCIdAWXzPkzHZSwwH6352x
	 B2WsBUj1UZPPR5QSMCczzGjElY22H3rUdWWkmBo9yVlu/eva/WJtByGVm8sJ6KSTwSypn6mN9HYy
	 EJuOa01DS1lxyto/0TELT2YC7+rn3nUeVKCmd+qshlSUA4BUbop+bKbDtQKHmXHu1HDuoev11vXA
	 V+wjqhU6hN06hCrC+5y85JL4mDqSXdool2S94/X8aipPG8k9INXXDgOVIxkw180XAq0ctzWdnlaD
	 5TBMFd6g1o+UP81YdDvKJzdqR/e2eGZM2qw3HH5spPlmJVyS9etobj4MXEvOcYkVo8GnJsTZsiEt
	 jqIRM22T1aHZC7cSVfSIMeZH9pguXQEY9XRejgPdZg6JDc9afMLg1zOOS7z7ZkCFOoWumfeeuFOM
	 TmP+xVW2rkguHclgl4oCrp39+OqO2OH5DleUNJkd4I4fIaGM4Jjug9j0StMgfxYvcC5yiK4ICoIH
	 YB0eb+mnQYTW32fqgWxSYaPcM8rh+aCfNyUUQ83taZ52DiGQlhEqLfX2/6K+VKN2jNk15ARQvp2y
	 oGJBcFl1Ey4gJf2NjYyTaTXUuFElMXI5xzjCJa+wAXOdVHFRakqBdlFcJLID4ShOwayESA9faf/v
	 ZjJiiPb8GtdPGp8W+d5vd8KPVHvP46FM2o3Tju/oe0kqQbTyqgUBZs9QNC7R6Aes4bnvHd9hrQ+H
	 WDFMwq9mf/0vFihSqeo+6aXSOE5SrKpY1wYOAa87KKDFip/n7Agm7oOPkZkrEyjIzDgCwIeg==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: lanbincn@qq.com
To: stable@vger.kernel.org
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bin Lan <lanbincn@qq.com>
Subject: [PATCH 5.10.y] iio: adc: rockchip_saradc: fix information leak in triggered buffer
Date: Wed, 15 Jan 2025 19:22:51 +0800
X-OQ-MSGID: <20250115112251.2504-1-lanbincn@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025011310-ruckus-ceramics-7ebc@gregkh>
References: <2025011310-ruckus-ceramics-7ebc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

commit 38724591364e1e3b278b4053f102b49ea06ee17c upstream.

The 'data' local struct is used to push data to user space from a
triggered buffer, but it does not set values for inactive channels, as
it only uses iio_for_each_active_channel() to assign new values.

Initialize the struct to zero before using it to avoid pushing
uninitialized information to userspace.

Cc: stable@vger.kernel.org
Fixes: 4e130dc7b413 ("iio: adc: rockchip_saradc: Add support iio buffers")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://patch.msgid.link/20241125-iio_memset_scan_holes-v1-4-0cb6e98d895c@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
(cherry picked from commit 38724591364e1e3b278b4053f102b49ea06ee17c)
Signed-off-by: Bin Lan <lanbincn@qq.com>
---
 drivers/iio/adc/rockchip_saradc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 12584f1631d8..deb58e232770 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -254,6 +254,8 @@ static irqreturn_t rockchip_saradc_trigger_handler(int irq, void *p)
 	int ret;
 	int i, j = 0;
 
+	memset(&data, 0, sizeof(data));
+
 	mutex_lock(&i_dev->mlock);
 
 	for_each_set_bit(i, i_dev->active_scan_mask, i_dev->masklength) {
-- 
2.43.0


