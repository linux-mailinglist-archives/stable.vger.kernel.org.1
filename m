Return-Path: <stable+bounces-274124-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 63R9J1DDVWpnsgAAu9opvQ
	(envelope-from <stable+bounces-274124-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 07:04:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBDC75103E
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 07:04:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MmoElVNx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274124-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-274124-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E73263017FA5
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 05:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF071A285;
	Tue, 14 Jul 2026 05:03:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40A3286D7D
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 05:03:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784005402; cv=none; b=ILZcjyFENmWKUFwo/+pDdi99g77xXD96oNzkJev6NWG7naxIgAfUQE/QVRN1KRCdfRPJxNkD7fWbeSZVLeJq12xdOpkhk1woPikXjTSLl2rkfJ+sL0aXbTCRPuJ9dI6D86/weF4hi+WBtD4J57xGUEmp99VvEFSC173WjMl1/Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784005402; c=relaxed/simple;
	bh=/e02zoCng2yy6jKUgkGJhTRqlBX8J/D+be0zaZ2j9+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CpLRMlidqJ/5WiJVoBDrIBKWjh87pDrrDj//iK+SGiQcqspLdNAC2UQXX98HBRgJQeh9UK+1Idohd3Ni5ezCSckm5hSbib7uZrGdTibT0AseLDB+EfFp8wNXnjpOcd1X+W7Uy94zdkVbo2AbQLD94DV+A7UycAc6XxV4NSCaXG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmoElVNx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DF71F00A3A;
	Tue, 14 Jul 2026 05:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784005400;
	bh=g8cF5BmjIbHYxIcsnaFNSFE3e9chFDivIMl8jnEVFV4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MmoElVNxr44AF5mFtKrC8aBjBm22XiImwSWwv1uZxRfcJImRhW6ufOqWlrj/gIoJo
	 VZ4TH7snbAxxl8CDOAYwFyT9bLmitOHWBAtz8lA52nmrUlWQ+RteM182jyO/gtzjJj
	 0z4qdl6B/jX4g3+0J2KzZPIVOykH40FV3Wsgfj40ktsNhlZH55GQH33qfY9SuMRu3Y
	 m79uaam8ovm1JIFLPBFbnUWPwe+YNu2+7Kf7UsMpCqY0gIPNTV2W41kq1Oj0hqTdQv
	 syYym7SlJ6fr5S6ZgxiIdohPtZ8qv53tS00cydEk0DmKoaE5ZO10P1MvR+x0koYAKg
	 P/hpwfmu28Z4A==
Message-ID: <3ea09dad-9688-4f50-9939-059b8c6177fc@kernel.org>
Date: Tue, 14 Jul 2026 00:03:19 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y] efivarfs: expose used and total size
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, Anisse Astier <an.astier@criteo.com>,
 Ard Biesheuvel <ardb@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20260714043329.3510162-1-superm1@kernel.org>
 <2026071408-vividness-saga-4987@gregkh>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <2026071408-vividness-saga-4987@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:greg@kroah.com,m:stable@vger.kernel.org,m:an.astier@criteo.com,m:ardb@kernel.org,m:mario.limonciello@amd.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[superm1@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-274124-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[superm1@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,criteo.com:email,amd.com:email,hughsie.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EDBDC75103E



On 7/13/26 11:58 PM, Greg KH wrote:
> On Mon, Jul 13, 2026 at 11:33:29PM -0500, Mario Limonciello (AMD) wrote:
>> From: Anisse Astier <an.astier@criteo.com>
>>
>> When writing EFI variables, one might get errors with no other message
>> on why it fails. Being able to see how much is used by EFI variables
>> helps analyzing such issues.
>>
>> Since this is not a conventional filesystem, block size is intentionally
>> set to 1 instead of PAGE_SIZE.
>>
>> x86 quirks of reserved size are taken into account; so that available
>> and free size can be different, further helping debugging space issues.
>>
>> With this patch, one can see the remaining space in EFI variable storage
>> via efivarfs, like this:
>>
>>     $ df -h /sys/firmware/efi/efivars/
>>     Filesystem      Size  Used Avail Use% Mounted on
>>     efivarfs        176K  106K   66K  62% /sys/firmware/efi/efivars
>>
>> Signed-off-by: Anisse Astier <an.astier@criteo.com>
>> [ardb: - rename efi_reserved_space() to efivar_reserved_space()
>>         - whitespace/coding style tweaks]
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> (cherry-picked from d86ff3333cb1 ("efivarfs: expose used and total size"))
>> Adjusted for headers in linux-6.1.y
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> Cc:Steve McIntyre <steve@einval.com>
>> Cc:Richard Hughes <richard@hughsie.com>
>>
>> Background for this backport is that fwupd needs to be able to do CA
>> updates on Debian oldstable (bookworm) which tracks 6.1.7.  The CA update
>> process checks for free storage, and needs this function to do it.
> 
> What is the git id of this commit?

Oh I mentioned it above between Ard's S-o-b and mine:

d86ff3333cb1 ("efivarfs: expose used and total size")

