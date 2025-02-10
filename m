Return-Path: <stable+bounces-114657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0430DA2F0EE
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 16:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8BF6162823
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B961F8BB0;
	Mon, 10 Feb 2025 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sbfy6kzQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C321F8BAA
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200096; cv=none; b=YTXr4+VGqhNMRETg4V2Fi4vOXMbJD3HdNJsZc3zXVQ0pv6CcLIGASwnONs/W/peSA/TmnrdY3rMEFD6MTcRs0phUnbeVLVLy8fAy7id1ffjh2mf5Rmz3jMUtFtjDzMt2C+/UfuyfcJvgE74fgjOOJIaiNOfyYH/816TxqMrspWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200096; c=relaxed/simple;
	bh=gDAiHxxUJMd1ND/b7EHSgnRpgh1liCOEZVBQ6PDqaUM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pJcUGEM3SY5t7Ec1RMNiPdzN2hDSYL5n57etKVHG4D94JsLDp8DvKeNveEZOof/N8ZwKs1FKxJUz41kezcnDtPFR99wm/52cO0BeFL2zWiXKasu81u0omPdSXYscVp/b62qH8rqvez3e14CZpLXNlL4rLFpWpsHqBHAzPjS4j9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sbfy6kzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98AA6C4CED1;
	Mon, 10 Feb 2025 15:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739200096;
	bh=gDAiHxxUJMd1ND/b7EHSgnRpgh1liCOEZVBQ6PDqaUM=;
	h=Subject:To:Cc:From:Date:From;
	b=Sbfy6kzQMr/p9SDGPUXzLiOPcv3VIfbaOnQsYsMlnPP3FOjHYtjVs03NVLbIt3r5E
	 EZ3Y+kBs4bSG5Pc8+xRyNH+72/kaCg1OVnpHJrVK7x81uqOsXC2idatduC5ZTZEq+l
	 pmkRogTtPPoFRirKLSq542NztMV5hdkOYI5pE3MU=
Subject: FAILED: patch "[PATCH] soc: mediatek: mtk-devapc: Fix leaking IO map on driver" failed to apply to 6.6-stable tree
To: krzysztof.kozlowski@linaro.org,angelogioacchino.delregno@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 16:08:12 +0100
Message-ID: <2025021012-busybody-undertook-fce1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x c9c0036c1990da8d2dd33563e327e05a775fcf10
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021012-busybody-undertook-fce1@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


