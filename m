Return-Path: <stable+bounces-219922-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QvCwGiE5oWlrrQQAu9opvQ
	(envelope-from <stable+bounces-219922-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 07:26:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B23EE1B33BA
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 07:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3843A3026C18
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 06:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A44A3E8C47;
	Fri, 27 Feb 2026 06:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=moonlit-rail.com header.i=@moonlit-rail.com header.b="BIiCfi1Z";
	dkim=permerror (0-bit key) header.d=moonlit-rail.com header.i=@moonlit-rail.com header.b="nfzf3rf2"
X-Original-To: stable@vger.kernel.org
Received: from hua.moonlit-rail.com (hua.moonlit-rail.com [45.79.167.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D197C36896C;
	Fri, 27 Feb 2026 06:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.167.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772173574; cv=none; b=enc6+dLOTw48CLqxGaxvYLYqD2bfgQJHoO6KnDEU8rCGJFXMViEf3/ulrRtsvLZ4u3eXotzy4qN3tE0Fow1x3vPTLi3Ye9C4pJPLXF7abPERs9UEMYhiqzU37b4lucCpg8t5RMIWx4W/WXcEabwBhwwrBSo12Zb1tczPJjT/q9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772173574; c=relaxed/simple;
	bh=omCANq+GO161ANZd59TZbJcYRvMmMi1XT60uk2wCXxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTj+uB4UvO92B4+6SSNS0EUyQ6Xs6queOAs7g7XZQjRXqTjxD86Y7u3CK47jQHHF5aCMQ7AWbEvh+0brZYB6FzHfaDPtg5qaalM3yaNPfn7DkSTtyiFcU+SLoG7pxhzWGAXxV1HPCqAgLf39k6kQitHJsN9uEYSi8P0DPxwjdiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonlit-rail.com; spf=pass smtp.mailfrom=moonlit-rail.com; dkim=pass (2048-bit key) header.d=moonlit-rail.com header.i=@moonlit-rail.com header.b=BIiCfi1Z; dkim=permerror (0-bit key) header.d=moonlit-rail.com header.i=@moonlit-rail.com header.b=nfzf3rf2; arc=none smtp.client-ip=45.79.167.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonlit-rail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moonlit-rail.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=moonlit-rail.com; s=rsa2021a; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SboBPE69nohA7mfKCJwIEx+BjmV4eSsPoVcPFw3dtvQ=; t=1772173571; x=1774765571; 
	b=BIiCfi1ZwHRN/Oz1KcqYRLg1N/PVE84MQfPobtKUN1+ff/WBlRlO2dKzn7GNqrmT9zav0zL0F1P
	llCCeDDNAfGqzr4wQnvAV9jlLn+0FS+gj5tj+7YeAv5JzzOkF6dqeaX2kvs6tWhjB5qZmn7IdsBqH
	hEI3vv2HkyH1EvW7K7hmGEhze1LrXUPOqWFaDfK3n3/xIEPffpFhnFWln6r2oTGDa8ErvAPqJtBwb
	Fezpxr4X4rqxQrlby9FSsz+neo2p4aqVsREdheWxOMFXnExfh73KCGY2YU/gWrCpJUpbcypUNI0tD
	y70jSWfvhGG4OjAehdsZIMrzcb2HUasXJxOQ==;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=moonlit-rail.com; s=edd2021a; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SboBPE69nohA7mfKCJwIEx+BjmV4eSsPoVcPFw3dtvQ=; t=1772173571; x=1774765571; 
	b=nfzf3rf2KhtpkgRfcCX2Os9r4LZjqYmDaM2O2vMspO1lmrqyYCk9QSg9rsDJuLvGpujuqSYrsnv
	RMnv0MSUKAQ==;
Message-ID: <bb9ab61c-3bed-4c3d-baf0-0bce4e142292@moonlit-rail.com>
Date: Fri, 27 Feb 2026 01:26:11 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.19.4 - Oops, regression
To: Greg KH <gregkh@linuxfoundation.org>
Cc: akpm@linux-foundation.org, jslaby@suse.cz, linux-kernel@vger.kernel.org,
 lwn@lwn.net, stable@vger.kernel.org, torvalds@linux-foundation.org
References: <2026022657-clambake-mountable-8175@gregkh>
 <eb2d1da9-0b4b-4887-83a4-0e2a65e703aa@moonlit-rail.com>
 <2026022612-buckskin-surfacing-d854@gregkh>
From: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>
Content-Language: en-US, en-GB
In-Reply-To: <2026022612-buckskin-surfacing-d854@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[moonlit-rail.com:s=rsa2021a,moonlit-rail.com:s=edd2021a];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[moonlit-rail.com : SPF not aligned (strict),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219922-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[moonlit-rail.com:-];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bugs-a21@moonlit-rail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:email]
X-Rspamd-Queue-Id: B23EE1B33BA
X-Rspamd-Action: no action

Greg KH wrote:
> Ick, not good.  Can you do 'git bisect' to find the problem commit?  As
> you have a pretty reliable reproducer it should go pretty fast.

Bisect complete (from 6.19.3 to 6.19.4)

> e308d4e35ce1e26cd67070a7035ad265662ab9e5 is the first bad commit
> commit e308d4e35ce1e26cd67070a7035ad265662ab9e5
> Author: Pablo Neira Ayuso <pablo@netfilter.org>
> Date:   Wed Jan 21 01:08:45 2026 +0100
> 
>     netfilter: nft_set_rbtree: translate rbtree to array for binary search
>     
>     [ Upstream commit 7e43e0a1141deec651a60109dab3690854107298 ]
>     
>     The rbtree can temporarily store overlapping inactive elements during
>     the transaction processing, leading to false negative lookups.
[snip]

Kris

P.S.  I ran the bisect from 7.0-rc1, so many reboots there, and
       it is fine.  The bug only seems to affect 6.x

