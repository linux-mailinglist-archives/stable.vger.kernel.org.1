Return-Path: <stable+bounces-247632-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIOhCnHvBmrOowIAu9opvQ
	(envelope-from <stable+bounces-247632-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:03:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 776BB54CF4C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68D4B311385B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA5138F925;
	Fri, 15 May 2026 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ez8tBPwD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B253C39E6F5
	for <stable@vger.kernel.org>; Fri, 15 May 2026 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778837345; cv=none; b=PTspB32Ww31kza/szl+I7MMx+azCPtTCRhLhjZmJYx0ljJJn15kj07c0NUcBnma9XjSTSFgnnIDN0UNaTEnyOvTZRcHn2C3HVvXSf3BBoAsDlR2ROuX6zYxlBX5sb85vrGlFzPqNqXjouhsyfuVUfBGKE2aZesPJNws2UO69tCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778837345; c=relaxed/simple;
	bh=oDn+fWZ992YKCmwO3OrdkyTSS35uifAJVtSnVo9X5AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwB6zLlS6o1np5wgEG31PWrgGFU026it35CxJGww5q4V+FFtZIDH+8nawCPy2zC+VWyDYUCiUNtslHFBvBZ3cUFwLlLVmEM73YAj9wbJUR1+KOmwA0hFoBLnjfT1rW5iQ/Ea4qPQ7f6o0U1Lz5nula0rSOWt6bJ32S9nEs3rKVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ez8tBPwD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1C5C2BCB0;
	Fri, 15 May 2026 09:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778837345;
	bh=oDn+fWZ992YKCmwO3OrdkyTSS35uifAJVtSnVo9X5AI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ez8tBPwDhezzoOwGHRVdHCdgnNKXHl61rRaPm22YlaLYf2/QUI0VnTudReqQd3eKx
	 CjoL0pIJIYi9qSoXywzVMC9xN2QafKdxSrNIkfejTjlJ6YkUqswTSD+DHs2QmteNh4
	 1/aEPK38wpXhTzVDOenOAltzZcMtENkyyghE4weM=
Date: Fri, 15 May 2026 11:29:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Siwei Zhang <oss@fourdim.xyz>
Cc: stable@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: [PATCH 6.12.y] Bluetooth: L2CAP: Fix null-ptr-deref in
 l2cap_sock_get_sndtimeo_cb()
Message-ID: <2026051556-union-footsore-3414@gregkh>
References: <2026051216-harsh-pretender-53e0@gregkh>
 <20260513130248.2192409-1-oss@fourdim.xyz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513130248.2192409-1-oss@fourdim.xyz>
X-Rspamd-Queue-Id: 776BB54CF4C
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
	TAGGED_FROM(0.00)[bounces-247632-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 09:02:37AM -0400, Siwei Zhang wrote:
> Add the same NULL guard already present in
> l2cap_sock_resume_cb() and l2cap_sock_ready_cb().
> 
> Fixes: 8d836d71e222 ("Bluetooth: Access sk_sndtimeo indirectly in l2cap_core.c")
> Cc: stable@kernel.org
> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/l2cap_sock.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 1960d35b3be0..adee617517bb 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1725,6 +1725,9 @@ static long l2cap_sock_get_sndtimeo_cb(struct l2cap_chan *chan)
>  {
>  	struct sock *sk = chan->data;
>  
> +	if (!sk)
> +		return 0;
> +
>  	return sk->sk_sndtimeo;
>  }
>  
> -- 
> 2.54.0
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

