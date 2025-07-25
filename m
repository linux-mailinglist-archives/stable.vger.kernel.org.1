Return-Path: <stable+bounces-164723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0DEB11950
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 09:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE0E1C27A2D
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 07:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7E32BD595;
	Fri, 25 Jul 2025 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuhFYXh9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43548262FED;
	Fri, 25 Jul 2025 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753429285; cv=none; b=sKOXXduTKbuYQOamX+JUwXXu7MvpWarH6Z2B+aRz+AJbrqOiEDBDSZ/tzkMOwyW/ly00uKR5w/Gf5yg17Dh5JX/OGjIxFTy/bW3tPH6sS8DeCIi183etqHGscADHUHBhBcx4Qg4yBvCXbTuwNBuyirRtnmOqFTXw7cM1TDoOxvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753429285; c=relaxed/simple;
	bh=EJdajs8yNIrucCAJlRxnjIKqvHvgDMG64nsg+BaAj/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i/nADgfNe89tpMt8rWZjSewFrWZQvQ/ZCXnDhQz6JjVgNhgxPAfq2dXWEyks9OZSpQPCS7Y8r3hOmPkuPKV6cAvIoDmnh7+FPuPG5Wyr3GHG/SpFUTs3Q8GG6lDKW8K3jF/nM90BxuU8m/g+tJo/gYy1i3x9kCwHanjf1Xb71pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuhFYXh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6ACC4CEE7;
	Fri, 25 Jul 2025 07:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753429285;
	bh=EJdajs8yNIrucCAJlRxnjIKqvHvgDMG64nsg+BaAj/o=;
	h=From:To:Cc:Subject:Date:From;
	b=ZuhFYXh9u89PfWUt/FxW+kI6wZEXz8rPquuUlHpcWz9Phdoza4n6mVb5ljTXe9BxZ
	 mlulrhxPtBrhgbb3hOlA8Pi6QCMODh3cPZZa9/ZX26MWqwOP7QFGPvHXFqhXXBBA/J
	 SIWtR7/ubH/Zl/sAZ/3BWIxrGGjYTsUUeaPt9VEvkgJ3+S9re8JhIgm1ncj/SCU9OG
	 +2EfD8mDTo5ngDzmBtQyo3Vsx38afJ7wI7Bfv5EV6fatxDhLknz1QHcay4gJ4HyGC7
	 3gld08H70iuLUSAJZdZMkW79B2Gv3ksN/33hhMgGb2ycOtBhfY5mUzTXe64rPhnd+8
	 E19mv4spF2tcA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ufD3Q-000000002Ig-3bqf;
	Fri, 25 Jul 2025 09:41:20 +0200
From: Johan Hovold <johan@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Carlo Caione <ccaione@baylibre.com>,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] firmware: meson_sm: fix device leak at probe
Date: Fri, 25 Jul 2025 09:40:19 +0200
Message-ID: <20250725074019.8765-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference to the secure monitor device taken by
of_find_device_by_node() when looking up its driver data on behalf of
other drivers (e.g. during probe).

Note that holding a reference to the platform device does not prevent
its driver data from going away so there is no point in keeping the
reference after the helper returns.

Fixes: 8cde3c2153e8 ("firmware: meson_sm: Rework driver as a proper platform driver")
Cc: stable@vger.kernel.org	# 5.5
Cc: Carlo Caione <ccaione@baylibre.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/firmware/meson/meson_sm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
index f25a9746249b..3ab67aaa9e5d 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -232,11 +232,16 @@ EXPORT_SYMBOL(meson_sm_call_write);
 struct meson_sm_firmware *meson_sm_get(struct device_node *sm_node)
 {
 	struct platform_device *pdev = of_find_device_by_node(sm_node);
+	struct meson_sm_firmware *fw;
 
 	if (!pdev)
 		return NULL;
 
-	return platform_get_drvdata(pdev);
+	fw = platform_get_drvdata(pdev);
+
+	put_device(&pdev->dev);
+
+	return fw;
 }
 EXPORT_SYMBOL_GPL(meson_sm_get);
 
-- 
2.49.1


