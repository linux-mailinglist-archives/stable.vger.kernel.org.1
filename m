Return-Path: <stable+bounces-114659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A67D4A2F0F0
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 16:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BFA216353A
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E6F1F8BD0;
	Mon, 10 Feb 2025 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YYw+S3uH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ED21F8BAA
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200108; cv=none; b=DAQnuBh3STpJ3ArR7+p2P6osKJg39g/n4F23AtgKldIYM6jEsjoW6KYxErTWY+AN+XEkVoe2EDlbsS91vkjG7mnlbILPXJyiVn/3WjXCtNjwfsvHL0v2pDXWYC2zkst/hZKEBbzGAwYVCrE9cQIU92ToHrLkzswBW3N930IWCMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200108; c=relaxed/simple;
	bh=Q+C4Y+f5N2zEZR743fqKiIikcfq0NwUPlTNVOarHKUQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=o+ytATuWh6VguZrDcpfBI+hjcWzt8YJptGu9ChAMIL1i7ioHcG66v53VJwP3lZYlApGQS/g0/cJFa5poCJodB2Wz/Dyabpt/U83s6/1w5T/TQpFUteFYBt70cyVOt/AEDFCtHU5pusPliAAUWhBrlhP0xOAfBVzlBIwUEmWklBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YYw+S3uH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C2FC4CED1;
	Mon, 10 Feb 2025 15:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739200107;
	bh=Q+C4Y+f5N2zEZR743fqKiIikcfq0NwUPlTNVOarHKUQ=;
	h=Subject:To:Cc:From:Date:From;
	b=YYw+S3uH6am7u08LInHJJeOUc8uqWCZcGRrW+0opgNZ08UDhDH/PAvQoFg9kFuKkx
	 QK7BcvRLWGy8FD+sSCJldUry4+SIbw8WO//N9OFI6a320n7CQta2uPEqIFsZci7KdQ
	 iX0iazUf/61WFVXgr13bKHxByMWGclKi2+1Il5+c=
Subject: FAILED: patch "[PATCH] soc: mediatek: mtk-devapc: Fix leaking IO map on driver" failed to apply to 6.1-stable tree
To: krzysztof.kozlowski@linaro.org,angelogioacchino.delregno@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 16:08:13 +0100
Message-ID: <2025021013-trinity-yearling-c7bf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c9c0036c1990da8d2dd33563e327e05a775fcf10
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021013-trinity-yearling-c7bf@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c9c0036c1990da8d2dd33563e327e05a775fcf10 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 4 Jan 2025 15:20:12 +0100
Subject: [PATCH] soc: mediatek: mtk-devapc: Fix leaking IO map on driver
 remove

Driver removal should fully clean up - unmap the memory.

Fixes: 0890beb22618 ("soc: mediatek: add mt6779 devapc driver")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20250104142012.115974-2-krzysztof.kozlowski@linaro.org
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
index 500847b41b16..f54c966138b5 100644
--- a/drivers/soc/mediatek/mtk-devapc.c
+++ b/drivers/soc/mediatek/mtk-devapc.c
@@ -305,6 +305,7 @@ static void mtk_devapc_remove(struct platform_device *pdev)
 	struct mtk_devapc_context *ctx = platform_get_drvdata(pdev);
 
 	stop_devapc(ctx);
+	iounmap(ctx->infra_base);
 }
 
 static struct platform_driver mtk_devapc_driver = {


