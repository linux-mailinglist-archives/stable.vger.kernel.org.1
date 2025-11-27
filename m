Return-Path: <stable+bounces-197105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E0657C8E92F
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 14:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E22FC4E9EDA
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 13:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E62267B94;
	Thu, 27 Nov 2025 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdwWYaU8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEFA1EB1A4;
	Thu, 27 Nov 2025 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764251242; cv=none; b=gNIeqr3CIoXzUR7H9vVs7teGd17T0VwkBIouPSJW0iWlXLxa+Vxnlsh3DUp+x81tuYfM4A5Li7XYfju6UacJbafDz33t8gfS1/nzlDff54DczeglHZhMKcPqorn87cULPQAyQfGxXv4x1jzVOnBUgUh4EFwy8PcLlXJ5Qfcrjqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764251242; c=relaxed/simple;
	bh=WlaS2NiP9VyUK5RBnIDbkYPzn1Q+caa+OeUlNygoR4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M+gVSQ++sk5O9I/0SD5qQPSs8hits+IUGvRYMM6IzpZ/nZ0KphpU6VgNVNhgOpB7MiVKZjO8yKTR2hgkfN6IdXQ+ArXzupHEZX3pm+C+B3m1/fUFAuU9z9JKytdYpCz142x2JMEdgC18h1B+OEWWAtgy7WukpQ0fYaw9OTiVt8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdwWYaU8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B28CC4CEF8;
	Thu, 27 Nov 2025 13:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764251241;
	bh=WlaS2NiP9VyUK5RBnIDbkYPzn1Q+caa+OeUlNygoR4E=;
	h=From:To:Cc:Subject:Date:From;
	b=tdwWYaU8syHQMhF7AQZKvnoWjUjUta1B3rTVaCBc6qXGWE6fErjguuuywbXhpwfbr
	 sRutUK7kndlgJg0HGRTwxF/dk5xv8jh/31aoMNspM09mupYvfeqjV8GRlbyXeZp1cQ
	 E5F6EFW6TCYbgx58dpg855gDXis64jpvEdF6Ks8MZtwQP9gBTysZ+wq17TKtKJx7gg
	 4h5thC7fjd06gjpfueQYZKRX9n49NlcOh6zPc7W2kAWdQggiSZzpBmyVBlgFpvtRvi
	 iNE72mUD0g3/gcmPHA4L6rxqp7beK9JfyWIaiwWDolblEItP3lsowvEUj8xv39um/M
	 pAz91CLACJMsg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vOcLE-000000000VJ-1EFL;
	Thu, 27 Nov 2025 14:47:24 +0100
From: Johan Hovold <johan@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Andrew Davis <afd@ti.com>
Subject: [PATCH] mux: mmio: fix regmap leak on probe failure
Date: Thu, 27 Nov 2025 14:47:02 +0100
Message-ID: <20251127134702.1915-1-johan@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mmio regmap that may be allocated during probe is never freed.

Switch to using the device managed allocator so that the regmap is
released on probe failures (e.g. probe deferral) and on driver unbind.

Fixes: 61de83fd8256 ("mux: mmio: Do not use syscon helper to build regmap")
Cc: stable@vger.kernel.org	# 6.16
Cc: Andrew Davis <afd@ti.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/mux/mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
index 9993ce38a818..5b0171d19d43 100644
--- a/drivers/mux/mmio.c
+++ b/drivers/mux/mmio.c
@@ -58,7 +58,7 @@ static int mux_mmio_probe(struct platform_device *pdev)
 		if (IS_ERR(base))
 			regmap = ERR_PTR(-ENODEV);
 		else
-			regmap = regmap_init_mmio(dev, base, &mux_mmio_regmap_cfg);
+			regmap = devm_regmap_init_mmio(dev, base, &mux_mmio_regmap_cfg);
 		/* Fallback to checking the parent node on "real" errors. */
 		if (IS_ERR(regmap) && regmap != ERR_PTR(-EPROBE_DEFER)) {
 			regmap = dev_get_regmap(dev->parent, NULL);
-- 
2.51.2


