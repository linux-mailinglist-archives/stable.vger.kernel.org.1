Return-Path: <stable+bounces-230421-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOB5JInOxGnb3wQAu9opvQ
	(envelope-from <stable+bounces-230421-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 07:13:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DAC32FAA3
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 07:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29D433034567
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 06:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5D73AEF58;
	Thu, 26 Mar 2026 06:08:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B7039D6D4;
	Thu, 26 Mar 2026 06:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774505325; cv=none; b=N7mCPg/qNhQDk1EJi68ec6aVfZh1tZAsFhcldZZr9D5E2JOT6nDZppDBGjOYojMIQv9iLvpUEhXtHkKX/JZLDJkbsVGAqGcY7IK+qfpxL60YOfWUZyXHkl5dtrqLdcyGd63MQmVfNsj+AX/M46f3hxzQ3WM97ZlyY8MBYcIUesU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774505325; c=relaxed/simple;
	bh=IGBz7634ql8MU/T2Y4f0LGAcRXRpaV0P0K09NrMZOt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGMGyyeNnB2oT+NoxC+X3jgMJ4yJgeI7XkKAeVI/5MUYwNhjHJNarpNtmurI06aDLkO5ehgfbezMczLkp8plWRB79jc+Tk/slLxJvcL6620ABSY/TQD2Dkl8vHVbxicJA+kf8E5hgGqW+o1a31o/jIh+xwIzF6s5mj96OcNe7hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CEFB968B05; Thu, 26 Mar 2026 07:08:40 +0100 (CET)
Date: Thu, 26 Mar 2026 07:08:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <dgc@kernel.org>
Cc: Hans Holmberg <hans.holmberg@wdc.com>, Carlos Maiolino <cem@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	linux-xfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] xfs: start gc on zonegc_low_space attribute updates
Message-ID: <20260326060840.GA23733@lst.de>
References: <20260325124312.26349-1-hans.holmberg@wdc.com> <acSfSmE_IBjWl_cR@dread>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acSfSmE_IBjWl_cR@dread>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-230421-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 25DAC32FAA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 01:51:54PM +1100, Dave Chinner wrote:
> > - Added a new helper to wake up the gc thread in stead of unparking it,
> >   which is required to make this work properly.
> > - Added protection against races with unmounts as sysfs gets torn down
> >   after the zone info struct is freed. This also avoids unneded
> >   wakeups during remount.
> 
> Isn't that a deadlock vector?
> 
> i.e. unmount takes s_umount, concurrently userspace writes a new
> value to sysfs file. sysfs file write blocks on s_umount, unmount
> blocks holding s_umount waiting for sysfs file reference count to go
> to zero to destroy it?

Given that the code does a trylock it should not.


