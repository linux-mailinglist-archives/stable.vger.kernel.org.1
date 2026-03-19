Return-Path: <stable+bounces-227314-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMK5AOoKvGkArgIAu9opvQ
	(envelope-from <stable+bounces-227314-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 15:40:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 836E42CD03D
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 15:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1A87307037B
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 14:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2DD3783A2;
	Thu, 19 Mar 2026 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zteub98z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0266E284693
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 14:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930945; cv=none; b=jW2lDMvPXYs8uVf9xhuU/DIGgAjsMJM6YZOBBSAGJCElsNFQnJCjMaNiAWB27Bn9pk7M/o4V2e1FBxBDDTp0DotGcGxQmleFuXSrY/ky5K6Z9KHpVp4OT7E/3aoAMzUj/Dj5lg06q1X/UmXMw0c5gJnkmI9uj6ZcOJ7QQjtO34w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930945; c=relaxed/simple;
	bh=uLnXtIaLEaryzqEolHOs3gNwJifTJXlDl/iFjMOoN18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWrueT/Rl88+5XUlLxchR1nmtCFCVubDLQ/YLoSM2TXGGSuU8i3HJ7nhIFZmWxfvPBfqglw+Xz+KrMg9dpoFkxWXqMiEu/BEe33kfHsJHNIJVUbWDi00kcZJ3v92jXi8enwuYoFbHWtQg/VtQuT/CnRSrL/mPovZt1EMfZOlhtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zteub98z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D90FC19424;
	Thu, 19 Mar 2026 14:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773930944;
	bh=uLnXtIaLEaryzqEolHOs3gNwJifTJXlDl/iFjMOoN18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zteub98z8royI9OAqvNMRyiwGJi0mbQG+ZC2SgfmCkPTApbGAGt1DC1panx/32G0a
	 3NHK0iVziXZnOBHgx4GhJPTwfmgz9JWcVvNpvfBUN5Sp3W191/SDJHNVRUypIKhHAX
	 Tot1pBRxAauhs4gw1BWf0x+Qa4dgdgUZTsjthrSo=
Date: Thu, 19 Mar 2026 15:35:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: vsntk18@gmail.com
Cc: stable@vger.kernel.org, baolu.lu@linux.intel.com, black.hawk@163.com,
	jgg@nvidia.com, joro@8bytes.org,
	Vasant Karasulli <vkarasulli@suse.de>
Subject: Re: [PATCH 5.15-stable] iommu: fix a reference count leak in
 iommu_sva_bind_device()
Message-ID: <2026031901-supreme-laptop-72f2@gregkh>
References: <20260319142544.23049-1-vsntk18@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319142544.23049-1-vsntk18@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-227314-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.intel.com,163.com,nvidia.com,8bytes.org,suse.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.957];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,suse.de:email]
X-Rspamd-Queue-Id: 836E42CD03D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 03:25:44PM +0100, vsntk18@gmail.com wrote:
> From: Vasant Karasulli <vsntk18@gmail.com>
> 
> From: Vasant Karasulli <vkarasulli@suse.de>

Two from lines?

> 
> commit b34289505180 ("iommu: disable SVA when CONFIG_X86 is set")
> disables SVA to mitigate a security vulnerability. 

Trailing whitespace :(

> 
> Due the current placement of the condition check,
> function returns after iommu_group_get() without a corresponding
> iommu_group_put(). So move the condition check above.
> 
> This is a stable-only fix applicable to linux-5.15.y.
> 
> Fixes: b34289505("iommu: disable SVA when CONFIG_X86 is set")

This needs an extra space, and the proper number of digits

> 
> Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>

No blank line between the two.

thanks,

greg k-h

