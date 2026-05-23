Return-Path: <stable+bounces-253963-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id u6A4FiXbEWq0rQYAu9opvQ
	(envelope-from <stable+bounces-253963-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 18:51:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1D75BFE3D
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 18:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43D2C3006468
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 16:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6FD314D35;
	Sat, 23 May 2026 16:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/86Sq7/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47883232395
	for <stable@vger.kernel.org>; Sat, 23 May 2026 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779555104; cv=none; b=SecAtwq80gUZnCvg184m4wJy4GmdXuhO71cRFoxVT3sT1Z4OKDGhCmY6HSZtsyQAGP4CdQFSp7qpLIuAF0omHJ9eicIj8rUbpTcBWwM0MmP7PqU91Uq3vDnoEtpqajKUhVqRQHsrHrR2DePLIrYzNbpRiIfY8+6j/KWpxpDI9uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779555104; c=relaxed/simple;
	bh=iTidN3F81Jah3XVANBRxCoojAySuHYgdDF+zBpHSWnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfRdl5oHaIRDVK4PN7OW3KCHZna4a9pwbmARTkOp9HE3sBWstVDrGTnJUSQ/Ec8q95kRv+SPDvpFt/GPNmw9FnVPgxzqM4xU4A8QNNds6F22mIFGNl3A9N7OeHkksqPR7zPgZ2G4jsH+2NFePH4T7CAjFEwYjtWM6jkArPXL0Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/86Sq7/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89021F000E9;
	Sat, 23 May 2026 16:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779555102;
	bh=joKLIL3ONfOSnnRBUuqZh/rkH2nj5hE3ZMRfcdtP0CY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H/86Sq7/kriiYFYnT+p4onX5kQnH41zVQDHZB1riI4nXTD4LxXKk+RP8A3dY4J7pF
	 mwTwN8QEUAdbRH+yhbwFdafmv8VWk93QjmgI6E87EeRKPKYvjgXuvxLK5EzPextXXd
	 QyVH0jb3Gpe/bQ32DIrK98GGQ1Z9fRd3opHrD8ufxcEHsOCpIB1p+O11BoCIKwyD9D
	 k2WtFzg4FSkGdl3maYF3CIXi9mHKb7OOdYgEv7PI9IViPRN2GvFG+713EP43gC8yNm
	 3n+nIbf+na7BzcR8vJRWIvW6YCo9L7Zq5V5gmf8vD6T6dGM5CVWqgIh3Ael076KUQH
	 4PudTPkmSwrFQ==
Date: Sat, 23 May 2026 12:51:41 -0400
From: Sasha Levin <sashal@kernel.org>
To: AlanCui4080 <me@alancui.cc>
Cc: stable@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: Patch "nvme: add quirk NVME_QUIRK_IGNORE_DEV_SUBNQN for
 144d:a808 (Samsung PM981/983/970 EVO Plus )" has been added to the
 7.0-stable tree
Message-ID: <ahHbHXj9Apy7c9VF@laps>
References: <20260523143029.590331-1-sashal@kernel.org>
 <9hBwPrIRQFOSOc3QwbVPmQ@alancui.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9hBwPrIRQFOSOc3QwbVPmQ@alancui.cc>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253963-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alancui.cc:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lkml.org:url]
X-Rspamd-Queue-Id: EA1D75BFE3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 23, 2026 at 10:40:37PM +0800, AlanCui4080 wrote:
>On Saturday, 23 May 2026 22:30，Sasha Levin wrote：
>> This is a note to let you know that I've just added the patch titled
>>
>>     nvme: add quirk NVME_QUIRK_IGNORE_DEV_SUBNQN for 144d:a808 (Samsung PM981/983/970 EVO Plus )
>>
>> to the 7.0-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      nvme-add-quirk-nvme_quirk_ignore_dev_subnqn-for-144d.patch
>> and it can be found in the queue-7.0 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>>
>>
>>
>> commit e86bd12c5a99ae20455deaa902dc8ab755d9f1e7
>> Author: Alan Cui <me@alancui.cc>
>> Date:   Thu Apr 9 16:15:25 2026 +0800
>>
>>     nvme: add quirk NVME_QUIRK_IGNORE_DEV_SUBNQN for 144d:a808 (Samsung PM981/983/970 EVO Plus )
>>
>>     [ Upstream commit 7f991e3f9b8f044640bcb5fa8570350a68932843 ]
>>
>>     The firmware for Samsung 970 Evo Plus / PM981 / PM983 does not support SUBNQN.
>>     Make quirks to suppress warnings.
>
>This commit is actually a mistake and is reverted in 7.1-rc4.
>
>https://lkml.org/lkml/2026/5/17/896
>AlanCui4080 (1):
>      Revert "nvme: add quirk NVME_QUIRK_IGNORE_DEV_SUBNQN for 144d:a808"
>
>Sorry I'm new to the kernel, and i don't know how "backport" works, but since
>this commit is a mistake, so should it to be not merged into the stable?

Now dropped, thanks.

-- 
Thanks,
Sasha

