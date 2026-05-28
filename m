Return-Path: <stable+bounces-254836-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMaoNIwZGGpCdQgAu9opvQ
	(envelope-from <stable+bounces-254836-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:31:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7574C5F09C8
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2F8BC300A339
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 10:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6C5397E8E;
	Thu, 28 May 2026 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RURdwQQL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBvpIKZW"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA79189F43
	for <stable@vger.kernel.org>; Thu, 28 May 2026 10:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779964291; cv=none; b=YI8kVVPSbUQlJr9ChzO1BVQXCPId535/zYvD438KnXBpHxcR4VCq3W1vqHBd4bxseqQ7fPp3qftVf7ht7ypkKnPU4+vZl07gA6KBK1eiwW9pHMDekuec5MO4z5Xg7FvAXaJAyrPrijONuADAkrD3OLf0fhx4OEooXCczpXdFfF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779964291; c=relaxed/simple;
	bh=uMZInyhct2J6By9KxHA5ABF9l3RGFcif2+JpLTJpi2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raJuSYQSS3Kp0BtEJKy98DiuZ59uZABRCTcomO+R5iZse2eB/fW4eK9Q8H9DFgmNyAIlaumE3IpSXUHDHy8WVmv36WvFD71piD4UFSp92FkxUEm+r/r/u15olSGBCUWtJtawzl7NDSZJTIG3mwhMgn0rfRubIPJZXIz9JMqs/No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RURdwQQL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IBvpIKZW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779964288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Aww6jC3I0Nj95YFehLzt5woPsMu1GhH9KVyzIE2qdSg=;
	b=RURdwQQLjSUSGU64TXzz/+FAxz74ijsOa1eFqRMQS6ZuBON6bXmsodRPDjalTWEc8UkMCH
	9hV3as0UfzYAvFQY/qzz/FpOcycznNqgGqF7xu1jkdEqdSdHg54g+38mO5Zhn/iN1yR9J5
	ixGECI/q1itAsjvETay8Hdv1hg/YVbA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-DHN-I9pZNCOUJ0cTUujWGw-1; Thu, 28 May 2026 06:31:27 -0400
X-MC-Unique: DHN-I9pZNCOUJ0cTUujWGw-1
X-Mimecast-MFC-AGG-ID: DHN-I9pZNCOUJ0cTUujWGw_1779964286
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44d9ace59efso7390328f8f.1
        for <stable@vger.kernel.org>; Thu, 28 May 2026 03:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779964286; x=1780569086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aww6jC3I0Nj95YFehLzt5woPsMu1GhH9KVyzIE2qdSg=;
        b=IBvpIKZWXj0J0IVWvVuueUTaYy5x9zH3gB5XP7WNB2tVzcW3KkxIEPfSweb1jyvNu+
         nIXyf5ryB5CZ9W+evXRfpsBT9UgV/sld8OUaIAFAeY3CDJqYViD6kAaoA2B/T8aei7f4
         K6hWSZ1cR928VAKp+sBv6ShSj4oXlI/urufjJNJgkv9siJTY2otkPwadnktAxrdISDLh
         JdfA8dvAJuLYSQrmq+ReH50wZ1CSZicsmogV2xacCes8gJH6/ihwoYpVY4vp4CFAhvfc
         E6vLKfcpng/5bMx6io2mDtpoo3NHy0g8EXfAnLbAffI2wCVTGJVrePPRdWedp4InGwlM
         UhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779964286; x=1780569086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aww6jC3I0Nj95YFehLzt5woPsMu1GhH9KVyzIE2qdSg=;
        b=a6G6x+R2Co86mmIhdxe06egM+RBjfdPKlTH1wexOR2GdSBh2vMKL0NzcBLKh/CFJoD
         y48osDHI6Os9iXpzlYdkdeKTbxOGSisuOZgJniyzmZi9OVe1NPTHNaVi68xVkNKLiEIC
         hBARyVMZ1kfsiufenYTjcl6CZ9JhwApdTnByq3gUyo6CxixQBsLdAyAeDVlNrpzHp1mn
         zEsvqppQvfgNktqBvG51YwV1XLFiQ18v+af31OJ0/5zH/YaXe5teKKk4SMwwqVOzQO7k
         lzwMYdaZqpmFNO8794cSUbjgL/hUjRKvvTd0KJMSY0enRyt791BPBM3v1Gr2m5jqetN3
         5rDg==
X-Forwarded-Encrypted: i=1; AFNElJ/vBTgRTBpVY/U31R/MKKBr7lcbR7pIdL3rOwnO9YXxjr5Pe9BbzNliqsVmp99TF2yo3zjuP3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1oP68371MavebjYsg+kJp7lEnlAKUB5/uKQtrzMvTHf8nfcfD
	bHQN5Oo4aD1F6qvWDxXugIeK6Vi8zMibx57bGNmk8mxa46OYKxWtZUHtW35BYPls1G1H5Tu3khC
	IcuCrNLVWFjRfK/Qv3IBvC7xc2vfBlMHBqHMk2WW7k2VX7Sys6+UbzP5mhA==
X-Gm-Gg: Acq92OGtTvGtIw4iF2+usOpeuZNp+xkQHxpD1vq9QQC+Bbxw+1J+Ehg7kLqnEUkOomy
	fXo3evsxMvw+idU0FBBcDLDA2xMoLA23expKcFtjwwf613GcRG7XW3+vgkTrQsfXcLPEqcJgojs
	L9CYikqwyj8mwvARUaVuZ09SzbZLONARyjWX20+cLwes1rf8lvIxZCgR6x31/ULFLhKIcVB7loa
	69THwb403+OTsZx+7SuBHCEdZYj05RllGu7I20LCPEYomuJUwU0cbCTfC4x6e05fgrKEVFhMC67
	xVjYFOAG9a6aLdbOu6vLrgx7cc/9nNZGLiNGtZrOpcPHkamQKWLZ9YhmiOTwIP0RCaD89DZqx28
	UshfALOGbcRUwqMfC7QuuFBPh8Al8c7Z3KejhkyyylLMTUXccrsISv24b7GtnnuWCAEPJkPJXjA
	4JxKZk86I3/pA=
X-Received: by 2002:a05:600c:1992:b0:48a:76a3:2b9b with SMTP id 5b1f17b1804b1-490426c5416mr418407325e9.17.1779964286058;
        Thu, 28 May 2026 03:31:26 -0700 (PDT)
X-Received: by 2002:a05:600c:1992:b0:48a:76a3:2b9b with SMTP id 5b1f17b1804b1-490426c5416mr418406935e9.17.1779964285634;
        Thu, 28 May 2026 03:31:25 -0700 (PDT)
Received: from debian (2a01cb0580324c00f1205deb3ed928e2.ipv6.abo.wanadoo.fr. [2a01:cb05:8032:4c00:f120:5deb:3ed9:28e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49092a817d3sm38019705e9.10.2026.05.28.03.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 03:31:24 -0700 (PDT)
Date: Thu, 28 May 2026 12:31:22 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: James Chapman <jchapman@katalix.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] l2tp: fix tunnel refcount leak on register failure
Message-ID: <ahgZerhdz5KcVMNz@debian>
References: <20260528043418.1153320-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528043418.1153320-1-vulab@iscas.ac.cn>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254836-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnault@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 7574C5F09C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 04:34:18AM +0000, Wentao Liang wrote:
> pppol2tp_tunnel_get() creates a new tunnel via l2tp_tunnel_create()
> which initializes tunnel->ref_count to 1, then increments it to 2 via
> refcount_inc(). If l2tp_tunnel_register() subsequently fails, the
> error path calls kfree(tunnel) directly, bypassing the refcount
> mechanism entirely.

This is the expected behaviour. Since l2tp_tunnel_register() failed,
the tunnel hasn't been exposed to the rest of the system and we're
guaranteed that nothing depends on it.

> This leaves the tunnel's ref_count at 2 with no
> way to properly release it through l2tp_tunnel_put().

The tunnel is simply freed. The refcount doesn't matter here.

> Replace kfree(tunnel) with l2tp_tunnel_put(tunnel) to properly release
> the reference through the standard refcount cleanup path, which will
> call l2tp_tunnel_free() when the counter reaches zero.

This is buggy. At this point, the refcount is 2, and l2tp_tunnel_put()
will decrement it by only one. So this patch just leaks the the tunnel
forever.

> Cc: stable@vger.kernel.org
> Fixes: 6b9f34239b00 ("l2tp: fix races in tunnel creation")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  net/l2tp/l2tp_ppp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
> index 99d6582f41de..16672e9df748 100644
> --- a/net/l2tp/l2tp_ppp.c
> +++ b/net/l2tp/l2tp_ppp.c
> @@ -661,7 +661,7 @@ static struct l2tp_tunnel *pppol2tp_tunnel_get(struct net *net,
>  			refcount_inc(&tunnel->ref_count);
>  			error = l2tp_tunnel_register(tunnel, net, &tcfg);
>  			if (error < 0) {
> -				kfree(tunnel);
> +				l2tp_tunnel_put(tunnel);
>  				return ERR_PTR(error);
>  			}
>  
> -- 
> 2.34.1
> 
> 


