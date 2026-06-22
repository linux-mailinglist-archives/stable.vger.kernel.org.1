Return-Path: <stable+bounces-267784-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7/7QEBF1OWrqtQcAu9opvQ
	(envelope-from <stable+bounces-267784-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 19:46:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C7A6B192F
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 19:46:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=WYZSZIYQ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267784-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267784-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C3BE300B1F4
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 17:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2E02E3B15;
	Mon, 22 Jun 2026 17:46:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA963200110
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 17:46:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782150413; cv=none; b=Z5GO2Qbr2cNFt13ezOhn80YLQJRsXfz7letghkFQJyvcYktM8R+abgRB2LhECKPoBM8v0mapy345xVUGLWDqW5sYQozXsrrOi4VLSR2Huii7TiqsnE8a9Pk8e5Vzo4zBXzlYzOUcrm3sodD6ihN5Vs9SetUkPL9VwlBOPPLbgP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782150413; c=relaxed/simple;
	bh=5Md68ozpaBWQYx5mDCyb358QU5P+LGoDnzuxsdgoaMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idT0zi/pD0gmzPAO1oGCjkFWr0AfiqZHkZkMJScFehPmjr7KFfQonQUGaamTtjF8oqxfQNQ32CbgYvPD7yoFnq+19/Yk1aodMzdAkszl7vlMw2jwfu/mWbFHCaj390Q5grKQKS2CJJWid5wj5hx722/5F4VLMeVMCTDQjaF6/1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WYZSZIYQ; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782150410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ogkNTdRbHLKr+SfKtfZvK8CYRxW/59/l8+UnBjTN5IU=;
	b=WYZSZIYQEEt+PHNosZX6VNVOf8Pp4zDAcatzrODGxf2zsRBBKmhvRpOMOLCW6e8naXK6AH
	qAqirabw4/Mj/J1tOggto+CL0HOZXstPsQbyUlmS31wmmXxRGRNtsmFCpO2oEbjYPJTPZd
	tFt+P7YO6PSkNqZfZa0iHP0vh0paWiM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-Y88W61W_PXqrW7GAbp0kDw-1; Mon,
 22 Jun 2026 13:46:47 -0400
X-MC-Unique: Y88W61W_PXqrW7GAbp0kDw-1
X-Mimecast-MFC-AGG-ID: Y88W61W_PXqrW7GAbp0kDw_1782150405
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7407D1954B3A;
	Mon, 22 Jun 2026 17:46:44 +0000 (UTC)
Received: from fedora (unknown [10.44.32.50])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D746B180058D;
	Mon, 22 Jun 2026 17:46:39 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 22 Jun 2026 19:46:44 +0200 (CEST)
Date: Mon, 22 Jun 2026 19:46:37 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Christian Brauner <brauner@kernel.org>, ebiederm@xmission.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Huang <adrianhuang0701@gmail.com>,
	Marco Elver <elver@google.com>,
	Kexin Sun <kexinsun@smail.nju.edu.cn>,
	Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] signal: avoid shared siginfo namespace rewrites
Message-ID: <ajl0_fTFXHpL8P9T@redhat.com>
References: <20260622164029.11474-1-include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622164029.11474-1-include@grrlz.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,xmission.com,linux-foundation.org,infradead.org,gmail.com,google.com,smail.nju.edu.cn,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-267784-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS(0.00)[m:include@grrlz.net,m:brauner@kernel.org,m:ebiederm@xmission.com,m:akpm@linux-foundation.org,m:peterz@infradead.org,m:adrianhuang0701@gmail.com,m:elver@google.com,m:kexinsun@smail.nju.edu.cn,m:tglx@kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[oleg@redhat.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oleg@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D8C7A6B192F

On 06/22, Bradley Morgan wrote:
>
> send_signal_locked() rewrites sender ids for the target namespace.
> Group sends reuse the same siginfo, so one recipient can affect the
> next.

Hmm... I'll re-read this change tomorrow after sleep, but I am almost sure
you are you are right anyway...

I am wondering if we can conditionalize the "swap(rewritten, info)" logic
with your patch, most probably this makes no sense...

May I suggest another change on top of your fix? Make the "kernel_siginfo *info"
arg of send_signal_locked() "const". To make it more clear. Yes, the signature
of has_si_pid_and_uid() should be changed too. Up to you.

Thanks,

Oleg.

> Copy the siginfo before changing it.
>
> Fixes: 7a0cf094944e ("signal: Correct namespace fixups of si_pid and si_uid")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bradley Morgan <include@grrlz.net>
> ---
>  kernel/signal.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index b9fc7be1a169..d72d9be3a992 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1181,6 +1181,7 @@ static inline bool has_si_pid_and_uid(struct kernel_siginfo *info)
>  int send_signal_locked(int sig, struct kernel_siginfo *info,
>  		       struct task_struct *t, enum pid_type type)
>  {
> +	struct kernel_siginfo rewritten;
>  	/* Should SIGKILL or SIGSTOP be received by a pid namespace init? */
>  	bool force = false;
> 
> @@ -1194,6 +1195,9 @@ int send_signal_locked(int sig, struct kernel_siginfo *info,
>  		/* SIGKILL and SIGSTOP is special or has ids */
>  		struct user_namespace *t_user_ns;
> 
> +		rewritten = *info;
> +		info = &rewritten;
> +
>  		rcu_read_lock();
>  		t_user_ns = task_cred_xxx(t, user_ns);
>  		if (current_user_ns() != t_user_ns) {
> --
> 2.53.0
>


