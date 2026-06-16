Return-Path: <stable+bounces-263738-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7Ym6H0xOMWp0gQUAu9opvQ
	(envelope-from <stable+bounces-263738-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:23:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 226E268FE21
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:23:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cv7enJ9U;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263738-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263738-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35C8C309D10D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 13:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1DB329391;
	Tue, 16 Jun 2026 13:22:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C50B2EC0AE;
	Tue, 16 Jun 2026 13:22:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781616138; cv=none; b=oUBW1p4Suw18+ceu1o49YH+siIf37vKcXJLCLEytoB9FQ5T8xu/aQN/D+dQjFYM24Khmp+9CUFgfBYEWC/XiWSfvYkORgJGUYOZxn3l8YuEYTD3/AsUkOfSJmDAKmFvOyJ2PWuedpmfPnnm0C9lBMd2wo5MVMbCKnLGb4lVgNpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781616138; c=relaxed/simple;
	bh=TsXinStHtWl5K2yKuHlOl4bUsbZy1AvuMwCW0izFIC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGyxGqpfQ+O/2F+mSVJ1F5NiGhaFjXnkcVZGjert6grhoV29/XszEHdXQMIrpitOzNswJUFFo01PS/Q2IV0duY0vZ1oLyQ5QPIaj4cmz7WXpU/9F85KXBwr6AF3+VvW394hLu7sy84SXXbo8DTdbpNEGdwhg8052MxDib8RBWzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cv7enJ9U; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45E71F000E9;
	Tue, 16 Jun 2026 13:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781616136;
	bh=1+P+K7C8m0gS0Giz5lDKi9nkVJKlfkfqXl54LcBLclk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cv7enJ9UBb2POCviyNZNStx6GndmMuKnRkVvOD3ViojcbKq5JI/TVcWqwiI89e/Ik
	 kSgGc3YJ85kE8kl/WvgQjuK08NQj0CxajlK2nr0nrQfz0ZpJykOligD5PryyE3piPk
	 3t1Ls0JsJGieKh/RWTtOfroDJhz2awYJXmb4jAMu9HUcpGn7+t7GrXm5pOwuXvvvCr
	 SS+Aw4wZJp2dUXuzMwoF/N5EOYoExSUjBKeIhAmp30fbsmnzwvV0lMWQdvMEr/A3G5
	 Ds/NrzC5t+koTqX533cttr74mI/ATLNtRgKBOuICcR2l1a2Asm8SwgVMdccHKUYZ9J
	 zkcyuTpkp2Kew==
Date: Tue, 16 Jun 2026 14:22:11 +0100
From: Simon Horman <horms@kernel.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>, Kito Xu <veritas501@foxmail.com>,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] appletalk: fix TOCTOU race in atalk_sendmsg
Message-ID: <20260616132211.GT712698@horms.kernel.org>
References: <20260615090635.1549-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615090635.1549-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263738-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zhaoyz24@mails.tsinghua.edu.cn,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kees@kernel.org,m:veritas501@foxmail.com,m:linux-kernel@vger.kernel.org,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,foxmail.com,mails.tsinghua.edu.cn,seu.edu.cn,126.com,tsinghua.edu.cn];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,tsinghua.edu.cn:email,seu.edu.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 226E268FE21

On Mon, Jun 15, 2026 at 05:06:33PM +0800, Yizhou Zhao wrote:
> atalk_sendmsg() looks up an AppleTalk route, stores the returned
> atalk_route and net_device pointers, and then drops the socket lock
> around sock_alloc_send_skb().  The route pointer returned by
> atrtr_find() is only protected while atalk_routes_lock is held; after
> that lock is dropped, a concurrent SIOCDELRT or device-down path can
> unlink the route, drop the device reference, and free the route.
> 
> When sendmsg resumes, it can still dereference the stale route and
> device pointers while building or transmitting the packet.  A KASAN
> reproducer using AF_APPLETALK sockets and SIOCADDRT/SIOCDELRT reports
> slab-use-after-free reads in atalk_sendmsg(), with the object allocated
> by atrtr_create() and freed by atrtr_delete().
> 
> Fix this by splitting the route lookup into a helper that is called with
> atalk_routes_lock already held.  atalk_sendmsg() now performs route
> lookup, copies the route fields it needs, and takes references to the
> selected devices with netdev_hold() while still holding
> atalk_routes_lock.  After the lock is dropped and skb allocation sleeps,
> the send path uses only the copied route data and the held net_device
> references, which are released with netdev_put() before returning.
> 
> This preserves the existing route selection behaviour, including the
> separate loopback route used for broadcast loopback, while removing the
> dangling route/device window.
> 
> Fixes: 60d9f461a20b ("appletalk: remove the BKL")
> Cc: stable@vger.kernel.org
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Ao Wang <wangao@seu.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Assisted-by: GLM:GLM-5.1
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> ---
> Changes in v2:
> - Use netdev_hold()/netdev_put() instead of dev_hold()/dev_put().
> - Drop explicit NULL checks before releasing temporary device refs.
> - Link to v1: https://lore.kernel.org/netdev/20260610052315.64504-1-zhaoyz24@mails.tsinghua.edu.cn/

Reviewed-by: Simon Horman <horms@kernel.org>


