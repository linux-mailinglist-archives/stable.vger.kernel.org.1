Return-Path: <stable+bounces-268945-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ImT/IPKOPmqvHwkAu9opvQ
	(envelope-from <stable+bounces-268945-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 16:38:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D205B6CDFFF
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 16:38:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b=PBmEcR9S;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268945-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268945-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4104930160DC
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 14:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9707E3F8883;
	Fri, 26 Jun 2026 14:36:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716613859FB;
	Fri, 26 Jun 2026 14:36:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782484587; cv=none; b=ra9fwbsF6VDikk+pWTSh3sOZ3df/r8AQ1A+r1k1GZ7I8Es9byP7lfTqWFPfAKjnNGPb95osMcHqIo9I8Qx07Ydjkh7YQ4zscg76QnfaEcAWHXZj5Y75sjZR8CbGsjcFYrPuKqd7zhbrAM4S8OJBiVOcrMpUxxE+GeDHuXeIUd+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782484587; c=relaxed/simple;
	bh=HwoQ7Hc+9baeMVRso79IcDntEW6RNB1kqlni7JORUi0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=D0e2Sr8blXAAaJSGL6R6Lpzp4y3gcHV2KNHn4H9rzWXJ16lTw2O83IHpfJcso5X8uOhtUVmJeJFFRMRQbEbv7OgNRIPJ/gI3qjKcpX/g1OgiTBvOIEnYqCxjWEOkb1CRmMVlPu9XHOOI8MP9K15BHf64rDreom3J8CyyDyb6RYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=PBmEcR9S; arc=none smtp.client-ip=185.218.207.228
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782484584;
	bh=2jdgjcMfnHgTvC7vDPfdH7xP3bL+xZK0xbYTZzjQZ5E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=PBmEcR9SzwbHeKoYzHK82/gSR8eYO9HhntEmOrA30cU0lCaqzaB/k2Qjei2uqwLlA
	 DZPtx9fTdhdvQU+hQvLMj9oLasQwdfUClwR53Ztb7FtvqmMIz2Ed6MfNWJDdQSPPBJ
	 vPpRgtr3Rf7AuQSnIhRFr2jceZYLA79a88YymGEc=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4gmysh0SDfzGpDl;
	Fri, 26 Jun 2026 14:36:24 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4gmysg5MQWzGpDh;
	Fri, 26 Jun 2026 14:36:23 +0000 (UTC)
Date: Fri, 26 Jun 2026 15:36:25 +0100
From: Bradley Morgan <include@grrlz.net>
To: Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 ebiederm@xmission.com
CC: Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Adrian Huang <adrianhuang0701@gmail.com>, Marco Elver <elver@google.com>,
 Kexin Sun <kexinsun@smail.nju.edu.cn>, Thomas Gleixner <tglx@kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] signal: avoid shared siginfo namespace rewrites
In-Reply-To: <aj6Ms6uygc1vtySn@redhat.com>
References: <20260622164029.11474-1-include@grrlz.net> <aj6Ms6uygc1vtySn@redhat.com>
Message-ID: <FC7EAB84-0845-4DA3-AD43-3B30B47507E5@grrlz.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,gmail.com,google.com,smail.nju.edu.cn,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268945-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,grrlz.net:dkim,grrlz.net:email,grrlz.net:mid,grrlz.net:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D205B6CDFFF

On June 26, 2026 3:29:07 PM GMT+01:00, Oleg Nesterov <oleg@redhat.com>
wrote:
>To avoid the confusion, let me reply to V1 again.
>
>Acked-by: Oleg Nesterov <oleg@redhat.com>
>
>IIUC Eric is fine with this change too.
>
>Andrew, can you take this fix please? We will send more changes on top
>of it.

Thanks again oleg.

Andrew did reply to V2. 

>On 06/22, Bradley Morgan wrote:
>>
>> send_signal_locked() rewrites sender ids for the target namespace.
>> Group sends reuse the same siginfo, so one recipient can affect the
>> next.
>> 
>> Copy the siginfo before changing it.
>> 
>> Fixes: 7a0cf094944e ("signal: Correct namespace fixups of si_pid and
>si_uid")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bradley Morgan <include@grrlz.net>
>> ---
>>  kernel/signal.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/kernel/signal.c b/kernel/signal.c
>> index b9fc7be1a169..d72d9be3a992 100644
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -1181,6 +1181,7 @@ static inline bool has_si_pid_and_uid(struct
>kernel_siginfo *info)
>>  int send_signal_locked(int sig, struct kernel_siginfo *info,
>>  		       struct task_struct *t, enum pid_type type)
>>  {
>> +	struct kernel_siginfo rewritten;
>>  	/* Should SIGKILL or SIGSTOP be received by a pid namespace init? */
>>  	bool force = false;
>>  
>> @@ -1194,6 +1195,9 @@ int send_signal_locked(int sig, struct
>kernel_siginfo *info,
>>  		/* SIGKILL and SIGSTOP is special or has ids */
>>  		struct user_namespace *t_user_ns;
>>  
>> +		rewritten = *info;
>> +		info = &rewritten;
>> +
>>  		rcu_read_lock();
>>  		t_user_ns = task_cred_xxx(t, user_ns);
>>  		if (current_user_ns() != t_user_ns) {
>> -- 
>> 2.53.0
>> 
>
>

Thanks!

