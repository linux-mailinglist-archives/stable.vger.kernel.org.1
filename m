Return-Path: <stable+bounces-25166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19822869802
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9881C234C7
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83342145334;
	Tue, 27 Feb 2024 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YKTDtgQU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E03D1448D7;
	Tue, 27 Feb 2024 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044048; cv=none; b=jXK1Pi36rsfH9LXn8VWHtXrWC4YVj09BNCWw0S22ndwd6uT3208tp3f+rsqWd6wEdpkWxukwVBzpY2rwobiOsIc/KUF5LOHScPczDhhr2fPJRAgwOMRCLk0mVC0JUkB4DRxGrcJV1hDh0xUjxCHz8iIUwPsCZi7La/KFaiUoo7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044048; c=relaxed/simple;
	bh=NMFCcU3frx9Hp2NRY6OezQlROsBaz6WfTBnYlN6qIbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KAwN5SyiIhI9Ld4AEN6c6gk2mnFVGNtN+lYVyaOXGfMo5vc/nR2zUt5ur2PRYoGvCHBK53wP06RLXOOCVAo+FOtRip41WhFYqr4fVnwwDs4sK1uheKAPmubpegYqL8PdUmuOdkTTbKMCcoT7JdpNJFLKG0dYCeZgQ1cHUBowp0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YKTDtgQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64343C433F1;
	Tue, 27 Feb 2024 14:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709044047;
	bh=NMFCcU3frx9Hp2NRY6OezQlROsBaz6WfTBnYlN6qIbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YKTDtgQUTTlGICRQY4aqaQy0EwBFjO+TJHHKKgixBYz6BBMeq5yjF09yiv0ojqchK
	 af1ZmYmHDuSeE0BXa+gZ/1NvthdQkNt3TMKG2TgzsYie/fAn9Ln5YBs6dMPMT1V8jP
	 RWrp1Vy9O2utIbHTDaDkVjDmHZya/PAjV8VpLW4A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 014/122] dmaengine: fsl-qdma: increase size of irq_name
Date: Tue, 27 Feb 2024 14:26:15 +0100
Message-ID: <20240227131559.173773727@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131558.694096204@linuxfoundation.org>
References: <20240227131558.694096204@linuxfoundation.org>
User-Agent: quilt/0.67
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vinod Koul <vkoul@kernel.org>

[ Upstream commit 6386f6c995b3ab91c72cfb76e4465553c555a8da ]

We seem to have hit warnings of 'output may be truncated' which is fixed
by increasing the size of 'irq_name'

drivers/dma/fsl-qdma.c: In function ‘fsl_qdma_irq_init’:
drivers/dma/fsl-qdma.c:824:46: error: ‘%d’ directive writing between 1 and 11 bytes into a region of size 10 [-Werror=format-overflow=]
  824 |                 sprintf(irq_name, "qdma-queue%d", i);
      |                                              ^~
drivers/dma/fsl-qdma.c:824:35: note: directive argument in the range [-2147483641, 2147483646]
  824 |                 sprintf(irq_name, "qdma-queue%d", i);
      |                                   ^~~~~~~~~~~~~~
drivers/dma/fsl-qdma.c:824:17: note: ‘sprintf’ output between 12 and 22 bytes into a destination of size 20
  824 |                 sprintf(irq_name, "qdma-queue%d", i);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/fsl-qdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index 69385f32e2756..f383f219ed008 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -805,7 +805,7 @@ fsl_qdma_irq_init(struct platform_device *pdev,
 	int i;
 	int cpu;
 	int ret;
-	char irq_name[20];
+	char irq_name[32];
 
 	fsl_qdma->error_irq =
 		platform_get_irq_byname(pdev, "qdma-error");
-- 
2.43.0




