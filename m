Return-Path: <stable+bounces-249213-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPKODXDECmoI7gQAu9opvQ
	(envelope-from <stable+bounces-249213-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:49:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D115681A4
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF92E30414A3
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 07:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6183D669A;
	Mon, 18 May 2026 07:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIWBptgn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YrjpdpZP"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936953C3BF1
	for <stable@vger.kernel.org>; Mon, 18 May 2026 07:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090207; cv=none; b=DZ5C3IqpZEAHcm3PFebesm/WNkblhCjbYfNsDGT7sHdEStC3aahdCRQV7Lk5YZiA5lD5iwCScwTI2RdF+zp45h1rkKmoqNkiyjaVd+SJEAJPHeTnN66egBporFIzHBk0RaxvK77QYkif0GjsLBW5vtlEin2aBJz/Us/hd3shI/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090207; c=relaxed/simple;
	bh=MovC6lzwqjBIYUrOC7QBOqcc/WMNFxOnawRcJ7P2/Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9FP7JglnUV9bXPpYVToj0sy3ccwETJTxKAz2OUsav1sY6LkG8Mjys03Hk2WjVbUc9mDhyHew2FCbhI/tL/OarJBqZJX4Dp1QfbyZnmZ9vRd+GH29GJp17yKNAkYerqLjAAazP1abXDGHYWlmMGE/mxZn2x44U58A3bRxq+aLx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gIWBptgn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YrjpdpZP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779090204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dkz4o1HCLWz8eoAHqvdPjV97uEnFp10w6ezT5caacdg=;
	b=gIWBptgnAbwkqCsUNwU4yU2ZqgknRyl3PQgkm+dnNaZowdY7+kIU3dkki6QgPrRGmSQWAK
	xX8v50J8zQz1KZ20p8IyQc0ITYMzOM0VJVrdodJByFGaBw7FDhve02l4O80ciVIKHERV4M
	8lMN6cfPW85Uy6z6bM5rzWeBWib+ko0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-ABZGV2dtMEaRySX_GvZbRA-1; Mon, 18 May 2026 03:43:22 -0400
X-MC-Unique: ABZGV2dtMEaRySX_GvZbRA-1
X-Mimecast-MFC-AGG-ID: ABZGV2dtMEaRySX_GvZbRA_1779090201
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48ff0eb77b5so17836665e9.0
        for <stable@vger.kernel.org>; Mon, 18 May 2026 00:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779090201; x=1779695001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dkz4o1HCLWz8eoAHqvdPjV97uEnFp10w6ezT5caacdg=;
        b=YrjpdpZPpC5tFQjqn0D83UeDnlOFSD8D3WERvz2u0OfkH546kE4GvZCtTYgbJCMvxt
         bqVcWoph+GBR4i+eheXZZRGp7KhjJW0S6xKSU7hXrohu+bF9HHQ7+kXjfu9C2USEbWJz
         tKq1bg2y4VVfFZVhotwnco5aYNQRr+gqhpbgFKuM4nqLdGjDER5GQ08xATNpfwQVr9Bt
         huAsdIt8PeX1UJBgOtc/JVjdzuinE2nxU47InWwjZhrGsULn6pacPx4NNsLJ2fkeNwaB
         o8ZycV1CF6tYzNFNKmrehZc6oAX7Z8ABnAtGykbW6Kq5oEW9o5MEnI5NWE90PcHs+gAe
         MPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779090201; x=1779695001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkz4o1HCLWz8eoAHqvdPjV97uEnFp10w6ezT5caacdg=;
        b=V56pk/N9f4q4Y8jxMhQJjyiA/mRJPfUek+FdB2r9CU7LlkrNuiStv3jWjRl7mGHKrT
         D4ukEcv0X6N7pyUzhIQNQFhf8WD17TYlSHjPWZ+XBATaYBdD/TTKldAAEhPVlQY8EsE8
         C08pbK6L1UMEWYbQchDc0sdsyrLYrqZ0QOW5hSBf5rOYeFQK2nblI5KaMBRoncp5VAEH
         19MbPcw1cDpIW4CFwSnZxiUzqKrW+VoK4j9iOFlgrUlTrkbKFwf2Py72kf0LKRni0bVX
         dUCFnZNdc8hqzg8u2QxrNp4NaW1RjiLULpO1+6vEOMOw3L0DGkIINFhRNV2AaxiTjGr9
         ff/g==
X-Forwarded-Encrypted: i=1; AFNElJ8U4bFn2yjE4CugESOujnA1Za/03c6utxi2UcsotaBgEgn/dGJo4p9EwnJR89zczqHez0CsdC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyfoM1qJpcyL09YfcvlcwtatJN8U2M6VtEW+YBZgwxb2wHYcMQ
	NAC1SJiyXv8fqZ8NjvY8uF7d/qNPdwrvpkHIZ9VieS5voJuvc8VBiWIDW4hVhRTS18rHwPvgE+V
	r8r3bgQhaGPtv/HKX6ZG5yAmjhEwlnpO2Pmy+XLz3S73248lA7iXQ6PCyOg==
X-Gm-Gg: Acq92OF6WyShRpPdDDnlFS6DMHPol7XkdKBRMOx5a+GVbDdV9FpxihO6jL7T9c9orxO
	m42tVSE3vuMieCdWKbp9oxj3lDkxEiSx7WKAImGVphwdF1I93fy4HG8sMGOUyuG5IprRgDLTxdX
	DAVGbN5E5lG75EoNoTAt7Yyt0HATgOjs750nHa7KC9qlvrGablmZmX4ZiEFmoAoaTDAOAdHbHAE
	NzIIdRUxuz1xzRDon06lmxOOT2RvdgtHZQbZpse+oBddLVnhB2gagbQEfi9/dcXc8Xgwfe+qvUe
	F69SL6ys7wi0995LAO4kWYke1bTo8PHqzXlKvJzpk0i5U4YFIDq7jL8Q/kAIEkPqYDE01KZ0N3j
	BCATcd31ksbZTuSokVW9YH0RzDag6kzrK1mbU7GppZVTS+GC1OLTA
X-Received: by 2002:a05:600c:8189:b0:48a:9428:5522 with SMTP id 5b1f17b1804b1-48fe632249dmr217556745e9.16.1779090201291;
        Mon, 18 May 2026 00:43:21 -0700 (PDT)
X-Received: by 2002:a05:600c:8189:b0:48a:9428:5522 with SMTP id 5b1f17b1804b1-48fe632249dmr217556445e9.16.1779090200920;
        Mon, 18 May 2026 00:43:20 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.56.132])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c834besm241779275e9.3.2026.05.18.00.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 00:43:19 -0700 (PDT)
