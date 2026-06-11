Return-Path: <stable+bounces-262794-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Tn81GMv4KmoO0QMAu9opvQ
	(envelope-from <stable+bounces-262794-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 20:04:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CE96744AA
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 20:04:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=queasysnail.net header.s=fm2 header.b="a YDpwFG";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=ZalM005o;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262794-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262794-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 142BC31A6465
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 17:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19BF428859;
	Thu, 11 Jun 2026 17:49:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9140334252C;
	Thu, 11 Jun 2026 17:49:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200199; cv=none; b=MAXCyvb0B+7urThmICUG8hCIcwb3O7/OwQ/h20O3BWhQTO1D8F3LSTMXYn6jCLkjzllS8HyfHLLJOVZKfZ+o4nv0xjSPR6DbThSLnUWMVocuNVnGGzR0ko1/X2ow1i4nKtmL3d9RYePGfqnB0zmvBcVtMg8CD+NaANWeG3/llcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200199; c=relaxed/simple;
	bh=A0tgh4WnHTxGBmbh+DeIP5G40O2qNmEvB42OOSSf30c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLCFK3Xgdz7e2MtikdKZFTkJY/GM4BxMfpk2np1T/0SQQeVF2ipWzm+4Uq0FKr2rmccvGHgCOkf7wiwbDPe5Vl8KoI5GfOS/BQS2r76LFn93D/WBhj8qHw05pV0lbKO1RtnJ1mMwtw+/14AbIsEKRy+6biiLHM+zBbK0bsAnSA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=aYDpwFG6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZalM005o; arc=none smtp.client-ip=103.168.172.146
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id AF36CEC01F5;
	Thu, 11 Jun 2026 13:49:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 11 Jun 2026 13:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1781200195; x=
	1781286595; bh=Fv3zltmQZuUcdgjP+FmX8anaVH8F8UP5gl9/ld5PYuQ=; b=a
	YDpwFG6N42MTs/xsMq0oIwkEr28q4aqM59KBJJkB9mX1zMJRZysGXeNRAjLEXKSj
	yXcwNgaFHSWNTHtFvcLufn2pCVK1FQyKAlxwGyP8UPYFhw9w3u/qr5LCQmWLzjsT
	1myyRuHh74RJEAhtNlmXXuO73XucbW6Njv/gjWYMTzCJ9XhWUC1P6z3qnC3+3XtX
	gB3kQTb9zjCa3mDTYzCmybNS+laNfe44NUoTL38zUfB/d5EwBleieY38RfgefHXj
	FMHDGPZs73v8Ne+s3t+2KhWM7rgZuRjYeFi9nt/B0xtfxVlWAuvfuMHIHSUeQI9d
	W5PCr4b0hgSp2ecgMF9qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781200195; x=1781286595; bh=Fv3zltmQZuUcdgjP+FmX8anaVH8F8UP5gl9
	/ld5PYuQ=; b=ZalM005o+Fz9LA8WRNXfAuVxBM/jX/JF16Yc1RFoZY5E2OQdsiT
	94eZFeSfKJ5fT2Sk7jvQUvvMirT8+3w9KbwlGVWkDKiGczFUL6BsxeMLeYD2bXxB
	NPL4ykPQv6oe8+BuYfZ/yWgityw8KmYbfOSY32atOBgOKCdTvb5Y98Fi7ZpqoXzb
	EgCzJBDBRo+m8cV55/37SaZn6khOONL3ULhZB3WjtNjw3hdfjlPrmtxQcwba9KZk
	jd9rVQgNcOV1FyQsrx4NUbthdkSy8titp8IOpxG0CMoS/C7DgiqTsGo57nrnEPaS
	kEDQQbxQruQ/JsRmTy2s6eXvuEmZ/QY4ycQ==
X-ME-Sender: <xms:QvUqahe7RnBPgWL6EOHhl5zjyDVWufkn5LD5rboL7X6m2-56O8ct-g>
    <xme:QvUqanUkZ_CDy38EzZahBIZrrIfZf7ac1GvhDxAbwk-SI9xP6_4udYPRk0fC6K8W2
    Bj0c4X0u2gubSBqVF4F1iJ2RdjlKLrGrv8dB3U8AucyOA9aZwR1xQ>
X-ME-Received: <xmr:QvUqaqCxIOJIimaCFDhUzzc-3jyXfARjKam3fMduxoptvWeEhNVBVm0v74OwKI8J-LnIjzVd8g9Qaf96zWsgkeo>
X-ME-Proxy-Cause: dmFkZTE+9xNvn3jpTJhf5GiPXg4ArdU+aLZLs6IgDmj1lh17R+bGZ2cfhULK8LvQkOC6gd
    sPJ6Z5hKhXLloLTmhArtHiDtixi5soLxdAS28QGjPdxD1iV7YmP//vgXDKz7NmqIa1S0bc
    c5crwom/9jSFmNqoWJvAhczVhCcwguIaKir/9l2kMPoBJHCcmqEw8AliwQ7S6OJxaiTvKD
    zIowhRtEvSyO4vLm5xP0vRjK8EDlS4oOH8Dr/oCWsw0TZOGQLsYqjUd0VjGSarwzwlNEf9
    mCZ/pyzObhJLqbkR9hcMb7WHtd5BvJA7pQx2cSXH/meQqQbbs2oUFJxmV281gKYuJSHqMr
    iasO144mTjSoImMMtv6J8Q0RYf9jFuAlTQDAibYpomlp3CKZeSm2hSznAYYRdVmClniBkn
    +3AGUmVNdFzw82QA+4DUttwAwSrUhwicxxdPlC37Ja8k8D0Q6Y1Tj+074DJokv4/Ho10vV
    LZ/oMFtRjmLJ301e4ZE8DgFv3HfHnO+88s+EXF5PvRx6d5zFyzxQT8xQYGhssC8/Jl5GB1
    i8BSrCOyCEVn1PvBz0yZcY2+FlwI7R7J+uux4Kk9zt8Hfic4DVniK4f4U1Mgj30O0zM31r
    EKcZ5L2uXwP2W7TjqInWREzz2MOKLTqAv0VAKEY54emai4RZ57L9EMtV/3TQ
X-ME-Proxy: <xmx:QvUqaq7fa3n3xS01vwny9P0EOVxsp69qQsvCdghPQlfEp_vokN6w_g>
    <xmx:QvUqap2yPDNeAi1FRbmd0AGELdYZTb_gRQ3AUqq0ppcBBMfj4nsK1g>
    <xmx:QvUqamm6eo28Ta_xIIdmW2WLOmv98GuUGqamMKBoAlwgOtKWgYLrgA>
    <xmx:QvUqan6_cQBUrz0kb9VnQmu-stU2Nvnv_PrUTX50wL7jiNEDLFHx9g>
    <xmx:Q_UqajkLvOsay_46oH49iZPloH6_rY6ZuBkIysmWeWhmHaH060qpCgKq>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 13:49:53 -0400 (EDT)
Date: Thu, 11 Jun 2026 19:49:51 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: af_key: fix refcount leak in pfkey_spdadd()
Message-ID: <air1P8N3WC8mG4Vf@krikkit>
References: <20260611163743.99526-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260611163743.99526-1-vulab@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262794-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sd@queasysnail.net,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,queasysnail.net:dkim,queasysnail.net:from_mime,vger.kernel.org:from_smtp,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D2CE96744AA

2026-06-12, 00:37:43 +0800, WenTao Liang wrote:
> In pfkey_spdadd(), an xfrm policy is allocated via xfrm_policy_alloc()
> with a refcount of 1. On the success path the policy is eventually freed
> by xfrm_pol_put(), which decrements the refcount and calls
> xfrm_policy_destroy() only when it reaches zero. However, all error
> paths directly call xfrm_policy_destroy() without releasing the initial
> reference, leaking the policy object.

Uhm... have you looked at what xfrm_policy_destroy and xfrm_pol_put
do?

-- 
Sabrina

