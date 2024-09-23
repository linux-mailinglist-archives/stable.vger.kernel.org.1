Return-Path: <stable+bounces-76893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8708697E8F2
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 11:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D9B1F21BBC
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 09:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD14A194A4C;
	Mon, 23 Sep 2024 09:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b="IBKhZlrP"
X-Original-To: stable@vger.kernel.org
Received: from 0.smtp.remotehost.it (0.smtp.remotehost.it [213.190.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E31D528
	for <stable@vger.kernel.org>; Mon, 23 Sep 2024 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.190.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727084604; cv=none; b=eePWcEOv9lAQyjiMyQ7CqDlS/Tc7g7DX/23YU6r6blF8LmBMKdkakVRL3tdVXScMcG0T8tnMper3ySHUO/1l8MZe/L8Yzvsl1+15RlAc/VNMoEs05cCzcPqI3U9DNVYaT4Kkr6XqUPPIFd0N5FpWY1cVz3nXtAR60My6g6hi8Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727084604; c=relaxed/simple;
	bh=3KmzN9q0YrVYUTc2bw+QN62wo7282TimYa9ts4FIiLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=NIB2uPFdDPFwQDjnc4VvorDjQmOkq9rO/0hQ52Rg10ZNsVY946qJEB8voFv1q7sfZmNmAjAq/qX8GvDtik4PIzzNB4IWEehhFqM77cbBDsTv8sTYHUe7/NTiBj9NK6dJZp+zwCUolwS/ZHhPUm1b+sRmBCYRQ7AjrOiQ8Qxa8ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net; spf=pass smtp.mailfrom=hardfalcon.net; dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b=IBKhZlrP; arc=none smtp.client-ip=213.190.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hardfalcon.net
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=hardfalcon.net;
	s=dkim_2024-02-03; t=1727084232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xUxgnPmHdxKwloKsrhXtwk3dtfWEHo7DThCIS8M/UD0=;
	b=IBKhZlrPKoENOpz/zOJ3p+Wbz+7sPfF8RQkn+NaU/fAYRvZRE2Kqo/XsH3pgxpHmwBblvi
	QiadBxc4VeMhWNCQ==
Message-ID: <178b4702-101e-4ca4-856a-c9fd5401670a@hardfalcon.net>
Date: Mon, 23 Sep 2024 11:37:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Patch "ASoC: SOF: mediatek: Add missing board compatible" has
 been added to the 6.10-stable tree
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
References: <20240919193644.756037-1-sashal () kernel ! org>
Content-Language: en-US, de-DE
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Pascal Ernster <git@hardfalcon.net>
In-Reply-To: <20240919193644.756037-1-sashal () kernel ! org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[2024-09-19 21:36] Sasha Levin:
> This is a note to let you know that I've just added the patch titled
> 
>      ASoC: SOF: mediatek: Add missing board compatible
> 
> to the 6.10-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       asoc-sof-mediatek-add-missing-board-compatible.patch
> and it can be found in the queue-6.10 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.


Hi Sasha,


it seems that in your commits to the stable-queue repo on 2024-09-19 
around 15:36 -0400 / 19:36 UTC, every patch was added twice. This 
affects all supported stable version branches from 6.10 down to 4.19 (a 
single commit per version branch):

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=19260ab5db68912b2983aecb3a5e778a908e4a30

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=f95efa9ab525da0bfaa852bfd27ed453c1bde67e

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=e9452f2ddd7affa8424fcd7cbc8816d92a74bd70

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=678cff8b6a095767aee1c6b750ccd10362bcbe82

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=0f5b9efe8e5fcd26d35af38d43a459a99b648c67

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=0c554a1406f2ce8c4d5357fc474af50857cead46

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=8ce8b1c9dcf3f5625be3a6a4afd5815c55c0ea49


Regards
Pascal

