Return-Path: <stable+bounces-69501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27100956770
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D77B22832E7
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E176415D5B8;
	Mon, 19 Aug 2024 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y6G8J7Nq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFB615B14D
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724060857; cv=none; b=j0ml5hMbp9C2C/5cczS2+N+hvLhITH3+bpLNGI2DOHapSHCKsPRbQZu4TZyoAhyLESihQ1u+QPfMvbfL4lsppiEtMiTr5Xqckeffd7Yt1sYFORARHWgGxYfbOgg6qpC6uz3xfeNAIf+rc5NlNeqvBVlVziGQ1hLDllXa5xRBusk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724060857; c=relaxed/simple;
	bh=h31ecI91nVfliFk0/vaevO6nliImoBPXP1o5/EZb5Ps=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PmTfsX9Vp9s/+4sVt3hxHk5HPoRRZl26g3tLVtaQNH/Wwz1OF0IBWTObo/nHg6kY1Vm4N9FsRp1QtxfYj0Qoo4yfr55cTyR0MNZRjo6AaHXuw+aqru0nq0vglv7E6C1SO4mVpTcUr43ODE8g2wszTONi6r3jKWy6Zsv37/680Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y6G8J7Nq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51ABC32782;
	Mon, 19 Aug 2024 09:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724060857;
	bh=h31ecI91nVfliFk0/vaevO6nliImoBPXP1o5/EZb5Ps=;
	h=Subject:To:Cc:From:Date:From;
	b=Y6G8J7Nq3sKNi/7/SGH6WVXSAzuNJKp4444fPUgKZbknXwYq0rYyl0ezmV4kbsLYH
	 ywgwrwMLqxImAofUptQVjfkthAUmxpepDk9iBtPL5hI+PuQjUP8LO1uBZ3JhNK/mLA
	 kPr///gy9t7I+Gg1GcFRT/4cv+pRMgyEdJUTnsJE=
Subject: FAILED: patch "[PATCH] i2c: qcom-geni: Add missing geni_icc_disable in" failed to apply to 5.10-stable tree
To: andi.shyti@kernel.org,cuigaosheng1@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 11:47:26 +0200
Message-ID: <2024081926-thrower-salaried-4605@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 4e91fa1ef3ce6290b4c598e54b5eb6cf134fbec8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081926-thrower-salaried-4605@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

4e91fa1ef3ce ("i2c: qcom-geni: Add missing geni_icc_disable in geni_i2c_runtime_resume")
14d02fbadb5d ("i2c: qcom-geni: add desc struct to prepare support for I2C Master Hub variant")
d8703554f4de ("i2c: qcom-geni: Add support for GPI DMA")
357ee8841d0b ("i2c: qcom-geni: Store DMA mapping data in geni_i2c_dev struct")
9cb4c67d7717 ("Revert "i2c: i2c-qcom-geni: Fix DMA transfer race"")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4e91fa1ef3ce6290b4c598e54b5eb6cf134fbec8 Mon Sep 17 00:00:00 2001
From: Andi Shyti <andi.shyti@kernel.org>
Date: Mon, 12 Aug 2024 21:40:28 +0200
Subject: [PATCH] i2c: qcom-geni: Add missing geni_icc_disable in
 geni_i2c_runtime_resume

Add the missing geni_icc_disable() call before returning in the
geni_i2c_runtime_resume() function.

Commit 9ba48db9f77c ("i2c: qcom-geni: Add missing
geni_icc_disable in geni_i2c_runtime_resume") by Gaosheng missed
disabling the interconnect in one case.

Fixes: bf225ed357c6 ("i2c: i2c-qcom-geni: Add interconnect support")
Cc: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: stable@vger.kernel.org # v5.9+
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 365e37bba0f3..06e836e3e877 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -986,8 +986,10 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
 		return ret;
 
 	ret = clk_prepare_enable(gi2c->core_clk);
-	if (ret)
+	if (ret) {
+		geni_icc_disable(&gi2c->se);
 		return ret;
+	}
 
 	ret = geni_se_resources_on(&gi2c->se);
 	if (ret) {


