Return-Path: <stable+bounces-223333-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GrOD9vHqmlTXAEAu9opvQ
	(envelope-from <stable+bounces-223333-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 13:26:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF9C220913
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 13:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BF8A3033D32
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 12:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5195B35A925;
	Fri,  6 Mar 2026 12:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="DO1ZhLzz"
X-Original-To: stable@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8D335B12B;
	Fri,  6 Mar 2026 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772799951; cv=none; b=iA4wSjkLKjm3QMXAvowOBhWnGGPUZN1Z77rrYdLYTaPWQpaNOgbmh4dpCvibrO1gvMoutinyWAHsTM2X2myzrkz3NJ4GoQHzxjEVqy5AityWlBxPakNMzolGPBTmpg8Bfj/QrQRxZQ6ueqkkeAZqrbqbpMZUKxSR1BDopYUT59U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772799951; c=relaxed/simple;
	bh=IB4RFGtEX5IyRqsuPjZWPyREG+seLheh0xa2LYQx1ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6oVjHIrYfezvenz6pAW0Yn5vm7fw5glTMvtdf5pGEVVarlm3CT3PbwpJJezbjGT6ZbjM37KHE5jKWi2AEm5sohHUPIgmYug4Bmy8Ncz5QMR8jG6JPEbfe8YCH5N8gre4EsqRUbphEaIhQc46GZ71qlabiWsmmePELOk7tag5PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=DO1ZhLzz; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 6C641602CA;
	Fri,  6 Mar 2026 13:25:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1772799947;
	bh=JhW7KxJHfQ8Od1ZCI3A9xvsSokTzQtYE2iyTRHH3eGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DO1ZhLzz14HcRPFl4m2thmCAGHgZcP0+rXm1j/Cnuc7nszOu5U2IXSOoSOtDmtIhj
	 M4TTQB24J5xZ+UT5nb2Fc3S6JFZPWP0hZRAcbDZOlffQrlApyPCSJDvwQNRRLpq5MK
	 +pqVGu3N3csw43p6Y2/kxmPSXsz9Y9+2+oqqtpf9aHqbPkFEew5rvV5K52ZTrAJXhj
	 jnrCde07OwKnlS+U3hNyISiCEgw5rmhkSEWxiMfI25FkLarQbyeKR8YFvc0qU4okYp
	 8JdjLcpzd60/TblerCjNos4OVhvx/MbORea46fv9CXRE5o/qFp33TkpQAQM1Mw3wqL
	 FBDnUei7tDO6w==
Date: Fri, 6 Mar 2026 13:25:44 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Chris Arges <carges@cloudflare.com>
Cc: Florian Westphal <fw@strlen.de>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lwn@lwn.net,
	jslaby@suse.cz, kernel-team@cloudflare.com,
	netfilter-devel@vger.kernel.org
Subject: Re: [REGRESSION] 6.18.14 netfilter/nftables consumes way more memory
Message-ID: <aarHyHIQY0nS9d9K@chamomile>
References: <aahw_h5DdmYZeeqw@20HS2G4>
 <aaijcrM5Ke5-Zabx@chamomile>
 <aaij0XAgYRN40QdD@chamomile>
 <aamvQTTZu4-chpsS@20HS2G4>
 <aarHEfdMXDJ-Wq3V@chamomile>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sjVQ9/yd0Z5i2DI2"
Content-Disposition: inline
In-Reply-To: <aarHEfdMXDJ-Wq3V@chamomile>
X-Rspamd-Queue-Id: AEF9C220913
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-diff];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-223333-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


--sjVQ9/yd0Z5i2DI2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Mar 06, 2026 at 01:22:44PM +0100, Pablo Neira Ayuso wrote:
> Hi Chris,
> 
> On Thu, Mar 05, 2026 at 10:28:49AM -0600, Chris Arges wrote:
> > I noticed after I sent, thanks for fixing.
> > > Hi,
> > > 
> > > On Wed, Mar 04, 2026 at 11:50:54AM -0600, Chris Arges wrote:
> > > > Hello,
> > > > 
> > > > We've noticed significant slab unreclaimable memory increase after upgrading
> > > > from 6.18.12 to 6.18.15. Other memory values look fairly close, but in my
> > > > testing slab unreclaimable goes from 1.7 GB to 4.9 GB on machines.
> > > 
> > > From where are you collecting these memory consumption numbers?
> > > 
> > 
> > These numbers come from the cgroup's memory.stat:
> > ```
> > $ cat /sys/fs/cgroup/path/to/service/memory.stat | grep slab
> > slab_reclaimable 35874232
> > slab_unreclaimable 5343553056
> > slab 5379427288
> > ```
> > 
> > > > Our use case is having nft rules like below, but adding them to 1000s of
> > > > network namespaces. This is essentially running `nft -f` for all these
> > > > namespaces every minute.
> > > 
> > > Those numbers for only 1000? That is too little number of entries for
> > > such increase in memory usage that you report.
> > > 
> > 
> > For this workload that I suspect (since its in the cgroup) it has the following
> > characteristics:
> > - 1000s of namespaces
> > - 1000s of CIDRs in ip list per namespace
> > - Updating everything frequently (<1m)
> 
> I see what is going on, my resize logic is not correct. This is
> increasing the size for each new transaction, then the array is
> getting larger and larger on each transaction update.
> 
> Could you please give a try to this patch?

Scratch that.

Please, give a try to this patch.

Thanks.

--sjVQ9/yd0Z5i2DI2
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="fix-rbtree-array-resize.patch"

diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 853ff30a208c..cffeb6f5c532 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -646,7 +646,7 @@ static int nft_array_may_resize(const struct nft_set *set)
 	struct nft_array *array;
 
 	if (!priv->array_next) {
-		array = nft_array_alloc(nelems + NFT_ARRAY_EXTRA_SIZE);
+		array = nft_array_alloc(priv->array->max_intervals);
 		if (!array)
 			return -ENOMEM;
 

--sjVQ9/yd0Z5i2DI2--

