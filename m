Return-Path: <stable+bounces-106293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3728A9FE763
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 16:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802663A22B3
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 15:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AEC537E9;
	Mon, 30 Dec 2024 15:00:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2F4CA5A
	for <stable@vger.kernel.org>; Mon, 30 Dec 2024 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735570826; cv=none; b=s7qV9nkojywmdM4qCOd3Z+TYn/X+Uf7AXsr/3RdGje4HfMcrSDF/FyawZn9jGGrUBpmcTvNZoqX67xeKCGrnKnGlANTTt0EAryaPi4IC0XW+1Z/oktu81ikIvdhF+/jjhif7+PYtdCyH8MoPtpN/CTLpMnKzxOlhjybNtjJWDrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735570826; c=relaxed/simple;
	bh=3GSoGOPGYgwcLnjNEfttpY3etyVjmlLoA0IJytW4qcI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VL2SXt547Ke6T8fCEaWzAPCbIVuKsmF538hfD370Ayt+qe6GXf3neFZN6VggPy4XHKApfSc3o75aL5F7gAG5MbwOidbZZ7nZz9tzaIfd1llWqpYfWIJX9zqD2qY8d54PUj3rKeUeHLXijt9dnA1DS3yLlUO7FXT8yr97gfv5wSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [113.116.6.180])
	by smtp.qiye.163.com (Hmail) with ESMTP id 73e017e2;
	Mon, 30 Dec 2024 23:00:11 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: gregkh@linuxfoundation.org
Cc: amadeus@jmu.edu.cn,
	heiko@sntech.de,
	stable@vger.kernel.org
Subject: Re: Patch "phy: rockchip: naneng-combphy: fix phy reset" has been added to the 6.12-stable tree
Date: Mon, 30 Dec 2024 23:00:09 +0800
Message-Id: <20241230150009.173286-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2024123026-founder-sporty-a9c7@gregkh>
References: <2024123026-founder-sporty-a9c7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSRlKVhhNHUlITEseQhoaSlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkhVSkpNVU1VSkNLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09LVUpLS1VLWQ
	Y+
X-HM-Tid: 0a941814e96203a2kunm73e017e2
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PDI6Dzo4EjIUITAuAQsfKg00
	SzJPCilVSlVKTEhOTkxLQ0pKTE1LVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	SFVKSk1VTVVKQ0tZV1kIAVlBT0xINwY+

Hi,
>> Please backport this commit together:
>> arm64: dts: rockchip: add reset-names for combphy on rk3568
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=8b9c12757f919157752646faf3821abf2b7d2a64
>
> That is not in Linus's tree yet :(

These two patches are in one series. I suggest waiting for
the above patches to be merged before backport this one.
Same for the 6.1 and 6.6 stable kernel.

Thanks,
Chukun

-- 
2.25.1


