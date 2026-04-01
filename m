Return-Path: <stable+bounces-232710-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IaqMGbLzGn5WgYAu9opvQ
	(envelope-from <stable+bounces-232710-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 09:38:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8D13760C9
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 09:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C57C8307A47E
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 07:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A54A38643D;
	Wed,  1 Apr 2026 07:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QJ0xbG6Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216BA3803E1
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 07:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028594; cv=none; b=PeM+mh/R59O9Om1wyv3ImDOWxmnIVCPDLfh5hFkEv0qr0ZZ6Zi6hbFdprScsNlu4TsKJtdBlJgQUwFdpLKAWlTBbcbSD6VykYR78XKD/4A/H2ZMvcJF7piQ8hHW8iT1xjURq3gx/vu8LiMN/OVHe2WYHiim+iEW4loLm+urw9w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028594; c=relaxed/simple;
	bh=gXUZsNneD1tBBWx88eLhjeerMVQGed8SWG9JNYjZGxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYF4Oom7XsAc45g+NcLb3/mjVZz9ZJtymCdmLldUSfWJWNTgSFNbOxspH0F7HJhtM5OpHGDpGGq4spK5BulFapq4n7IO0fXuhIIwgjtFwBoPGBFD4uNvh+w6Gb/Hn6vWYX0tCuE1P7Cz4v7eKZyePxT8pnKVGFEwwIV0+2ps5G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QJ0xbG6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B858C2BC9E;
	Wed,  1 Apr 2026 07:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775028593;
	bh=gXUZsNneD1tBBWx88eLhjeerMVQGed8SWG9JNYjZGxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QJ0xbG6QiIAcCxbAq1HAEid5IFKgsTLOib+IOg7b2z6z+TMSVKSQl1Gd11dJJL4hz
	 fO4VFl+HvI+mCxsvJPhaDDH0Ox1Jk6A44ttdIa7M4M9YMHJiW4arim+vRaATf5G1Z4
	 9q8nnpdazEOI/gNObptw1+ObclxLyNXeyTehJwws=
Date: Wed, 1 Apr 2026 09:29:27 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 6.12.y 0/9] Few stable backports for CVE fixes
Message-ID: <2026040116-paced-those-ca63@gregkh>
References: <20260324140456.832964-1-harshit.m.mogalapalli@oracle.com>
 <a3c185fd-2573-4061-8816-2762241a4144@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3c185fd-2573-4061-8816-2762241a4144@oracle.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-232710-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E8D13760C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 11:59:21AM +0530, Harshit Mogalapalli wrote:
> Hi Greg,
> 
> On 24/03/26 19:34, Harshit Mogalapalli wrote:
> > Hi stable maintainers,
> > 
> > I have tried backporting some fixes to stable kernel 6.12.y which also
> > have CVE numbers and are fixing commits in 6.12.y.
> > 
> Thanks a lot for queuing these up for 6.12.y stable tree.

Hey, thank _you_ for doing the real work here!

