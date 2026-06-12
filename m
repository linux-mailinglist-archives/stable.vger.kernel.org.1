Return-Path: <stable+bounces-262837-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IP3vNtRqK2qv9AMAu9opvQ
	(envelope-from <stable+bounces-262837-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 04:11:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33ECE6763F1
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 04:11:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UlS6glMc;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262837-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262837-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F504312A0D1
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 02:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7812837FF75;
	Fri, 12 Jun 2026 02:11:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E62E2EF9;
	Fri, 12 Jun 2026 02:11:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781230277; cv=none; b=KTxRdNQ11g9hhfplkqy+99UhJYOW9CR8MzRVtvr8+9gAb0MZQ//xWR8P2vuCr6E1AwSUegeLgiH1F0Gp5y1mAg5zNzNgJT4KpsJfD1N0B0CtCctD0PjC9c3QGkcwd4d4NsoUR494yGKh2Pdo+Pe8HMAJxQuAqpqg1J3B0oMK43k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781230277; c=relaxed/simple;
	bh=zTGBTXl0ViAN2GDQrYz3xiWUW1bXEx6iD0qdjwqLlzA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s92IPTByVPqY47zNWX9/gjZVS/+IPl4lrVHRkGD3p1UFHJo4RwXu1C0YMxns2yy3pghZazkfQVfg2xOa36FL7vMR1J3lVGTwmdm85IYF0Htc1947rHM2sY2ilzVl6bvmhXt0ygTtfLeOlIGI3iPlR7Xvxe4CvtiUqNvRT2QDsDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlS6glMc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622EA1F000E9;
	Fri, 12 Jun 2026 02:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781230276;
	bh=vadAOQacVxu+iSmH7N1q5YcflWk6I88dj6tEMH9/Vos=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UlS6glMcOW0m7YUvzbP9E3nC+hlxiUVWH7MiTBPiSyJEeSH8JPihQcD4btCvFJ/sb
	 LFZYNlaB+iwBwL/DuCQgnSfwhKYF43S7VWWZ+0iFkrIWWFIbmiy8iU2RbBUcVxz/Bn
	 C0Gm3ohtNfvBnxFdkBx4i1R9d4edFozm0UGYMX7Ns/pV48TT0Ow58uF8IvBzCc6YsY
	 SJzEgnr8+qZzZD9MbwGkoKBzMKnZ77ZBCyCuRHCUfeF4p7Gev2N0//MUYC5/Ev+2zW
	 MKd2aR8gmGdBxEkdRGtD1o7w9JaJwgv06JGk39YC2AgDBMl7EhNa68mUbmzHgCGDWt
	 Q7mBIVqNqEHZQ==
Date: Thu, 11 Jun 2026 19:11:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vlad Poenaru <vlad.wing@gmail.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Thomas Gleixner <tglx@kernel.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Breno Leitao <leitao@debian.org>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH net] netpoll: run NAPI poll in softirq context to avoid
 rq->lock self-deadlock
Message-ID: <20260611191114.5bc43a59@kernel.org>
In-Reply-To: <20260610183621.3915271-1-vlad.wing@gmail.com>
References: <20260610183621.3915271-1-vlad.wing@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-262837-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,linutronix.de,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vlad.wing@gmail.com,m:bigeasy@linutronix.de,m:tglx@kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:leitao@debian.org,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:linux-rt-devel@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:frederic@kernel.org,m:vladwing@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33ECE6763F1

Please trim the pages of slop in the commit message and the comments.

On Wed, 10 Jun 2026 11:36:21 -0700 Vlad Poenaru wrote:
> @@ -194,11 +194,56 @@ void netpoll_poll_dev(struct net_device *dev)
> +	local_bh_disable();
> + 	poll_napi(dev);
> +	_local_bh_enable();

tglx, Sebastian, are you okay with using _local_bh_enable() to trick
softirq into not waking ksoftirqd? The problematic path is:

  scheduler -> printk -> netconsole -> raise softirq -> scheduler (deadlock)

so the softirq may never get serviced.

In netcons we try to avoid touching the network driver if the Tx path
locks are already held. Ideally we'd do something similar with the
scheduler. Try to do bare minimum if we may be in the scheduler.
Failing that - don't poll the driver if we were called with irqs
already disabled.

Or maybe we only poll from console->write_thread ?

