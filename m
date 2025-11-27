Return-Path: <stable+bounces-197508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 833BCC8F66E
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 16:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71D574EBEA3
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 15:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFCF336EE7;
	Thu, 27 Nov 2025 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0Akzf8y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC8C3321AE;
	Thu, 27 Nov 2025 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764259006; cv=none; b=M1Q4TELiKTwL/hYMDrl4TlCg0d7W/cOqZ/ZflVWsYilsrDf8nppBCzYwF+s62wWW9PB2ef/rBPa5zQ9v18M7riTLxFgfH7u2arGj2ckhxmLXihG26Po9nMOyS8czwgRL5pAU8VV790sOZeLj6zvqUkUrD/hfMafbZOwMmdpaf4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764259006; c=relaxed/simple;
	bh=2dRh/lO8w9gjp9CZZ1jgYVcCk9vqQVBMj2KusLiFLtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WXaSFVGfzZVUR/rJ3SNl2NdEoIVM/AT6aoTF9qjKddq8mERzgBTudKd6afHxwHrAgPsc6dqDRg1G9gpymK/sKCXOGhxCx8Fe0QCQ3789c9ErwfYgBsOMKMgUjt8sxapcR9jSv99baxOl/4aBs4DOPqEw4FK+J/z0CVVVOeuoAIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0Akzf8y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D8AC4CEF8;
	Thu, 27 Nov 2025 15:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764259005;
	bh=2dRh/lO8w9gjp9CZZ1jgYVcCk9vqQVBMj2KusLiFLtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q0Akzf8yY3/1r8dv8+Lw0MQVfBgT6e+KJkEIWg2hR4iH5XRUrw3xWvnkplWdvEmYh
	 /yVbCuLIBnw77LyDMyo4TFgz2R7kBcS16ZDc6qi5/6pFglM1UTT0dPNjcoebQF1Tcc
	 IrJmxVZpHAVaUL42KPu+ExQ6jFMlnRic7VAUIAR6HURNrUHMQTRWhN2ooKnORECf4G
	 nKfS+HSPpJvAA1r9AsKA1csto7l02AlKBvGcbp+itiGzZmJeIGiU+uf/bMKA9oV5RP
	 WQJf8KMRy4JgS3Uf6f02YDMboeZNJiIDy8v6eXpEZMlR9gEmnd45mTLhgnQUDCchVs
	 YPZAQVHFPDJTA==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alim Akhtar <alim.akhtar@samsung.com>,
	Johan Hovold <johan@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] soc: samsung: exynos-pmu: fix device leak on regmap lookup
Date: Thu, 27 Nov 2025 16:56:39 +0100
Message-ID: <176425898784.291734.15552085991167409827.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251121121852.16825-1-johan@kernel.org>
References: <20251121121852.16825-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=682; i=krzk@kernel.org; h=from:subject:message-id; bh=MPMTHicfE5qBYcrGgMD5P0FlY7Jilx4P3KMD7rZHDqo=; b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpKHS2MRTQIjhor/gTscD1Gc7AZvDEEXpgfEsah wA5reP8dG+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaSh0tgAKCRDBN2bmhouD 18deD/wNwby4UkooJ8OQKJxVgPB/uQ+AR2k/vs7G0zAFkSG9jLQkLaApfGjL0ITa/6L6QNeNJB8 9npoOLNrHZbVMcb5YdLE9x7aOUwwtDl8qnoyK2DtS3Afn0ZL6mPqVwmHiY+fuW5tpOzFdGoGyjk aMT5rdEJeX2ByHMub2FRkd20T4w4/+9anX+ekBsS2EUUv6mwdHjF4/WtKPHmEd8dlO+Kgl+aTrb wbUljDFxqrkKQqnCkY55k/ObOpQ/kY1lD2SLGHWW0agcd4fbOzeMWLM/Lbh+BFSx2+AIjnnyJcu OvbWLHKT1v3nvo2b8m7I1MJpS46di/NbNyTDuWAGPf4wORjQMvO1e/wEOLJUs30DLq27tODkcSm mJS9wKJOMizFt0dK2y3MQG/p+x0kkGQRb8W40/bcnYK786rsvPNu/4tJVazvh8817uY1phbeN4R WcP0IDxxE86s8yhaC+KdgxQsvI+RRejIE1+mJTOAfFjrC0V155YnPjiLy64FCzAWT3UWTAGwri1 ZNjZMqNL0BF61w1PmJ/Dpg2fVROvFWpd4DZ2ZR9Fgt+uOgHwTAWNxQ320RHI0W9AXKVRYNq+RLR 7oRm70kt8+dWSGICWiRAfrG/n545eGSgevDiMJ7GzLo1dm+zL2YVegW1E5ugkr6G2ag3720r7DO 3qD9dwy9dC5cTJ
 w==
X-Developer-Key: i=krzk@kernel.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit


On Fri, 21 Nov 2025 13:18:52 +0100, Johan Hovold wrote:
> Make sure to drop the reference taken when looking up the PMU device and
> its regmap.
> 
> Note that holding a reference to a device does not prevent its regmap
> from going away so there is no point in keeping the reference.
> 
> 
> [...]

Applied for late. I might send it during merge window or might miss it and roll
for the next one. In any case I will keep it in my tree.

Applied, thanks!

[1/1] soc: samsung: exynos-pmu: fix device leak on regmap lookup
      https://git.kernel.org/krzk/linux/c/990eb9a8eb4540ab90c7b34bb07b87ff13881cad

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>

