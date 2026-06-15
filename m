Return-Path: <stable+bounces-263415-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7d1rF5w2MGpRQAUAu9opvQ
	(envelope-from <stable+bounces-263415-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 19:30:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B94688E1A
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 19:30:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mBf1ZR22;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263415-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263415-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1E9230DBAA8
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 17:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEB7416CED;
	Mon, 15 Jun 2026 17:23:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85F6413608;
	Mon, 15 Jun 2026 17:23:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544190; cv=none; b=OnNkNY89u+s4CdlelIDSQks9g0AngqahJvgE5sKP3T8OgEznsSBX9MZLM4yqmOMoykyoghWzSCVF1MOhnhLny6JFZbUzN+SeLWMXGf3Fzv0pT7K2bVeplwFZqhVEreE/14vCSv4KrXv9qeNuv0f9tcpm6sk7tkyShrjPNhSHWDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544190; c=relaxed/simple;
	bh=N6y0vq+NaK23z9JhdIID744AoLD2BvsZNgbM1FPQweY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ClqUd67gxztj/RaXmyZ598dkw3uA7idZqNw818P1ZkeoPb78lNroowMTH0E/+DPe9mRF1ua7qrxG8zSomzfe8JEnQOx5iL9pNUuXzm6ju5cGR2EOOtbr32tHX0cq3kQj7ktdpj0fJeQZbcr8sSiiaKxPTVG+dZk1MtcaJR+Md7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBf1ZR22; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F711F00A3A;
	Mon, 15 Jun 2026 17:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781544189;
	bh=v7e2Vt12tohS0iTXggAduooumafOG/B22gTZ2Fnf3bQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mBf1ZR22843m/HP0p0Kme6PpVVQsMzWqqId0aVbZ6gL5s/TN+8H1J0oBDtKhG73wg
	 NzW56imR8yE23jTopCHIfxuoNzVyJj03aryASnwAjtHNqfolpahhWMndvAUJ0IkWqr
	 Gcr5ZRwha6ZvDUBj0Bh2qrOzvX2LxCctp7Wwl8dEjoOrYZRTJvSxF7qzbZ4bv8fe1d
	 FyTRD14zTdRE0k+RtTUQV8DUUmifR6Ba2PsmPHrZx+D+sRWIIL0RwZ1vprBGCl0ixl
	 6OssvyuxL/4LY4u7cOOY4CLmYqpNYBqsDQDTA8D8jRgogn8K+OvOlrG0G4rBddbipA
	 kQG3qg+NkKXKw==
Date: Mon, 15 Jun 2026 10:23:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>, Kito Xu
 <veritas501@foxmail.com>, linux-kernel@vger.kernel.org, Yuxiang Yang
 <yangyx22@mails.tsinghua.edu.cn>, Ao Wang <wangao@seu.edu.cn>, Xuewei Feng
 <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, Ke Xu
 <xuke@tsinghua.edu.cn>, stable@vger.kernel.org
Subject: Re: [PATCH net] appletalk: Hold socket reference in atalk_rcv()
Message-ID: <20260615102308.49f90c0e@kernel.org>
In-Reply-To: <CANn89iLwy0tsB5wMrREnGSvmPrThyCkjHEz0hpWbCiTJSG0NCA@mail.gmail.com>
References: <20260614095226.1210-1-zhaoyz24@mails.tsinghua.edu.cn>
	<CANn89iLwy0tsB5wMrREnGSvmPrThyCkjHEz0hpWbCiTJSG0NCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-263415-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:zhaoyz24@mails.tsinghua.edu.cn,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:veritas501@foxmail.com,m:linux-kernel@vger.kernel.org,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[mails.tsinghua.edu.cn,vger.kernel.org,davemloft.net,redhat.com,kernel.org,foxmail.com,seu.edu.cn,126.com,tsinghua.edu.cn];
	MIME_TRACE(0.00)[0:+];
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
X-Rspamd-Queue-Id: A4B94688E1A

On Mon, 15 Jun 2026 09:53:59 -0700 Eric Dumazet wrote:
> > atalk_search_socket() walks the global atalk_sockets list while holding
> > atalk_sockets_lock, but it returns the matching socket after dropping the
> > lock without taking a reference.  atalk_rcv() then passes that pointer to
> > sock_queue_rcv_skb().
> >
> > That leaves a race with close().  A concurrent atalk_release() can orphan
> > the socket, remove it from atalk_sockets, and drop the final reference via
> > atalk_destroy_socket(), freeing the socket before atalk_rcv() queues the
> > incoming skb.
> >
> > On a KASAN-enabled kernel this can be reproduced by racing AppleTalk DDP
> > delivery on loopback against close/rebind of the destination DGRAM socket:
> >
> >   BUG: KASAN: slab-use-after-free in selinux_socket_sock_rcv_skb()
> >   sk_filter_trim_cap()
> >   sock_queue_rcv_skb_reason()
> >   atalk_rcv()
> >   snap_rcv()
> >   llc_rcv()
> >
> > Take a reference on the selected socket before dropping
> > atalk_sockets_lock, and put it after sock_queue_rcv_skb() has finished.
> > This keeps the socket alive for the receive path without changing socket
> > lookup semantics.  A malformed or racing receive still drops the skb on
> > queueing failure as before.  
> 
> No idea why linux still carries appletalk.
> 
> MacOS dropped it 20 years ago.

Yes. Let me try to move it to mod-orphan.

