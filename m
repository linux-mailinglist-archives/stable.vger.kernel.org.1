Return-Path: <stable+bounces-267524-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0aDbLgZ5N2ruNwcAu9opvQ
	(envelope-from <stable+bounces-267524-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 07:39:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E796AA41B
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 07:39:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="1WX/wGQO";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267524-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-267524-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0EFC2300B99E
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 05:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006E833985;
	Sun, 21 Jun 2026 05:39:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4B51DDC37;
	Sun, 21 Jun 2026 05:39:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782020355; cv=none; b=bDw6BOIFVNqFXbufJYIG/pQ/duzr684ozyuGNGsPDDSEf0cEsoqLNYYht5uyhSZ4oXq4/WtfBIkgPQAeJ/hYnN6wKh6SYES7ZTxXE8pYRZ4juqT7bZLS3NIOvdWYNc0NyGhTYS7Y3LPH+Mbct8DMgm7c1LLJfMj9H4lT4xiRzBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782020355; c=relaxed/simple;
	bh=nwfuR7vyMinBAPE+rYZyPFUgqHeAIK7T9UKqDm0zf3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDBQfhfgPv6qNRwgnMRHkFR/IU0212e0qkzF5bHW2fz5wyl6OoLSz3bhqUM9K/Y9zx7VTyWPmfvOZzyiCOFY36DXOSAalNeX/nxTuiPDLf/NnScbqflZHsLTYWz0IrgqQswsokYXEXW2ylmBXV9uXqQR1Ua3HxNCRi8j6LtsmuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1WX/wGQO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2372F1F000E9;
	Sun, 21 Jun 2026 05:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782020354;
	bh=v6wADMUi0lpR3SGAx412F1px7EYsSiwMbiEhOqY2PYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=1WX/wGQOOixMWA+NDiylaUwIpM8be2nFiwb8jHguBmUowX/893TfqE/fQLX4RJyoR
	 A9c4T+oJL3M6he0b7vcbBnXAhMZtXqLpLKJJ8QzEUXo8N1dLbUGjcaz84cwlrXGPvQ
	 x4CoetNJVeKswuEeq6DiT4LQTikOcMNTqnjsKECU=
Date: Sun, 21 Jun 2026 07:39:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: XIAO WU <xiaowu.417@qq.com>
Cc: Li Xiasong <lixiasong1@huawei.com>, Jon Maloy <jmaloy@redhat.com>,
	stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Ying Xue <ying.xue@windriver.com>,
	Tuong Lien <tuong.t.lien@dektech.com.au>, netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, yuehaibing@huawei.com,
	zhangchangzhong@huawei.com, weiyongjun1@huawei.com
Subject: Re: [PATCH net] tipc: restrict socket queue dumps in enqueue
 tracepoints
Message-ID: <2026062113-reflex-enforcer-441e@gregkh>
References: <20260611135647.3666727-1-lixiasong1@huawei.com>
 <tencent_EC8B2032C1F9358EA3B49645F0F2277B210A@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_EC8B2032C1F9358EA3B49645F0F2277B210A@qq.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:xiaowu.417@qq.com,m:lixiasong1@huawei.com,m:jmaloy@redhat.com,m:stable@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ying.xue@windriver.com,m:tuong.t.lien@dektech.com.au,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:yuehaibing@huawei.com,m:zhangchangzhong@huawei.com,m:weiyongjun1@huawei.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[qq.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-267524-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 26E796AA41B

On Sun, Jun 21, 2026 at 09:21:15AM +0800, XIAO WU wrote:
> Hi Li Xiasong,
> 
> I see this patch was merged into net.git as commit acd7df8d9554 — thanks
> for the fix.  However, a Sashiko AI code review [1] flagged that
> `tipc_poll()` in the same file has the identical pre-existing issue: it
> calls `trace_tipc_sk_poll()` with `TIPC_DUMP_ALL`, which triggers a dump
> of all socket queues without holding the socket owner lock.  The merged
> fix addressed `tipc_sk_enqueue()` but left `tipc_poll()` unchanged.
> 
> I was able to reproduce the remaining use-after-free in QEMU with KASAN
> by racing `tipc_poll()` against `tipc_recvmsg()` on the same socket.

Great, can you send a fix for this?

thanks,

greg k-h

