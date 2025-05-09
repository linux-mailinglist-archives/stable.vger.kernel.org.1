Return-Path: <stable+bounces-142943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F5BAB0799
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 03:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0FFF1B62696
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 01:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698F713632B;
	Fri,  9 May 2025 01:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vf+pLOny"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A481FC3
	for <stable@vger.kernel.org>; Fri,  9 May 2025 01:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746755531; cv=none; b=LO3ZmUa7JytbZhFFVzN/Y6kOPrnSM9udcc6RsAtUSNqT62QUYgkrEhLQEBlb4hmQEh6AIcvfPWZegREROcxeK43qBWhdIeT1IYfWXLfvvOiGFNiFuE0bU6AlXGmUU4Au3P2ZrgCYUqsUmt3xsVPuOafOQMHeD0Zm3N9kbGZj32Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746755531; c=relaxed/simple;
	bh=P6zXiBxgjSzKlfu0U87KcyZyc4D8c17kbwrvH+RsYi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJf8TgFinQGTrpulVTkNow2SZa4bcGLtIEh5MJGAkbbXU/Cg6/eTC9kUupvuRbyUBUFuJq6FTiAzaSCqAHwTP5aFtVbnIAUl/nEHBm3rXkuU62dNWpO0j7HHm0Oxopg1Vj7BOncDXHpPwGuwxI0eh/pvVwnsilRyd06QWNPGqY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vf+pLOny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305C3C4CEE7;
	Fri,  9 May 2025 01:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746755530;
	bh=P6zXiBxgjSzKlfu0U87KcyZyc4D8c17kbwrvH+RsYi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vf+pLOnyiVREFjpO88G9nnjBN7gWIJNCVs+//DEqVN0zVkYQFIY9QnJYd5kM1Jq95
	 mX+YjDnb3jQOpFZgl3x4SqGAd47myN2383yPpnBKFXx68F5qrdqwXEvgEVJQRd4Ldz
	 R8PbddU81AzJzN6FgBI6XW6eAOblSFvON0eCDIQJIvcs8YaOIDaTwjxyj4qd7KRZFI
	 QjoPJRW0gJ2wUJlZdeO/UEB1qYm4uE4y7lafT5+3n0f1MGcBquNGrgCCDYI2/9mZrB
	 UijRAP95RuggEeI1MotJxVYHb42MhyNwiquNaolqAj2HG1HSVCDVVOM2vJqdZpLyPf
	 5IKSoq3VBdJwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] of: module: add buffer overflow check in of_modalias()
Date: Thu,  8 May 2025 21:52:05 -0400
Message-Id: <20250508133222-1adad8fedd5cab79@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250507131123.538166-6-ukleinek@debian.org>
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
6.1.y | Present (different SHA1: 5d59fd637a8a)
5.15.y | Present (different SHA1: 5bdbbfb49bec)
5.10.y | Present (different SHA1: 6df2777b9e01)

Note: The patch differs from the upstream commit:
---
1:  cf7385cb26ac4 ! 1:  c4addef3bafbd of: module: add buffer overflow check in of_modalias()
    @@ Metadata
      ## Commit message ##
         of: module: add buffer overflow check in of_modalias()
     
    +    commit cf7385cb26ac4f0ee6c7385960525ad534323252 upstream.
    +
         In of_modalias(), if the buffer happens to be too small even for the 1st
         snprintf() call, the len parameter will become negative and str parameter
         (if not NULL initially) will point beyond the buffer's end. Add the buffer
    @@ Commit message
         Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
         Link: https://lore.kernel.org/r/bbfc6be0-c687-62b6-d015-5141b93f313e@omp.ru
         Signed-off-by: Rob Herring <robh@kernel.org>
    +    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
| stable/linux-5.4.y        |  Success    |  Success   |

