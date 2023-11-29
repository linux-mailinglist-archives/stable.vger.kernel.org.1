Return-Path: <stable+bounces-3175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFA97FDFC6
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 19:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D2FA1C20E45
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 18:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C225CD2D;
	Wed, 29 Nov 2023 18:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="o7QqF0Tb"
X-Original-To: stable@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4710AD71
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 10:59:23 -0800 (PST)
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
	by cmsmtp with ESMTPS
	id 8PQ4rRjI0hqFd8PmMrxyPV; Wed, 29 Nov 2023 18:59:22 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 8PmLrK8jvb8Qn8PmMr5s0Y; Wed, 29 Nov 2023 18:59:22 +0000
X-Authority-Analysis: v=2.4 cv=IuQNzZzg c=1 sm=1 tr=0 ts=65678a0a
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=7m0pAUNwt3ppyxJkgzeoew==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10
 a=-ubsauMo1vhQ0g-4glIA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7OI9D0eyAxHKpZTaNiARRfZBik1LQdu0fxFr+ZBYUKY=; b=o7QqF0TbfUWmnTNpbRbOD0FKmE
	XxBedNgtDThkbqTmx9RPT3YGhbug1lHYZ6yjmflddwTUikk07lTPqND2yl2U+5pKs/XBgQHLjuP+f
	gJjYczf5mW3iMd8268mMcupsn7pjclY38K1KwOSmVifcdUS/GCQEJizf8rKsjI86fCLeG+H55E3UF
	Am9Fq2vkVWju31xE5gqh8qGzc/OBqiNOyqIBryKfHQh23pSW/J3VdY6ppTBAIgOEn3xhkjlqKV545
	fMOY/7CScJLh4PUFQgP7kNVGChaVZ9ZYAhF8yZhY/3uz1BXvjzCRV6BiRqKfkfC7k19+PEcrfjPM6
	TzJZBYsQ==;
Received: from 187.184.156.122.cable.dyn.cableonline.com.mx ([187.184.156.122]:1245 helo=[192.168.0.28])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1r8PmL-001xh8-1J;
	Wed, 29 Nov 2023 12:59:21 -0600
Message-ID: <a4890aae-2be8-42e3-9aa1-ee62f892553f@embeddedor.com>
Date: Wed, 29 Nov 2023 12:59:19 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.5.13 regression: BUG: kernel NULL pointer dereference, address:
 0000000000000020
Content-Language: en-US
To: Dan Moulding <dan@danm.net>, sam@gentoo.org
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, toralf.foerster@gmx.de
References: <87jzq1lflc.fsf@gentoo.org> <20231128224816.6563-1-dan@danm.net>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231128224816.6563-1-dan@danm.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.156.122
X-Source-L: No
X-Exim-ID: 1r8PmL-001xh8-1J
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.156.122.cable.dyn.cableonline.com.mx ([192.168.0.28]) [187.184.156.122]:1245
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBqlliSnGt9UlhRxgMGMz2AvQMZ1F1RMUD5ALCq0cITG/xcs4BGL+UY60KA7ZZXJf1V0AE4NaOHZFExzKZWKmWz8ZVu9hGbqe5zwBc7WGycha5Uzd0mI
 u3ij7emp6Cpv92cFEmAg0ofGJCIjMPNtBsrA7W5AihWVDN5gTNMZcb4UGCWKcWrBEKA2U+mjwsJwAkHPrjVZy1Pt4S7PN4qUXJw=


> the kernel source. But a quick (and possibly imperfect) grepping seems
> to show that struct neighbor was the only one used with
> __randomize_layout. So, I *think* it might be the only one that could
> cause a problem with the recent change to the randomize_layout plugin.

Yeah, I can confirm we don't currently have any other fake flex array
in a struct with __randomize_layout. :)

--
Gustavo

