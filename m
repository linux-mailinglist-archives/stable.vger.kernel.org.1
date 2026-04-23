Return-Path: <stable+bounces-240477-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLjlE0sN6mn4sgIAu9opvQ
	(envelope-from <stable+bounces-240477-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 14:15:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F37E1451D4D
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 14:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB30B301EBDA
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 12:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC3A377543;
	Thu, 23 Apr 2026 12:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MWkZ/Q6o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D1F2FE071;
	Thu, 23 Apr 2026 12:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776946402; cv=none; b=KvFsq093S7pD3nMPmzCUobMUTpZw2WeFQOn1RmcvqHcRQkx4vSRB57X0sZ2GgL67gJe0A8GPRRBHrInsn8YW9nYa4blgCxH8Ny/Dr61gNiaP3nmTR4SqJ1BVEzUPjXKfTh+8qNUmF5oviB42Qr8Ah0ngQBKKp1HUNyHRWd+nvoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776946402; c=relaxed/simple;
	bh=f/om5ADRMKsy+r05vHr/1yUfOvzUiOshox5HxAehQWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8HjoDGCKOi5fo5dazkINVXraJIfR35R9uRTVoVdBfcS+Kz3zwlpVCBTRpSDbP16jVfh1Gko4kfFIqX+/DEd0iFkNtiAZ+O5eh9pF2FpxgsBB8Ui8ih7oTzCJwqoUfER0I8SkoWOE3rQ4e9GjCFX0IqCoutfElIy9eRfppXlgCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MWkZ/Q6o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CF5C2BCAF;
	Thu, 23 Apr 2026 12:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776946402;
	bh=f/om5ADRMKsy+r05vHr/1yUfOvzUiOshox5HxAehQWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MWkZ/Q6oCvZmNx3P8Mc2McHSHF134OiT6NCkkuVcULYym4NNklwnEm1/gZut3d4Vo
	 6SFkZzdsCUcpU9Ga4g/7DZsFfRPPP8ejLRM0AP5aQiQf92Qcoj3BsieJyWnhMtwSv3
	 IXlVei2fGesjiH3BTs2jfiqZB2S6QTdyofaEasxQ=
Date: Thu, 23 Apr 2026 14:13:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jay Wang <wanjay@amazon.com>
Cc: stable@vger.kernel.org, dhowells@redhat.com, marc.dionne@auristor.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-afs@lists.infradead.org, jay.wang.upstream@gmail.com,
	Faith <faith@zellic.io>, Pumpkin Chang <pumpkin@devco.re>
Subject: Re: [PATCH 5.10.y] rxrpc: Fix recvmsg() unconditional requeue
Message-ID: <2026042307-joyous-deliverer-c4bb@gregkh>
References: <20260422222432.7236-1-wanjay@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422222432.7236-1-wanjay@amazon.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240477-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,auristor.com,davemloft.net,google.com,kernel.org,lists.infradead.org,gmail.com,zellic.io,devco.re];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.232.135.74:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: F37E1451D4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 10:24:32PM +0000, Jay Wang wrote:
> From: David Howells <dhowells@redhat.com>
> 
> [ Upstream commit 2c28769a51deb6022d7fbd499987e237a01dd63a ]
> 
> If rxrpc_recvmsg() fails because MSG_DONTWAIT was specified but the call
> at the front of the recvmsg queue already has its mutex locked, it
> requeues the call - whether or not the call is already queued.  The call
> may be on the queue because MSG_PEEK was also passed and so the call was
> not dequeued or because the I/O thread requeued it.

Why did you reformat the changelog text?  Please do not.

thanks,

greg k-h

