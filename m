Return-Path: <stable+bounces-261759-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6VQ7GaxOJWqxGgIAu9opvQ
	(envelope-from <stable+bounces-261759-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:57:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD0865029C
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:57:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=QY4FP97K;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261759-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261759-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E62E23008E08
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92B5308F38;
	Sun,  7 Jun 2026 10:55:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C84318EF4
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 10:55:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780829736; cv=none; b=iv2vPXgvdmcTrjhvKmq+vuPoB91dnLo24P8YQ1xXmTwR1cWoTV7fjrdPtcG5YV8GpTiiN2FZ9zk+pJaIoq6BI8V2REH9QjxzxJtiXF2xE4TqulLLfvT29Yo6ef32e5mYHUM9YODVrCjx8eRXqqeF5KsJxKprqXKZlx0RbsruD7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780829736; c=relaxed/simple;
	bh=zDchtkG0SHxwHlkSQPxGEA64pnEyQcwoePej9IajXBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMIa5SspfO3W1Q085erPrhSyXjniIdSael89pmcKev6GglVv5iuYW2J6DU5J+Xx4JNcw/PZ/TggfmaNC7qNi6tG5Bq0DMq20rlSQMuj9iQIStB/uEgWEYog+yCvTzAQSpXp4h5y5r7CBLpNlm367o+kQEYwuQVwVpmk2WmMoCYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QY4FP97K; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780829734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M529Pw8aQ7DzKV9C1FdjvA3fcDeW8DhgDiOdy61/ANI=;
	b=QY4FP97KHpPFx7isVtGjd+j16nUnM47z9E33zEs5KzyAbFV8LH6R+1r88HWIef5h6sRi5n
	rQ6HX+WfcxAdZCeWqtYmQkzEPAJG0YUCFHzHGjoXjRTBoRoGblRWAhegNTXgjgCAMZq9ky
	1uNPUFB3fY8JOiul5o9xYF/leKI0fBw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-4YQwnNpRPiaAzfHiQUe45Q-1; Sun,
 07 Jun 2026 06:55:27 -0400
X-MC-Unique: 4YQwnNpRPiaAzfHiQUe45Q-1
X-Mimecast-MFC-AGG-ID: 4YQwnNpRPiaAzfHiQUe45Q_1780829725
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A90C918004A9;
	Sun,  7 Jun 2026 10:55:23 +0000 (UTC)
Received: from fedora (unknown [10.44.32.36])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 611511800367;
	Sun,  7 Jun 2026 10:55:14 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  7 Jun 2026 12:55:23 +0200 (CEST)
Date: Sun, 7 Jun 2026 12:55:12 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Deepanshu Kartikey <Kartikey406@gmail.com>,
	syzbot+bbe6b99feefc3a0842de@syzkaller.appspotmail.com,
	Michal Hocko <mhocko@suse.com>, Ben Segall <bsegall@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Kees Cook <kees@kernel.org>, Liam Howlett <liam@infradead.org>,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	Mel Gorman <mgorman@suse.de>, Mike Rapoport <rppt@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 7.0 015/332] kernel/fork: validate exit_signal in
 kernel_clone()
Message-ID: <aiVOEKt9QL5cvkwz@redhat.com>
References: <20260607095728.031258202@linuxfoundation.org>
 <20260607095728.598854921@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607095728.598854921@linuxfoundation.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261759-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:Kartikey406@gmail.com,m:syzbot+bbe6b99feefc3a0842de@syzkaller.appspotmail.com,m:mhocko@suse.com,m:bsegall@google.com,m:brauner@kernel.org,m:david@kernel.org,m:dietmar.eggemann@arm.com,m:mingo@redhat.com,m:juri.lelli@redhat.com,m:kees@kernel.org,m:liam@infradead.org,m:ljs@kernel.org,m:mgorman@suse.de,m:rppt@kernel.org,m:peterz@infradead.org,m:rostedt@goodmis.org,m:surenb@google.com,m:vschneid@redhat.com,m:vincent.guittot@linaro.org,m:vbabka@kernel.org,m:penguin-kernel@i-love.sakura.ne.jp,m:akpm@linux-foundation.org,m:sashal@kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[oleg@redhat.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com,syzkaller.appspotmail.com,suse.com,google.com,kernel.org,arm.com,redhat.com,infradead.org,suse.de,goodmis.org,linaro.org,i-love.sakura.ne.jp,linux-foundation.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oleg@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,bbe6b99feefc3a0842de];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CCD0865029C

On 06/07, Greg Kroah-Hartman wrote:
>
> 7.0-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Deepanshu Kartikey <kartikey406@gmail.com>
>
> [ Upstream commit 09e7827e785729f391c8d46dc71becce70d296ab ]

I don't think this is the -stable material.

> Note that this is a user-visible change: previously, passing an invalid
> exit_signal to clone() was silently accepted.  The man page for clone()
> does not document any defined behavior for invalid exit_signal values, so
> rejecting them with -EINVAL is the correct behavior.  It is unlikely that
> any sane application relies on passing an invalid exit_signal.

Yes...

This patch is the preparation for another commit 0f8e38eeb995b
("do_notify_parent: sanitize the valid_signal() checks").

Oleg.


