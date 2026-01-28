Return-Path: <stable+bounces-211956-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CoFFE7ueWkF1AEAu9opvQ
	(envelope-from <stable+bounces-211956-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 12:09:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8C1A013E
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 12:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11C13300B04E
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 11:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982E129E10F;
	Wed, 28 Jan 2026 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZIG2w5J3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D26C274B51
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769598482; cv=none; b=MxeiFi0UnlaGonIvULaFKx44LUGFFc7RTm/3I9eDe4jS1EQLBah8VYaV0VgmFCB5+7hGO4fXHjmy3fv631xdXNcvAHCmKCbEztMgz3/huw6FAZLVK+3VkGKx22rqkdA0jzacs0izKdk5hUSGwJrCMFN9uAU4LVTH5V31tlrbw1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769598482; c=relaxed/simple;
	bh=Xx+SaZnBAPKzobSqSPVYcHV8x3ziTYzbPdKba+APPbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAHPDJ2VmZsl9w4SaslNieT+vihFVkkIDqJk/dhsYZFfLLU3B1K0A9YXe/WEaM8vKoM1N20Y6aCFfG6X1kzv6VqB0MEJ+NZeCLQC5OIAzzwYo1Ar+K3U3GYtotqRKh1eOaVCHPNOoHFk6Ol0pERPCc+RvQMmZ2vyXtcQ6NlGPSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZIG2w5J3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EAAC4CEF1;
	Wed, 28 Jan 2026 11:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769598482;
	bh=Xx+SaZnBAPKzobSqSPVYcHV8x3ziTYzbPdKba+APPbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZIG2w5J3J4k1/vgWX+ootC+Ri9a1Lp5MWM9TYw5jL6TcaQn++IFzqPboHKnaFBqpR
	 qUbVuvdLJtcjCAY/8hmHSzdFOT1ni0V6kRsp0Hd9gWJH5bp0a7YAodq8HCqigqAWqP
	 V7u3Quvfc62dLazDIAhoTy1gnZDWA/z36hBDrwXE=
Date: Wed, 28 Jan 2026 12:07:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com,
	david@kernel.org, gourry@gourry.net, jannh@google.com,
	joshua.hahnjy@gmail.com, lance.yang@linux.dev,
	liam.howlett@oracle.com, lorenzo.stoakes@oracle.com,
	matthew.brost@intel.com, rakie.kim@sk.com, riel@surriel.com,
	stable@vger.kernel.org, vbabka@suse.cz,
	ying.huang@linux.alibaba.com, ziy@nvidia.com
Subject: Re: FAILED: patch "[PATCH] migrate: correct lock ordering for
 hugetlb file folios" failed to apply to 6.1-stable tree
Message-ID: <2026012853-icy-revivable-74a5@gregkh>
References: <2026012707-hazard-unmanaged-494d@gregkh>
 <aXjIK6dhZ1EfpKFX@casper.infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXjIK6dhZ1EfpKFX@casper.infradead.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211956-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[linux-foundation.org,nvidia.com,sk.com,kernel.org,gourry.net,google.com,gmail.com,linux.dev,oracle.com,intel.com,surriel.com,vger.kernel.org,suse.cz,linux.alibaba.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: CC8C1A013E
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 02:14:03PM +0000, Matthew Wilcox wrote:
> On Tue, Jan 27, 2026 at 02:09:07PM +0100, gregkh@linuxfoundation.org wrote:
> > The patch below does not apply to the 6.1-stable tree.
> 
> The 6.6 patch applies fine to 6.1
> 

Thanks, all queued up now.

greg k-h

