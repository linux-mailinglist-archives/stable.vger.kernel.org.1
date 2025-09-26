Return-Path: <stable+bounces-181771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 757ADBA4314
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 16:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B56562414
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 14:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CACB1D7E31;
	Fri, 26 Sep 2025 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3lvwbrM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E511D432D;
	Fri, 26 Sep 2025 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896709; cv=none; b=ftPIqoQGTvC27KNssXQ16wkX5AzGuocuSGyIt7viPVoNpyOwfAWcYw46I88op+v+tAMUQXL51xcncasyhVWHWKRnDAvUs82f7Y9ulncK09qpDcRkbIqn6nARhJRc8G/PZXlh+akMdrZ7bmnWynC0jwedGApMfmm9V/zZdrFf24g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896709; c=relaxed/simple;
	bh=Jg3dS60+quRoQDa5nDEodavgLyUoChDVPfThy50rlf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjoxSlE0FaU3Yvt4nyf1ddhftKvBp/vlXegPXNsCciM5Rr6j3h97drLfY45UicHqYQ4v8FFTngH6J9VniiXuAZWlJE6Dg3aX5PROFV9rXv9nmvFc5NE/rG9gk4LKyM/esDpfsBUA5CQvXArh7ycxyE0gxxLfImoXrNxvUuH0aVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3lvwbrM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD4BC4CEF4;
	Fri, 26 Sep 2025 14:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758896708;
	bh=Jg3dS60+quRoQDa5nDEodavgLyUoChDVPfThy50rlf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g3lvwbrMJ3oqd+tzV9CIHLFzuRYRPNfZrMGQQZuuyOLTTjkGaaRMUO0/VinFPwDV3
	 Tkccr/Da7WwKdou9PWDgnLGo/EVQ6RuDFLnyP6Lsisuih6DNVX5WuUmvcHSWoeSNJV
	 eDmdGuFAQ/TPKOjG8tWnTRioovZOEbZrDCqvUvNYhdZPOiqQF9uzo0yzheAoJD5kwz
	 meR8lMAaspw92/4TIixyBtBUhVNuG3NK+ebJtxDwW6iynFHoCm9eFbcRrQFqddvy49
	 U5e40iwk3eGeuE9Fpq4iPu9PRi5a9DojLVzeCgpC4cXDOYpI3plPbVj+lMthZUBxtg
	 z8fnCl4WEYsUQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v29Ne-000000001Y4-289q;
	Fri, 26 Sep 2025 16:25:02 +0200
From: Johan Hovold <johan@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH 1/2] soc: amlogic: canvas: fix device leak on lookup
Date: Fri, 26 Sep 2025 16:24:53 +0200
Message-ID: <20250926142454.5929-2-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250926142454.5929-1-johan@kernel.org>
References: <20250926142454.5929-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken to the canvas platform device when
looking up its driver data.

Note that holding a reference to a device does not prevent its driver
data from going away so there is no point in keeping the reference.

Also note that commit 28f851e6afa8 ("soc: amlogic: canvas: add missing
put_device() call in meson_canvas_get()") fixed the leak in a lookup
error path, but the reference is still leaking on success.

Fixes: d4983983d987 ("soc: amlogic: add meson-canvas driver")
Cc: stable@vger.kernel.org	# 4.20: 28f851e6afa8
Cc: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/soc/amlogic/meson-canvas.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/amlogic/meson-canvas.c b/drivers/soc/amlogic/meson-canvas.c
index b6e06c4d2117..0711088da5dc 100644
--- a/drivers/soc/amlogic/meson-canvas.c
+++ b/drivers/soc/amlogic/meson-canvas.c
@@ -73,10 +73,9 @@ struct meson_canvas *meson_canvas_get(struct device *dev)
 	 * current state, this driver probe cannot return -EPROBE_DEFER
 	 */
 	canvas = dev_get_drvdata(&canvas_pdev->dev);
-	if (!canvas) {
-		put_device(&canvas_pdev->dev);
+	put_device(&canvas_pdev->dev);
+	if (!canvas)
 		return ERR_PTR(-EINVAL);
-	}
 
 	return canvas;
 }
-- 
2.49.1


