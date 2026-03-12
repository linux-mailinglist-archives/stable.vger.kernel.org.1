Return-Path: <stable+bounces-224904-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIz0OWP8smmQRQAAu9opvQ
	(envelope-from <stable+bounces-224904-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 18:48:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4593F276C8D
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 18:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A72FC30A187E
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 17:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A02622A4F1;
	Thu, 12 Mar 2026 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2B9kvyD0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D618221F2F
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773337649; cv=none; b=gUnL8Rblnda3X0+F2YciMizh0Hp5EsM0UXVbTMo/mXVIN8kL7HvHzXYQfM1O1SfPpHKYu/faPZ7khrRJKxw8Q3eNHKU9+qtI2mMHmTczrJO3fqFjeqveyT5/l4kbBzfSVEm7ocy+uxRe1NrP+mKYXfOYT/NY9dVigLNSaa1j5Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773337649; c=relaxed/simple;
	bh=ehJUvxvid3t2rmAdiav8+vgSkMWongK0fp+rm1Z3YEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omYV8FvkS0xzsvBqUodfi+msnHHkjz0Oo17BXpJAK87Ll7Ac5aJwWiVLmbjgEeOJQrEVPTgzC44rl7U+lY5p3mQlxhFqRUCjf3b6yZGp5jlw1ZJl5HBfnoEtIyOk/zc/K8oUawfQdkAyTx1Wj9LgghJc7OmVFzADmlaRdGt51a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2B9kvyD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499C1C4CEF7;
	Thu, 12 Mar 2026 17:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773337648;
	bh=ehJUvxvid3t2rmAdiav8+vgSkMWongK0fp+rm1Z3YEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2B9kvyD03M4iobzfw738CUb7Zo4v0G+8mlyNeM7oGWz9mNoWZb0zBB184KYis6Zf9
	 HyXFlcgGxfAn233Swf9N3op49P3VbypAZmdQxxGquhTZSIXAR0H3yimNZQw3lJpJgk
	 9mqp242HYiSqz1BWDbPouiQ+EDsYYebthrgMVBVI=
Date: Thu, 12 Mar 2026 18:47:25 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	linux-mm@kvack.org, Jane Chu <jane.chu@oracle.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Oscar Salvador <osalvador@suse.de>, Jann Horn <jannh@google.com>,
	Liu Shixin <liushixin2@huawei.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rik van Riel <riel@surriel.com>,
	Laurence Oberman <loberman@redhat.com>,
	Lance Yang <lance.yang@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>
Subject: Re: [PATCH 5.15.y 0/6] mm/hugetlb: fixes for PMD table sharing
 (incl. using mmu_gather)
Message-ID: <2026031222-vacation-cramp-6fdb@gregkh>
References: <2026012608-tulip-moisten-c6f6@gregkh>
 <20260218110129.41578-1-david@kernel.org>
 <c6f63b74-d532-4384-a1e6-2b0dcb7b5303@lucifer.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6f63b74-d532-4384-a1e6-2b0dcb7b5303@lucifer.local>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224904-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4593F276C8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 05:42:13PM +0000, Lorenzo Stoakes (Oracle) wrote:
> Hi,
> 
> This series was sent a ~month ago, is anything holding this up? The underlying
> issue is causing a really serious regression so it's quite urgent to get this
> pulled ASAP :)

I see 70+ pending 5.15 patches that people have backported that need to
be queued up as well as the pending upstream patches.  During the -rc1
cycle the stable trees get flooded, so the older kernels take a while to
get released as they are on the bottom of our priority list.

We'll get to them "soon", they aren't lost.

thanks,

greg k-h

