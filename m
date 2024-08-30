Return-Path: <stable+bounces-71655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE8396638E
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 16:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77671F243FC
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 14:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0291AF4FE;
	Fri, 30 Aug 2024 13:59:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79921B013F;
	Fri, 30 Aug 2024 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725026399; cv=none; b=X6gBUh9LGJvsSIzoE3YTQt3eVOW86mBJ6QHvwmOgRUvnp3NUoifot6JBFw0IwMuhMRyWnL7qSSbdlk402e8MlKc9+uymhuKo19XxOU43LQX6Raod1g6fbse0jVewJCS4zImGflX57xr0JDdyQxd4txkDC3NzdejPzzY2Yq3NqK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725026399; c=relaxed/simple;
	bh=bselyroxCpJGOSKatFYEgv8MGFuDJbZUWr4MgP+zWbo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lhnBxwqi/3VUhFyhqrIlOtjT0AxDrcBEuLP8eSW5AUNVPy27jZATMh7P/B/fRg7OlDJ3VKuT5dRkt9wl0FATszMWFjhnWA2/6oY1RTfXU7QIlIWZPQJQWoBbdyDdoLcIqwiFTnF4TmaMDksoFH3q8vZQx8a1ooBOs7tYwDI9GOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowAD33zpQ0NFmzL19Cw--.1712S2;
	Fri, 30 Aug 2024 21:59:50 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: broonie@kernel.org,
	grant.likely@secretlab.ca,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] powerpc/5200: handle irq_of_parse_and_map() errors
Date: Fri, 30 Aug 2024 21:59:43 +0800
Message-Id: <20240830135943.3443245-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD33zpQ0NFmzL19Cw--.1712S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JrWfuF17Kr4DCryUGr17KFg_yoWDXrcEka
	12gry7XrW8AFs3t3WSgr4rZryjqr4fAF1vq3yDta9xK39xuFyIvr4v9F98WFsrCryUAFyx
	C3y7GryUArn3JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUjJ3vUUUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Zero and negative number is not a valid IRQ for in-kernel code and the
irq_of_parse_and_map() function returns zero on error.  So this check for
valid IRQs should only accept values > 0.

Cc: stable@vger.kernel.org
Fixes: 42bbb70980f3 ("powerpc/5200: Add mpc5200-spi (non-PSC) device driver")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/spi/spi-mpc52xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index d5ac60c135c2..b49155a25694 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -472,7 +472,7 @@ static int mpc52xx_spi_probe(struct platform_device *op)
 	INIT_WORK(&ms->work, mpc52xx_spi_wq);
 
 	/* Decide if interrupts can be used */
-	if (ms->irq0 && ms->irq1) {
+	if (ms->irq0 > 0 && ms->irq1 > 0) {
 		rc = request_irq(ms->irq0, mpc52xx_spi_irq, 0,
 				  "mpc5200-spi-modf", ms);
 		rc |= request_irq(ms->irq1, mpc52xx_spi_irq, 0,
-- 
2.25.1


