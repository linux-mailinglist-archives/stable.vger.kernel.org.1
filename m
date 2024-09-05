Return-Path: <stable+bounces-73175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC6496D38F
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 11:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A810728AF77
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DE319538D;
	Thu,  5 Sep 2024 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0M05Pv9X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92FE1925AA;
	Thu,  5 Sep 2024 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529387; cv=none; b=TXdruHqFlMPI2oxU+S1NlClfOSkwJ5XY5Sy2idxgOLGqrspj141sr1Szt8mizuzyEVsgs7qobQq4iGLNvzgFy2VDAKtzuL8cZ+i+9PGOxmcEzRDfIHU/YUYzV7Qb/naI94ISwTOYRwzjouhmVp44LEuDCnkkNyrzfPHIkJYwxb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529387; c=relaxed/simple;
	bh=KlX+dCXVYfkTD1ZCtyzG+8OmZTQZdStilDKNdnvBI+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvBsjQ7Ld0JLZQRPj5vSrsfR4WNmv1ZhKvIa+wGoSFrTSScAGQFJYIu5I5qhR6rjXg5hgNEwwh5AvVYVuR5osdgJdBXw40RO2IwtbwfrCtwgTckPnkbOXa/lYHQCep+yHznYwU18gImjGqEkVUsGR/v8NECEGFd20eEbyIvqA9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0M05Pv9X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61175C4CEC3;
	Thu,  5 Sep 2024 09:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725529387;
	bh=KlX+dCXVYfkTD1ZCtyzG+8OmZTQZdStilDKNdnvBI+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0M05Pv9XkE/FZIhzW/Vb5EE3aQBsBlREkbBbHes/McQu+ceQtD8GzX8Yt3nBOqFho
	 JNFJ0peceRQSJppnFVsj2MebIzX89Xbwzt3QFCJpfjfnp4T1eNDL/NhL69Bw0KuoNS
	 PE+3qf1B9CfFHnS6DxkAshcsaKwv43NwAA8qQMs8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Devyn Liu <liudingyuan@huawei.com>,
	Jay Fang <f.fangjian@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 017/184] spi: hisi-kunpeng: Add validation for the minimum value of speed_hz
Date: Thu,  5 Sep 2024 11:38:50 +0200
Message-ID: <20240905093732.919693301@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905093732.239411633@linuxfoundation.org>
References: <20240905093732.239411633@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Devyn Liu <liudingyuan@huawei.com>

[ Upstream commit c3c4f22b7c814a6ee485ce294065836f8ede30fa ]

The speed specified by the user is used to calculate the clk_div based
on the max_speed_hz in hisi_calc_effective_speed.  A very low speed
value can lead to a clk_div larger than the variable range. Avoid this
by setting the min_speed_hz so that such a small speed value is
rejected.  __spi_validate() in spi.c will return -EINVAL for the
specified speed_hz lower than min_speed_hz.

Signed-off-by: Devyn Liu <liudingyuan@huawei.com>
Reviewed-by: Jay Fang <f.fangjian@huawei.com>
Link: https://patch.msgid.link/20240730032040.3156393-2-liudingyuan@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-hisi-kunpeng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-hisi-kunpeng.c b/drivers/spi/spi-hisi-kunpeng.c
index 77e9738e42f60..6910b4d4c427b 100644
--- a/drivers/spi/spi-hisi-kunpeng.c
+++ b/drivers/spi/spi-hisi-kunpeng.c
@@ -495,6 +495,7 @@ static int hisi_spi_probe(struct platform_device *pdev)
 	host->transfer_one = hisi_spi_transfer_one;
 	host->handle_err = hisi_spi_handle_err;
 	host->dev.fwnode = dev->fwnode;
+	host->min_speed_hz = DIV_ROUND_UP(host->max_speed_hz, CLK_DIV_MAX);
 
 	hisi_spi_hw_init(hs);
 
-- 
2.43.0




