Return-Path: <stable+bounces-223604-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPTaNnqrrmntHQIAu9opvQ
	(envelope-from <stable+bounces-223604-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 12:14:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 333D8237B09
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 12:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 671DC30BAEEF
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 11:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1449396B91;
	Mon,  9 Mar 2026 11:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hLReKhy5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855E7396B82;
	Mon,  9 Mar 2026 11:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773054566; cv=none; b=cYSibFxRfA4d7zPZghjrsHAK6vmtEsIBhJiZGqgLcodig2EogolGSq4+5pRa9fh4ktNbUVhI3rpYiHMJ8Ps49eGuMy8kTNgLoLpBGDrGpALiWA0eMtFFpugalxUljX43DmTIdZo5T8b1rLTlK9ixf17XcSw2C+nl+Wa/3x1B0qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773054566; c=relaxed/simple;
	bh=C9CxlbuBkYwey1uKH3/UlC0KxzYwZ9MsY3WLQ4axT28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEcKecKIL2XdfMh2s2NOn0pzaExet2OTWbK+RQvOEXxP2pdKSTl0WBQEB2PaLtw69X2lC9WmT8s+SMPy13xlck8LrGZeiUqI5VK9Om9xDJLa43lhMLUHxK10iVF9U4srIjt8Ps4nxv0xY8+iP5HaX+vDmhLvoa2bjipZgafTIv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hLReKhy5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D27C2BC87;
	Mon,  9 Mar 2026 11:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773054566;
	bh=C9CxlbuBkYwey1uKH3/UlC0KxzYwZ9MsY3WLQ4axT28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hLReKhy5BDQfAiDiC/tv1nvYT+cE3jvBWEVy06oQ4Q9AtYOvfnMO0aHPPIk8s3O0S
	 IlDzKpQhBAm1E1ZFmCmX3XHrV5/qI86OP03PTgtME0Ti8juq9eMIDzqW4icwM1blaa
	 MpO5s1WImxkoCZ5tErxdJ5FjGpAme4R5i1IRf+34=
Date: Mon, 9 Mar 2026 12:07:14 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Breno Leitao <leitao@debian.org>
Cc: stable@kernel.org, Sasha Levin <sashal@kernel.org>,
	Corey Minyard <corey@minyard.net>,
	openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Vlad Poenaru <thevlad@meta.com>,
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH stable] ipmi: Fix use-after-free and list corruption on
 sender error
Message-ID: <2026030957-stricken-pebble-7b5a@gregkh>
References: <20260309-ipmi_stable-v1-1-be09c9686671@debian.org>
 <2026030953-imaging-resize-ce85@gregkh>
 <aa6mEr-pcU0iXNXG@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa6mEr-pcU0iXNXG@gmail.com>
X-Rspamd-Queue-Id: 333D8237B09
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-223604-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.259];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,minyard.net:email,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 03:52:41AM -0700, Breno Leitao wrote:
> On Mon, Mar 09, 2026 at 11:34:08AM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Mar 09, 2026 at 03:16:13AM -0700, Breno Leitao wrote:
> > > From: Corey Minyard <corey@minyard.net>
> > >
> > > [ Upstream commit f9323a44994c2ccd5e0d582bac6f2b2a662e5603 ]
> >
> > This is not a valid git id in Linus's tree :(
> 
> Sorry about that, Greg. The correct commit is
> 594c11d0e1d445f580898a2b8c850f2e3f099368 ("ipmi: Fix use-after-free and
> list corruption on sender error").
> 

Great, can you resend it?  And also let us know what branches you want
this applied to?

thanks,

greg k-h

