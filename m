Return-Path: <stable+bounces-227169-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEcIB7sXu2k+fAIAu9opvQ
	(envelope-from <stable+bounces-227169-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 22:23:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 710762C2F14
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 22:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73BEB30FFF16
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 21:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CEA376BDC;
	Wed, 18 Mar 2026 21:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="HYFu+fGk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DwHfwK0Q"
X-Original-To: stable@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C57C2D879E;
	Wed, 18 Mar 2026 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773868976; cv=none; b=c2GK/dyrRkud+ilaMtoKYvSmGh8S7BN20zzuLTDGjBEWdeYMep1vN36AEq9c6CYF8Mh86SzH0FJQAJAkgw+VtI6UWeLVaRU6AYOX5OMTcXfn/KIMs0XSWFKmbMF4HkiqjttX8JTpPLlGlaphBJ6So89M+TnJUBHVgkdzmcN5Ojo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773868976; c=relaxed/simple;
	bh=Lr8WJ1pbf2MMvZ07npOpxTu5vDyPtHiDSzMNSJrmTg0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JOpi/k8gVVlZH7/MR7rwlCysD2bq5m56htH66oPgFqQ3hiH3VXvHCJBtwGsOLhFq+gK9mbakm16x5OCWRqAZJVozRZdoXEHswg+AtJHC5omVxYJQW1/LDFG6FvYnfCgHQ4EOPG0mzLeaxPhqZgkjkhBg2Nf26X9px8fdI+KitE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=HYFu+fGk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DwHfwK0Q; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id C8A5FEC01CE;
	Wed, 18 Mar 2026 17:22:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 18 Mar 2026 17:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773868971;
	 x=1773955371; bh=i3rzu56iHOdiPo0h0sV4fs0AbEWpwwHMYjaaBOspznI=; b=
	HYFu+fGkclc5+ktjuFY4t8iUbi1ynQSICLqP63EBuw1wZycs3e1KDB1zvBclaEaF
	cm6aJUe5QZcsXcl5a26zOKIzS9UY6hG/WV1WUHCaL5yzrdkk0G4mpBYnEbLchxXq
	dyUH3Z7lR7+5s7bLaqzjPuc1ADQJkBQj702S5FMnWlIsrmjXdUECRPY67UjBYCvE
	1UWH0yfdeVybuQdnOp5I+FvQamF1KMOCS0xumvxRy1ivVqUC6Or2fNXbL29QqGmN
	k32QonyO1OZKLYbwSEg7eoCPrJvNv+UXgAWRw+czTloAdUuqn5MjaDzQ8PV9mffG
	7CsJmViK8tfdsCSSDukN/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773868971; x=
	1773955371; bh=i3rzu56iHOdiPo0h0sV4fs0AbEWpwwHMYjaaBOspznI=; b=D
	wHfwK0Q2b1ZbU+p7r5DalmHP/6dRh4TmlnAcW0Cgq6bwvuAI31Ef0Vm1zsXArNsn
	xTijdL/MdouuNalhdA4J8IEnA0p0HfVqv1o3YaEV2+s1z7XYJgOqP9/1ckdpH4Cu
	9tyd00Tyh7O5TzE1v2kAIv64pGO2HUKonEry5Hn4q0wRWDtpzll7h1J9yZN4r+LX
	D7vNh5lvQOl0tJdADyXvb0QEM2sokxxlw60vgT2eY3YYNPjEwf1IBLxywM2tybwZ
	HI8DmxmWq/SoCNEYYQWKpILgIZxbV6vcljo+ci2j2Cnts273ikQwA/uSZLfNxhUN
	5LWqmmDqfsZZ7LsVtqeJg==
X-ME-Sender: <xms:qxe7aVnkS09inuxw5F4KX0jhLvbT1cn7LVjk1_vq7ba-ZxqcRk6bhQ>
    <xme:qxe7abxOtDHRNd4l2CL7RiIydUIX3WiH_ETAcuoWLFrSn6tj1xdYS302vObHbYl_m
    zz2lITzZ7sSNfdpeBDZFIaSjMWfjv7tXAcam8JQKkcfr9R1Z13RWA>
X-ME-Received: <xmr:qxe7aark2tPqGfU2UiYIhNkF8ChS5XdUd6p4rhO6eFO7j_dHDZsd-hLEFQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdehvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfesthejre
    dtredtvdenucfhrhhomheptehlvgigucghihhllhhirghmshhonhcuoegrlhgvgiesshhh
    rgiisghothdrohhrgheqnecuggftrfgrthhtvghrnhepvdekfeejkedvudfhudfhteekud
    fgudeiteetvdeukedvheetvdekgfdugeevueeunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhgpdhnsg
    gprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvnhhu
    lhhlodhmsghoohhnvgdrrghkrghmrghirdgtohhmsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehmsghoohhnvgesrghkrghmrghirdgtohhmpdhrtghpthhtohepkhhvmhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgiesshhhrgiisghothdrohhrgh
X-ME-Proxy: <xmx:qxe7aa4cKhW8n6YPfr3U7bchl07lveBc-mhr9--iUhgJH2uoeWJW9w>
    <xmx:qxe7aRdmXhivPcQnA-Qb7E2OPlqOnV45u9DYJhthUJVQpBFNsMl_ng>
    <xmx:qxe7af6Pzc11m2bzvM0-0QL66WakQeb_EQyU0jpsnCYJvG58BX1o9Q>
    <xmx:qxe7aYtXwZmL5rbsn-v2as4IIukpZ1F183hOBgl_JqKWQr45Z8pH3g>
    <xmx:qxe7aUuXuJKEfo-JvCrX6F7EtmpPWXZzXit5rfuYHqw9YBLuJNnKBsRB>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 17:22:50 -0400 (EDT)
Date: Wed, 18 Mar 2026 15:22:49 -0600
From: Alex Williamson <alex@shazbot.org>
To: Max Boone via B4 Relay <devnull+mboone.akamai.com@kernel.org>
Cc: mboone@akamai.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH] vfio/type1: Retry follow_pfnmap_start() when PFNMAP is
 zapped
