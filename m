Return-Path: <stable+bounces-143842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB15AB4201
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 908357B3460
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7282BD012;
	Mon, 12 May 2025 18:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icbnnhpC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5D52BD004
	for <stable@vger.kernel.org>; Mon, 12 May 2025 18:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073115; cv=none; b=LknP0BBHd0JtLVqTRE+vZuUi8uRolEmBP4U3Zvcd6XWLTgpLJJNNjxIS1W8CAs4BHJj0kHwQMRKHgnDAbcbLIEbwmCVJjcMsmRpReIFEIWwZZYcQUP5bVt1+olwRHugQNAMBf93+L+PRolKrDwtec0WM5T7Q4QPN4q2Y3mmWzRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073115; c=relaxed/simple;
	bh=PBtjmxKQgSbzUymj+O+Bvs1NZ29mSwGZfUp0nH/yIB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWjKVB17K2DiY8MJyT8zN7EhI3xFuLkYxKEVo0qrHt0SXR71UDqanOFh9kXL81LXulcJIwuzWBx5QSgSDbV3B/FhvNg/qFC2JhMfVHP8cn577o+KsBg9uSMXl0WF3Om6q/jCWWvAuQUviIihvN9n3HrtVShzgejjVcH2uPIzZXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icbnnhpC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF8BC4CEE7;
	Mon, 12 May 2025 18:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073114;
	bh=PBtjmxKQgSbzUymj+O+Bvs1NZ29mSwGZfUp0nH/yIB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=icbnnhpCVS2xGPrWsflehXoG9ct9Ko6naay+PEJY/yjQQ0ITacIHVOFNNCyd6japF
	 JnxQXhbEHu2lqPHPnSeqPkP7tdY5h2gkcJ+SQTA59M65rjyL8k/uKq1hy7kD+34pmh
	 kCJi2I0JI+HTZA7eMnpEPZOmnA5zXXETl9Mrtm2s5kNrxGufEupZjlIlYef0oXdhEh
	 Y7xhMhMDr0NTUjOlvWCHj1NOnD191/P5nPr90cMeWjBq0KFrSDHv94dBFIFAyPstSX
	 +9I/fkFSvML6oeNm3rt1C/2hELwLcK2VjxMqDHwOlXmQ02vUCNxVvccjtYk4GwlKcI
	 ue3ZfUVYNHqkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	bin.lan.cn@windriver.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 1/2] usb: typec: fix potential array underflow in ucsi_ccg_sync_control()
Date: Mon, 12 May 2025 14:05:11 -0400
Message-Id: <20250511231302-15ae1af200b9d853@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250509063512.487582-1-bin.lan.cn@windriver.com>
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

Summary of potential issues:
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: e56aac6e5a25630645607b6856d4b2a17b2311a5

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: Dan Carpenter<dan.carpenter@linaro.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 56971710cd54)
6.6.y | Present (different SHA1: 0e66fd8e5a2e)
6.1.y | Not found
5.15.y | Not found

Found fixes commits:
b0e525d7a22e usb: typec: fix pm usage counter imbalance in ucsi_ccg_sync_control()

Note: The patch differs from the upstream commit:
---
1:  e56aac6e5a256 < -:  ------------- usb: typec: fix potential array underflow in ucsi_ccg_sync_control()
-:  ------------- > 1:  9a3fccdc1acb9 usb: typec: fix potential array underflow in ucsi_ccg_sync_control()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

