Return-Path: <stable+bounces-220009-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JVuA+MEomkGyQQAu9opvQ
	(envelope-from <stable+bounces-220009-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 21:56:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 916401BE00F
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 21:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 425FE30AA06B
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 20:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6382D37416E;
	Fri, 27 Feb 2026 20:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="lDsUIogg"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271E944DB92;
	Fri, 27 Feb 2026 20:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772225741; cv=none; b=JqowmmTurpUUQYPYEDPxEEGPUnuC5ejNCxOxo/QYtqIFqKhfrzQ6BVAXDpRAT8BrsROxW1jb77VfpGv21vc+o4nsm9ZwwnXh0pbxElZjXqraFYwPPxmvz4mTbchIECD7vDng55m4NM1JMyLNtHTV/nG+wBQ4t25GWxkeJrUheX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772225741; c=relaxed/simple;
	bh=yKbnfJ00/4NIPvfXd2Gsg6mgWCrwgN9yr3Iz6Xs78MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwiUb/+AvfAko/5yiaBiIBN+wSGCLL5wxRneI1g/8TO1Wt/RAq6MroCD+hP0QwSaSt8dpuDWDb5DOpXe6lrrAcRhDLWEZifQ8YLapgGXZngEUF53cVGyHPiMilKEKL+0ZLH839cIU38LzGnNPXngYrzBtzOhXScF6ZOpRqwQQqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=lDsUIogg; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 789BD40E0184;
	Fri, 27 Feb 2026 20:55:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id muIcxaNBuyCk; Fri, 27 Feb 2026 20:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1772225731; bh=9iDNfKsXTTJOyzMt+chboBAv/ve22A1BTcLTExG5kqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lDsUIoggBBBAJ3aTUws1Ow4EAfrml0WxUZab22HzNWYxM4ATZUqvhUPobkP65B6Ag
	 Kmo2CG7Kc/IpWsBxfUiGA0nPj4fnQh9Frfmm0YrXpBDXaB/53idX/xAxygpAK+8Hdw
	 FH09paWWWPn5vpRvXUYQOL7ykmw7JrytUqUcVNd5GxXlvIYmkuOm51wQlBAn3ppQt+
	 raadcqGYUM0KzwFZDxXnEP1MTjY3iIbI1mwd7gqIV5GqpJx2CAB86rrXWJbFaJc8oF
	 joz6up2K5znESNIdmqq01qOz9cymPvcRCPUYqeQw/irEGFXRCq+iLiORd5y12Kqsfo
	 REZBz14ytXNM627kRqlcgVyD/EmY6+jZ007GaOSrH0hrPam3mQ0i3Twz3zw+/qyp0h
	 LoOYMli8DBHYecdrw5+ZtijKh7TlAy82sbnJyTfeA8rj4CY9EkF903tHCBrx9eEHxr
	 n6sRckxA/KEyOCT2mf3QM122Qsj2FcYllbZioBRuYzayd6we+IgP/i7kFvNtj/Tkzh
	 08ApRmyWjdq04e8qjv/OwH9znQ62X4Gc3irFuwjqInmnQIE8gUDPFvWXmfPRuK/X6s
	 E7KPACpbHiHI0T87Q8JLKjkfAXnfdQArkvjg4f3lrG2fYBs9zp8pVIyE30VKTWf4T8
	 D6R8qyHOIRiPkdhQl8yIsBng=
Received: from zn.tnic (pd9530d5e.dip0.t-ipconnect.de [217.83.13.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 7EA1740E015D;
	Fri, 27 Feb 2026 20:55:21 +0000 (UTC)
Date: Fri, 27 Feb 2026 21:55:15 +0100
From: Borislav Petkov <bp@alien8.de>
To: Changyuan Lyu <changyuanl@google.com>
Cc: thomas.lendacky@amd.com, ardb@kernel.org, dave.hansen@linux.intel.com,
	kevinhui@meta.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
	stable@vger.kernel.org, tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH] x86/boot/sev: Move SEV decompressor variables into the
 .data section
Message-ID: <20260227205515.GFaaIEs0S_aZoVGekj@fat_crate.local>
References: <5648b7de5b0a5d0dfef3785f9582b718678c6448.1770217260.git.thomas.lendacky@amd.com>
 <20260226191612.1962381-1-changyuanl@google.com>
 <19F7B76A-8DC7-4CA9-9646-90931AF78CD7@alien8.de>
 <CAGzOjsopYTEoNqdtO3w58wyuDcqW4QjJUHH5K0niEfj20bZBMQ@mail.gmail.com>
 <4D33D340-F46C-4744-90F8-7B71C72FEDC8@alien8.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4D33D340-F46C-4744-90F8-7B71C72FEDC8@alien8.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220009-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[alien8.de:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 916401BE00F
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 07:38:44PM +0000, Borislav Petkov wrote:
> On February 26, 2026 7:29:56 PM UTC, Changyuan Lyu <changyuanl@google.com> wrote:
> >
> >I rebased this patch to e3c81bae4f282a6be56bc22e05e2ce3dd92ae301
> >and tested with the steps in
> >https://lore.kernel.org/all/20260226060714.1636773-1-changyuanl@google.com/.
> >This fix works for my use case (direct kernel boot without UEFI).
> >
> >Tested-by: Changyuan Lyu <changyuanl@google.com>
> 
> Thanks.

Seems to work here too. Will queue next week.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

