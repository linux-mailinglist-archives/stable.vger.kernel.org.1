Return-Path: <stable+bounces-241752-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOFgGyb48GkpbgEAu9opvQ
	(envelope-from <stable+bounces-241752-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 20:10:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCB648A76E
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 20:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF3D13130843
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 18:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C576A4611E8;
	Tue, 28 Apr 2026 18:06:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF424657F8;
	Tue, 28 Apr 2026 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777399562; cv=none; b=AepPBLzdDymnQKNa+VMKFXXtjmD12LDVTN/5Ussapt2Xf9iZyhRJ++qT+5YhCvJowDIZ1ZXQMoH163+HnDBJ6P93OnPMcYdiR46KDKEF5y72LzsRHearENQ4S1pUCP21nyWaE9mboRbTijzvgHa/Bfb6KNjosPj/ir5oKrP9OLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777399562; c=relaxed/simple;
	bh=bbEXpEfs6dCNRnczgeeU3GweJqdrd4bPoA9yWRJvzm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cy6md3yZ/CbQXMoRavNv5LBhiEUM2ZkBkf3lPeTFP3Ivt/ojAqJV3ft9LDriDlBsklY8XYYQZuvGmOoUq/foWHZMYfMk0PFCjR9LFCJwtyVD5KqsLzq0xNNTHPhrEn/gPS7DIaC5bRNVT+uYvAkYXxaxln1dCTM0657xDX8Msj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.104] (213.87.153.112) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 28 Apr
 2026 20:50:33 +0300
Message-ID: <756c03d6-d36a-4774-88ff-635e9f8a1437@omp.ru>
Date: Tue, 28 Apr 2026 20:50:32 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y] ata: pata_sil680: fix result type of
 sil680_sel{dev|reg}()
To: Rand Deeb <rand.sec96@gmail.com>
CC: <stable@vger.kernel.org>, <axboe@kernel.dk>, <linux-ide@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <deeb.rand@confident.ru>,
	<lvc-project@linuxtesting.org>, <khoroshilov@ispras.ru>, Damien Le Moal
	<damien.lemoal@opensource.wdc.com>
References: <20260419222355.5842-1-rand.sec96@gmail.com>
 <5584ba17-bc68-4d3a-aa63-0e18c3eff22a@omp.ru>
 <CAN8dotkWCxBT-Sg=Sv+nbZCdTD=DWoHL=Kb2atFoo2KgcCjzSQ@mail.gmail.com>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <CAN8dotkWCxBT-Sg=Sv+nbZCdTD=DWoHL=Kb2atFoo2KgcCjzSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 04/28/2026 17:40:32
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 202727 [Apr 28 2026]
X-KSE-AntiSpam-Info: Version: 6.1.1.22
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 104 0.3.104
 557b3c2486a74077a103cf2acd83f2ecf4c95118
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.153.112 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.153.112 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2;213.87.153.112:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.153.112
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/28/2026 17:42:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 4/28/2026 2:22:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Rspamd-Queue-Id: EFCB648A76E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[omp.ru];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-241752-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.423];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s.shtylyov@omp.ru,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxtesting.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,omp.ru:mid,omp.ru:email,wdc.com:email]

On 4/28/26 11:15 AM, Rand Deeb wrote:

[...]

>>> From: Sergey Shtylyov <s.shtylyov@omp.ru>
>>>
>>> [ Upstream commit dafbbf5c57dd6ae01d20b894bc2200e9d9834c4e ]
>>>
>>> sil680_sel{dev|reg}() return a PCI config space address but needlessly
>>> use the *unsigned long* type for that,  whereas the PCI config space
>>> accessors take *int* for the address parameter.  Switch these functions
>>> to returning *int*, updating the local variables at their call sites.
>>> Get rid of the 'base' local variables in these functions, while at it...
>>>
>>> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
>>> analysis tool.
>>>
>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>> Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
>>> ---
>>>  drivers/ata/pata_sil680.c | 30 +++++++++++++-----------------
>>>  1 file changed, 13 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
>>> index 7ab9aea3b..fe60f884b 100644
>>> --- a/drivers/ata/pata_sil680.c
>>> +++ b/drivers/ata/pata_sil680.c
>>> @@ -47,11 +47,9 @@
>>>   *     criticial.
>>>   */
>>>
>>> -static unsigned long sil680_selreg(struct ata_port *ap, int r)
>>> +static int sil680_selreg(struct ata_port *ap, int r)
>>>  {
>>> -       unsigned long base = 0xA0 + r;
>>> -       base += (ap->port_no << 4);
>>> -       return base;
>>> +       return 0xA0 + (ap->port_no << 4) + r;
>>>  }
>>>
>>>  /**
>>> @@ -64,12 +62,9 @@ static unsigned long sil680_selreg(struct ata_port *ap, int r)
>>>   *     the unit shift.
>>>   */
>>>
>>> -static unsigned long sil680_seldev(struct ata_port *ap, struct ata_device *adev, int r)
>>> +static int sil680_seldev(struct ata_port *ap, struct ata_device *adev, int r)
>>>  {
>>> -       unsigned long base = 0xA0 + r;
>>> -       base += (ap->port_no << 4);
>>> -       base |= adev->devno ? 2 : 0;
>>> -       return base;
>>> +       return 0xA0 + (ap->port_no << 4) + r + (adev->devno << 1);
>>>  }
>>
>>    And why exactly is this needed in 5.10.y?
>>
>> [...]
>> MBR, Sergey
>>
> 
> Hi Sergey,
> 
> This is a direct backport of upstream commit dafbbf5c57dd.

   I figured. :-)

> It fixes a type mismatch between the helper functions and the
> PCI config accessors (which expect int), as identified by
> static analysis (SVACE).

   Thank you for reminding me what my patch does... :-)

> The intent is to keep the code consistent and avoid issues
> flagged by tooling.

   What tooling, Svace?

> If this is not considered appropriate for 5.10.y, I’m fine
> with dropping it.

   If I considered this a fix for something, I'd have added
the Fixes tag -- then it would be worthy of backporting. Now
it's not, I think...

> Thanks

MBR, Sergey


