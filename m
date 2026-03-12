Return-Path: <stable+bounces-224857-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEGgEK62smmYOwAAu9opvQ
	(envelope-from <stable+bounces-224857-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 13:50:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2FF272036
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 13:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63ACE30185FD
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 12:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE20E3BFE2A;
	Thu, 12 Mar 2026 12:50:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA5D395279
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773319842; cv=none; b=l8ZsZ0lSSgZB0PfgvU+MIPaLE0krXVdktaBBoe/1UCfbKkD3x/qR7PrwuQNsH6edcK26kASSFqmSiU/VokVuUOORC4SduDG+5LIO2ImDueiAjD8OdyOf3DsxodhZzpGOheQuURH0ADnDth4/T7wzZbLgIIE7EHE83pxyEPX/8X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773319842; c=relaxed/simple;
	bh=kV1QKCeXB4TJv1DVrK7SE7qBQNRJBSrsSTNnfhUn4ls=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=cJXXSbiaIISlUh8PgGJd4tRUFlfuWeK3FPG6vziLVO38xG9oT1q3YRBbgM5jIbA0e10LebnUrtKlIUdqfv6XjroA9qoqo1aLR1ffttNG2hTOdn0XpWunF5+6jn+KsdtJ2ZZi+MM27a4kHLWvf6GJV8a99pxjIJwxTfvRzOKNfIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.104] (213.87.161.141) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 12 Mar
 2026 15:50:27 +0300
Message-ID: <da1ef317-51af-4078-8e9a-8b6624ccf350@omp.ru>
Date: Thu, 12 Mar 2026 15:50:26 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 5.10.y] PCI: Check parent for NULL in
 of_pci_bus_release_domain_nr()
From: Sergey Shtylyov <s.shtylyov@omp.ru>
To: <stable@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>
References: <6fd6e18f-4979-4556-9dd2-cda6e703643a@omp.ru>
Content-Language: en-US
Organization: Open Mobile Platform
In-Reply-To: <6fd6e18f-4979-4556-9dd2-cda6e703643a@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 03/12/2026 12:33:29
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 201265 [Mar 12 2026]
X-KSE-AntiSpam-Info: Version: 6.1.1.20
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 88 0.3.88
 cf79c71dc438a5d750ce7f66bc9a19dbc08dac54
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_one_susp_tld}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.161.141 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.161.141 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;patch.msgid.link:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Tracking_ip_hunter}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.161.141
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/12/2026 12:37:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 3/12/2026 11:37:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[omp.ru];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224857-lists,stable=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s.shtylyov@omp.ru,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.993];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,omp.ru:mid]
X-Rspamd-Queue-Id: DA2FF272036
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/11/26 11:39 PM, Sergey Shtylyov wrote:

> From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
> 
> [ Upstream commit f7245901de8978d829f80b3d8e36ed9a8fd18049 ]
> 
> of_pci_bus_find_domain_nr() allows its parent parameter to be NULL but
> of_pci_bus_release_domain_nr() (that undoes its effect) doesn't -- that
> means it's going to blow up while calling of_get_pci_domain_nr() if the
> parent parameter indeed happens to be NULL.  Add the missing NULL check.
> 
> Found by Linux Verification Center (linuxtesting.org) with the Svace static
> analysis tool.
> 
> Fixes: c14f7ccc9f5d ("PCI: Assign PCI domain IDs by ida_alloc()")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://patch.msgid.link/20260127203944.28588-1-s.shtylyov@auroraos.dev

   BTW, I'm sorry for sending this from the OMP account and not adding
the corresponding signoff -- sending thru mail.auroraos.dev unexpectedly
failed on me yesterday (complained about certificate) and I wanted to
send the thing out already... :-)

[...]

MBR, Sergey

