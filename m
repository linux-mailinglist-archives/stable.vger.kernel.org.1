Return-Path: <stable+bounces-240411-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CE1zKKKm6WmzgQIAu9opvQ
	(envelope-from <stable+bounces-240411-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 06:57:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 336F044D1C4
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 06:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 055833023A69
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 04:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1288244687;
	Thu, 23 Apr 2026 04:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BcSlBE3e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95267611E
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 04:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776920222; cv=none; b=jBnfwdP0+Oz9yQ/YgoYR4iC5tAtOzk/dQi3kofuMFU8iLLhoHg//JoJJ+jPWCozJqMsU4imUMH+3EPPIdfKuAPJyk0L11ukwhVU3i9/pocoWJI8c84r/OdTYUQ34A0gBJMWeK2r6jXr09X2rZRD80dbHejBL4ob1xb02kYCulYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776920222; c=relaxed/simple;
	bh=BC9GTBdNO0Lq8OWjR7BelcdwpVcqM4n+6HABP1TV9jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcrOA/kcctbo4OKp362dQoX0Vj9n5UrEX8w4e/Chi+8wuvR53KE9Rq7Qx0qHavn7Oj7YUO2JZkyTVIBkJ3R7FawMDVmBMK77hbxN5qtnMRu1QmpJgWjZx4GXHuhKvM542Y6q1YLhqUikuChBe92HG4Z1CTHWtNuGX57p3ht1aEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BcSlBE3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E46C2BCB2;
	Thu, 23 Apr 2026 04:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776920222;
	bh=BC9GTBdNO0Lq8OWjR7BelcdwpVcqM4n+6HABP1TV9jU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BcSlBE3ejMRolK1b2I31m6rHoqU7gvooilnUcbgvwPEhS9XNKHlmeUm0JNStpdLTd
	 HHGr/3i7pZ6evursT7Z5m9HMnKqG33YxyJw7UdMYclMk5h3VRw3U9Fn6dJ7x90Zukl
	 9gWYR3rNoRlcWGdmD83CYUZoZ2mHM0DaF0awc2FI=
Date: Thu, 23 Apr 2026 06:56:59 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Wolfgang Walter <linux@stwm.de>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: Fwd: [PATCH] crypto: authencesn - Fix src offset when decrypting
 in-place
Message-ID: <2026042353-bonded-easel-15c0@gregkh>
References: <2026041152-boaster-patrol-1918@gregkh>
 <b397c5b34ed7484aad6e0acf7e1319c6@stwm.de>
 <ad7QGhjPKRh-Vvm5@gondor.apana.org.au>
 <0462b2759106bbb145297a49369820c4@stwm.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0462b2759106bbb145297a49369820c4@stwm.de>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240411-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 336F044D1C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 11:30:11AM +0200, Wolfgang Walter wrote:
> Hello,
> 
> the fix from Herbert Xu has landed in Torvald's tree as:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1f48ad3b19a9dfc947868edda0bb8e48e5b5a8fa
> 
> 
> Would it be possible to include it in the next stable releases? I using it
> already for v6.18.22 and v6.18.23 and it fixes ipsec with esn.

Now queued up, thanks.

greg k-h

