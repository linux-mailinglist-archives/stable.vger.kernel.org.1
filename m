Return-Path: <stable+bounces-238999-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hwfVFGI45mlutgEAu9opvQ
	(envelope-from <stable+bounces-238999-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:29:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CB042D1E7
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEB5433C516C
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED6D3BFE3C;
	Mon, 20 Apr 2026 13:26:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB053BF676;
	Mon, 20 Apr 2026 13:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691580; cv=none; b=pkEP92XNy9TQs9Yf4oO6LF8ih9IK7xiIM8rpOXMpffOjuFSy9XVtYIh3CJVGe/QqixUwJrEd0YHuHEpL88Q0MrPPCCo1U0nPafDr22yxxPWJyK62FmTVwLIDlAGOqBE5kn5MZp4yY9Y3WAR0SAp6Uk14E0yX7cppcd+thZkafIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691580; c=relaxed/simple;
	bh=DNKwBGIaLjPlsb7ZI58Ka3QcN1r97FnA/wx1odcoGUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U1fA4VeDG1O+KJU5DI27SC0t8G7UNZyU7aqGOtVd3G9IZg1DSBJjGU6m3JniUXRo2jDdmxVVP1XeqzE42WyCo4cThMGTbXPj5SpTMeD3MYCAi0N8ta1YMpinm6J8GJGkSv551cRWddSWPWecPRbMyG5q3DPzcio0OuxeEPA01Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.104] (213.87.137.185) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 20 Apr
 2026 16:10:55 +0300
Message-ID: <5584ba17-bc68-4d3a-aa63-0e18c3eff22a@omp.ru>
Date: Mon, 20 Apr 2026 16:10:54 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y] ata: pata_sil680: fix result type of
 sil680_sel{dev|reg}()
To: Rand Deeb <rand.sec96@gmail.com>, <stable@vger.kernel.org>
CC: <axboe@kernel.dk>, <linux-ide@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <deeb.rand@confident.ru>,
	<lvc-project@linuxtesting.org>, <khoroshilov@ispras.ru>, Damien Le Moal
	<damien.lemoal@opensource.wdc.com>
References: <20260419222355.5842-1-rand.sec96@gmail.com>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20260419222355.5842-1-rand.sec96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 04/20/2026 13:02:31
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 202452 [Apr 20 2026]
X-KSE-AntiSpam-Info: Version: 6.1.1.22
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 100 0.3.100
 82998f6d011048b8a55d77ec41a5097a5546c4f1
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.137.185 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.137.185 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: {Tracking_ip_hunter}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.137.185
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/20/2026 13:04:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 4/20/2026 11:11:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238999-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[omp.ru];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s.shtylyov@omp.ru,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,omp.ru:mid,omp.ru:email,wdc.com:email]
X-Rspamd-Queue-Id: E4CB042D1E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/26 1:23 AM, Rand Deeb wrote:

> From: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> [ Upstream commit dafbbf5c57dd6ae01d20b894bc2200e9d9834c4e ]
> 
> sil680_sel{dev|reg}() return a PCI config space address but needlessly
> use the *unsigned long* type for that,  whereas the PCI config space
> accessors take *int* for the address parameter.  Switch these functions
> to returning *int*, updating the local variables at their call sites.
> Get rid of the 'base' local variables in these functions, while at it...
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
> ---
>  drivers/ata/pata_sil680.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
> index 7ab9aea3b..fe60f884b 100644
> --- a/drivers/ata/pata_sil680.c
> +++ b/drivers/ata/pata_sil680.c
> @@ -47,11 +47,9 @@
>   *     criticial.
>   */
> 
> -static unsigned long sil680_selreg(struct ata_port *ap, int r)
> +static int sil680_selreg(struct ata_port *ap, int r)
>  {
> -       unsigned long base = 0xA0 + r;
> -       base += (ap->port_no << 4);
> -       return base;
> +       return 0xA0 + (ap->port_no << 4) + r;
>  }
> 
>  /**
> @@ -64,12 +62,9 @@ static unsigned long sil680_selreg(struct ata_port *ap, int r)
>   *     the unit shift.
>   */
> 
> -static unsigned long sil680_seldev(struct ata_port *ap, struct ata_device *adev, int r)
> +static int sil680_seldev(struct ata_port *ap, struct ata_device *adev, int r)
>  {
> -       unsigned long base = 0xA0 + r;
> -       base += (ap->port_no << 4);
> -       base |= adev->devno ? 2 : 0;
> -       return base;
> +       return 0xA0 + (ap->port_no << 4) + r + (adev->devno << 1);
>  }

   And why exactly is this needed in 5.10.y?

[...]
MBR, Sergey


