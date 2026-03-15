Return-Path: <stable+bounces-225459-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDpPO5wHtmku8gAAu9opvQ
	(envelope-from <stable+bounces-225459-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 02:13:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC5628FB6E
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 02:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1798302244C
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 01:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F3020DD51;
	Sun, 15 Mar 2026 01:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdJGaiPB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3591D7995;
	Sun, 15 Mar 2026 01:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773537165; cv=none; b=l30lVvoyG4M3lI72HS7uqy9QVF6319Cp1+Oyuao/EjldmizYSnyC+v22/H2oY6n/62vA5Wc3FZlGbUe+xPDF/4PoJfV/nxp5ic1fYL5qRnKV7dsDdVNAq9FWm8eST0odqStiWk6hZTrj5k7HDwHko+6eY+MA72ijO2BScnlTL7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773537165; c=relaxed/simple;
	bh=JAs/1nlYTkYCSuyox/Z4p/qg35k7HFn5402MuhdAo3g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AnD2/JXwCPxdzKQRkM7Jr62d+YW1CdXvQgijjTtbsDCFJ5J9mc1kunZ0cROSygi/tFm7Bg3y8auPekG3jg5TyW8fVEUq73iJwcM9P006PbMqjH+NrI/A411Nk8mvsyPkSFjzqz45xxg15e8kMJemGkDJmmI749O+lJsG291TaFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdJGaiPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31517C116C6;
	Sun, 15 Mar 2026 01:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773537164;
	bh=JAs/1nlYTkYCSuyox/Z4p/qg35k7HFn5402MuhdAo3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SdJGaiPB8kA5VjEf+HBii1iPWqlVB7gSwv1gRkXcjcRaA4X4OKNCqrYHtzVEjwt/2
	 W3mkfCxb+FPk1cKpiwjN0HxpK3XsF9DD9Y/VsaHRx7MiS/WtoDi+/R7ncZnOiyfESU
	 jkkIE6Xo2rS9Y9HoPkCPfa9k1TC2paVUmx34NFKhFJoiPKssfm2cxW64dYwsc/2Krw
	 p5kWl6r01Or1MCuoSW1i3tykayDGqvfGxmf3YqN3poJxvIycu4cS9nEUkslBpbm/Ws
	 En1AzOmiQrz5sBBZh5U9qu/4vtXcNtWD/5orhm6a3wX9K8vT+/Fa2a/gK7WpPmZOJe
	 ru63pHsk7191w==
Date: Sat, 14 Mar 2026 18:12:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: xietangxin <xietangxin@yeah.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2] virtio_net: Fix UAF on dst_ops when
 IFF_XMIT_DST_RELEASE is cleared and napi_tx is false
Message-ID: <20260314181243.177d4ab4@kernel.org>
In-Reply-To: <CANn89iJHp+nCcAo7tzMTfH5yW2qDsEXP_u=RzdV=DC9ZvDH9Fg@mail.gmail.com>
References: <20260312025406.15641-1-xietangxin@yeah.net>
	<20260314124017.59206dac@kernel.org>
	<CANn89iJHp+nCcAo7tzMTfH5yW2qDsEXP_u=RzdV=DC9ZvDH9Fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225459-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[yeah.net,redhat.com,davemloft.net,lunn.ch,linux.alibaba.com,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,yeah.net:email]
X-Rspamd-Queue-Id: EAC5628FB6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 14 Mar 2026 21:11:33 +0100 Eric Dumazet wrote:
> > On Thu, 12 Mar 2026 10:54:06 +0800 xietangxin wrote:  
> > > Fixes: f2fc6a54585a ("[NETNS][IPV6] route6 - move ip6_dst_ops inside the network namespace")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: xietangxin <xietangxin@yeah.net>  
> >
> > The Fixes tag should be:
> >
> > Fixes: 0287587884b1 ("net: better IFF_XMIT_DST_RELEASE support")  
> 
> I disagree
> 
> What was the situation before this patch ?

My thinking process was that it's fairly unusual that the dst is kept
because the stack decided so. Normally its the device driver that asks
for dst to be kept when its xmit is called. I thought 0287587884b1 was
the first time when stack could make the dst decision behind device
driver's back. But my analysis was very shallow, could well be wrong.

