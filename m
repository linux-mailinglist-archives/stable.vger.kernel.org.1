Return-Path: <stable+bounces-254630-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJSTHV0aF2ov4gcAu9opvQ
	(envelope-from <stable+bounces-254630-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 18:22:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F01535E7B49
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 18:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEC1E3056378
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2517742EEDE;
	Wed, 27 May 2026 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Ki5GHB5y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="omqbMe3s"
X-Original-To: stable@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF7D236453;
	Wed, 27 May 2026 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779898916; cv=none; b=RELNfa3q/sows47FAXrsopkZ0g5a8oNfNg37XHjIFLflnJkltnaD3JAxI4yAaeIysTywZakE8T2ll2NlxKeNbvWyZdkADHnFQUE9K7L5qGx9ct8zhS1ANiGQRbLpJO/j6/u9x07kxMQkaaIeNPMkiMPPIWoBeon1WsXQggUkZXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779898916; c=relaxed/simple;
	bh=XbT1g+8GUb9HDwonX1DCruD/yWZSK3lGsfCSsSFHSDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOh4js1RncqnLn6SS1rZHOffoQOGzpXWAQ685bsAN8KYSWFJzuWL4uOQfoZnkHO0pyr0HUx+XPj1e/JrbD+LIArraGJajJvWjAbCbyrjCRrI2BDOyd9Z0jvFMPds9cSvSBST3v2AyQYgOtXdGg1q3UbIRM3HtMUpf+vvNJjIp6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Ki5GHB5y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=omqbMe3s; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 53CDEEC0098;
	Wed, 27 May 2026 12:21:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 27 May 2026 12:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1779898912; x=
	1779985312; bh=aEeoFnQGgZEYGi6tSF7m/UIIOpj9D7Uy8UVZJVSQY30=; b=K
	i5GHB5yDPfoOx3V2hUn0B6nZwBHTupqe+xDnOsM7FbBrKL/n2+1MdaJl2VEAjgaJ
	uqc0wy5epvrz+zqesRH7BLui6q9laAsR32anFMThVV8tV0rbnbblzjUO6c83qPsG
	IlZ01V0uk2g+QHSq0mhd++Ed/KihMCP/t6AP4IaVfR1tD8cBb8L+lHJ+8jNKKTjo
	OA6ysZEXL1eqmJHdqDxKb8fIvPdx6xRQ+Ee/CN5xEPPVCLe4vGLxUyGHE+17muA4
	YjuwW2gIbG89WpPiPgti0HnIyw0qX+WgxU0VplclNy1awBqXFuvRl7bzS4nwwsgM
	yZ7gmxQ8dXK7SxH5AHsbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779898912; x=1779985312; bh=aEeoFnQGgZEYGi6tSF7m/UIIOpj9D7Uy8UV
	ZJVSQY30=; b=omqbMe3slTffliWJlYbsMiaBvQEYycaAqQZFTkjFSz5uT3iEkcQ
	NeJuVdqqMEi9Rkh8NSDAS1tb9NC1cqaWJMkH4eJjkbty4F5k3QAdvqX3mQTLz3EI
	+Rb/9q5PIit0roqQSb6n8kAQW7waLg9fJK/qybOF9Gbye0Lj21kYc3iKoeztLfuu
	di6cv9xIidTBvwpIOzhCNNzxckLIznkfHUFBIIbwVhyB/WABbVRXY2YSwLUIl8v4
	UKXyzi0BIBL/wB/zRCNlMAZMNPyRHN3cLILwqocEq0hFf4JBSM6shp4jiUM6zBJD
	9jm1T6c3uOoxUf7TqbgrA6ftJfBvoGVQ9mw==
X-ME-Sender: <xms:HxoXarBJsGggQtI1beDTu-yVFSTkdFmoM0ngHN-1n31aOgmt7VSK6Q>
    <xme:HxoXanj3hVxew5h-RtAqtmj_mxK2foEyENogjT9gbv_XaR98PHxvUF3jH4nFT00l9
    YmnxUQIrQyooogtyzp0gFhJ9-TBSFLyQpnRkZFspayG39FM1fOjvQo>
X-ME-Received: <xmr:HxoXahaXwIclYIxf-N_XhY0ysbkFQGpoCVDGe_ImowQlixOdvFPxiJgtAc7ya6Tey1rtAzUskznozcmMTOvXB4Q>
X-ME-Proxy-Cause: dmFkZTEg4WRu41kuea+OrnrY7p+6/hEgjnJ8R8tIcuQsRP/DtKZ77PFQYb8vQfWp4gTZ3J
    WHAz0K53zdRl+3Wq9+owJrFJe4af/d2WIXfsp/juA3cY2LYho8Iv9xOTBmvrpGc4k7d80v
    KXzAmOucOvmig6EnoGxRy0aI+KtVEo7yeKQLQ/P/GYaXTwVF2biNFA3pgl5xVleNQe/Ogm
    IAX+AJQvUoSpurVVynAwat4cx3HYXicx81KUM42+11hM4SdRFc7pTFi+X7Ezyf1X0bH49E
    eFGYoOOwftSRQZjjOO6CJPT17rrfgr7krY8Hsrcw71vRZ+wsGSaoD3Qdc9r9qw71UOgcIW
    g9dVY5NY45ShdnQu9hBcpA8aj4Rs6PoZrfBeOq0yjaWgLUrkigUixeiS7b0NE4YdSl1cxY
    NIEWuC/oszjM1ZjEHPtnhtIIBb5pddO2TlUqThvHX/hWo+Qbacf3n4RwoCvfSHysBRcysd
    wi9kulmu/BAo/Ifjg0pgeywZ2lwyy9va+QanpXHsTAkPcONJdypkmzDfGvqylBmqTA1aC9
    vZpZn0RBP6YiNZ/xuVQpPDVNxe3K9VnMRcXrIf0VWjzaqTyK9BROyE18jm8VTybV3hZwTg
    KhahZ/rvs3IrjygYFIDx1GNaBzeKUkWB+ShFE7IcPduHfWDehbMmgOeSz37g
X-ME-Proxy: <xmx:HxoXagkpePO-ff1LdSIaAiEBsNhzupEc-Qgq12ij9gaH4OWRsopdHA>
    <xmx:HxoXavhQzsrqhEdd1LlsTk1gEvaVxo9k6rK9OKNM6TjaqkzqvWFuUA>
    <xmx:HxoXaqTPr82My0Zn0URB7DhnU82GiIY-ZqlVZWo7yQ7h4-gtw1xWdQ>
    <xmx:HxoXaoYE5yJ-N3ZdMdAChLI_eQoAxtkoAzHUp0fVF8RQYXYpnCIBFA>
    <xmx:IBoXatU8bphPQYpJGS3j20K7Lg6uH5QHyiXWedVmPCOwn2BP89CUPBS->
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 12:21:51 -0400 (EDT)
Date: Wed, 27 May 2026 18:21:49 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Pavitra Jha <jhapavitra98@gmail.com>
Cc: antonio@openvpn.net, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] ovpn: fix peer refcount leak in TCP error paths
Message-ID: <ahcaHaYr0LJ8GVY4@krikkit>
References: <20260523090244.504790-1-jhapavitra98@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260523090244.504790-1-jhapavitra98@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254630-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:email,queasysnail.net:dkim,messagingengine.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F01535E7B49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-05-23, 05:02:43 -0400, Pavitra Jha wrote:
> When either the TCP RX or TX error path calls ovpn_peer_hold() followed
> by schedule_work(&peer->tcp.defer_del_work), and the work item is already
> pending from the other path, schedule_work() returns false and the work
> runs only once. Since ovpn_tcp_peer_del_work() calls ovpn_peer_put()
> exactly once, the extra reference taken by the losing path is never
> dropped, leaking the peer object.
> 
> The race window:
> 
>   CPU0 (strparser/RX error):       CPU1 (tcp_tx_work/TX error):
>   ovpn_peer_hold()   <- refcnt+1   ovpn_peer_hold()   <- refcnt+2
>   schedule_work()    <- queued      schedule_work()    <- NO-OP
>                                     (work already pending)
>   ovpn_tcp_peer_del_work runs:
>     ovpn_peer_del()
>     ovpn_peer_put()  <- refcnt+1
>                                    <- peer never freed
> 
> Fix by checking the return value of schedule_work() in both paths and
> calling ovpn_peer_put() to drop the extra reference if the work was
> already pending. ovpn_peer_hold() is kept unconditional in the TX path
> as it cannot fail at that point.
> 
> Fixes: a6a5e87b3ee4 ("ovpn: avoid sleep in atomic context in TCP RX error path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
> ---
> Changes since v2:
>   - Include RX path fix in the diff (was missing from v2)
>   - Link: https://lore.kernel.org/netdev/20260522091718.270956-1-jhapavitra98@gmail.com/
> 
> Changes since v1:
>   - TX path: keep ovpn_peer_hold() unconditional per Antonio Quartulli's
>     review; only check schedule_work() return value
>   - Link: https://lore.kernel.org/netdev/20260521083739.65061-1-jhapavitra98@gmail.com/
> ---
>  drivers/net/ovpn/tcp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

This looks correct to me:

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

