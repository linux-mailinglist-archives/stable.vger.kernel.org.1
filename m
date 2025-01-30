Return-Path: <stable+bounces-111747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0305A236AA
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 22:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F663A73FB
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 21:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395941F0E4A;
	Thu, 30 Jan 2025 21:27:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CF01EE7C6
	for <stable@vger.kernel.org>; Thu, 30 Jan 2025 21:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738272431; cv=none; b=GY28HBwPwdbGEqwN0ujlB2ntpjWmMVCPDsOF2Gqxx1XQr8Gj65WcOVWg+6jHmrg7tnQC1JTlmWS026xuztFY5WC3HQN0pnu1JWns9r3jv/G/8uYVr6uRBVkMbtyVYescClVBl8vD+KU5EV4LVd47oLl43l9rpqwlUtM3rp+mjMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738272431; c=relaxed/simple;
	bh=y2KHYycjVfI35WupMgvrrSn2I1xNSG20tvGqyZUm0+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=gVf2/AP7ENrD3aPqxmJy2Av5IphGheL5hdiLitFqV+nWMDSLE6JSrbJNTpXLsDzroncpodPE8dvxbrpi5j8yGX9c4aTZ1sp0bFT9Q9e9CWtBzbnRjABsEjHKNWae6r40kg6Twoy43JXhspYMZllt99F528iN+exhoISbuy/2vMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from [192.168.0.103] (unknown [178.76.204.78])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 81C29233D1;
	Fri, 31 Jan 2025 00:26:58 +0300 (MSK)
Message-ID: <dd882e87-c08e-bc78-0b3b-09b097d08c94@basealt.ru>
Date: Fri, 31 Jan 2025 00:26:57 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 5.10.y 0/3] scsi: Backport fixes for CVE-2021-47182
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20241209170330.113179-1-kovalev@altlinux.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: Vasiliy Kovalev <kovalev@altlinux.org>
In-Reply-To: <20241209170330.113179-1-kovalev@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

09.12.2024 20:03, Vasiliy Kovalev wrote:
> The patch titled "scsi: core: Fix scsi_mode_sense() buffer length handling"
> addresses CVE-2021-47182, fixing the following issues in `scsi_mode_sense()`
> buffer length handling:
> 
> 1. Incorrect handling of the allocation length field in the MODE SENSE(10)
>     command, causing truncation of buffer lengths larger than 255 bytes.
> 
> 2. Memory corruption when handling small buffer lengths due to lack of proper
>     validation.
> 
> CVE announcement in linux-cve-announce:
> https://lore.kernel.org/linux-cve-announce/2024041032-CVE-2021-47182-377e@gregkh/
> Fixed versions:
> - Fixed in 5.15.5 with commit e15de347faf4
> - Fixed in 5.16 with commit 17b49bcbf835
> 
> Official CVE entry:
> https://cve.org/CVERecord/?id=CVE-2021-47182
> 
> ---
> v2: To ensure consistency and completeness of the fixes, this backport
> includes all 3 patches from the series [1].
> In addition to the first patch that addresses the CVE, the second and
> third patches are included, which prevent further regressions and align
> with the fixes already backported and proposed for backporting [2] to
> the stable 5.15 kernel.
> 
> [1] https://lore.kernel.org/all/20210820070255.682775-1-damien.lemoal@wdc.com/
> [2] https://lore.kernel.org/all/20241209165340.112862-1-kovalev@altlinux.org/
> 
> [PATCH 5.10.y 1/3] scsi: core: Fix scsi_mode_sense() buffer length handling

Please add this [1] missing commit from this series to queue 5.10.y.

[1] 
https://lore.kernel.org/all/20241209170330.113179-2-kovalev@altlinux.org/

The other two have already been added in 5.10.231:

> [PATCH 5.10.y 2/3] scsi: core: Fix scsi_mode_select() buffer length handling
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.15.y&id=154cf95664de63382a397205ea6254ed5b769ec2

> [PATCH 5.10.y 3/3] scsi: sd: Fix sd_do_mode_sense() buffer length handling
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.10.y&id=a0777b45095f5ec3c220f074cfc9cc9721a455b0

> 

-- 
--
Thanks,
Vasiliy

