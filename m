Return-Path: <stable+bounces-143815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31719AB41CF
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8D83A3FF8
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A7429A304;
	Mon, 12 May 2025 18:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzLFUX+4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFCF29ACCD
	for <stable@vger.kernel.org>; Mon, 12 May 2025 18:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073086; cv=none; b=rIffpxtLGs3tuOEkTgz6LFqX7mw+7nfGlolnnaqLVPrkPgxlOK1SvZwCFGbyvmXGSPSVtvF0VSi7STAq53ymtesSSsz5bAxfD4kleG1ZcKqLWnvGr+ijGYHca4JwqLBIKKClAF6SdmIyTZ6QsnxRYkCoBsROvut9guJo2lYlCc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073086; c=relaxed/simple;
	bh=cnscXap8IpT84pLQ0Zr+ht/y+vHMOUALR/t5RIPyWB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CVlx8uN4QyP3/dqSiU0I8JHWk/sb01v1LmuPz1np4DiyEfoAjyeOxGDs4TVVa5XAKfTq1BIUdEJcqfAdTe1X+iZqQk9T6o9f9FAev2sB5peE0llg+jxX3KTsqA6BBGVif02ELJIB2/1bxvOnUgjPXffq9PRhQ08gNgwGt5VA/mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzLFUX+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8830C4CEE9;
	Mon, 12 May 2025 18:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073086;
	bh=cnscXap8IpT84pLQ0Zr+ht/y+vHMOUALR/t5RIPyWB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DzLFUX+4kttpmaOnbg7awmE6i42TlIWCPR/W4sTpdSiHhColXcqk88n8fedlJzXRr
	 u2vryi5iQVTm8iZ5SZ71zXjxeTnCxCUcXPR18UmIpJzJy0dv6RA7whZ6KRAj5CGTiu
	 7CGJouKgSQKChW2cuyGSbNbkN8GRIr6+tk5PCuT6Ud7vAryOP0huEc1yBMSQzofmXY
	 JszIFMRvV94NBX2aie3pi2BzPXoL7WeiqeS2NLpsKmDw3k9VMAZ4uuqdAocg3WOQcc
	 V+m2vH6iMGtVMWbaa7FAqWD/gYYIfvYrRHP2/SzIS35oHvS/zGD5T5EewyyCURMxxw
	 aGmQu8PsuE8HA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 2/2] usb: typec: fix pm usage counter imbalance in ucsi_ccg_sync_control()
Date: Mon, 12 May 2025 14:04:43 -0400
Message-Id: <20250511232133-3de07c425aeddf00@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250509063512.487582-2-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: b0e525d7a22ea350e75e2aec22e47fcfafa4cacd

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: GONG Ruiqi<gongruiqi1@huawei.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 976544bdb40a)
6.6.y | Present (different SHA1: e8336d3c9ab7)
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  b0e525d7a22ea < -:  ------------- usb: typec: fix pm usage counter imbalance in ucsi_ccg_sync_control()
-:  ------------- > 1:  9da00b33bfbc3 usb: typec: fix pm usage counter imbalance in ucsi_ccg_sync_control()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

