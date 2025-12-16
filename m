Return-Path: <stable+bounces-202707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B29CC35AC
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 14:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 093FE30A8090
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DF63A5C30;
	Tue, 16 Dec 2025 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="affPBMq4"
X-Original-To: stable@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7733AD49B;
	Tue, 16 Dec 2025 13:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.241.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765892899; cv=none; b=IGzkcua+/BlaFfJ1WHUApqENG2tgd4HU+tv3+c49+dzJom5N95TD06w5tp4FYbXf7C79wqCveh6O9DQeZbVvkw1Rwfr2PYezBr1vQJn8VdbO879dY24Pz8Wg4cxL/n1G6JkMoP4qzkuwxn3zWJbytbLk5ZCEM8NUO5t/iGxAETQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765892899; c=relaxed/simple;
	bh=MJJFPU5l/IkQvxNX9Lq0VP/ykfAP0Eh22OmWK6Qz+T4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mnHXhNrP+fbTVDKHKhr3UU2qqS3V2C8DOeJuLzHkeez1TFbxLydVCycyRuwAtKRwKFx5WLHPwi/SsutXJXS9fBnM5KxoRCvN3SnWNUo4rLcNkQC0IxpTp6YkEGKdtIAvZBtIR/l0HKdhNvDHbMgh3IcBWbES6mAOrHwpo46gNNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=affPBMq4; arc=none smtp.client-ip=159.100.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.156])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 19D8020233;
	Tue, 16 Dec 2025 13:48:14 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay4.mymailcheap.com (Postfix) with ESMTPS id F16E920057;
	Tue, 16 Dec 2025 13:48:05 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id 53A3A40085;
	Tue, 16 Dec 2025 13:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1765892885; bh=MJJFPU5l/IkQvxNX9Lq0VP/ykfAP0Eh22OmWK6Qz+T4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=affPBMq4Au3vfK2G3vwYTZGIYEBMc7oUU909vh6pNNIfosmNkmc76vuVkloSPOQx/
	 vLjIwF9fnWYU6SSAIdLI2LhXxbzXdklgCY1NM/ptG6dSWDkI3f4nmRYvE8lBfPFxZd
	 MQEULRgfxXMf01dNKiXAS8YQ/KAkW4TU26VtPJCo=
Received: from [192.168.5.7] (unknown [111.40.58.141])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id E292743ADF;
	Tue, 16 Dec 2025 13:47:57 +0000 (UTC)
Message-ID: <84cb474d-c41e-40dd-9a75-704b9ebaaf45@aosc.io>
Date: Tue, 16 Dec 2025 21:47:48 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: add quirk for Wodposit WPBSNM8-256GTP to
 disable secondary temp thresholds
To: Keith Busch <kbusch@kernel.org>
Cc: linux-kernel@vger.kernel.org, Wu Haotian <rigoligo03@gmail.com>,
 Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>,
 stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <20251208132340.1317531-1-ilikara@aosc.io>
 <aUAqGO7GXRrTk4Vq@kbusch-mbp>
From: Ilikara Zheng <ilikara@aosc.io>
In-Reply-To: <aUAqGO7GXRrTk4Vq@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Queue-Id: 53A3A40085
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 10.00];
	BAYES_HAM(-0.36)[76.71%];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,aosc.io,kernel.dk,lst.de,grimberg.me,lists.infradead.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]

Hi Keith,

On 12/15/2025 11:32 PM, Keith Busch wrote:
> I'm not finding vendor 1FA0 registered on the public pci-ids, nor in the
> pcisig.com members list.

When I run command lspci -vvnnk, I got outputs below:

     01:00.0 Non-Volatile memory controller [0108]: Device [1fa0:2283] 
(prog-if 02 [NVM Express])
             Subsystem: Device [1fa0:2283]
             Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx+
             Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
             Latency: 0
             Interrupt: pin A routed to IRQ 37
             NUMA node: 0
             Region 0: Memory at 40110000 (64-bit, non-prefetchable) 
[size=16K]
             Expansion ROM at 40000000 [disabled] [size=64K]
             Capabilities: <access denied>
             Kernel driver in use: nvme

 > I just want to make sure the identifier is officially registered.

I have no idea why they didn't use their PCI Vendor ID, see 
https://pcisig.com/membership/member-companies where they used a 
different Vendor ID (0x2094).

