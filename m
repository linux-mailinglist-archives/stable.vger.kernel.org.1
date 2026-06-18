Return-Path: <stable+bounces-267046-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id irghHwmsM2qnEwYAu9opvQ
	(envelope-from <stable+bounces-267046-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 10:27:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C36A069E726
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 10:27:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dGItt6b3;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267046-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267046-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C9E030097D4
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 08:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D24E39B949;
	Thu, 18 Jun 2026 08:27:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AF738F92D;
	Thu, 18 Jun 2026 08:27:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771266; cv=none; b=CMJqFeG7nH+0iCpiPSWxKUj7P9zXdI0bfkN70qti8Mi7jvuS7MP41lCTz2Hs8YvPwd/5VJJqvFDx7NOYZms/ELNDqjJq2WtmFICkxSbYNyCjx32nmR7a+KABnt0szxvQyJQo9sMiT5Aq0w8XXMt35TetO33Tr+3wjex+N3RDCv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771266; c=relaxed/simple;
	bh=aS0apVPUMbKYFtz5HWk1NqXptXEWB6A9d3RlUBNvAn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FXNQyIpaA9rin2/xVnJAoP0MhlckmwhA4oxoov6ZrkcQh+GlQ/BBifAH7vw2ok3+10PuJOKSnNltltL1+T0805eRw5w96bualHKfmhmdS1fgZShrB2kJghVBwIKctT0R6Y6Dx9loAN/y508WcylPDxPbC8DvMU3WGrIAA4hJLEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGItt6b3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF91A1F00A3A;
	Thu, 18 Jun 2026 08:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781771265;
	bh=df2P3LLdIKFcPNMZ6yyraPQDNBfXCa18dbEbECBPaP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dGItt6b3EWpzDA0Z3vvErqdIdZgYPl7taI1f4vdMj+hQDkadCmsGWM7+olyROffTR
	 OmsRCdibeFfVgjdeUE28fQhWAugUcSWW54THgMDplI5f/P7/T5L8ibpzqMj/llblYS
	 sObi1DS1lb5fo+WNjuaxjEpV/6aNqEv1ZvSAjU9WAlQSBVEgnWf1H82clrBuf5J4Wi
	 kjJqIaHUvlJfWzRw3TOwxsdNltfnB19pjEdqo54F4iNTzvjqB2Uz6qDsUb5o0AXWYc
	 YLBlDErbqMiSYmIySBhj0iilkucIgKv73yM7URei2okB20k1f5XF3oQFE84awPPIU1
	 vqc2PJC8RFsWg==
Message-ID: <3a2e32b9-d725-4bd6-bdb7-0081962cd3fc@kernel.org>
Date: Thu, 18 Jun 2026 03:27:43 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EDAC/altera: Use parent device for devres in
 altr_portb_setup()
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, dbgh9129@gmail.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260617164303.585555-1-dinguyen@kernel.org>
 <20260617221834.GAajMdOocCPq39b-s0@fat_crate.local>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20260617221834.GAajMdOocCPq39b-s0@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267046-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dinguyen@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bp@alien8.de,m:tony.luck@intel.com,m:dbgh9129@gmail.com,m:linux-edac@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dinguyen@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C36A069E726



On 6/17/26 07:18, Borislav Petkov wrote:
> On Wed, Jun 17, 2026 at 11:43:03AM -0500, Dinh Nguyen wrote:
>> Anchor the devres group and the devm-managed IRQ requests in
>> altr_portb_setup() to the actual parent device (device->edac->dev)
>> instead of the embedded struct device inside the copied per-port
>> altr_edac_device_dev. This keeps devres_open_group(),
>> devm_request_irq(), devres_remove_group() and devres_release_group()
>> all referring to the same long-lived device so the group and the
>> resources allocated inside it are torn down together.
>>
>> Fixes: 911049845d70 ("EDAC, altera: Add Arria10 SD-MMC EDAC support")
>> Cc: stable@vger.kernel.org
>> Closes: https://sashiko.dev/#/patchset/20260503212558.2811480-1-dbgh9129%40gmail.com
>> Assisted-by: Claude:claude-opus-4-7
>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>> ---
>>   drivers/edac/altera_edac.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> How urgent is this? Can it wait until the merge window is over?
> 

Not urgent at all. It can wait until v7.2-rc1.

Thanks,
Dinh

