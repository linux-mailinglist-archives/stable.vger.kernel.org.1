Return-Path: <stable+bounces-267805-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IGSZJcKVOWpqvQcAu9opvQ
	(envelope-from <stable+bounces-267805-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 22:06:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C676B236E
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 22:06:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b=JmSAlrvy;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267805-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267805-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A09C302F72E
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 20:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B676D34B410;
	Mon, 22 Jun 2026 20:05:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F8F2C21FF;
	Mon, 22 Jun 2026 20:05:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782158756; cv=none; b=M7muNXED/XK7x0lW57/T5DNyl/fcZxQ0g8/sklo4mdg8s7blo9EQ67feLAxcmLdtsPPYMRmaX/rLYX4D9bv28XvrGBvOFxAphliKUxh5Cfwzyc6xpdWFwJ4wHq7AOSIn3gvjLZpnRJukxb1Dm74RXkd6ILq+CTRKanRcv56k8zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782158756; c=relaxed/simple;
	bh=ekb7irfG3v0KJG330BbVaYKyJ+lOjmtWZbx/uoMxyxI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=FhnpgTl8AX+UswU8hER9RT8sdbY36AdoIHxj5vl4MqsXewTGapm2RwsFkDj3qiRC3RxYKcT+czgl2qyc6vltoLvDVuvmyT6HTgwbLQReDi2RkeMEaJ3uz8MqU0MZDf9Rf2J7U5qmjKQ+eJlXKIsKoJpnS8s24z/5yCSEl87kzz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=JmSAlrvy; arc=none smtp.client-ip=198.167.222.108
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782158750;
	bh=0QY9WmsSEegkR8/znuKKw2NESLcnUTCfnX6JO57mUy0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=JmSAlrvyQtN4rS9FSRTeCTjvVHmGP5R0Vf14j5aA1PfeAToaI0S0GDA9ddN2XvfRo
	 3FLRV2GlKGW8JCzo8BkjmYmgGehxmpumFnMqp7wHrTexaHlqQ3U8dzYZIB1JWQnzHr
	 nvSPKWjC9qEt0J6tFzUHmWHYI+rOSfSPyBbKA7mE=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4gkfMf5tS0z6vNp;
	Mon, 22 Jun 2026 20:05:50 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4gkfMf27knz4y2q;
	Mon, 22 Jun 2026 20:05:50 +0000 (UTC)
Date: Mon, 22 Jun 2026 21:05:51 +0100
From: Bradley Morgan <include@grrlz.net>
To: Oleg Nesterov <oleg@redhat.com>
CC: Christian Brauner <brauner@kernel.org>, ebiederm@xmission.com,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Huang <adrianhuang0701@gmail.com>, Marco Elver <elver@google.com>,
 Kexin Sun <kexinsun@smail.nju.edu.cn>, Thomas Gleixner <tglx@kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] signal: avoid shared siginfo namespace rewrites
In-Reply-To: <ajl0_fTFXHpL8P9T@redhat.com>
References: <20260622164029.11474-1-include@grrlz.net> <ajl0_fTFXHpL8P9T@redhat.com>
Message-ID: <0873AC4A-3CB2-4F7B-BFE6-75D855AD22DC@grrlz.net>
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
	FREEMAIL_CC(0.00)[kernel.org,xmission.com,linux-foundation.org,infradead.org,gmail.com,google.com,smail.nju.edu.cn,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-267805-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:oleg@redhat.com,m:brauner@kernel.org,m:ebiederm@xmission.com,m:akpm@linux-foundation.org,m:peterz@infradead.org,m:adrianhuang0701@gmail.com,m:elver@google.com,m:kexinsun@smail.nju.edu.cn,m:tglx@kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,grrlz.net:dkim,grrlz.net:email,grrlz.net:mid,grrlz.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E4C676B236E

On June 22, 2026 6:46:37 PM GMT+01:00, Oleg Nesterov <oleg@redhat.com>
wrote:
>On 06/22, Bradley Morgan wrote:
>>
>> send_signal_locked() rewrites sender ids for the target namespace.
>> Group sends reuse the same siginfo, so one recipient can affect the
>> next.
>
>Hmm... I'll re-read this change tomorrow after sleep, but I am almost sure
>you are you are right anyway...

Sure! Feel free to take ur time!

>I am wondering if we can conditionalize the "swap(rewritten, info)" logic
>with your patch, most probably this makes no sense...
>
>May I suggest another change on top of your fix? Make the "kernel_siginfo
>*info"
>arg of send_signal_locked() "const". To make it more clear. Yes, the
>signature
>of has_si_pid_and_uid() should be changed too. Up to you.

I'll do it. I don't mind.

>Thanks,
>
>Oleg.
>
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

