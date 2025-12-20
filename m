Return-Path: <stable+bounces-203140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52278CD3067
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 15:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BF33301E58B
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 13:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7819429AAFA;
	Sat, 20 Dec 2025 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HnwjqGb+"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68ED2EFD86;
	Sat, 20 Dec 2025 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766239004; cv=none; b=cx1KIbVW1PbpzJ0V4am9ujX+etRRct507uc6Hm/U1qWHb3E/sz22YO64Mqs8fbZs0AB1JlH4PC66Q+v6acORMh6xKrA4VqgxiBVG79nQlXSVbdaj2pM6VTzRduDQpog3kRgqg3gh3IHiJqq29rRBp0JPWGbSriuwN1ffQbuF0YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766239004; c=relaxed/simple;
	bh=suJrVFvELInNV3Ffoqka4tOlFefEf67MTlGNgnQyX+Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=IoX6E+S70waVWFV2bG9mZPLnF1fmvieS02iySbmKyLFa+03mCpbxBCFQPR+YKnpfLFQVYj/S5V0XUI9S9Exe8IbHsApvwDfhxY7/AuZfZew8KSuvD5XinsOvkUObiQrJr2bajuuK3noTFQ8cRguHDVjz+90UnYUzuwdujNI2PUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HnwjqGb+; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1766238970; x=1766843770; i=markus.elfring@web.de;
	bh=suJrVFvELInNV3Ffoqka4tOlFefEf67MTlGNgnQyX+Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HnwjqGb+ioAKyx2hGEgS2D0PuPtVyI/yEOPlIMgwjUIDHpCywoEQZ1TBXVxI1znM
	 F0fytgaGA7RLSgsUhMeHbQT4VxPHP7gljzVvoyKPJmKH2LdMDyte2lcmPnSHKFUIO
	 LFLQdcqwxFxuQcSUftV3g6whJ7RA4s4epeiAj+GWHazB6f1cyr165rcswrcAx+UfE
	 HtkP87XD9Q3xxoUJrFXCSphQBHkkKakkyUKBa4mC+63uyL5WCIvtGAA41Y1WK7OZC
	 MxShNACyKGjbvuF0YrTD7asWLndtlivNCZNWSpTvFK6w5pwhs4La9fqWnuUKOSWvN
	 Uvworcc+pzGWSQGtMQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.215]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mav6t-1w7vsn0keZ-00d6tf; Sat, 20
 Dec 2025 14:56:10 +0100
Message-ID: <8552e5b2-16ea-42d9-978e-5d26ad0b1f15@web.de>
Date: Sat, 20 Dec 2025 14:56:07 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, linux-sh@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Kay Sievers <kay.sievers@vrfy.org>, Rich Felker <dalias@libc.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20251220062836.683611-1-lihaoxiang@isrc.iscas.ac.cn>
Subject: Re: [PATCH] sh: dma-sysfs: add missing put_device() in
 dma_create_sysfs_files()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251220062836.683611-1-lihaoxiang@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:eDtLB3VkkLZPLOh6QCMNcWc0Zfmbi98VPTtSNtgVdUyjKib3Kh9
 xYEkixiWCJmZboYec3AswsbmOYT6b6BlgtGW02MBBbPs+xoFYpNMrGFCc2yOJD5jFPRoBTL
 uiLD6vu47ROJlkLVwS1ea0PE66P5+iMc5zgBkH9AlpYcB3qXan74//hAHfKKVvR6jddHZTN
 agp43lH/ovaI3nkrMMlxg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:t10vmHPApDQ=;LdyQF9aCRiEPr+6IIINW1tPFFIJ
 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

> If device_register() fails, call put_device() to drop the device
> reference. Also, call device_unregister() if device_create_file()
> fails.

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.19-rc1#n659


You propose to complete the exception handling for two cases.
Is there a need to indicate such a detail in the summary phrase accordingly?

Regards,
Markus

