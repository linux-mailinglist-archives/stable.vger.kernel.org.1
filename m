Return-Path: <stable+bounces-254177-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AmdOUdwFGqXNQcAu9opvQ
	(envelope-from <stable+bounces-254177-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 17:52:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFE25CC887
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 17:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD91F300461C
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 15:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1193F4105;
	Mon, 25 May 2026 15:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kt3y9pvQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330E6262FF8;
	Mon, 25 May 2026 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779724357; cv=none; b=ae+COIvxiGZbXwJuVqzdwGXM/sAvP5CO9OxMFD2++anBa1vD0D9ph4nYeb4LlyiP2KqZ4A2JWRnpfv51Oa1eRRCm089Nv8F0CXRQDpXrqWBf8bu89jUF6e5usIXwv6hqNLKutvXHEZn8U7QdxSHN+zWPa3+u32pMCmEa25y8Mok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779724357; c=relaxed/simple;
	bh=tqbA0loR2xDZXnLKfFMuf7M2BRFAVk7486HBRiTlpok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heiV7MTkU2UwFyuKveT6oxFSaBK13XVODUa7Wna3zSXzqqnU+EqLPKgvVKMkSwcQSnf+vDACfZpX8FsZSfnt3hQReDn0cRPnR3e23oyvHAM2R+jSTTrhlQB4eOCCrARyAOJ8lV+c7eQvVBekU23eZV5rvuKUw95wbeJwV9UBvdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kt3y9pvQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4361F00A3A;
	Mon, 25 May 2026 15:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779724355;
	bh=k/Z8pdHv+cejKJRoNdNxhQU2h7dJRvk5CmidndA10Ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kt3y9pvQwdSuJvSTN7r4XI5/WHegjzntVLK6Pd1S5QJhj2zIobFJYb/xhTuzCBGuL
	 y6HSVM65kCCxp2g6iltV2ZtcmXLmgjWNXyIhIeSrZZBePRkr4YmFljRJTEFEbDlS9A
	 a8y584fH//yWR59AYHGGrQnzb54Z2e+VZIaSZAiax5tru2UysZVas7oSUfj3vgtXMp
	 LEpkO6WnIGt0K2FEOaHaiwSZqYLaMbnrv0rYf299gs55+VqF/Xi9wKg8P39V4ZATqj
	 oJ2TY32irf0jqG+n64y3WOujqj5K4rEnmANxrZPN9Ag0MGo2cJOz6YvYLkpXevOawy
	 zNIPOEAhm4E4A==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id AF47EF40068;
	Mon, 25 May 2026 11:52:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 25 May 2026 11:52:34 -0400
X-ME-Sender: <xms:QnAUaibTqZNNkpfvaTg4ESj2J48AtkXqLmiZWdG4auANFJ2EWVOC_Q>
    <xme:QnAUaj5Jke3dVBcxUG17rltglfQusJSRkRDhJuZ-aEsi37JaVK9ZRWCvfvyEP9Ijj
    xjbgduOFx_FwslUjVdSAlFwzVGi2r0aqfO54OmDmA2QmR_m55yFgKg>
X-ME-Received: <xmr:QnAUajz_zW08SVZXxXiZRAVPUUfpLHW41K7kA9pRKt0MYYxlGrSKAzJ2YZJgFQ>
X-ME-Proxy-Cause: dmFkZTFG3QYNTvlQv4dXNCn1oodIpGtSg2/FSbVjxuVpQ1UyDWtTeK1CyeqKqmJVajGwCO
    wIChQ7Vt+BXUskOWr6LlBPn5GN5fGeqIk/NYKTa7qGi7goriiLHEOgMdCN04mw+FZtqYdg
    XErwWFDznvfyjghz9mVLXKWox2GcuQMRU36tAor3BJtQgbKRAsNYDSm4IMOLEaZpCmNrZV
    1Azo9HmUZBLZ/jpte6sWbkMoMVQmjwnZysrX/e7xS+6iJOK1SGB1tZpM2eqpHr33IvrFjz
    GsC6d4gEejnCFMPKdLRWBwAG+EL3MQw/6/7pdlGjdNgxTKKiFHLJw02Nwa/LaqI65l03Tk
    W43i4GsczMkIPAnVOQktTyqvrTxNqlwhagFQqla8GI6lpovjMMG6yECuWIAupScgIhjeC0
    RPhDVRC4U1j/Q+x/9dF+fCmWjXKdI24pKDdslMjuFe5Angg4dk1J53w2TudjkLs1mBIyc3
    tDx4SDYb8Ed29GaGAQcMvjGGE+ZHk3dW6BEPZkEXLOyABIBm32uBzaVDaR02mRitIGSm1S
    cvzCpK7BEJwsMlBGMO+0PNhsvyNG5fBxc2MVprZ1HOo27C3yMO08eLPPgoH/8bAy7ImtTr
    Sluo4QhynIVqoTPRd6qxnBH5FWbYIClaoSGfgY87TMP3ibV2pyiFBkRx9gBg
X-ME-Proxy: <xmx:QnAUakrgu_jvN2NHAJqKMSuAa8xVZUabZMW7dk_-cPNBn67x0PQSqA>
    <xmx:QnAUal05uHNZ3hC2Z-bRyzFqsCwDllOKhkavr-YmWWW8_DvWLoaiNw>
    <xmx:QnAUatB47owQ_CXGPBSTWL9qLyzwkAg-QqroVDTKZpfu4ZdrUZhNNg>
    <xmx:QnAUamNWgeC5p20LW1FXGtJBj4GConISVPQe6r69QYCdFHClPDhqRQ>
    <xmx:QnAUahSEdPXjDDrhoQlbTnGjYSflKyAg2k5i4-uJbhdbRr94Ena6jRnz>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 May 2026 11:52:32 -0400 (EDT)
Date: Mon, 25 May 2026 16:52:27 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb_vmemmap: fix incorrect vmemmap restore in
 rollback
Message-ID: <ahRwIo7Mg71IY_Dy@thinkstation>
References: <20260525025213.2229628-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525025213.2229628-1-songmuchun@bytedance.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254177-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,bytedance.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kas@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8AFE25CC887
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 10:52:13AM +0800, Muchun Song wrote:
> vmemmap_restore_pte() rebuilds restored vmemmap pages from a
> tail-page template derived from compound_head(). This is wrong when the
> current PTE already maps a page whose contents are not tail-page
> metadata.
> 
> In the rollback path of vmemmap_remap_free(), the first restored PTE is
> backed by vmemmap_head and contains head-page metadata. Reconstructing
> that page from a tail-page template overwrites the head-page state and
> corrupts the restored vmemmap page.
> 
> Fix this by copying the full page from the page currently mapped by the
> PTE. Also pass vmemmap_tail to the rollback walk so only PTEs backed by
> the shared tail page are restored, while the head PTE remains mapped to
> vmemmap_head. Add VM_WARN_ON_ONCE() checks for unexpected cases.
> 
> Fixes: c0b495b91a47 ("mm/hugetlb: refactor code around vmemmap_walk")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Kiryl Shutsemau <kas@kernel.org>

Thanks!

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

