Return-Path: <stable+bounces-120232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FF2A4DC65
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 12:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869791894DBF
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 11:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A181FFC4D;
	Tue,  4 Mar 2025 11:18:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DDC1FDE27;
	Tue,  4 Mar 2025 11:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.230.196.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741087120; cv=none; b=EaFYYDCd3zAncadb/Lcrz99f8NvAuMuCuR/243SNNUzdGosaODu6ckTvSVcO6hrEbZtjRjBi7laVDp46IMVPGYk/4rGN1onxQ2DnWF6NMo0uNeflEvJfjg3GCAexMCH3+uPYNEzCKpVcG7fRUFVsSFzS67pYPhQKqkSuXW14DNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741087120; c=relaxed/simple;
	bh=4gSmLRbTivzjiU8XEaQKI//sTOVkf96OovK/HUTeQOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2Poeuwl0pAbT903x/BAvzK6OG+gERVrwzOEYnZi3cpcMiuc6V1yZC2sbrcUKMJIHpa0ylhIMkgrU+mPfFA56/EYlJ9AJ/n7LHpkp62vau1g/QHipvepD24XcoRaW1mJl0rJdr3CqWLku8K0aSSm9Q9tlmAA8X9LKT9+hHPV07k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=37.230.196.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 908DC25037;
	Tue,  4 Mar 2025 14:18:31 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail03.astralinux.ru [10.177.185.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Tue,  4 Mar 2025 14:18:30 +0300 (MSK)
Received: from [10.177.20.114] (unknown [10.177.20.114])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4Z6Y8M73L9z1h0Rt;
	Tue,  4 Mar 2025 14:18:27 +0300 (MSK)
Message-ID: <108a8459-6024-4af1-978a-b085729825f7@astralinux.ru>
Date: Tue, 4 Mar 2025 14:18:26 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: RuPost Desktop
Subject: Re: [PATCH 6.1 1/2] erofs: handle overlapped pclusters out of crafted
 images properly
Content-Language: ru
To: Fedor Pchelkin <pchelkin@ispras.ru>,
 Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Max Kellermann <max.kellermann@ionos.com>, lvc-project@linuxtesting.org,
 syzbot+de04e06b28cfecf2281c@syzkaller.appspotmail.com,
 syzbot+c8c8238b394be4a1087d@syzkaller.appspotmail.com,
 Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org,
 Yue Hu <huyue2@coolpad.com>,
 syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Gao Xiang <xiang@kernel.org>,
 linux-erofs@lists.ozlabs.org
References: <20250228165103.26775-1-apanov@astralinux.ru>
 <20250228165103.26775-2-apanov@astralinux.ru>
 <kcsbxadkk4wow7554zonb6cjvzmkh2pbncsvioloucv3npvbtt@rpthpmo7cjja>
 <fb801c0f-105e-4aa7-80e2-fcf622179446@linux.alibaba.com>
 <3vutme7tf24cqdfbf4wjti22u6jfxjewe6gt4ufppp4xplyb5e@xls7aozstoqr>
 <0417518e-d02e-48a9-a9ce-8d2be53bc1bd@linux.alibaba.com>
 <whxlizkpoqifmcvjbxt35bnj5jpc5cx6wzy3nq47zteu5pefq3@umdsbzhl3wqm>
From: =?UTF-8?B?0JDQu9C10LrRgdC10Lkg0J/QsNC90L7Qsg==?= <apanov@astralinux.ru>
In-Reply-To: <whxlizkpoqifmcvjbxt35bnj5jpc5cx6wzy3nq47zteu5pefq3@umdsbzhl3wqm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-KSMG-AntiPhishing: NotDetected, bases: 2025/03/04 09:15:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: apanov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, lore.kernel.org:7.1.1;127.0.0.199:7.1.2;astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;new-mail.astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 191453 [Mar 04 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/03/04 09:41:00 #27591543
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/03/04 09:15:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

Hi Fedor and Gao!

Thanks for your efforts. I've sent out v2 of this patch with the
appropriate changes.

https://lore.kernel.org/all/20250304110558.8315-1-apanov@astralinux.ru/

