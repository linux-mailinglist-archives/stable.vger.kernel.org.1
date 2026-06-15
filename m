Return-Path: <stable+bounces-263429-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 08SFBktCMGoKQgUAu9opvQ
	(envelope-from <stable+bounces-263429-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 20:19:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C88689206
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 20:19:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=TuY2emd5;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263429-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263429-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D23F30701D5
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 18:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9066630DD2F;
	Mon, 15 Jun 2026 18:18:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4025630B50A
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 18:18:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781547521; cv=none; b=HBLTIhbG2ekwfIQblGwq/2AoHNNzLPH71Ql4HbkwTHbNvsuwW/V3voXquGOh31CXiJqc80oN5x7NkM83IJ7jslD4YkzvVVWvKbt9Y383r+aiJiiQuCRT3nrSdJh2rnYXoPHHi36Pq7QNCMFQh6vZdc36jG7Ubwl2vnxLDShxiZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781547521; c=relaxed/simple;
	bh=d/zJqzPDYl0eFhHJf1rXOd+s/47OZ8+fhxMbbOlibRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZYrZROFKla6l+C1EROx5qNFW6svXZjUlYxMWiStM+M8bEWSzNN2oL3pzbuIf1xa9INmBPkmdoqyNYYWpiGdXjXp69TBg8wCrRhcie/FER+4Y8JwBAuzheE7G6sQ1yuaFhY90XzTiND6+R9DPB+9fhKPXoISXRIwy+Agkpuieew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TuY2emd5; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781547519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Dnt+X/+rLGbXNim1bfemrl2ojHWdXyPMtzExzsz2m4=;
	b=TuY2emd5tp15/tiPVg2FgyOZIgu39oEu7Uo9wuhYKPHd2FF7OsH0oTL30xQXYhsvKikYqZ
	iq4Tn0qaj/BogW8mI/gz55xBdEQzxOQKPLffpIBIJEFtNICyMnwG4y/E5aS7tIoSD7Z30F
	Z12kz/jQpIYTYRAoZnsjojyMGTlS54o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-hJUVKRQ9P5m-_CoyTLxyHA-1; Mon,
 15 Jun 2026 14:18:33 -0400
X-MC-Unique: hJUVKRQ9P5m-_CoyTLxyHA-1
X-Mimecast-MFC-AGG-ID: hJUVKRQ9P5m-_CoyTLxyHA_1781547512
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8938A1955F2F;
	Mon, 15 Jun 2026 18:18:31 +0000 (UTC)
Received: from fedora (unknown [10.44.32.13])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B576F3008B37;
	Mon, 15 Jun 2026 18:18:27 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 15 Jun 2026 20:18:31 +0200 (CEST)
Date: Mon, 15 Jun 2026 20:18:26 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Breno Leitao <leitao@debian.org>,
	Andrew Morton <akpm@linux-foundation.org>, lance.yang@linux.dev,
	Davidlohr Bueso <dave@stgolabs.net>, Qian Cai <cai@lca.pw>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/kmemleak: avoid soft lockup when scanning task
 stacks
Message-ID: <ajBB8oXVOBd0NO6F@redhat.com>
References: <20260612-kmemleak-stack-resched-v2-1-53240de79e88@debian.org>
 <aiw9u4BllwZXDH2S@arm.com>
 <ai_wOdHprarXnURN@redhat.com>
 <ajAWzSN_dgD9K_FY@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajAWzSN_dgD9K_FY@arm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263429-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS(0.00)[m:catalin.marinas@arm.com,m:leitao@debian.org,m:akpm@linux-foundation.org,m:lance.yang@linux.dev,m:dave@stgolabs.net,m:cai@lca.pw,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[oleg@redhat.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 60C88689206

On 06/15, Catalin Marinas wrote:
>
> On Mon, Jun 15, 2026 at 02:29:45PM +0200, Oleg Nesterov wrote:
> > On 06/12, Catalin Marinas wrote:
> > >
> > > 	if (kmemleak_stack_scan) {
> > > 		struct pid *pid;
> > > 		int nr = 1;
> > >
> > > 		do {
> > > 			struct task_struct *p = NULL;
> > >
> > > 			rcu_read_lock();
> > > 			pid = find_ge_pid(nr, &init_pid_ns);
> > > 			if (pid) {
> > > 				nr = pid_nr(pid) + 1;
> > > 				p = pid_task(pid, PIDTYPE_PID);
> > > 				if (p)
> > > 					get_task_struct(p);
> > > 			}
> > > 			rcu_read_unlock();
> >
> > I don't think we need get_task_struct(p), the code above can just do
> >
> > 				if (p)
> > 					stack = try_get_task_stack(p);
>
> I think we still need the task_struct around. It depends on whether
> CONFIG_THREAD_INFO_IN_TASK is set but even when it is, the refcount is
> still in task_struct and task->stack_refcount does not prevent freeing
> of the task_struct. Then we have the !CONFIG_THREAD_INFO_IN_TASK where
> try_get_task_stack() does not touch any refcount.

Indeed. Thanks for correcting me.

Oleg.


