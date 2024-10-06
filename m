Return-Path: <stable+bounces-81198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 264CD991F9E
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 18:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC073B21754
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 16:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAD874068;
	Sun,  6 Oct 2024 16:30:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D24228EC;
	Sun,  6 Oct 2024 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728232259; cv=none; b=f7kVJxPbs3ZmL9w9fY37t4p1M7b/7w+o9YF+EPZNrv26BL8UQ8I6MQkUe6avD9wQYfK8pzo62VeUACNKJ3QzQwEVpD+DDjGSOi+zLtlSRs/1rqB7GzOG8NjW4YuXDctLfmvNmYvWlzsJ9CxuOy5e12wRItvwqVmTj+fzSiTaGxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728232259; c=relaxed/simple;
	bh=GhbHXVFrXTV4h+t9O9YExUGsfkiGJ4V8EVDKnnjWkNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iMxcwGEwWxGUAqXIgDuFbGg3LZ3Egk0NeleML//K1YnNyQ7IkHxFa7HRsPo84Lf1UGkxXsIUAPBhAOFwDjQ7xPGT2MtKe2zGBlEkXszc5d1JrVmLFSLoDeSNL+5bANcVlu96FCL8IL274+i69sJNeVxM8Z2u3iQcd7CJmz1WiNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.100] (213.87.128.249) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sun, 6 Oct
 2024 19:30:37 +0300
Message-ID: <ba0e407e-46c5-4681-862c-3204eb2e6c16@omp.ru>
Date: Sun, 6 Oct 2024 19:30:36 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "ata: pata_serverworks: Do not use the term blacklist" has
 been added to the 6.11-stable tree
To: <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>,
	<dlemoal@kernel.org>
CC: Niklas Cassel <cassel@kernel.org>
References: <20241006151837.2327-1-sashal@kernel.org>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20241006151837.2327-1-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 10/06/2024 16:15:19
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 188238 [Oct 06 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 39 0.3.39
 e168d0b3ce73b485ab2648dd465313add1404cce
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.128.249 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.128.249 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;www.kernel.org:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.128.249
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/06/2024 16:19:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10/6/2024 3:26:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 10/6/24 18:18, Sasha Levin wrote:

> This is a note to let you know that I've just added the patch titled
> 
>     ata: pata_serverworks: Do not use the term blacklist
> 
> to the 6.11-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      ata-pata_serverworks-do-not-use-the-term-blacklist.patch
> and it can be found in the queue-6.11 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

   Hm... again, what exactly does this commit fix? :-/

> commit 106fce3509096c391ee57d0482d1e857e3dfb6fb
> Author: Damien Le Moal <dlemoal@kernel.org>
> Date:   Fri Jul 26 10:58:36 2024 +0900
> 
>     ata: pata_serverworks: Do not use the term blacklist
>     
>     [ Upstream commit 858048568c9e3887d8b19e101ee72f129d65cb15 ]
>     
>     Let's not use the term blacklist in the function
>     serverworks_osb4_filter() documentation comment and rather simply refer
>     to what that function looks at: the list of devices with groken UDMA5.
>     
>     While at it, also constify the values of the csb_bad_ata100 array.
>     
>     Of note is that all of this should probably be handled using libata
>     quirk mechanism but it is unclear if these UDMA5 quirks are specific
>     to this controller only.
>     
>     Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>     Reviewed-by: Niklas Cassel <cassel@kernel.org>
>     Reviewed-by: Igor Pylypiv <ipylypiv@google.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
> index 549ff24a98231..4edddf6bcc150 100644
> --- a/drivers/ata/pata_serverworks.c
> +++ b/drivers/ata/pata_serverworks.c
> @@ -46,10 +46,11 @@
>  #define SVWKS_CSB5_REVISION_NEW	0x92 /* min PCI_REVISION_ID for UDMA5 (A2.0) */
>  #define SVWKS_CSB6_REVISION	0xa0 /* min PCI_REVISION_ID for UDMA4 (A1.0) */
>  
> -/* Seagate Barracuda ATA IV Family drives in UDMA mode 5
> - * can overrun their FIFOs when used with the CSB5 */
> -
> -static const char *csb_bad_ata100[] = {
> +/*
> + * Seagate Barracuda ATA IV Family drives in UDMA mode 5
> + * can overrun their FIFOs when used with the CSB5.
> + */
> +static const char * const csb_bad_ata100[] = {
>  	"ST320011A",
>  	"ST340016A",
>  	"ST360021A",
> @@ -163,10 +164,11 @@ static unsigned int serverworks_osb4_filter(struct ata_device *adev, unsigned in
>   *	@adev: ATA device
>   *	@mask: Mask of proposed modes
>   *
> - *	Check the blacklist and disable UDMA5 if matched
> + *	Check the list of devices with broken UDMA5 and
> + *	disable UDMA5 if matched.
>   */
> -
> -static unsigned int serverworks_csb_filter(struct ata_device *adev, unsigned int mask)
> +static unsigned int serverworks_csb_filter(struct ata_device *adev,
> +					   unsigned int mask)
>  {
>  	const char *p;
>  	char model_num[ATA_ID_PROD_LEN + 1];

MBR, Sergey


