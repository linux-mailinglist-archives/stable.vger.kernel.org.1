Return-Path: <stable+bounces-13789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E524837E0C
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124FF1F29C56
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E4750A86;
	Tue, 23 Jan 2024 00:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O5AvcyNq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47A34F204;
	Tue, 23 Jan 2024 00:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970323; cv=none; b=jMG3jezemn+IOq7wbTj5HhFSAs894Sc2IWCpDHNMIsJuTVEn0D7gLEycvvaYYZoEe7VvCsqXVPF+k7aRxWlx373INbml7QKpGrFM0XVlY0jDu/k+6gfa0JJVMM5yBvVmufXdEWRzDPT0Xv5c+lzQTOYbmbOB/CJBpL4Vc71yrwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970323; c=relaxed/simple;
	bh=H9+0ixVc1l8G5NewfttagVtFBG/vj9ReMwimT/nFXFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L5VLl8+tZOPsQ9Acaj3zK+76XFj8sU5n6mxpNBdWSrHLpuhxsoWEBD8ITRpkuTJ0ekMqG980QYxgb4DKj9xYr6IAoo+WipTrngVRUQ/xY9bUs0l6a/h6T8uZZw9EVKoJy7AoSqjJDrN8pa2v1RKJpQC5p5xUpGwuI6b1CliWHFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O5AvcyNq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD1AC433F1;
	Tue, 23 Jan 2024 00:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705970323;
	bh=H9+0ixVc1l8G5NewfttagVtFBG/vj9ReMwimT/nFXFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O5AvcyNq78s+0oqeaMIBWsYfrYpgTIsIie/61TBVhB7BMTQS9O7qJeX4GaCsmU5B9
	 yxxAgtSvNg71gAyAgScBOmjdEvwGalkESg8U6yPtWCvBXFR1BQElKv0mio6wxM4wko
	 ro8xiF7n2FrSnzOt09AJbig7YN3andHi4RPVJZUk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lukas Wunner <lukas@wunner.de>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 609/641] gpiolib: Fix scope-based gpio_device refcounting
Date: Mon, 22 Jan 2024 15:58:33 -0800
Message-ID: <20240122235837.293587150@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

[ Upstream commit 832b371097eb928d077c827b8f117bf5b99d35c0 ]

Commit 9e4555d1e54a ("gpiolib: add support for scope-based management to
gpio_device") sought to add scope-based gpio_device refcounting, but
erroneously forgot a negation of IS_ERR_OR_NULL().

As a result, gpio_device_put() is not called if the gpio_device pointer
is valid (meaning the ref is leaked), but only called if the pointer is
NULL or an ERR_PTR().

While at it drop a superfluous trailing semicolon.

Fixes: 9e4555d1e54a ("gpiolib: add support for scope-based management to gpio_device")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/gpio/driver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 0aed62f0c633..f2878b361463 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -614,7 +614,7 @@ struct gpio_device *gpio_device_get(struct gpio_device *gdev);
 void gpio_device_put(struct gpio_device *gdev);
 
 DEFINE_FREE(gpio_device_put, struct gpio_device *,
-	    if (IS_ERR_OR_NULL(_T)) gpio_device_put(_T));
+	    if (!IS_ERR_OR_NULL(_T)) gpio_device_put(_T))
 
 struct device *gpio_device_to_device(struct gpio_device *gdev);
 
-- 
2.43.0




