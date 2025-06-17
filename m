Return-Path: <stable+bounces-153389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 664A6ADD44F
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0D9519464FB
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662ED2ECD2F;
	Tue, 17 Jun 2025 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vt2Wybod"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239C92F237C;
	Tue, 17 Jun 2025 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175800; cv=none; b=fmP1+ap9zoM4q1/eBLKEYnrHb28AHjqfgt6Dvt5PABF3rdC8BngYDw7kpZ/gyhandmdfDksppb6dqffkGGU6GeM+w3lHqJVvpgdEUUjjbRe+IuVvRcLibve9f+c1lHUPVJCPvI97afkApE3q7vc7xnFpU7Y+KAHWSx7Tq8Wlk14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175800; c=relaxed/simple;
	bh=iUfJRxbysRYkT+/Y88xWX41H3Zu/kk+BiD1IpxzLo68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJ8AEBDr7xPrPKIOSCsMBlTiM6tF2EfsBfdLQfHZsI6Sh91raDbDwPHWq0JOZkKF1EGtk0HSFPJA2Om+0KlawzGrgxkq3d8dmeegkE8iC8+yZakB0WQW2fPhLFC4H9g5oNtCRcqv9xhG4V3TPSJZ8FOgiFY91kPkqnyjVOEYeDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vt2Wybod; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3EDC4CEE3;
	Tue, 17 Jun 2025 15:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750175800;
	bh=iUfJRxbysRYkT+/Y88xWX41H3Zu/kk+BiD1IpxzLo68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vt2WybodgCpWqBG4Pu6ZUVpgV2/9vpLcvXBuY0JJ5LRZwt2yCLHnwJ9ahMGIi+sOE
	 STHjW9YDJyISOEBZcToVlWpu+dBREK/1jD6NX+zVE8UGvdtidRnCDGkJM21MXmhBHY
	 tZNbmoL/q79z6UBWgXrBp6xU1zYk8tuI6tHl0J7Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexey Gladkov <legion@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 214/356] mfd: stmpe-spi: Correct the name used in MODULE_DEVICE_TABLE
Date: Tue, 17 Jun 2025 17:25:29 +0200
Message-ID: <20250617152346.823873158@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152338.212798615@linuxfoundation.org>
References: <20250617152338.212798615@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Alexey Gladkov <legion@kernel.org>

[ Upstream commit 59d60c16ed41475f3b5f7b605e75fbf8e3628720 ]

The name used in the macro does not exist.

drivers/mfd/stmpe-spi.c:132:26: error: use of undeclared identifier 'stmpe_id'
  132 | MODULE_DEVICE_TABLE(spi, stmpe_id);

Fixes: e789995d5c61 ("mfd: Add support for STMPE SPI interface")
Signed-off-by: Alexey Gladkov <legion@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/79d5a847303e45a46098f2d827d3d8a249a32be3.1745591072.git.legion@kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/stmpe-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/stmpe-spi.c b/drivers/mfd/stmpe-spi.c
index 792236f56399a..b9cc85ea2c401 100644
--- a/drivers/mfd/stmpe-spi.c
+++ b/drivers/mfd/stmpe-spi.c
@@ -129,7 +129,7 @@ static const struct spi_device_id stmpe_spi_id[] = {
 	{ "stmpe2403", STMPE2403 },
 	{ }
 };
-MODULE_DEVICE_TABLE(spi, stmpe_id);
+MODULE_DEVICE_TABLE(spi, stmpe_spi_id);
 
 static struct spi_driver stmpe_spi_driver = {
 	.driver = {
-- 
2.39.5




