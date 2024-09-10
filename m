Return-Path: <stable+bounces-75216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894DF973380
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6452848D8
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8A1192B9C;
	Tue, 10 Sep 2024 10:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N/3t6q3/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B76172BA8;
	Tue, 10 Sep 2024 10:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964088; cv=none; b=JH1qT9XknN0g8SMjXpSr8NvCheCadL3NnvUM2ADz14xuDWytv33fWtwDlqBJtkDQ3bZWPvR6jTEX11n471M3pQ7vZY6IX3EBQUmLg5SH1Bae9WydnILgFCfEpQRvL6QBxpoRKCx1Olyu7KtQHrY9IauqfNehUtdnUPL1VTAnjNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964088; c=relaxed/simple;
	bh=f/w0tjnthylhMqvzO3lIBZSnp6CJcw9sbg8nZexUfiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6uETI1vGH3AmHsrMpLc3b/Fbpwr8TP9iFmisb8iRqd+iLmz9dDMuEh5IdL4nY2h2Gcf2bTdrK6MFUm4vQ2zflnEsAUX6nr0E4QoVV/zYvY6qpdbueMu7p1FvRM+3B/osxfPiJowEN9qAgAxLpXNdHntlTmnls+7/uWe62pyg94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N/3t6q3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43FCC4CEC6;
	Tue, 10 Sep 2024 10:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725964088;
	bh=f/w0tjnthylhMqvzO3lIBZSnp6CJcw9sbg8nZexUfiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N/3t6q3/tnW64fdhyB2WGrCpaJycIjqVu6l8NE1+cing/qvUXKRtv/d/yqXU60kJa
	 aNZA13QdBipGCiOVrXM/hm8XoINdkK7O6JpwrQPOygV5Qt83EtROKuKfaW3tI+Sugc
	 NKUHmGg0hub0ocakXONG9MVGa3muf1o1JIXmcjgY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Liao Chen <liaochen4@huawei.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.6 027/269] mmc: sdhci-of-aspeed: fix module autoloading
Date: Tue, 10 Sep 2024 11:30:14 +0200
Message-ID: <20240910092609.210416199@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092608.225137854@linuxfoundation.org>
References: <20240910092608.225137854@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liao Chen <liaochen4@huawei.com>

commit 6e540da4c1db7b840e347c4dfe48359b18b7e376 upstream.

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Fixes: bb7b8ec62dfb ("mmc: sdhci-of-aspeed: Add support for the ASPEED SD controller")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240826124851.379759-1-liaochen4@huawei.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sdhci-of-aspeed.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -510,6 +510,7 @@ static const struct of_device_id aspeed_
 	{ .compatible = "aspeed,ast2600-sdhci", .data = &ast2600_sdhci_pdata, },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, aspeed_sdhci_of_match);
 
 static struct platform_driver aspeed_sdhci_driver = {
 	.driver		= {



