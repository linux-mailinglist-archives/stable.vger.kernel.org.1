Return-Path: <stable+bounces-136751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0F8A9DB14
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 15:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 890DE1BC319A
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 13:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5CD13665A;
	Sat, 26 Apr 2025 13:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTDDpzyi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4EA1AAC4
	for <stable@vger.kernel.org>; Sat, 26 Apr 2025 13:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745673815; cv=none; b=UKRCNWKalVpjCESytp8yLbTUfoKXijJmYDA0j3ybK1vbIxdnlNtH3dnB6bLehIuOdNUmE+B2L9qgxYnefKMCVSBqAW5w81OfkhxccZ+uuulyUw3rL2zoZmfHUxrUjMrT0yq/t9mbXeNMvQ/EyGSRbj5IomQjLBLsAax6H3p7MmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745673815; c=relaxed/simple;
	bh=5UlexvvwYWF++H5J2VRMx8XbnhvgUmEGGLjvTHI5rNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e80yavFfIU4s1+JssL80NE5C2kIoLmhBrqpbEhWUKhHdfH26q5x5e7rcsuczHQXhOeMvkht9sMwYNnx71HlJwJCUV3wHypxdC+dxqPNhoxssp1xU5H9zk8Ehw7OZvc8mAS194XQysGzdRkBP0knRpSdwC3UtTlhO5U1FEj1KAhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTDDpzyi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CA1C4CEE2;
	Sat, 26 Apr 2025 13:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745673815;
	bh=5UlexvvwYWF++H5J2VRMx8XbnhvgUmEGGLjvTHI5rNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oTDDpzyirkleTBvZhBGy8mvWFSNUAycdnyb+4G7e/L7ymMO8yLaLE1ruTqbFcTbtD
	 I89YxRkvUCrYm//sS78B3pKRRg93jgp/ca/q9T5xkiUFlPVvn7aw9DinZdbvQhGcQE
	 uWn8CFKO5hOv4wDybvz04YO/Z9NoAB5gMpvd2ONgU+AxnTyBrFD2atSqOLtEIoMlqf
	 ZEeV27UBfjHbEX1rpquvPEx9p1irGx2GUM08Mzh1odlTjIce9oVWfT4J9zeuxCxqx9
	 PjCLB0/l5zGRuWtLlXyqPykoTFjJKiYYTGc1ElDgGLBvFmjwsDPNkKid7x+HjzvYJ7
	 wVJtqRNodS6iQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] of: module: add buffer overflow check in of_modalias()
Date: Sat, 26 Apr 2025 09:23:33 -0400
Message-Id: <20250426033555-72bb9d25f11e9774@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250425134622.3376068-2-ukleinek@debian.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: cf7385cb26ac4f0ee6c7385960525ad534323252

WARNING: Author mismatch between patch and upstream commit:
Backport author: <ukleinek@debian.org>
Commit author: Sergey Shtylyov<s.shtylyov@omp.ru>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 0b0d5701a8bf)

Note: The patch differs from the upstream commit:
---
1:  cf7385cb26ac4 ! 1:  a49c07db9c584 of: module: add buffer overflow check in of_modalias()
    @@ Metadata
      ## Commit message ##
         of: module: add buffer overflow check in of_modalias()
     
    +    [ Upstream commit cf7385cb26ac4f0ee6c7385960525ad534323252 ]
    +
         In of_modalias(), if the buffer happens to be too small even for the 1st
         snprintf() call, the len parameter will become negative and str parameter
         (if not NULL initially) will point beyond the buffer's end. Add the buffer
    @@ Commit message
         Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
         Link: https://lore.kernel.org/r/bbfc6be0-c687-62b6-d015-5141b93f313e@omp.ru
         Signed-off-by: Rob Herring <robh@kernel.org>
    +    Signed-off-by: Uwe Kleine-König <ukleinek@debian.org>
     
    - ## drivers/of/module.c ##
    -@@ drivers/of/module.c: ssize_t of_modalias(const struct device_node *np, char *str, ssize_t len)
    - 	csize = snprintf(str, len, "of:N%pOFn%c%s", np, 'T',
    - 			 of_node_get_device_type(np));
    + ## drivers/of/device.c ##
    +@@ drivers/of/device.c: static ssize_t of_device_get_modalias(struct device *dev, char *str, ssize_t len
    + 	csize = snprintf(str, len, "of:N%pOFn%c%s", dev->of_node, 'T',
    + 			 of_node_get_device_type(dev->of_node));
      	tsize = csize;
     +	if (csize >= len)
     +		csize = len > 0 ? len - 1 : 0;
    @@ drivers/of/module.c: ssize_t of_modalias(const struct device_node *np, char *str
     -		str += csize;
     +	str += csize;
      
    - 	of_property_for_each_string(np, "compatible", p, compat) {
    + 	of_property_for_each_string(dev->of_node, "compatible", p, compat) {
      		csize = strlen(compat) + 1;
      		tsize += csize;
     -		if (csize > len)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

