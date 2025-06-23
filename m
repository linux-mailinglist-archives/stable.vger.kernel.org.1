Return-Path: <stable+bounces-156147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E16AE4B17
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 18:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8851E1B60BB3
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 16:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBEA29AB01;
	Mon, 23 Jun 2025 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0SHEW2f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6859127A10F;
	Mon, 23 Jun 2025 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750696036; cv=none; b=QemRQqgGu8nI/qPE11Rm3gLmZ1zLlT4/M+lc1elafv2+ISnWvd9dBzutU86bFsL8Y1pXfdEsbBMxOKzr18cvDvCjq0IHpLGxAZ2tTL8r370kRH1TurZlBtZQawZeAj4g73MykZPJOpqC0VCMLhfnS+2Gvp4T45uVMvERHl4koXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750696036; c=relaxed/simple;
	bh=3EAO3YbUCzx9KDj7eT51E1hoJySpjiCVYtTzyMaRymg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dp9CiQ4IZFHbR68dg2WOZ3gEeYWQYypd+vSV9jNznhR6WyjIaRl9O6w2fJfZRjdYQXoiAQNaHlII7tmj3rKl6ZyoTU24FAgizVLj2b1G8hadQFW+eR9MvC7BV6WJJnBCT1cJvVKLI/6RetL3vza26WKyflwgOAYS4eP8b9xhPWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0SHEW2f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD90C4CEED;
	Mon, 23 Jun 2025 16:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750696036;
	bh=3EAO3YbUCzx9KDj7eT51E1hoJySpjiCVYtTzyMaRymg=;
	h=From:To:Cc:Subject:Date:From;
	b=m0SHEW2fviSGjxg6ilzUo3P+rf63rx1rtJDobLJ3Y1KqHCBTT9suj19xhU2M60NfJ
	 QYKcz4nhIqZ4GTmVwq4n9IbCgs4rb7zeERnZ4GLFMhrhVkWCPGm5qfy9zWGZpVbGMT
	 nnmElsH8pQrMekWBjomTmlwayR2IAnE5y/RVkbYqxCWwQBX6ZxAo+78Tq9QW0Fw+1P
	 raPaIazhI2AZzpOlB3ayXlx5U8XHPgMgLvVcwBb2UndApoUi2wJxc23PLOdboySaAi
	 Csl77p9XqgC33DUwyHy4Za989Y01UNcVJS3AuFM/U2+wuywmvUT+r1q5/aPDRJzN9R
	 XfhPONG52WjBA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Hans de Goede <hansg@kernel.org>
Cc: stable@vger.kernel.org,
	Andy Yang <andyybtc79@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: ahci: Use correct DMI identifier for ASUSPRO-D840SA LPM quirk
Date: Mon, 23 Jun 2025 18:27:11 +0200
Message-ID: <20250623162710.917979-2-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1193; i=cassel@kernel.org; h=from:subject; bh=3EAO3YbUCzx9KDj7eT51E1hoJySpjiCVYtTzyMaRymg=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDIiG+Li+EW/lX2P6qrc5FVutXOlLWPV3pwttQ17HJ48m TtD4SR/RykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACay3J/hv1/CvFUu5rIlOilc D4McwzOqHM6fPVoZyfsjUa0zvIl/EiPDW51NH1jlD0l+Fmb249t874Xkvzm8zqFctVw3I1WXHgv hBQA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

While most entries in ahci_broken_lpm(), for Lenovo based boards, match on
DMI_PRODUCT_VERSION, ASUS apparently store the board name in
DMI_PRODUCT_NAME rather than DMI_PRODUCT_VERSION.

Use the correct DMI identifier (DMI_PRODUCT_NAME) to match the
ASUSPRO-D840SA board, such that the quirk will actually get applied.

Cc: stable@vger.kernel.org
Reported-by: Andy Yang <andyybtc79@gmail.com>
Closes: https://lore.kernel.org/linux-ide/aFb3wXAwJSSJUB7o@ryzen/
Fixes: b5acc3628898 ("ata: ahci: Disallow LPM for ASUSPRO-D840SA motherboard")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index e5e5c2e81d09..aa93b0ecbbc6 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1450,7 +1450,7 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
 		{
 			.matches = {
 				DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-				DMI_MATCH(DMI_PRODUCT_VERSION, "ASUSPRO D840MB_M840SA"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "ASUSPRO D840MB_M840SA"),
 			},
 			/* 320 is broken, there is no known good version. */
 		},
-- 
2.49.0