Message-ID: <20260318152249.43eb81f6@shazbot.org>
In-Reply-To: <20260317-retry-pin-on-reclaimed-pud-v1-1-1f0d0a23f78d@akamai.com>
References: <20260317-retry-pin-on-reclaimed-pud-v1-1-1f0d0a23f78d@akamai.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[shazbot.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227169-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[stable,mboone.akamai.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shazbot.org:dkim,shazbot.org:mid,akamai.com:email]
X-Rspamd-Queue-Id: 710762C2F14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 16:07:45 +0100
Max Boone via B4 Relay <devnull+mboone.akamai.com@kernel.org> wrote:

> From: Max Boone <mboone@akamai.com>
> 
> A race between page table walking (e.g. via procfs numa_maps) and VFIO DMA
> pinning can lead to temporary failures in follow_pfnmap_start(). When a
> PUD entry is split and concurrently refaulted, the PFNMAP mapping may be
> temporarily zapped, causing follow_pfnmap_start() to return an error.
> 
> Although follow_pfnmap_start() returns an -EINVAL this is not due to
> invalid parameters, but rather because of the pfnmap being non-present.
> Treat it as such, and retry by returning -EAGAIN, similar to how GUP
> handles such races.
> 
> This avoids propagating an unexpected -EINVAL to userspace, like follows:
> [dma_map]
> dma_map iova=0x000000000000 size=0x000004000000 vaddr=0x00007f7800000000
> dma_map FAILED iova=0x020000000000: [Errno 22] Invalid argument
> dma_map iova=0x040000000000 size=0x000002000000 vaddr=0x00007f5780000000
> 
> Which would've succeeded on a retry.
> 
> Cc: stable@vger.kernel.org
> Fixes: a77f9489f1d7 ("vfio: use the new follow_pfnmap API")
> Signed-off-by: Max Boone <mboone@akamai.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 5167bec14..3a0d0bbb9 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -559,9 +559,17 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
>  		if (ret)
>  			return ret;
>  
> +		/*
> +		 * follow_pfnmap_start() returns -EINVAL for
> +		 * invalid parameters and non-present entries.
> +		 * If that happens here after a successful
> +		 * fixup_user_fault(), it is likely that the
> +		 * pfnmap has been zapped. Retry instead of
> +		 * failing.
> +		 */

It's a little stronger than that, right?  We're betting that the only
remaining non-zero return is due to a race and we can introduce what
appears to be potential for an infinite loop here because -EAGAIN will
get kicked out to redo the vma_lookup() and fixup_user_fault() should
return a genuine error if we're completely in the weeds.  Should we
make this a little stronger and more specific?  Thanks,

Alex

>  		ret = follow_pfnmap_start(&args);
>  		if (ret)
> -			return ret;
> +			return -EAGAIN;
>  	}
>  
>  	if (write_fault && !args.writable) {
> 
> ---
> base-commit: 96ca4caf9066f5ebd35b561a521af588a8eb0215
> change-id: 20260317-retry-pin-on-reclaimed-pud-dfb9e26eb8cf
> 
> Best regards,


