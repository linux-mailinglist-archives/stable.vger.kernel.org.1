Return-Path: <stable+bounces-224909-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HUYCZsQs2k9SAAAu9opvQ
	(envelope-from <stable+bounces-224909-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:14:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 786092777DE
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30121314D707
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 19:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B705540148F;
	Thu, 12 Mar 2026 19:13:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DEA3DBD70
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 19:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773342789; cv=none; b=SdmTR7kBvJg6qfozSkldZ4TCFkTzzWjbw86UNTe+3f4xrlf59El2be6mGPxGGHGOmrrFtjX8bYV+jZgiu31ctijl8qALRZuuamG+ZgwT47eXv9JEZK4aCYDGQjuTO78Vy8F2NnHzSB4T1kfBrgFJLlErce3eZjPMIZ1O1b8Iqlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773342789; c=relaxed/simple;
	bh=pg79LItd5J+5rQO75ArLdRkXPIJcXCoVNJgbJpsIi6Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=ceWhP+Un7y4PAlkYZb14HNFnRS3/vFqJKxEmklwPNB+eLBRQ7DzICcTwnFXTuervtr14LpL1QGpNTfL2lNfySuPkZanwwjJJ6zKeyBI144j/rRh4QU4ZZ3Z2LPUp3ZK4tVX9OS8ZSg0sX2zS4j2AL0+Zh0tz2mqZWVe0bX++13s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (213.87.133.121) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 12 Mar
 2026 21:57:52 +0300
Message-ID: <d6c7280b-6aa5-465f-ac5b-04fb9c592610@auroraos.dev>
Date: Thu, 12 Mar 2026 21:57:52 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 5.10.y] PCI: Check parent for NULL in
 of_pci_bus_release_domain_nr()
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
To: <stable@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>
References: <6fd6e18f-4979-4556-9dd2-cda6e703643a@omp.ru>
Content-Language: en-US
In-Reply-To: <6fd6e18f-4979-4556-9dd2-cda6e703643a@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[auroraos.dev : SPF not aligned (relaxed), No valid DKIM,quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel.dance:url,msgid.link:url];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.981];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[s.shtylyov@auroraos.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-224909-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 786092777DE
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

   I decided to not waste my time on sending the full series of the backports
for this commit. According to https://kernel.dance/#c14f7ccc9f5d, the offending
commit has been backported as far as 5.10.y -- backporting this commit should be
a no-brainer for the stable team... :-)

[...]

MBR, Sergey


