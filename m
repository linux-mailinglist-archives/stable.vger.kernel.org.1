Return-Path: <stable+bounces-263191-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NccTGD/xL2qdJQUAu9opvQ
	(envelope-from <stable+bounces-263191-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 14:34:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B79EA686408
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 14:34:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=HUEm963I;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263191-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263191-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD5A73088E19
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 12:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CB53E7BBB;
	Mon, 15 Jun 2026 12:30:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E4E3EAC84
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 12:29:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781526601; cv=none; b=JbocGBMnxxSB/keujp8hqzFaXtFAjLgEFwzqp3oO6UAvM89hVZIehT5wfbJmUY6UEbESjlByQWAaIOj/gG26uvIPSjMrqhLAr5kzPbowi/lOihqjwmbYN5AkbVsS0UnaakRGpFhcDSPLjJ9wjiVt8jAq37D7KUPVzpwN21LY6Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781526601; c=relaxed/simple;
	bh=iTwPS/H/VVfDYH1eZmJBl+2KCDvMmgD693ZNAikgS7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9qxo61jrrP0OYSwPLPd3Imw/nv1ddvNFFqXI+CR/v2T1enW9z+7jk0Qw7aTD6hg+Ddl/g1NfDvX8jwe8T1d//PA6XVo+LUeNgbPwpVxo0jLsOqA1/ewOXgJ+Oqv97n8oRYNFmZPhKboW215Kvh9sMfVaun0thOqQBDVOnBFvZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HUEm963I; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781526597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6MxYKjqmEg82jtzqXvEH2JnVszujlKcbr71SIAlxpqU=;
	b=HUEm963IsBFLkR0/O/Z+tj+h+ioM+h4la93Si9b/1kpt3K5Rv6EbWH+CNSJTMBymsRdCKb
	+TIapnupK/GkVlK3F5XSPNdnh9kUKyfwgeRGRWy8qZhxcrgVFS3oIXle5YFmfZ3Z6hmrxP
	8TuQRbRI1udwN3mnXOQlpAMWAydXqJU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-lvM1OmnNO4exSOp_USewIg-1; Mon,
 15 Jun 2026 08:29:56 -0400
X-MC-Unique: lvM1OmnNO4exSOp_USewIg-1
X-Mimecast-MFC-AGG-ID: lvM1OmnNO4exSOp_USewIg_1781526594
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC540195E928;
	Mon, 15 Jun 2026 12:29:50 +0000 (UTC)
Received: from fedora (unknown [10.44.32.13])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E639918001D2;
	Mon, 15 Jun 2026 12:29:46 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 15 Jun 2026 14:29:50 +0200 (CEST)
Date: Mon, 15 Jun 2026 14:29:45 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Breno Leitao <leitao@debian.org>,
	Andrew Morton <akpm@linux-foundation.org>, lance.yang@linux.dev,
	Davidlohr Bueso <dave@stgolabs.net>, Qian Cai <cai@lca.pw>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/kmemleak: avoid soft lockup when scanning task
 stacks
Message-ID: <ai_wOdHprarXnURN@redhat.com>
References: <20260612-kmemleak-stack-resched-v2-1-53240de79e88@debian.org>
 <aiw9u4BllwZXDH2S@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiw9u4BllwZXDH2S@arm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263191-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS(0.00)[m:catalin.marinas@arm.com,m:leitao@debian.org,m:akpm@linux-foundation.org,m:lance.yang@linux.dev,m:dave@stgolabs.net,m:cai@lca.pw,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[oleg@redhat.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oleg@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B79EA686408

On 06/12, Catalin Marinas wrote:
>
> Yet anther variant below, untested. Basically, it follows the
> next_tgid() or task_seq_get_next() approach (we might as well move this
> to a separate function to avoid excessive indentation):
>
> 	if (kmemleak_stack_scan) {
> 		struct pid *pid;
> 		int nr = 1;
>
> 		do {
> 			struct task_struct *p = NULL;
>
> 			rcu_read_lock();
> 			pid = find_ge_pid(nr, &init_pid_ns);
> 			if (pid) {
> 				nr = pid_nr(pid) + 1;
> 				p = pid_task(pid, PIDTYPE_PID);
> 				if (p)
> 					get_task_struct(p);
> 			}
> 			rcu_read_unlock();

I don't think we need get_task_struct(p), the code above can just do

				if (p)
					stack = try_get_task_stack(p);

Oleg.


