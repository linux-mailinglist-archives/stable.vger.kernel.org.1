Return-Path: <stable+bounces-118780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF786A41B7F
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396113B2CFE
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CB825744A;
	Mon, 24 Feb 2025 10:45:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out198-187.us.a.mail.aliyun.com (out198-187.us.a.mail.aliyun.com [47.90.198.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576B4256C96;
	Mon, 24 Feb 2025 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393915; cv=none; b=ZbCgfAFZNsTZyT/7IKbn+vTtEuJSXPdFTRSyGS3iFwYH2YDzNaaDABV7NOB1+2fJREGNSp5tSbYxSEGZxbfwdraVrRuZjkxZt20bspr+IQc0vBPnrW0cPmkLI6dG9tfgsZ3YoNpiY0WkeLR5e68HYenO7ZAYueUE7hXARnVzmPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393915; c=relaxed/simple;
	bh=OrRJDLSP8v7rCTbPUp4h3jGvBCAlXKK/YL2Biem0oWw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=V2MyRU9bBETgSoE85UeBvcoiiIPGm3TBKzKUHdDJ4RoMi1D8pZF4MZvgrLCNBewqJmPtZ5VSkj3bOrDfYqgetIoo8fVGUBiYD8iJQ3VqeOYBjY67QYSACRZ8dP1XRj+OlWkBlp6mdxqHW+QelqNAYs4tiEZws0H0ecmcuF0+ta8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=47.90.198.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.bbPuEMW_1740392958 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 24 Feb 2025 18:29:18 +0800
Date: Mon, 24 Feb 2025 18:29:19 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tomas Glozar <tglozar@redhat.com>
Subject: Re: Linux 6.6.78
Cc: linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org,
 torvalds@linux-foundation.org,
 stable@vger.kernel.org,
 lwn@lwn.net,
 jslaby@suse.cz
In-Reply-To: <2025021711-elephant-decathlon-9b66@gregkh>
References: <2025021711-elephant-decathlon-9b66@gregkh>
Message-Id: <20250224182918.C75A.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.08 [en]

Hi

> I'm announcing the release of the 6.6.78 kernel.
> 
> All users of the 6.6 kernel series must upgrade.
> 
> The updated 6.6.y git tree can be found at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
> and can be browsed at the normal kernel.org git web browser:
> 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> 

please revert these 2 patches.
because the struct member kernel_workload is yet not defined.

> Tomas Glozar (6):
>       rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads
>       rtla/timerlat_top: Set OSNOISE_WORKLOAD for kernel threads

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2025/02/24



