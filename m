Return-Path: <stable+bounces-245116-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNN/FjOGAWpOcQEAu9opvQ
	(envelope-from <stable+bounces-245116-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:33:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5EC509443
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C865230488F1
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AE93815CF;
	Mon, 11 May 2026 07:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eCYWFCRk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BDD37F73E
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484494; cv=none; b=H6ov76Sa+r/M7JfLQeNlgqQ3mhL1c5YWsVjGge8j1//Vr9997iXAgP9xwDUzUYZm/GkgXVMHeLb9gI+S+DLfZV63h3anw/18kkt3wcJ+cd/n6r3DrgR7UeX+mol7yeU4QvZ0hvXuBIakTu3fUll8X5k5F8/9NWF8ABB05vbpUSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484494; c=relaxed/simple;
	bh=4z/wfE5Za01yyEXVfcacuTEN8QQNoxxbNOO0MjNSIBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCYPNVV47a5/wcu9AOFov8wMtz/l6bN9dVPJt+fc3d5zO92gQFDvv21Co4dL2dgaGcl3pdkW8NFahAfiVzCeXnf1bZyR6x+vqX8RZhssCTIv92PCIrZC4oRzeV1WwmO2VjXqdjWa+0q89xRRwVijmOC2gV6Z9r7WPMrTv3T/IR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eCYWFCRk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1651C2BCB0;
	Mon, 11 May 2026 07:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778484494;
	bh=4z/wfE5Za01yyEXVfcacuTEN8QQNoxxbNOO0MjNSIBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eCYWFCRkZqX3nnZnR9sYpT42CIoCXCTccEKyF5tI87D3VfqZcbbCDjfntAVRYJDxw
	 AXlkkf0iJa4ELVPNx+CKTeDHEyJFQ0MwYmyQSlPrd2KD0SRsZ2PEzku6XOyE5cZGjY
	 Bsg6JZyWnAJRofTBdXqQR0yWsoCLjEdPiKwbrQCM=
Date: Mon, 11 May 2026 09:28:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: dhowells@redhat.com, imv4bel@gmail.com, jiayuan.chen@linux.dev,
	stable@vger.kernel.org, torvalds@linux-foundation.org,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
	stable@kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 1/2] rxrpc: Fix conn-level packet handling to unshare
 RESPONSE packets
Message-ID: <2026051152-mobster-abacus-7833@gregkh>
References: <2026051109-ocelot-dwindle-a7e9@gregkh>
 <20260511071833.44144-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511071833.44144-1-guanwentao@uniontech.com>
X-Rspamd-Queue-Id: AC5EC509443
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245116-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,linux.dev,vger.kernel.org,linux-foundation.org,auristor.com,kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,auristor.com:email,sashiko.dev:url,uniontech.com:email,msgid.link:url,infradead.org:email]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 03:18:32PM +0800, Wentao Guan wrote:
> From: David Howells <dhowells@redhat.com>
> 
> The security operations that verify the RESPONSE packets decrypt bits of it
> in place - however, the sk_buff may be shared with a packet sniffer, which
> would lead to the sniffer seeing an apparently corrupt packet (actually
> decrypted).
> 
> Fix this by handing a copy of the packet off to the specific security
> handler if the packet was cloned.
> 
> Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
> Closes: https://sashiko.dev/#/patchset/20260408121252.2249051-1-dhowells%40redhat.com
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: Jeffrey Altman <jaltman@auristor.com>
> cc: Simon Horman <horms@kernel.org>
> cc: linux-afs@lists.infradead.org
> cc: stable@kernel.org
> Link: https://patch.msgid.link/20260422161438.2593376-5-dhowells@redhat.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> (cherry picked from commit 24481a7f573305706054c59e275371f8d0fe919f)
> Stable-dep-of: aa54b1d27fe0 ("rxrpc: Also unshare DATA/RESPONSE packets when
> paged frags are present")
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> ---
>  net/rxrpc/conn_event.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)

What branch(es) are you wanting this applied to?

thanks,

greg k-h