Date: Mon, 18 May 2026 09:43:18 +0200
From: "juri.lelli@redhat.com" <juri.lelli@redhat.com>
To: batcain <batcain@protonmail.com>
Cc: "peterz@infradead.org" <peterz@infradead.org>,
	"jstultz@google.com" <jstultz@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] sched/deadline: Hard lockup during CPU offline
 after commit 14a857056466
Message-ID: <agrDFlsPQxzWa9Xs@jlelli-thinkpadt14gen4.remote.csb>
References: <r16mBH1ydY4oK0PInLKwpYR2I5qZBsV5J0JsNLrXAh8OR_QC6z6lABKlcvpzgUiBuarTKtVTP977RLI4mqt64Ydtd2O3yfhRuRJkQ1JL8u8=@protonmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <r16mBH1ydY4oK0PInLKwpYR2I5qZBsV5J0JsNLrXAh8OR_QC6z6lABKlcvpzgUiBuarTKtVTP977RLI4mqt64Ydtd2O3yfhRuRJkQ1JL8u8=@protonmail.com>
X-Rspamd-Queue-Id: 91D115681A4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	FROM_DN_EQ_ADDR(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[protonmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249213-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[juri.lelli@redhat.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello,

On 16/05/26 03:07, batcain wrote:
> [1.] One line summary of the problem:sched/deadline: Hard lockup
> during CPU offline/migration due to frozen rq_clock loop in
> update_dl_revised_wakeup()
> 
> [2.] Full description of the problem/report: A deterministic hard
> lockup occurs during CPU hotplug (offlining a secondary core) on
> stable kernels containing commit
> 14a857056466be9d3d907a94e92a704ac1be149b.
> 
> When a CPU core is set offline, tasks are migrated within the
> stop_machine() context where local interrupts are fully disabled
> (irqs_disabled()). During task migration, enqueue_task_dl() calls
> update_dl_entity(). Because of the new dl_defer rule introduced for
> implicit dl_servers, the code is forced into the
> update_dl_revised_wakeup() branch.
> 
> Inside update_dl_revised_wakeup(), the logic depends on rq_clock(rq)
> to calculate laxity: u64 laxity = dl_se->deadline - rq_clock(rq);
> 
> However, under the stop_machine() noirq phase, the runqueue clock is
> stale/frozen. Since the clock does not progress across iterations
> within the enqueue loop, the mathematical state stalls. Consequently,
> dl_entity_overflow() continuously evaluates to true, trapping the
> processor core in an infinite loop inside the enqueue path, resulting
> in a system-wide hard lockup.

I cannot immediately see how this issue can affect dl-server(s), as they
cannot migrate and are de-activated on CPUs going offline.

> [3.] Keywords (keywords of the affected subsystem): sched, deadline,
> dl_server, cpuhp, hotplug, hard-lockup, regression
> 
> [4.] Kernel information (output of "uname -a" or version): Linux
> workstation 7.0.7-hardened2-1-hardened #1 SMP PREEMPT_DYNAMIC Fri, 15
> May 2026 00:03:13 +0000 x86_64 GNU/Linux
> 
> [5.] Most recent kernel version which did not have the bug: Any kernel
> release prior to the integration/backport of commit 14a857056466.
> 
> [6.] Output of Oops/Panic/Bug/Objdump: No native kernel oops/panic
> stack trace is written to disk/serial because the freeze occurs inside
> stop_machine() with interrupts masked. NMI watchdog triggers a hard
> lockup panic if aggressively armed.
> 
> [7.] A small program which triggers the problem: # echo 0 >
> /sys/devices/system/cpu/cpu1/online
> 
> [8.] Environment description (Hardware, distribution, etc.): Hardware:
> Confirmed on both AMD Zen 2 (Renoir) and AMD Zen 4 (Phoenix)
> platforms. Distribution: Arch Linux (using official
> extra/linux-hardened kernel package).

Also cannot reproduce at my end.

Thanks,
Juri


