Return-Path: <stable+bounces-244708-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qECFCvCl/Wl0ggAAu9opvQ
	(envelope-from <stable+bounces-244708-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 10:59:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F30A4F3F55
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 10:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D62AD301D040
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 08:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC0831BCAE;
	Fri,  8 May 2026 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ONNozKaA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BF434F275
	for <stable@vger.kernel.org>; Fri,  8 May 2026 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778230666; cv=none; b=stkzAbz2KJhe+0M70yqnYl+fQP1sc7QB0ZyK9hnJIW7ssLmSb2pjnbnVE0zJoAu7G9G9hQvz4rmvEDnb4n3ybNgZXze4P6cCjVPkVf/2sQPV3hG1Txr9P8Az56hcY+zKD8oxP87YNljz7SzLt9XxGZlcN8zg7fFoYswWpuIIUKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778230666; c=relaxed/simple;
	bh=OU2SsqrtViCofMeBMGJ0jaSqme6jJJ7wpIEvUn0sMNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KO2mG1J8z3NT+7/OqRBMdgMhiirkgWoBLiDZz0QQ/TG1fd3+A84qRb+EHbVrmGVpZjk/PgCoikrS8SmdHh/umflICPmRi65/kXaomjULJf/GdjsfZnKJCNn7IaeeDKQGANRbul0+oOA5Xaqx43LDrx67oV2f02xAL60wqDqrXts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ONNozKaA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09A6C2BCB0;
	Fri,  8 May 2026 08:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778230666;
	bh=OU2SsqrtViCofMeBMGJ0jaSqme6jJJ7wpIEvUn0sMNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ONNozKaA0BLk8uKdl40V2Drk7ybKNs1hMwC0AM5V+HSVQ+zBGK+1E3g+psiW0AZMf
	 AobgHb9yt4sui1XjNY11+aUv7QySTZjhWuPLNnBpdEDbsQcLSq/Lmrnfy9um4Gj162
	 PIl1P9oxzG/QSGRgsPprWdgnxZQv93kvtn4AF0kc=
Date: Fri, 8 May 2026 10:57:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: sashal@kernel.org, dhowells@redhat.com, horms@kernel.org,
	jaltman@auristor.com, kuba@kernel.org,
	linux-afs@lists.infradead.org, marc.dionne@auristor.com,
	stable@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RFC 6.6] rxrpc: Fix potential UAF after skb_unshare()
 failure
Message-ID: <2026050805-chill-winking-91d5@gregkh>
References: <20260503143317.1089945-1-sashal@kernel.org>
 <20260508083142.1752208-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508083142.1752208-1-guanwentao@uniontech.com>
X-Rspamd-Queue-Id: 6F30A4F3F55
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-244708-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,linuxfoundation.org:dkim,infradead.org:email,auristor.com:email]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 04:31:42PM +0800, Wentao Guan wrote:
> From: David Howells <dhowells@redhat.com>
> 
> [ Upstream commit 1f2740150f904bfa60e4bad74d65add3ccb5e7f8 ]
> 
> If skb_unshare() fails to unshare a packet due to allocation failure in
> rxrpc_input_packet(), the skb pointer in the parent (rxrpc_io_thread())
> will be NULL'd out.  This will likely cause the call to
> trace_rxrpc_rx_done() to oops.
> 
> Fix this by moving the unsharing down to where rxrpc_input_call_event()
> calls rxrpc_input_call_packet().  There are a number of places prior to
> that where we ignore DATA packets for a variety of reasons (such as the
> call already being complete) for which an unshare is then avoided.
> 
> And with that, rxrpc_input_packet() doesn't need to take a pointer to the
> pointer to the packet, so change that to just a pointer.
> 
> Fixes: 2d1faf7a0ca3 ("rxrpc: Simplify skbuff accounting in receive path")
> Closes: https://sashiko.dev/#/patchset/20260408121252.2249051-1-dhowells%40redhat.com
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: Jeffrey Altman <jaltman@auristor.com>
> cc: Simon Horman <horms@kernel.org>
> cc: linux-afs@lists.infradead.org
> cc: stable@kernel.org
> Link: https://patch.msgid.link/20260422161438.2593376-4-dhowells@redhat.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [ Relocated the unshare/skb_copy block from rxrpc_input_call_event()'s rx_queue dequeue loop to existing `if (skb) rxrpc_input_call_packet()` site, and substituted rxrpc_skb_put_call_rx with rxrpc_skb_put_input. ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> [ Readd rxrpc_skb_put_response_copy() or will cause a build fail with commit 24481a7f5733 ("rxrpc: Fix conn-level packet handling to unshare RESPONSE packets") ]
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>

Why not backport the needed commits before this one instead?  That would
make the difference here much smaller.

thanks,

greg k-h

