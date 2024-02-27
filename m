Return-Path: <stable+bounces-24614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CB286956E
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0561C25292
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B71713DB83;
	Tue, 27 Feb 2024 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e+QFjeTe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7D213B2B4;
	Tue, 27 Feb 2024 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042507; cv=none; b=kAq5Y5/6Flwp4HhihmFFH49XouJPtcAAGx2xx5lXSjc1ql29hEWbuRJ5rNCGL+9cyWB9w0C2AR+7FHRJHTkOlozuFuyCr0NZgyM9urH/MGJZyZaIg0TsaPAFohGY56fvFJ8nachA9CsXwKqlH16GJTZl4wErLoA/qIoIG1uqngc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042507; c=relaxed/simple;
	bh=d+M3cslBYBg/v3RW6NhhaTuXaWMqSQPwJaQdy3qXUcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JwzCLUboFHwqea8Y/KqEWZOrFOYVLTKqa7XiGLqe0ZB/Trrd4HlhoWeeOGZVLBycjSOIG12rCg/j04nPb/i1al+SI0vgihPjOlqsC6opAc8c43NCJ7OvG7W/HptVSOF9y41E8gf6lErljnBx9FIhXRV9HuBPkeLoVB3y9b7QovI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e+QFjeTe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D591C433F1;
	Tue, 27 Feb 2024 14:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709042506;
	bh=d+M3cslBYBg/v3RW6NhhaTuXaWMqSQPwJaQdy3qXUcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e+QFjeTe1PiBrHpFDd4dsOu6nCATZIZsokYGNvs4Z/a8rusgMcZ2+Yw522Xyuv0EN
	 IT1ZhPh73smhlKiKhl5nK1dz/aCG6zew/2IputleB/KYGaTQLDUxkb540vf5akueqt
	 rNP+ITUUaRllihIpbhgBEF6qUluzApT6yx+gBpf0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 020/245] dmaengine: fsl-qdma: increase size of irq_name
Date: Tue, 27 Feb 2024 14:23:28 +0100
Message-ID: <20240227131615.773503427@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131615.098467438@linuxfoundation.org>
References: <20240227131615.098467438@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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




