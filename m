Return-Path: <stable+bounces-128631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BBAA7EA2A
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D493A53F2
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158C0259CBF;
	Mon,  7 Apr 2025 18:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuLHDIAh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F587259CB2;
	Mon,  7 Apr 2025 18:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049552; cv=none; b=lyCeRQGzHU7gKih07TGUu6cdxgrlonLhRTDuIz2EniFWZE9LOWvQsTEDFpb1/zuElglN8a4lCPl1VVWRqWRGSEYvaxfSKlpKqwhRmPClvK4hqSFKifC4hiFBXU2tnoxHegcvnLK4mwQqpg4l122bZOpvrAkCKgW97rQ+UNPbYT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049552; c=relaxed/simple;
	bh=aWnBchov1Oc4qRALKKfsxuNtvRNfxDEeevqDES1rkyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EcoZWpyZhzU3PvvbX1JyFDZBLoT9EZcaPi4UkS9mIPWG8IUMAuA92ubJNT0TaTvcIg3hZ/ELJ1x9KBTk5CC+2w5id3FmG6jWzwPPruYT/KchIiQCxXqCtCARKXaO8YvdVtqpAWRR87oI0YL6seMeBx3H6owlHWhpBKdH0Wrl9qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuLHDIAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA806C4CEDD;
	Mon,  7 Apr 2025 18:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049552;
	bh=aWnBchov1Oc4qRALKKfsxuNtvRNfxDEeevqDES1rkyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nuLHDIAhJbgA0aDMb7BKbzxM1OUEYvOc+nSrO/Hz4lF5Be1UW8bXQMYNgW5d83ozN
	 osU+mdjJiZ4WiJHSvBLLCIHIOM8jYcdeHQtZlvQrq1OJEP/MZ2/29IvKvlO+ns6X5g
	 CmKK+uhWJ/xU0GTP3Z01nkTfAEXAk2vMCrYbw+jcFSkd3BrAANR8Pu+t8ouit4gPnE
	 bhWMaMhouxDOAJ5Uk5GQ82XTZKLtcHSQbt+pHJYBLrnhqbFajWL3dvZRHxWB0gAn3r
	 U8zKB43U17Vls/7Jlj6WpEKttkUoKaKG3AR+3op8HioZjKbNQGhhhBo4LfOp14Sqag
	 6KgP69xj4sK8A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@mailbox.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mark.tomlinson@alliedtelesis.co.nz,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 02/28] usb: host: max3421-hcd: Add missing spi_device_id table
Date: Mon,  7 Apr 2025 14:11:52 -0400
Message-Id: <20250407181224.3180941-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181224.3180941-1-sashal@kernel.org>
References: <20250407181224.3180941-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.10
Content-Transfer-Encoding: 8bit

From: Alexander Stein <alexander.stein@mailbox.org>

[ Upstream commit 41d5e3806cf589f658f92c75195095df0b66f66a ]

"maxim,max3421" DT compatible is missing its SPI device ID entry, not
allowing module autoloading and leading to the following message:
 "SPI driver max3421-hcd has no spi_device_id for maxim,max3421"

Fix this by adding the spi_device_id table.

Signed-off-by: Alexander Stein <alexander.stein@mailbox.org>
Link: https://lore.kernel.org/r/20250128195114.56321-1-alexander.stein@mailbox.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/max3421-hcd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hcd.c
index 0881fdd1823e0..dcf31a592f5d1 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -1946,6 +1946,12 @@ max3421_remove(struct spi_device *spi)
 	usb_put_hcd(hcd);
 }
 
+static const struct spi_device_id max3421_spi_ids[] = {
+	{ "max3421" },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, max3421_spi_ids);
+
 static const struct of_device_id max3421_of_match_table[] = {
 	{ .compatible = "maxim,max3421", },
 	{},
@@ -1955,6 +1961,7 @@ MODULE_DEVICE_TABLE(of, max3421_of_match_table);
 static struct spi_driver max3421_driver = {
 	.probe		= max3421_probe,
 	.remove		= max3421_remove,
+	.id_table	= max3421_spi_ids,
 	.driver		= {
 		.name	= "max3421-hcd",
 		.of_match_table = max3421_of_match_table,
-- 
2.39.5


