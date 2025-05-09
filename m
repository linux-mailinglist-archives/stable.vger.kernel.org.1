Return-Path: <stable+bounces-142948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70663AB079E
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 03:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C11C9E5F4D
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 01:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC56713B58B;
	Fri,  9 May 2025 01:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5ldMN8P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3BF1FC3
	for <stable@vger.kernel.org>; Fri,  9 May 2025 01:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746755551; cv=none; b=c8LvjBQ7SbZmuq0eotbKZWopGRwVdlUusN07VDVi0JLb/jRw6S89Tj5pD17ZNgB7agel5+vCuo+C7e56tQ0Dy4P3ozFboTB2K1JSIapN3VCNh5GOZLbofxHVHCt4vuDzJ9A9xEedNINp05b/HpfbluMngCFuGli6hMm6Tu4ZgW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746755551; c=relaxed/simple;
	bh=KUEFKdOQnOPJlHld4Nezs+XFwM4xESS6EX7z9hLsLXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ns8LGtBIYSC4pf/7DC8JwPbfxAg4nO7K443DQC5uTSfVLlM95bOPmCjJsYnv351T2fNrvhgp6iTXWgX1m+Uhm/IvHhK9b/GHuj8SYGTfXO0wmuZPgsdjirMkRJPTEeY7+s3UdjrbTjTu5HCeUd0lkXSfelZB4sU6pTnUstUPbUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5ldMN8P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D29C4CEE7;
	Fri,  9 May 2025 01:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746755550;
	bh=KUEFKdOQnOPJlHld4Nezs+XFwM4xESS6EX7z9hLsLXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K5ldMN8PtfDHpkdGmDul4atlTRXtdnUYLbxrOpXvdSfDtcPLv5/1ia73hUdfVyYKo
	 dCb4sQOLZWkThe4rN6khPsl0032z6gFRSlKIr3NA9gWMVdh0Q2UenBzDSGxsk4Jbox
	 l3KcT50EhkWHo+9NkbHjSOS9Xi2hvjlas04juUBwQOrRfNm24EgxE1bSxvQoXcxihT
	 gVgOp9HiolA/l+U5sN0uJG0/V6SkKIcfmC9D3RwKD3fMLyLnb1WRUhzqyZE1SgpaaF
	 6drR9634mu+wpAFTUGFIhMhDV36x0j48DZawDAPxLWw1EjVD73VlicBthZT4y9QjCh
	 RHL7Lar5/Tw1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] of: module: add buffer overflow check in of_modalias()
Date: Thu,  8 May 2025 21:52:26 -0400
Message-Id: <20250508132422-0930197e96ee3d32@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250507131123.538166-5-ukleinek@debian.org>
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

Note: The patch differs from the upstream commit:
---
1:  cf7385cb26ac4 ! 1:  3e49a58876535 of: module: add buffer overflow check in of_modalias()
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
| stable/linux-5.15.y       |  Success    |  Success   |

