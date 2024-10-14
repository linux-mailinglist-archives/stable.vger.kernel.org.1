Return-Path: <stable+bounces-84526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CCE99D09A
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E472874FF
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E1B45C14;
	Mon, 14 Oct 2024 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1JGmNWU7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDA21798C;
	Mon, 14 Oct 2024 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918312; cv=none; b=qug/TmPZjnLJNxnaJOdTEDGIHu9InuJ31zkaHm+/2iKAmEH1Bc/tk2fz3y8fS6HEGcafMeh/RMWo49wGtuXtkONg185GYWkr9R+cXXomGzd8CAZbTZmTqcrB6jIyFLT6bWsfyQ0HSGQAENWn6ztbHyxXJaDhE+6JLxnQeJH9wmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918312; c=relaxed/simple;
	bh=+5j1hAq0tZ6AhKr53GaAYFnEKeuKSeSqOAJaGGAHRys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbboezL/ghGGz4JSgWO1iIcBLZUupQl6wek2erMaCZyz/OLD6F8AEVCdPwzopGUf9Z2GTGnfuzQ7bHMd3+M88BT47mqlJbPHvjjdhBcvdaesDy280MZo7x8m1DiOJZYmcCA9iwNEgMGySF9lba0oTpeD5xh9MzTHFngQfgN1gEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1JGmNWU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5170C4CEC3;
	Mon, 14 Oct 2024 15:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728918312;
	bh=+5j1hAq0tZ6AhKr53GaAYFnEKeuKSeSqOAJaGGAHRys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1JGmNWU79ClQYMr+NBUDra+AYrIV0HpoWwRqt8gXB70U+td++hNlvqB2kn7bCBUNt
	 gKmVlMTmRVmn3ly+z2tP2qQ/Dgkd8WjUnR0/Q3SFHjncSaVs/iqLh8q4RyyTqq7zks
	 /vBaLujVW1YtXevtJoq46k1HZJ3MowHIkexP/Rho=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 6.1 285/798] soc: versatile: integrator: fix OF node leak in probe() error path
Date: Mon, 14 Oct 2024 16:13:59 +0200
Message-ID: <20241014141229.142745664@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit 874c5b601856adbfda10846b9770a6c66c41e229 upstream.

Driver is leaking OF node reference obtained from
of_find_matching_node().

Fixes: f956a785a282 ("soc: move SoC driver for the ARM Integrator")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/20240825-soc-dev-fixes-v1-1-ff4b35abed83@linaro.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soc/versatile/soc-integrator.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/soc/versatile/soc-integrator.c
+++ b/drivers/soc/versatile/soc-integrator.c
@@ -113,6 +113,7 @@ static int __init integrator_soc_init(vo
 		return -ENODEV;
 
 	syscon_regmap = syscon_node_to_regmap(np);
+	of_node_put(np);
 	if (IS_ERR(syscon_regmap))
 		return PTR_ERR(syscon_regmap);
 



