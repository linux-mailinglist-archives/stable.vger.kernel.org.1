Return-Path: <stable+bounces-62817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC639413A8
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 15:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656B3280FBB
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 13:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12251A08A9;
	Tue, 30 Jul 2024 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="DlLbXEkU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AUEtrlBZ"
X-Original-To: stable@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FC7198856
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347549; cv=none; b=JkwAGnI97OGxXBzXPOQeZWze1qzb96NTuIryTvPfd58LAjW0pyZjFo0eML8jWtNx31BPiKCfpKzUoTSly9jbAnedsDq0f0t3IihWqNbpkI4z7EJCV6FHXJXYwt5I1TDTKgxZhHx6uKArYPUPszNDwq/mYNsr6Wj/dwO5oCIQoio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347549; c=relaxed/simple;
	bh=9zNtkHvCQEqhB3QqYT0L/zBYk5Ejup31UVy5nAwNpbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9XiQDeoX92W39U/UMsvgRuXGH2/a5vG9OAPiTlfkd8ScLGPaFTraXY2/nrmTyM+wW9k4Y/uyY1bIpbc2EwR4QtQkpII+K59mgAQooXUbc9mRZxaU7n2yjMljYMxDKS+8r1Hfw0uRFLv4LXKcdxGlaAwT+0FXwVcJfpw4XibLe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=DlLbXEkU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AUEtrlBZ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1F1E81380284;
	Tue, 30 Jul 2024 09:52:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Tue, 30 Jul 2024 09:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722347546; x=1722433946; bh=ij6GCdrhil
	7zgni/dPV9KAgLrdFBwG7AdbsW6DV7yTA=; b=DlLbXEkUyCUQvMXAwNE6B5eN30
	JXCKauriF8sQPku0zmBiBsiTtShoidxD51SQ21om/aimmrU0nKmmdykkprNi6T6n
	11Yv9nLOreKzeDYwYuiMpwzxoUrK2k1rhXtAEVRnRBAXmwdNsIgsC378NUAQiPM4
	9dJ86nYTB1HN4jQKo9AAscUSZ/v36G+m+eAjtygeJDBgbKluqWKnWYb8aNKkbWyC
	5u1GlsM/QjanBNdgXPcVypl9pnFokEg3P7s7rfRghL1+7iduWjGdlTWirKCEfFA0
	fVRVQIKNjra09VeG5gQG/oDvxpV2gadJnscLz2PlMDaDGg3c67w7SWZG85aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722347546; x=1722433946; bh=ij6GCdrhil7zgni/dPV9KAgLrdFB
	wG7AdbsW6DV7yTA=; b=AUEtrlBZz9xr7NhV9BIaK9wu1o780ZIKXjjyQlB+xl0z
	O4EAuATf0LnFd8tbuEI5Dd5wx8jS04l3uM17fK2dv5L1ALoC8jxoOd5h54NdnLI8
	G/HnDhf5fN7eQH18m0cz/voly25qUqpjukvT7neyj2EyKBlkHee7q4P57tTRkIQY
	5gq/D2iZKlyA1HacbVp1UhG0JhV7Db/NxqZ3+h2aXUiFTlW/BXfcVfER6Uuocd+9
	rc28LNFdJaVJK26tiud5zoZHCVY/LitQZyjR2g1qr+Qug2RCjw7dGSmkcWCSg1do
	FN44xljXJQoCus64pFQT9vyd18ZEqKo7ihAp6Fr67w==
X-ME-Sender: <xms:GfCoZiQ9bvX0UG5cTYnAeBqIYfm804XsJKxBm5QpDXNSBYsJG0vh7g>
    <xme:GfCoZnx8BGiT1rySCi1KRjgs6Tc18tMKIVdb7eDMj2gB3061lFcs221yy0XGK1Npa
    lRE8WuTL4aS2g>
X-ME-Received: <xmr:GfCoZv3AcJNNPU6dNECZZvYtzMvq62K5YUwpVlvRfLMyiI64KmMrL9sq-S77DZzo3KxXR3WEh2_P3uYpZQhFqGkc2mQ1IH6fIhXA4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhe
    fgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:GfCoZuDlhKi6B6lF_F-DgQlm5JNrtP8dE4OmBnLWEFBvZGaT1EeLzA>
    <xmx:GfCoZrjk4I0vxO9jKQpU6qCiXXQ-gZ3ouzzoohgV447sXVrbU08M1g>
    <xmx:GfCoZqpOxWBrbtwzNdXcHhfDPXlhYAXTXsUCQyWj5R0QrvSoX2bG1Q>
    <xmx:GfCoZujLBNzi9G5pcE-rE45k1JdCBLnhqKGFXtmvheR-Jss4FTJHaA>
    <xmx:GvCoZsXiddsoLHx6kjycXzuLQeU3oApjQMjKH7t6vR_1Dc7ZiGEdpT5y>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 09:52:25 -0400 (EDT)
Date: Tue, 30 Jul 2024 15:52:22 +0200
From: Greg KH <greg@kroah.com>
To: Yu Zhao <yuzhao@google.com>
Cc: stable@vger.kernel.org, "T.J. Mercier" <tjmercier@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.6.y 3/3] mm/mglru: fix ineffective protection
 calculation
Message-ID: <2024073016-spinach-salaried-fba0@gregkh>
References: <2024072912-during-vitalize-fe0c@gregkh>
 <20240729074434.1223587-1-yuzhao@google.com>
 <20240729074434.1223587-3-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729074434.1223587-3-yuzhao@google.com>

On Mon, Jul 29, 2024 at 01:44:34AM -0600, Yu Zhao wrote:
> mem_cgroup_calculate_protection() is not stateless and should only be used
> as part of a top-down tree traversal.  shrink_one() traverses the per-node
> memcg LRU instead of the root_mem_cgroup tree, and therefore it should not
> call mem_cgroup_calculate_protection().
> 
> The existing misuse in shrink_one() can cause ineffective protection of
> sub-trees that are grandchildren of root_mem_cgroup.  Fix it by reusing
> lru_gen_age_node(), which already traverses the root_mem_cgroup tree, to
> calculate the protection.
> 
> Previously lru_gen_age_node() opportunistically skips the first pass,
> i.e., when scan_control->priority is DEF_PRIORITY.  On the second pass,
> lruvec_is_sizable() uses appropriate scan_control->priority, set by
> set_initial_priority() from lru_gen_shrink_node(), to decide whether a
> memcg is too small to reclaim from.
> 
> Now lru_gen_age_node() unconditionally traverses the root_mem_cgroup tree.
> So it should call set_initial_priority() upfront, to make sure
> lruvec_is_sizable() uses appropriate scan_control->priority on the first
> pass.  Otherwise, lruvec_is_reclaimable() can return false negatives and
> result in premature OOM kills when min_ttl_ms is used.
> 
> Link: https://lkml.kernel.org/r/20240712232956.1427127-1-yuzhao@google.com
> Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Reported-by: T.J. Mercier <tjmercier@google.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 30d77b7eef019fa4422980806e8b7cdc8674493e)
> ---
>  mm/vmscan.c | 83 ++++++++++++++++++++++++-----------------------------
>  1 file changed, 38 insertions(+), 45 deletions(-)

Now queued up, thanks.

greg k-h

