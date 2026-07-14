Return-Path: <stable+bounces-274046-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gUhaCdiMVWrRpwAAu9opvQ
	(envelope-from <stable+bounces-274046-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 03:11:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB9374FFD2
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 03:11:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b="Y/1T3x+B";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274046-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274046-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 982BC3088F6D
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 01:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E45A35AC2C;
	Tue, 14 Jul 2026 01:10:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D57D359A90;
	Tue, 14 Jul 2026 01:10:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783991404; cv=none; b=q0jKYgii9MdevXdxQYC/H3pCm/dUg5oR1aX2i9W6N47d7Y5N2rCxq17SWcIgP1NwLmeaq+/rb6toV5u1cHxtqV1xH9czI3Q9oUQtoTcwqwSZiCg+HhNZn5mx/ShUeWnHS8ZDV2VM9LI88O4KbmqcNhblGaxHwYw+aK/V9Svovgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783991404; c=relaxed/simple;
	bh=EUT1H8CZlfCsXwXws8p89F0ROHWTErLJ+TlcQvDyB10=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ya9MYVqxNGSufI0UpCUO689+Omiy4X/KvC1Sz5stJCfMFwVnpCki5Tu8ZwNAg1A0mvMeLKjdCSW49wA0RAF2YCbYqCyTZAYIwAcx6aUI/jRTHE3e6L7jPAk4P3p8AqZIQqNZeZs9E2cHdbQiM+VfRj7PVtSgoqjIiffS4WZfxIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Y/1T3x+B; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6434A1F000E9;
	Tue, 14 Jul 2026 01:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783991402;
	bh=i+b4ZWR6/VuhZe1ElAoguh+SBQFRchHje486puKvLfE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Y/1T3x+BYJ4sYNWNhwWm8GjEg5haH7RQcjjWP0sqA/knc0Bsryhgy7dYSipm50qeU
	 SF31BpIPBo5xZNgei+Xr6r6HAsse0gfMyLy00g5duKIdRhJz87SlYP10sZa5j5JWm3
	 qOz/H7bg4F8UjqbN57myBvANdMr2lnLau0IrGDh8=
Date: Mon, 13 Jul 2026 18:10:01 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Bradley Morgan <include@grrlz.net>
Cc: brauner@kernel.org, peterz@infradead.org, oleg@redhat.com,
 tglx@kernel.org, npiggin@gmail.com, ebiederm@xmission.com,
 pasha.tatashin@soleen.com, kees@kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+8fdf0d8e10bdde1c2e88@syzkaller.appspotmail.com
Subject: Re: [PATCH] reboot: use make_task_dead for the halt and power off
 fallback
Message-Id: <20260713181001.a46e0bf04235dd076f10d5dd@linux-foundation.org>
In-Reply-To: <20260713062332.21131-1-include@grrlz.net>
References: <20260713062332.21131-1-include@grrlz.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:include@grrlz.net,m:brauner@kernel.org,m:peterz@infradead.org,m:oleg@redhat.com,m:tglx@kernel.org,m:npiggin@gmail.com,m:ebiederm@xmission.com,m:pasha.tatashin@soleen.com,m:kees@kernel.org,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzbot+8fdf0d8e10bdde1c2e88@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-274046-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,redhat.com,gmail.com,xmission.com,soleen.com,vger.kernel.org,syzkaller.appspotmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,8fdf0d8e10bdde1c2e88];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:from_mime,linux-foundation.org:dkim,linux-foundation.org:mid,grrlz.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7CB9374FFD2

On Mon, 13 Jul 2026 06:23:32 +0000 Bradley Morgan <include@grrlz.net> wrote:

> The reboot syscall calls do_exit(0) after kernel_halt() or
> kernel_power_off().  Those are expected to stop the machine and not
> return.  When they do return, the shutdown path has already disabled
> interrupts and torn down state, and do_exit() then hits its
> WARN_ON(irqs_disabled()).

Well...  why are they returning?  Is it both kernel_halt() and
kernel_power_off()?  The report seems to indicate that
kernel_power_off() is returning.

So is there a flaw in x86 machine_power_off() which we should be
addressing?

> That is an error path, not a clean exit.  Use make_task_dead() instead
> of do_exit(0): it is built for this, fixes up the irqs disabled and
> preempt state, and bounds repeated failure via oops_limit.  This
> matches the make_task_dead pattern that exit.c already uses for the
> oops path.

And make_tsk_dead() is __noreturn.



