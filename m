Return-Path: <stable+bounces-182976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F88BB1456
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 18:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5E737AECE6
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 16:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454D42877F4;
	Wed,  1 Oct 2025 16:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="UkKwVggC";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="pJ0y8IQw"
X-Original-To: stable@vger.kernel.org
Received: from mta-01.yadro.com (mta-01.yadro.com [195.3.219.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7962227AC54;
	Wed,  1 Oct 2025 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.219.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759336932; cv=none; b=kwWllJzhM8uzU0T6g+O586L5nnkOrCQ4roD6CzOnOhXsSxwykwsIAOHGO80xDUeJBDSIjetVlofLGwZsD6kpdyUG6gFaHpJrM+S5NPFNw37j+eu9lKurjsyRrRoVQx2T8RKkw68iGm2VgaWkttnFtMwHfQgKmCYB8f/SWlu8Nqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759336932; c=relaxed/simple;
	bh=TVoVBwqaUKFsNR6cH4DsWmLN/UrcY9uOgwBWZpo/Rkg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vi5bjKZd8ST7BqwmIwnQ2d5XaN+KEYHNNKkiqcZDuCNt+fVa9QRWZU608Lo5m9RN+8tYFa5Sydwt+Xhu6LcjRCfkxHeG8d8pBRW44/ayz++f4oJl2jOKbiMJMCB1b9RfvxN5z+V/N7wX8R5ysIruUE5UJX5uXKOZ+dG5Y/7AUVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=UkKwVggC; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=pJ0y8IQw; arc=none smtp.client-ip=195.3.219.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
Received: from mta-01.yadro.com (localhost [127.0.0.1])
	by mta-01.yadro.com (Postfix) with ESMTP id 486242000D;
	Wed,  1 Oct 2025 19:42:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-01.yadro.com 486242000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-02;
	t=1759336923; bh=kPROJS6eNp0rCugkjO7H9bY89HLgLr4JN7/6VlwSuhQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=UkKwVggCelVLSr04tH+RUn2Gd5fnpt9i0nRq9d2Z4vYB5K/jk79OGxK0zxZs67/28
	 mcmleRP2r3CPR0rCcumqifhRmqRwRjXI/jhS/D4PfEXQSUAjSyo2TFi+J2hLU4jKtw
	 9LEghD/3AhTuf0KslNRDZih4eIFK8bRo7ZzrW9DzqN/PUho3eyKsxhBWmpROlqabLM
	 DwlxcbuVsYEVQuWmjhEwkiIOChsfHc8L3BaCifnQgsIsO8PnTAVdhbpYpxoOPuQlnO
	 CkQt25jVB27jo5DioW8gwwvVxql43pTciv3UWVBWKnWIYKVnwfylT6ukKZz0uZA5LY
	 4i7d6O1fSlHjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1759336923; bh=kPROJS6eNp0rCugkjO7H9bY89HLgLr4JN7/6VlwSuhQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=pJ0y8IQw4VTVLha1cxkRjAXH/82Z+5Kz00wGXGkfJKZyirGsqg0IliuCeSjHVHytl
	 oS5p+TQkKq/7PhYhEW1K6Gzr9o17f/KmZFRApOGdqy9pMsMCARg7JMV2odYmuPx1jt
	 y3hNljQ//USBUTMEiujON2YwK+gnVq96oMVpNi0OTFMj02hr8veLU15D08ul+tRaBY
	 2Q5o4jxT2UkcxdfZ5QidV8mzMUHdRMDsP8HZQYePdg0Ga/xi8OwmRPuP9xdTQZwXYw
	 2VRr1M2wmcmwDk+ml0ZCZJSiL5X3823EWS3WnB3IvHHy4jsRN1G1kEoewvLCKYhMqE
	 LHM7tYuOUU5FA==
Received: from RTM-EXCH-01.corp.yadro.com (unknown [10.34.9.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mta-01.yadro.com (Postfix) with ESMTPS;
	Wed,  1 Oct 2025 19:42:02 +0300 (MSK)
Received: from T-EXCH-12.corp.yadro.com (10.34.9.214) by
 RTM-EXCH-01.corp.yadro.com (10.34.9.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Oct 2025 19:41:54 +0300
Received: from yadro.com (172.17.34.51) by T-EXCH-12.corp.yadro.com
 (10.34.9.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 1 Oct
 2025 19:41:54 +0300
Date: Wed, 1 Oct 2025 19:41:52 +0300
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Chris Leech <cleech@redhat.com>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, "Christoph
 Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Stuart Hayes
	<stuart.w.hayes@gmail.com>, <linux-nvme@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux@yadro.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] nvme-tcp: fix usage of page_frag_cache
Message-ID: <20251001164152.GB4234@yadro.com>
References: <20250929111951.6961-1-d.bogdanov@yadro.com>
 <20250930-feminine-dry-42d2705c778a@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250930-feminine-dry-42d2705c778a@redhat.com>
X-ClientProxiedBy: RTM-EXCH-04.corp.yadro.com (10.34.9.204) To
 T-EXCH-12.corp.yadro.com (10.34.9.214)
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/10/01 16:02:00 #27871772
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5

On Tue, Sep 30, 2025 at 11:31:26PM -0700, Chris Leech wrote:
> 
> On Mon, Sep 29, 2025 at 02:19:51PM +0300, Dmitry Bogdanov wrote:
> > nvme uses page_frag_cache to preallocate PDU for each preallocated request
> > of block device. Block devices are created in parallel threads,
> > consequently page_frag_cache is used in not thread-safe manner.
> > That leads to incorrect refcounting of backstore pages and premature free.
> >
> > That can be catched by !sendpage_ok inside network stack:
> >
> > WARNING: CPU: 7 PID: 467 at ../net/core/skbuff.c:6931 skb_splice_from_iter+0xfa/0x310.
> >       tcp_sendmsg_locked+0x782/0xce0
> >       tcp_sendmsg+0x27/0x40
> >       sock_sendmsg+0x8b/0xa0
> >       nvme_tcp_try_send_cmd_pdu+0x149/0x2a0
> > Then random panic may occur.
> >
> > Fix that by serializing the usage of page_frag_cache.
> 
> Thank you for reporting this. I think we can fix it without blocking the
> async namespace scanning with a mutex, by switching from a per-queue
> page_frag_cache to per-cpu. There shouldn't be a need to keep the
> page_frag allocations isolated by queue anyway.
> 
> It would be great if you could test the patch which I'll send after
> this.
> 

As I commented on your patch, a naive per-cpu cache solution is
error-prone. The complete solution will be unnecessaryly difficult.
Block device creation is not a data plane, it is a control plane, so
there is no sense to use there lockless algorithms.

My patch is a simple and error-proof already.
So, I insist on this solution.

BR,
 Dmitry

