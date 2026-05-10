Return-Path: <stable+bounces-245044-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FCTHtGvAGqBLgEAu9opvQ
	(envelope-from <stable+bounces-245044-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 18:18:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D45505109
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 18:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78216300A134
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 16:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBF239C658;
	Sun, 10 May 2026 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y1uhwhoy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEB226CE32
	for <stable@vger.kernel.org>; Sun, 10 May 2026 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778429902; cv=none; b=dUp7fmAYWm1h49oyT0jP4IulEMdu/GWKR/vg4b1rgX3jasqVbKOWxQV4QOyyzwSB4oeha2151hB8Sq7/f6vwo+IkmscmMRAmbqFORi161R6QtiKhsfD9W91WLZzQob/UF30T2zq3TxttgKA94+0pJGe0I9uaaq33RZ4Hwx07UV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778429902; c=relaxed/simple;
	bh=I3TDPWqvlVx9Tm/jPh/j7sv0fgPy7Hc5eWjFKrBZVAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4FshTxv9Y0o4rwvWlhkK4L8U4wcfq+upH+xqNCCRYRhRGvE9TxWI5AxDyO0NCGEPHzlHXdD3YBqdzWfpY8mX/fHpYl7DEcx8+42M5EQRM3s855fiWxxFRiyUOpzy2Bgkmba42HFpnz14lgvVdGdxi4YwShzOI1H1Y31Wij0X4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y1uhwhoy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBECC2BCB8;
	Sun, 10 May 2026 16:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778429902;
	bh=I3TDPWqvlVx9Tm/jPh/j7sv0fgPy7Hc5eWjFKrBZVAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y1uhwhoyshBT9UwHH6NOrrulf2OcophTyP43wqCmXCs5SRmb/vqr76WXADpdaGFkL
	 zsa9pLeqA+qz2Lt/fJDzn4eViktTa2/6MAQQcXGWoMvoMhE7AsxjbpW14LS+qYU9ko
	 UzuH8I32OFCTk1OkKtQVgEE/EhTNvx88scQfm8b4=
Date: Sun, 10 May 2026 18:17:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: sashal@kernel.org, dhowells@redhat.com, horms@kernel.org,
	jaltman@auristor.com, kuba@kernel.org,
	linux-afs@lists.infradead.org, marc.dionne@auristor.com,
	stable@kernel.org, stable@vger.kernel.org
Subject: Re: Backport RXRPC for 6.1.y from 6.2
Message-ID: <2026051040-primary-anyway-9a79@gregkh>
References: <939b8e49da80ebac-sashal@kernel.org>
 <20260509200157.191683-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509200157.191683-1-guanwentao@uniontech.com>
X-Rspamd-Queue-Id: F0D45505109
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-245044-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Sun, May 10, 2026 at 04:01:57AM +0800, Wentao Guan wrote:
> Hello All,
> 
> FYI, I found the commit list from v6.1..v6.2 mainline, with the refactor RXRPC 
> commit list, it will possible for v6.1.172 to clean apply for the becoming fix
> patches for AF_RXRPC in higher kernel version, but it a bit large...

Why is this needed?  If you want this, please provide a working set of
patches properly submitted, along with the reasoning why you just don't
move to a newer kernel version.  And do you really use the AFS
filesystem in a 6.1.y kernel tree?  If so, why?

thanks,

greg k-h

