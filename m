Return-Path: <stable+bounces-215997-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHEZMZpgjmnLBwEAu9opvQ
	(envelope-from <stable+bounces-215997-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 00:22:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C39131B4B
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 00:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B23D3031AF6
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 23:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDE21DF248;
	Thu, 12 Feb 2026 23:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tw/erl5i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D7C17C220;
	Thu, 12 Feb 2026 23:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770938516; cv=none; b=pegEhrDl9mcZHr3wgN0a0yFumR/PQeL/x+SlYJOrBKfQuZbFlqTgWNXauvitiQxH+uPeydFkfXsUQvoprHg9SBmC16IqSQ1TBJR3QdxmxWUOH5g9YiCqE/DPHOCSn5mkrPfZzYT4n2bS4DljjLdU5I8+ILw7xdePOjig9BykNK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770938516; c=relaxed/simple;
	bh=qp9sXiv6YCh7kOwFOz34uHvgOY/+lP6HG9yRJ7MwebU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DMv2uNde4jKPlamVXy+WNSkDeF86Ck9InPpr9xSrAk8awws7C9K1i8fP11kOyy1SLqoJBfC6aZ4IPpp4PyVPm8aU7jr0+1BtLuRZCdsLLkR8f+fzJ22HSPWakj2KmVLb7k6kFEe7AwNE0H/Nv+lN6VeUMu6aNcll1hft5wQtsYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tw/erl5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0237C4CEF7;
	Thu, 12 Feb 2026 23:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770938516;
	bh=qp9sXiv6YCh7kOwFOz34uHvgOY/+lP6HG9yRJ7MwebU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Tw/erl5i9fySER5rkZCKFWApobBaok/63eR0sHqXQmPaOPqXcyNDfzXq1ul9GmIqy
	 xQE2uq5b5bATz4n8TvFr0gGUBNRk4HqQrlhN+lnD3+v6asmbQnJs7LchrLBHUpQl1I
	 AHziSXdvKl/l9ph6nDlvAO2n3iEZ91xg1MircFRHXUvmTNs3GbrJZdyNKtj1iXXp9j
	 Og6gpy2spreRZrbQ1J8Ql+tlHZ3bs1TD0ZCNGYMr6EfMJnrZ23NhoICIq6ZYWoBtDG
	 mZBoEw8uE2ySvVxwolmrBVPPA6FNShcY9mxJQMmlbxZdukHVvHerFzZZK4e4QtCa8G
	 KEv8YxSBJbqpA==
From: Thomas Gleixner <tglx@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, root
 <admin@windowsforum.com>
Cc: peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
 mjfara@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [BUG] sched_mm_cid_exit+0xe2: page fault on CID bitmap write
 with nopti on 6.19.0
In-Reply-To: <31feb490-c9dc-4cb0-80bc-951e9a6cdab6@efficios.com>
References: <20260212211213.F1BE52A1C1D@windowsforum.com>
 <31feb490-c9dc-4cb0-80bc-951e9a6cdab6@efficios.com>
Date: Fri, 13 Feb 2026 00:21:52 +0100
Message-ID: <87seb58s4v.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-215997-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,vger.kernel.org,gmail.com,linuxfoundation.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 44C39131B4B
X-Rspamd-Action: no action

On Thu, Feb 12 2026 at 16:19, Mathieu Desnoyers wrote:
> On 2026-02-12 16:12, root wrote:
>> I'm hitting a repeatable page fault in sched_mm_cid_exit() on 6.19.0
>> when booting with nopti. The crash occurs during process exit
>> (do_exit -> sched_mm_cid_exit) on an atomic bit-clear (lock btr) of
>> the CID bitmap. The faulting address is within a 2MB huge page that
>> returns a permissions violation on supervisor write access.
>> 
>> The bug triggered 8 times over ~20 hours on a single boot, hitting
>> multiple unrelated processes (git, gce_workload_ce). Eventually D-Bus
>> died and systemd became non-functional, requiring a hard power-off.
>
> Can you confirm whether the following fix in Linus' tree fixes your issue ?

It's exactly that problem:

  2a:*	f0 48 0f b3 10       	lock btr %rdx,(%rax)		<-- trapping instruction

RDX: 0000000020000006

which has the TRANSIT bit set and that's what below fixes:

> commit 1e83ccd5921a ("sched/mmcid: Don't assume CID is CPU owned on mode switch")

