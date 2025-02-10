Return-Path: <stable+bounces-114658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD65A2F0EF
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 16:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5EB163211
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754F31F8BB0;
	Mon, 10 Feb 2025 15:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kobE4hAv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B371F8BAA
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 15:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200104; cv=none; b=VrIc+PAeKQfsv5g9eNjofFhahynMM4Oi1ALFhh/R/Vi2I3WQRT+S0DXIUp/eHB1ULxsnxYUMi/Qmq7ewqGeoNp5ak2kWXCMIVhpvsVnW8hsqqcRzYjJ5xaI23jDJQkAzLzkBwVRWlcZLvz9AR+rNwld/V1hTYu3/NepIZbPJAkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200104; c=relaxed/simple;
	bh=Cmu9AQfldRqzYkZDsAqvqNeSl7ygWEFZSSD3BSKCr30=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=T+YGSYeNOiVuDgndFb3Jc7jLI1oXyVOk3B9tVIRxzqCsBouWeHVfDX+tG+KL+2+GTq5XEil/TVB28md1hTNQm1CvXivmPR7eDDOHZ7DZt3NFjD5hDI6iiYG+B7N8fv50gymYubFD1GcN5vmSMThFj5cI30fC3nHINwZdN+wLhzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kobE4hAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF712C4CED1;
	Mon, 10 Feb 2025 15:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739200104;
	bh=Cmu9AQfldRqzYkZDsAqvqNeSl7ygWEFZSSD3BSKCr30=;
	h=Subject:To:Cc:From:Date:From;
	b=kobE4hAvYTFFhDpfq1Fg4/W97n43DdXLntPfpkw27DmdG/7P+/INmWUl0AguQV+5c
	 HaGDVLOOQgIz4k/rPrgPiHD9ee4+aghLNYy9JUupXUFgNO0mscXxKDypR33h2ZSgs1
	 50chELoNW3PS/v+xw8qj+Hn5+0y+u/Bdop/NjDkc=
Subject: FAILED: patch "[PATCH] soc: mediatek: mtk-devapc: Fix leaking IO map on driver" failed to apply to 5.15-stable tree
To: krzysztof.kozlowski@linaro.org,angelogioacchino.delregno@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 16:08:13 +0100
Message-ID: <2025021013-unveiled-grazing-b8ac@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c9c0036c1990da8d2dd33563e327e05a775fcf10
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021013-unveiled-grazing-b8ac@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


