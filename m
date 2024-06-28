Return-Path: <stable+bounces-56081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C43C691C423
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 18:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B13A1F21EC4
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 16:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A241C8FB5;
	Fri, 28 Jun 2024 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wy6bUkCH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37E0D2E5;
	Fri, 28 Jun 2024 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719593459; cv=none; b=Lvu8BPagR0T5oEeiq4xozEApHG4IFVow5l6s1zq//Zrx/SyOUCyQPPILvgIb6Cia/dFxiDH+2JY1RCLvGj+6igPHlIPpl/7fGvJZBHkD91xd7CECeR2hz7wBKukx8itluFS5ttrwUhXsFBZ1c4HMc0BOmvylyKG5PuH3uRwJkp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719593459; c=relaxed/simple;
	bh=FTp9dSh5FyTOEWzLM6PjdK2pJf3hHq6mZMfRAEMZD4o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HMuDp/Q2dLIbn8UZV6XTkL/OUg06r6gov1N1tAZ5tMVZsnKHHZUjl8/Okl668Bqwn/TYqYN29gDczQsJwRAcwV+DzeT+88QqaH8NZg03jS8CPJOkdzwaOb2PS33os6UhjG4iF7aFgOAsZT8d8m/xc4avidIVtl3HBaENALJwzVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wy6bUkCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B0BC116B1;
	Fri, 28 Jun 2024 16:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719593459;
	bh=FTp9dSh5FyTOEWzLM6PjdK2pJf3hHq6mZMfRAEMZD4o=;
	h=Date:From:To:Cc:Subject:From;
	b=Wy6bUkCHqHDayjMwzz9r2SjJRm1cIdLflmac3xgFcgipSClkD3dOSjTjajAA87IHT
	 qSjuL2Bm7wNKovfGJFVkpSr0IBX95ST1qQYdDhhahJ4mNDkH3kevex1PyPd1N67H69
	 Rrcyly9JdISRPhrTXybELz+ubHE4qejdRcEbKd7+xHWQouUv0Wnc88OlT7EoQ/MFUn
	 psROJGbZsJsxESZGkwsbk1dmGoMGRL958amE2XJ5Fgzp2SJqsbMGuOdXI3n2/8Kr8E
	 O8Pp8MkcVuz17dloqpPz+LkOheBI3EbLBwjeN1b9NNNWvILd6203+MXBN1nCU6w2HZ
	 aVzPvzfjIriCA==
Date: Fri, 28 Jun 2024 18:50:55 +0200
From: Helge Deller <deller@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: linux-parisc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [STABLE] Please add two upstream patches into stable series
Message-ID: <Zn7p77GGtqnYatBR@p100>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg & Sasha,
the following two upstream commits missed the "stable" tag, so
could you please add them manually to stable series?

a) commit 403f17a330732a666ae793f3b15bc75bb5540524
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Fri Jun 7 13:40:45 2024 +0200
    parisc: use generic sys_fanotify_mark implementation
-> please include into kernel v5.11+

b) commit 20a50787349fadf66ac5c48f62e58d753878d2bb
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Wed Jun 19 14:27:55 2024 +0200
    parisc: use correct compat recv/recvfrom syscalls
-> please include into kernel v5.4+

Thanks!
Helge

