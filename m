Return-Path: <stable+bounces-249819-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOfzFciZDWoMzwUAu9opvQ
	(envelope-from <stable+bounces-249819-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 13:23:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DFE58C56C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 13:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D3CE308E874
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 11:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C212371063;
	Wed, 20 May 2026 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cou08W7u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD46335200C
	for <stable@vger.kernel.org>; Wed, 20 May 2026 11:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779275873; cv=none; b=HjHCbl8JbZNThn8YC5tNA7eykxBks3PObKsrVqD7eccPRPlVCI15GC+20RXHNv8O1mjkO6NiCBxJUwROukrU5Ax2E/YXKYzo/j6FrpIpXFcfm6D1QeDoyOyAaV16NrjjOJBmoxQZDxO0AkAAwfVAtriZM0xm0LdpqzJkJhY79zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779275873; c=relaxed/simple;
	bh=5yULgoV7kHFYov5AsPRO3xclFHDIhL4Hr6/KXhbTjQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uW6J80xwsJSGqBGy6eQOI2DK2I12za4lu/ilkRThoMmc2q8HW/pSvjvx5jcECgNSEgfVDB/kOGbwRsyPXXiJDt0aW10klHrbZpCrY+sCrp8JqLTh+K+EjSH6lloitLoheQq+dsHIbhU+6ZEuoWfV1AgXNZ94gi9wDTBK1Us2BGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cou08W7u; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DF51F000E9;
	Wed, 20 May 2026 11:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779275872;
	bh=VCfSfuTFJQ0aq8b90CFw9fjvIeEAkFbYn4iKREt3ZBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cou08W7u3+flaJhUZj0zvVuvCcguv9cB8ajMaTtO0OBKvAlxPvcr6pYvWSErSbl/R
	 Lgli+fmsIs+Im+vkO3H+ZKPH/Fbf7Gr0r+urYgAatXmQ9rkEOoQ3pk2Eiw+y+mAZNp
	 Fz9livTfVIFMteM9sBHV1pFwlEHbCVrguNn6Ybr0=
Date: Wed, 20 May 2026 13:17:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xiangyu Chen <xiangyu.chen@windriver.com>
Cc: will@kernel.org, catalin.marinas@arm.com, stable@vger.kernel.org
Subject: Re: [PATCH 6.12 1/1] arm64: io: correct user memory type in
 ioremap_prot()
Message-ID: <2026052041-flashily-pajamas-e72f@gregkh>
References: <20260520091337.3799553-1-xiangyu.chen@windriver.com>
 <20260520091337.3799553-2-xiangyu.chen@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520091337.3799553-2-xiangyu.chen@windriver.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249819-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 06DFE58C56C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 05:13:37PM +0800, Xiangyu Chen wrote:
> @@ -27,7 +28,6 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
>  	/* Don't allow RAM to be mapped. */
>  	if (WARN_ON(pfn_is_map_memory(__phys_to_pfn(phys_addr))))
>  		return NULL;
> -
>  	/*
>  	 * If a hook is registered (e.g. for confidential computing
>  	 * purposes), call that now and barf if it fails.

Why remove this line?


