Return-Path: <stable+bounces-245117-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIq/OIGFAWoFcAEAu9opvQ
	(envelope-from <stable+bounces-245117-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:30:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64946509326
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E3DD3025E75
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A65386C13;
	Mon, 11 May 2026 07:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="En2JABTk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05E3386555
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484512; cv=none; b=W1jpqmu6uyquQL2FXVJbyNQVvJX31Q63rtAIYtUmPa2bqDfDYwS0z30BEAN01TTBP2LN0P24X5BQjNUlHagq9F5suaq+YDtMbuKyt40YRaoizO5g3ARErLWWmPOACTf/XYVT2rfzoeERXnvsHhvr0rgcAPa+sEiMa/rCtb/WLfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484512; c=relaxed/simple;
	bh=Hkm+ej5KFIhDwJGLKG18T97rBzFUof9AcSagqlJvnjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdIpKNBzv7FJ+Ecc4mLgo1DBstT6lPWWuJRlIvcJkOCjNkipiRBXFfrpHmKadBigZRX8xfmf0JupCO/DHIcRu49xl4WfQC6dzHZZFEwJDio6d6mqSiwBh4k2cFHLeI+6OwNBzC9Xsb5LBYG+TOjR59EfXKJrpmjzZ2ErdJPtgyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=En2JABTk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4735FC2BCF6;
	Mon, 11 May 2026 07:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778484511;
	bh=Hkm+ej5KFIhDwJGLKG18T97rBzFUof9AcSagqlJvnjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=En2JABTkLYZlcvyw4s3Fy199ye1HUXJ51H/mF959vX3VRMyXzXM9xHlfMbYKfbd+V
	 2M8he+xcITV41wk/pwMi2LDk41I77JuieaMVP1WanExf1Go3JqPIlbTAsAacbFmoA6
	 bYXX3pKTrMjmah4aU5DayA0W9MJ3+moVZaAElwzc=
Date: Mon, 11 May 2026 09:28:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: dhowells@redhat.com, imv4bel@gmail.com, jiayuan.chen@linux.dev,
	stable@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 2/2] rxrpc: Also unshare DATA/RESPONSE packets when paged
 frags are present
Message-ID: <2026051119-family-spiritual-5b2c@gregkh>
References: <2026051109-ocelot-dwindle-a7e9@gregkh>
 <20260511071833.44144-1-guanwentao@uniontech.com>
 <20260511071833.44144-2-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511071833.44144-2-guanwentao@uniontech.com>
X-Rspamd-Queue-Id: 64946509326
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245117-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,linux.dev,vger.kernel.org,linux-foundation.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,uniontech.com:email,linux-foundation.org:email,linux.dev:email]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 03:18:33PM +0800, Wentao Guan wrote:
> From: Hyunwoo Kim <imv4bel@gmail.com>
> 
> The DATA-packet handler in rxrpc_input_call_event() and the RESPONSE
> handler in rxrpc_verify_response() copy the skb to a linear one before
> calling into the security ops only when skb_cloned() is true.  An skb
> that is not cloned but still carries externally-owned paged fragments
> (e.g. SKBFL_SHARED_FRAG set by splice() into a UDP socket via
> __ip_append_data, or a chained skb_has_frag_list()) falls through to
> the in-place decryption path, which binds the frag pages directly into
> the AEAD/skcipher SGL via skb_to_sgvec().
> 
> Extend the gate to also unshare when skb_has_frag_list() or
> skb_has_shared_frag() is true.  This catches the splice-loopback vector
> and other externally-shared frag sources while preserving the
> zero-copy fast path for skbs whose frags are kernel-private (e.g. NIC
> page_pool RX, GRO).  The OOM/trace handling already in place is reused.
> 
> Fixes: d0d5c0cd1e71 ("rxrpc: Use skb_unshare() rather than skb_cow_data()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Acked-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> (cherry picked from commit aa54b1d27fe0c2b78e664a34fd0fdf7cd1960d71)
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> ---
>  net/rxrpc/call_event.c | 4 +++-
>  net/rxrpc/conn_event.c | 3 ++-
>  2 files changed, 5 insertions(+), 2 deletions(-)

Same here, what branches is this for?

thanks,

greg k-h

