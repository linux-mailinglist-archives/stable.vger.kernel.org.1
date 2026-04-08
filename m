Return-Path: <stable+bounces-233890-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mN/rMltQ1mm8DQgAu9opvQ
	(envelope-from <stable+bounces-233890-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:55:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 503383BC71E
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C7E730414A5
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 12:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55572EC0A4;
	Wed,  8 Apr 2026 12:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Od6B71TE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C3F27F01E
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 12:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652747; cv=none; b=RDeDtqgdwOWexpwZcYYyABYZNGvB8X2VOCUhgVP+LP2I2MAa0ho33GXpRyoDkpRaAK7MhTs1vKOsKwLs7akzY/gTjLFvTbSyaXYkphwoHCiGijAVd0omCKgHHaS9/M+ussu18v3X2OEY6IzZDDzNhtoa95C7O3djtiWl5OipXXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652747; c=relaxed/simple;
	bh=pI38M4TIKVe9bBgloxuZeTwodJ0BBnK5L95Fxg6BN3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmYPRKOEjU2DoH9bqL0czAZF9PN8TskNZI3eluxj80D7hpFjucVoPFy6mOTPT4xy+0PpBl+k7EZ6zO/i2IcWzU5H+U8IUILznZqGU+sIgg6wVmuEQy0pbgd912FO/YvQ0Pooc1/HjIsiIqajSQy0vsEUnDm6CsAAB6SlTkFnPNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Od6B71TE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F1EC19421;
	Wed,  8 Apr 2026 12:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775652747;
	bh=pI38M4TIKVe9bBgloxuZeTwodJ0BBnK5L95Fxg6BN3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Od6B71TENC1nv7URJ7PCOcItPI5OsgRz6eFR6lVg6CMp2pQMXSlit1YlmgJgggN95
	 8do93KHQk5pYtW0PSIB90NUmiwG9u/Rf+CRb8SzPz2JmVRarfbf3BNIxLI0JpyZm0Q
	 C4PuYzl8Qd7OHAupF58qKo/fb3HFo3UvkzYxv84g=
Date: Wed, 8 Apr 2026 14:52:25 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org,
	Jane Chu <jane.chu@oracle.com>, Harry Yoo <harry.yoo@oracle.com>,
	Oscar Salvador <osalvador@suse.de>, Jann Horn <jannh@google.com>,
	Liu Shixin <liushixin2@huawei.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rik van Riel <riel@surriel.com>,
	Laurence Oberman <loberman@redhat.com>,
	Lance Yang <lance.yang@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH 5.15.y 0/6] mm/hugetlb: fixes for PMD table sharing
 (incl. using mmu_gather)
Message-ID: <2026040846-curable-portfolio-0bba@gregkh>
References: <2026012608-tulip-moisten-c6f6@gregkh>
 <20260218110129.41578-1-david@kernel.org>
 <c6f63b74-d532-4384-a1e6-2b0dcb7b5303@lucifer.local>
 <2026031222-vacation-cramp-6fdb@gregkh>
 <c6b9712f-2f23-43e4-b270-dd3a7371e57d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6b9712f-2f23-43e4-b270-dd3a7371e57d@kernel.org>
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
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233890-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 503383BC71E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 10:00:44AM +0200, David Hildenbrand (Arm) wrote:
> On 3/12/26 18:47, Greg Kroah-Hartman wrote:
> > On Thu, Mar 12, 2026 at 05:42:13PM +0000, Lorenzo Stoakes (Oracle) wrote:
> >> Hi,
> >>
> >> This series was sent a ~month ago, is anything holding this up? The underlying
> >> issue is causing a really serious regression so it's quite urgent to get this
> >> pulled ASAP :)
> > 
> > I see 70+ pending 5.15 patches that people have backported that need to
> > be queued up as well as the pending upstream patches.  During the -rc1
> > cycle the stable trees get flooded, so the older kernels take a while to
> > get released as they are on the bottom of our priority list.
> > 
> > We'll get to them "soon", they aren't lost.
> 
> I assume that is still the case, another 3 weeks later? :)

These are all queued up now, right?  It's a matter of actually doing a
5.15.y release, which seems to be on the every-month-or-so cycle as
devices relying on this old kernel sure are not used to updating very
often, right?

thanks,

greg k-h

