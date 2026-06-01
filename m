Return-Path: <stable+bounces-259460-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GlRHlYzHWoqWQkAu9opvQ
	(envelope-from <stable+bounces-259460-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 09:23:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E975B61ACDE
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 09:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42819303CE0E
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 07:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A92348C7B;
	Mon,  1 Jun 2026 07:13:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE581A6815
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 07:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297995; cv=none; b=CPJh4bM95sAPOaGrXTeWQm2Fr6nAzMiLzTMDwbRCfO3IMxk0/PxyhXZUJnSEHgD7bDeGA6rLrMDfqw1OXM9YUyRZcZqnjgLCnIyncL4oLpZ1OV1C/jK+fPp7Gc8xw0JLTD2lIBgtJojzqVUxDWE18H9HTNKU+bWf52im8xY+I4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297995; c=relaxed/simple;
	bh=p1SJzXxY2u9L5GvhpaKSoycutsl+0AYMgIYio8M5mH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EruC3HVKmDpdhGSPhaDZZjPCBG2po9QLzeisaFckz/b0yeT8yPjF/EducjejBGS/8q6L9GR3KR3SgrdBlHYzOVMDooF/ZBbpabYGr/CHDcrz9pL0x+bQ6MBtp3yJaMcHqQ8LtWKFngYw/if1gaL4ToGYV5xf0f7I7Kl1xmNhP7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7797A68BEB; Mon,  1 Jun 2026 09:13:11 +0200 (CEST)
Date: Mon, 1 Jun 2026 09:13:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: hexlabsecurity@proton.me
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Greg KH <gregkh@linuxfoundation.org>, sagi@grimberg.me,
	kch@nvidia.com, "bvanassche@acm.org" <bvanassche@acm.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] nvmet: fix pre-auth out-of-bounds heap read in
 Discovery Get Log Page
Message-ID: <20260601071311.GB7533@lst.de>
References: <Q8CVAA098pa1LIPOSNGvR2qrzqdOBQqRTLK54O4KsGMzSh4IOT2Ucrlv87C0ULvpILYim-FotD-OumzPcjFauZM2iyjJ4tjzaMRsXE7G_3Q=@proton.me> <20260527132353.GB11071@lst.de> <QQhn1zPqAyjwS7XXM_jeFtjpyW7pXcVTGMP38boMl6zWR5ehel-nsdJdksZf0ASO03qt5pX1B5UAnlANuO7KZISSgggAjnjLruly7nAjJ2A=@proton.me> <20260528083537.GA7590@lst.de> <39YwPS5jntghiVQLt9ikZnmMc7O2g1AY3OVDcxdZjaK53FZHyzQNmyaS5eYBTS93g0Wc-S-UDC0auDRcGgC4iMR5RgXLEBPvqHfFZfbaeoU=@proton.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39YwPS5jntghiVQLt9ikZnmMc7O2g1AY3OVDcxdZjaK53FZHyzQNmyaS5eYBTS93g0Wc-S-UDC0auDRcGgC4iMR5RgXLEBPvqHfFZfbaeoU=@proton.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259460-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,stable@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,proton.me:email]
X-Rspamd-Queue-Id: E975B61ACDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 04:02:17PM +0000, hexlabsecurity@proton.me wrote:
> Suggested-by: Christoph Hellwig <hch@lst.de>

My only suggestion was for a slight cleanup to the flow, so I don't think
this tag makes sense.

The patch itself looks fine, though:

Reviewed-by: Christoph Hellwig <hch@lst.de>


