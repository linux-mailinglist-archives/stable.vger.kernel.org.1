Return-Path: <stable+bounces-268969-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1Dl4CgCXPmqcIgkAu9opvQ
	(envelope-from <stable+bounces-268969-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:13:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3EF6CE5DF
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:13:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b=WTKB4QMl;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268969-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268969-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B54C13028B28
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 15:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20347379EFE;
	Fri, 26 Jun 2026 15:08:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC17C376BE2;
	Fri, 26 Jun 2026 15:08:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486506; cv=none; b=tuZuunyPr08ONKs1knwWIQiYOq/ATvGj3CqoTYJlYWhEFjGEvdv+Z7ej0sVfL35eVVV5eJW9K6Sa6Ev4e8RI6n7c9aEfcd3oTmJI366xbx7vM1qVyNKGz6glXBnZq6g1ZWJhWZcChv/xReY+nMDrhfoob6TZ5x/PXgt+v7Qb2Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486506; c=relaxed/simple;
	bh=F4ljnoGc/56n7H6lPb2KzFJOK3AWxFO1R1S0xmBERp8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=dxCIhBwd6+XkT0nTWtE4K6lcVYuzPh8wDQEb86+5c+s1FVXf7/GKo11n1sDMtHFoNvHcIaI5nY0sNXOwnyc37pxvX5HTTpuvYyn92jTIjpwrswujx8Py6etpdP9V+2k7syBDfJyTudswC+aTc64agxVQ9c5A/y+u3YFtLWv5CCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=WTKB4QMl; arc=none smtp.client-ip=198.167.222.108
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782486501;
	bh=F4ljnoGc/56n7H6lPb2KzFJOK3AWxFO1R1S0xmBERp8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=WTKB4QMl8XYzBMKheH0O26pR7Uov5N4X83dtdsq8IRYuXuL456THRQK2HBTixEonP
	 LxLz8G0VUP96ahsVlgJIF3wydWm0rtyfzc1izyVpjux0KbXTkoBGCf/CwYhjylo9vn
	 rx+aHYfVjBZ2+3W6pidqFKbqXaxgG3j6PwRopEZ0=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4gmzZY640wz6vX9;
	Fri, 26 Jun 2026 15:08:21 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4gmzZY32x9z4y2q;
	Fri, 26 Jun 2026 15:08:21 +0000 (UTC)
Date: Fri, 26 Jun 2026 16:08:22 +0100
From: Bradley Morgan <include@grrlz.net>
To: Oleg Nesterov <oleg@redhat.com>
CC: Andrew Morton <akpm@linux-foundation.org>, ebiederm@xmission.com,
 Christian Brauner <brauner@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Huang <adrianhuang0701@gmail.com>, Marco Elver <elver@google.com>,
 Kexin Sun <kexinsun@smail.nju.edu.cn>, Thomas Gleixner <tglx@kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] signal: avoid shared siginfo namespace rewrites
In-Reply-To: <aj6Va2nNBZvDJqP5@redhat.com>
References: <20260622164029.11474-1-include@grrlz.net> <aj6Ms6uygc1vtySn@redhat.com> <FC7EAB84-0845-4DA3-AD43-3B30B47507E5@grrlz.net> <aj6Va2nNBZvDJqP5@redhat.com>
Message-ID: <D25A403E-7A0F-4654-B4E5-F6411B4C7A4C@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[grrlz.net,reject];
	R_DKIM_ALLOW(-0.20)[grrlz.net:s=stigmate];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,xmission.com,kernel.org,infradead.org,gmail.com,google.com,smail.nju.edu.cn,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268969-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:oleg@redhat.com,m:akpm@linux-foundation.org,m:ebiederm@xmission.com,m:brauner@kernel.org,m:peterz@infradead.org,m:adrianhuang0701@gmail.com,m:elver@google.com,m:kexinsun@smail.nju.edu.cn,m:tglx@kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[grrlz.net:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,grrlz.net:dkim,grrlz.net:mid,grrlz.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B3EF6CE5DF

On June 26, 2026 4:06:19 PM GMT+01:00, Oleg Nesterov <oleg@redhat.com>
wrote:
>On 06/26, Bradley Morgan wrote:
>>
>> On June 26, 2026 3:29:07 PM GMT+01:00, Oleg Nesterov <oleg@redhat.com>
>> wrote:
>> >To avoid the confusion, let me reply to V1 again.
>> >
>> >Acked-by: Oleg Nesterov <oleg@redhat.com>
>> >
>> >IIUC Eric is fine with this change too.
>> >
>> >Andrew, can you take this fix please? We will send more changes on top
>> >of it.
>>
>> Thanks again oleg.
>>
>> Andrew did reply to V2.
>
>OOPS... where? I didn't get any email from him in this thread...
>
>Oleg.
>
>

Ahh, it was a off list email, apologies..

I don't read much to the To: field.

My bad.

Thanks!

