Return-Path: <stable+bounces-268579-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cHP6LtFAPWo30QgAu9opvQ
	(envelope-from <stable+bounces-268579-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 16:53:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 080906C6D8A
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 16:53:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=wjE7+K1c;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268579-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268579-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA56E3016C92
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 14:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B583DD877;
	Thu, 25 Jun 2026 14:52:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462D931716D;
	Thu, 25 Jun 2026 14:52:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782399179; cv=none; b=tk9PVOBc3BQRWOFT6b0CP/cGf2UrcNn8L/uAa7AKEuTZlRrr/XYtXdAMMdEoPXGkBGbIFjZhNmEnJtETmgH0+HDzUPDPdUZdSF9Hb0KhbOnf+BtlM8TKBDQbBt9erLaKfzB2zp9Ts8Kesw3q6XYnYkpLIH28VUm+qc9uLgfWD0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782399179; c=relaxed/simple;
	bh=20MUo8eaeVSqPU1qEd78hjP4lpOcs+X0kOSNQv2AnHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaKkCw/2/xhCmBYDXJ4o1AMo6nslYuSOGGZmxW9McVT8VahaMh4HsdpXymDs7uA93SU7+nKYYCpDXKNar5eQNE0QSigbgPKvaLuIJ0+1+dfG0Ba1NVkdm7qFrSZ8z/C+AIIVKVQ+UN2aHWmzRGM9PFuKy9zsE+1mvaF9m9gZK/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wjE7+K1c; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3951F00A3A;
	Thu, 25 Jun 2026 14:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782399178;
	bh=7y4lmHCjm26T3HpVZ0fSNx9nDdJxZoHYLU4ZSc+rGHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=wjE7+K1cABR8msNzsyw0UruERqdlhlYEQ2gYAPSC5MrX5+F6s+FdH8sHmXIppmBf2
	 76LQqoqkK3Mn6K2RR9u6qi5WlvDvNK77K1Jehz61SllFfiXHEfRz6lz50YmTy1MRjB
	 /J9qRd95xs2oBOsHWGc99LNFKsvYxQyxNWbUFTMc=
Date: Thu, 25 Jun 2026 15:51:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: kees@kernel.org, oneukum@suse.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] USB: misc: uss720: fix refcount leak in
 submit_async_request()
Message-ID: <2026062530-capsule-citable-1d57@gregkh>
References: <20260611132952.83931-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611132952.83931-1-vulab@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268579-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:kees@kernel.org,m:oneukum@suse.com,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,iscas.ac.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 080906C6D8A

On Thu, Jun 11, 2026 at 09:29:52PM +0800, WenTao Liang wrote:
> When submit_async_request()'s call to usb_submit_urb() fails, the
> error path directly calls destroy_async() on the request structure
> instead of kref_put(). This bypasses the reference counting mechanism
> because the kref is initialized to 1 and the preceding kref_get()
> increments it to 2. The callback function async_complete() will never
> run in this case, so the reference acquired by kref_get() is leaked,
> and the structure is freed while still holding two references.
> 
> Fix by replacing destroy_async() with kref_put() in the failure
> branch, properly releasing the extra reference.
> 
> Cc: stable@vger.kernel.org
> Fixes: adaa3c6342b2 ("USB: uss720 fixup refcount position")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/usb/misc/uss720.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/misc/uss720.c b/drivers/usb/misc/uss720.c
> index b7d3c44b970e..e1eba3cbef0a 100644
> --- a/drivers/usb/misc/uss720.c
> +++ b/drivers/usb/misc/uss720.c
> @@ -168,7 +168,7 @@ static struct uss720_async_request *submit_async_request(struct parport_uss720_p
>  	ret = usb_submit_urb(rq->urb, mem_flags);
>  	if (!ret)
>  		return rq;
> -	destroy_async(&rq->ref_count);
> +	kref_put(&rq->ref_count, destroy_async);

As
https://sashiko.dev/#/patchset/20260611132952.83931-1-vulab@iscas.ac.cn
shows, this creates a new bug :(


