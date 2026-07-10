Return-Path: <stable+bounces-273154-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6LD3FJKPUGrJ1QIAu9opvQ
	(envelope-from <stable+bounces-273154-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 08:22:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7466F737986
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 08:22:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273154-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273154-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA240302B74B
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 06:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCC73955D2;
	Fri, 10 Jul 2026 06:21:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790A33AEF3E;
	Fri, 10 Jul 2026 06:21:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783664473; cv=none; b=PVY8bAQmj0eKiDmwtzt5FOzDVg9sVeDiU9j7ZoURxilMxuP36QpI8cihVyTNREpoKY+Irqkq7fbr5CBApiiN8KC8BqJBxY2wjmbEtUsnFqcLw4ScpPjj0oJ0KabrK/4EES4qyvQG8LVmwkOsKgtZf6OB0UgTPi1cTaf4vSLX3oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783664473; c=relaxed/simple;
	bh=zCI178hp/jB1MPGEjtv/ebra6nJ3w1ben+OhMzdLiaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KiNORiouys93E1PNRL/GF9dBvxgxnFfemkR3NMojSJGm4BrWR6EmkN3K+MQJcFeFUX9wL6RSi1SofKggNl2AMWqOye43/k17o2ccOy+/ZJoOgkHUccJ7I04nCIq4Vg6JVrHX0oqvSMh75HXQHhWhxHwX94k6lAzMCgy6jJgFSpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Received: from [192.168.0.150] (ip5f5af733.dynamic.kabel-deutschland.de [95.90.247.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 78AB04C288719B;
	Fri, 10 Jul 2026 08:20:56 +0200 (CEST)
Message-ID: <718783b3-89ea-41f8-8eb1-48bf0876281a@molgen.mpg.de>
Date: Fri, 10 Jul 2026 08:20:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btintel_pcie: fix memory leak in
 btintel_pcie_probe()
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260710060334.136987-1-nihaal@cse.iitm.ac.in>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260710060334.136987-1-nihaal@cse.iitm.ac.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[mpg.de];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-273154-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nihaal@cse.iitm.ac.in,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:linux-bluetooth@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[pmenzel@molgen.mpg.de,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp,iitm.ac.in:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7466F737986

Dear Abdun,


Welcome, and thank you for your patch.

Am 10.07.26 um 08:03 schrieb Abdun Nihaal:
> The memory allocated for data->workqueue is not free in some of the

free*d*

> error paths. Fix that by adding the corresponding free function.
> 
> Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> ---
> Compile tested only. Issue found using static analysis.

Maybe add that to the commit message, and the mention the tool you used.

> 
>   drivers/bluetooth/btintel_pcie.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index 7a87549f587d..870939d8450b 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -2988,6 +2988,7 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
>   	btintel_pcie_reset_bt(data);
>   
>   	destroy_workqueue(data->dump_workqueue);
> +	destroy_workqueue(data->workqueue);

gemini/gemini-3.1-pro-preview comments [1]:

> Is there a use-after-free race condition introduced here? 
> If the workqueue is destroyed while the devm-managed IRQ handler is still
> active, could an inbound device interrupt arrive before devres tears down the
> handlers? This would route to the active handler and execute queue_work()
> against the destroyed workqueue memory.


>   
>   	pci_clear_master(pdev);


Kind regards,

Paul


[1]: 
https://sashiko.dev/#/patchset/20260710060334.136987-1-nihaal%40cse.iitm.ac.in

