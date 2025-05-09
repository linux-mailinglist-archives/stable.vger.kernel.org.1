Return-Path: <stable+bounces-142949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D35AB079F
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 03:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4147B4E85B4
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 01:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B578139D0A;
	Fri,  9 May 2025 01:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hygm6fXO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF45E1FC3
	for <stable@vger.kernel.org>; Fri,  9 May 2025 01:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746755555; cv=none; b=MjWNS0ZaFt5IgCvdIflyx0RBKDDOsFtpk696cKBWswWsg78mZ4J12BWE8mYoibgNOjCdQfOClG/CIF2iivw4TBaumzrpeN6XzkrJmMJGaNvbc5+Miv8Pp9NzLIb2WO47wwbz8VpoGlZDLWiZTKgnfgRDOU5z+VJD4KaR0TNS1CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746755555; c=relaxed/simple;
	bh=hPWybB8Yah07NVVYm497aQLXONqy2q3nE2f1gPWQU40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lnn0/SgmCs7pmlkSFpVp1G/axTdhv6NxKoo1kc9MzZ/A4MVFxLEQSVRBrjKUiM0UgLsGLNekdLpcKCQGYVy8xynyoTsomcZ1e7Vl5f//jpfWXj3wCi4EBeJXkQH+7N237MFerCsn5JwUoAdH2FSLTk3iKiy1rO+n6SFfTk70tAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hygm6fXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5E1C4CEE7;
	Fri,  9 May 2025 01:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746755554;
	bh=hPWybB8Yah07NVVYm497aQLXONqy2q3nE2f1gPWQU40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hygm6fXO2VlQkhUvtAI8LQrAw/MMajRY7yYcEoSGn/3nNxQ5lVvohDpe5c6XCFjJB
	 VQPgcnF7uybkckI/98xQIVPf0w4y3OtsI7bp1hvPIcHokPnB6EMhArVmY1x63AuNQE
	 bDrdlPyik/KXTdiWDk3wy7XPZPsdERAJhrntJ6Emiyc1yvNWwk9Xx2kwicpnMCqR2M
	 Hsbn/TXetl5JeYW5WZLma6w1giBt0K14ry7c5ndhMYQuMSrxkYZ2zg0fyyeVl3ZLum
	 8tVPwI8F9bQ15SBjJ61Q2cquAgemPu9hRZXqnSjQJ9/XZEufPNtJdjBHcTJPVCgdb2
	 SE+wIcB2LpZXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] of: module: add buffer overflow check in of_modalias()
Date: Thu,  8 May 2025 21:52:31 -0400
Message-Id: <20250508143001-f68b4ddd467473f0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250507131123.538166-4-ukleinek@debian.org>
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

Note: The patch differs from the upstream commit:
---
1:  cf7385cb26ac4 ! 1:  b4d14b17aca12 of: module: add buffer overflow check in of_modalias()
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
| stable/linux-5.10.y       |  Success    |  Success   |

