Return-Path: <stable+bounces-223601-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6L2kHnynrmkFHQIAu9opvQ
	(envelope-from <stable+bounces-223601-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:57:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DABFF2376F4
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FB4330763FB
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 10:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59CC390234;
	Mon,  9 Mar 2026 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Hu3BVn/b"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577A6364056;
	Mon,  9 Mar 2026 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773053575; cv=none; b=lMBBgt/TTialQXF67giiqsx0mfvWMHbkaSEXDnUB2WnggYwMbyH76aLvmANx0d8bmKFNYT+CFy51UU7ohnCj9gMWzI7xcQKGxYwJAqbFFM9nB1GhZQXygzI3LsVkEy1SZEYvitwW+3U4eBMCt06m25tn3ANFMds5feB4eiZUtp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773053575; c=relaxed/simple;
	bh=iktH1jROnqsVKKCnwzENbfNDMCokWUY8MGmKtoY2gsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdN/rGIBDTgV1dZYt8eBBc3HOhSCiMZns5ihX4sPLXfRliPnLhLd3pqJFJ3YJ/Z/K5kmjIPZTi2XUTuFenia54ZyQ4VqQIXyUOOBugw81DQqk8jwZhG6DisZd4RlpiUL3HW50fkhdC3l6lL4mqNqLkaSlbhqIZgWQ2RkUhVIdKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Hu3BVn/b; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iktH1jROnqsVKKCnwzENbfNDMCokWUY8MGmKtoY2gsY=; b=Hu3BVn/bqAPA7o+m4BY7cW/Bt2
	RGDh5/sFw0ZgPCf0rFFbK06Ycm1AYLjZXUvxl4CoEF82cwr5bMi/hKVf0k4cQ812rTJgPnzL0y6/K
	IsMviG19LcWJQz9VULjBEjfZ1qgnbbdKCkUU53shHDq0Dzydk6xvtM5BHGPZ4LIiLOE9P8rrXHDP2
	w6f445lkzEDE8AJE+rVEXbbaEQxTuUp2aDH+UNI894OfLRQniBNH5xPyVisLKW5xXhcHilSD1+Q/S
	F4EIdmSUe2tVKFo8RaUXDAYenXsyRFo7vIwvCs4nLqBNv/1VhZSLJDsHWveF4exaILPeM/VLXazcd
	NNU+iPTQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vzYEA-002ARk-Kp; Mon, 09 Mar 2026 10:52:46 +0000
Date: Mon, 9 Mar 2026 03:52:41 -0700
From: Breno Leitao <leitao@debian.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@kernel.org, Sasha Levin <sashal@kernel.org>, 
	Corey Minyard <corey@minyard.net>, openipmi-developer@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, Vlad Poenaru <thevlad@meta.com>, kernel-team@meta.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH stable] ipmi: Fix use-after-free and list corruption on
 sender error
Message-ID: <aa6mEr-pcU0iXNXG@gmail.com>
References: <20260309-ipmi_stable-v1-1-be09c9686671@debian.org>
 <2026030953-imaging-resize-ce85@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026030953-imaging-resize-ce85@gregkh>
X-Debian-User: leitao
X-Rspamd-Queue-Id: DABFF2376F4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[debian.org];
	TAGGED_FROM(0.00)[bounces-223601-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.945];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 11:34:08AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Mar 09, 2026 at 03:16:13AM -0700, Breno Leitao wrote:
> > From: Corey Minyard <corey@minyard.net>
> >
> > [ Upstream commit f9323a44994c2ccd5e0d582bac6f2b2a662e5603 ]
>
> This is not a valid git id in Linus's tree :(

Sorry about that, Greg. The correct commit is
594c11d0e1d445f580898a2b8c850f2e3f099368 ("ipmi: Fix use-after-free and
list corruption on sender error").


