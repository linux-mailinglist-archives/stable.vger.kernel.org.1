Return-Path: <stable+bounces-223359-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Gh7D7z2qmlaZAEAu9opvQ
	(envelope-from <stable+bounces-223359-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 16:46:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 971A02241F9
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 16:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 886AF3036770
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 15:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25D13E9F82;
	Fri,  6 Mar 2026 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sin/qmdA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F9C3E8C4F;
	Fri,  6 Mar 2026 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772811851; cv=none; b=DC4wGs1es0SYEnooo2CNcbzIDjafQsPonG2SsbbvPqEO7pEbveyYzU6o0qfk8got0CSiRFvvw9lH9t7K46TwspfPmwz2ni4h4sSeQiDdv+Q8QmfR81R2w2tH5ORqys9UNfSWcTnSPs7hNj4g8kVd72JH5oXAfiWnIB4s8O/XARA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772811851; c=relaxed/simple;
	bh=Wk4h9dnWkeV9U+ZTFSAgXgbx28Yra+Fa6gacJCp9eGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fxr95KYOWoDG3bpp63aDDGD9cj6LifPT9YKY8XK54nKXuEQGui/WUUEYZOLcZUO5LRtVu69bKl7AnZQnZNyXUbX67GY4T9m6sMQyLQoFimWNVuIXd/K0Rny/phm/g9a+1DJu1RA/Hitx1BI9KvPb0QUOYjtNCbeSpbTXEajGrUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sin/qmdA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CE2C4CEF7;
	Fri,  6 Mar 2026 15:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772811851;
	bh=Wk4h9dnWkeV9U+ZTFSAgXgbx28Yra+Fa6gacJCp9eGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sin/qmdAh+e/cLQeAo844HNn73cnfzU0zCaK+3+yI6EQKZy9MgUHlMZfTkACMkyKc
	 nGe+r3tk5rmd59+6VDMakoi4yvDy+lCSprKwKB40jG2KH9tw6FMzpGj8zK8RMSd6tl
	 ucJ6SJywQ+x84Ds8R2AISvdvGCQ1omneuwqbqMFmEX9c+tygyAi+oSLR7Ceh8EoZdY
	 RwXUqrzDidOWGTZvYHsTOClFSvEUF3qEY7oJX4970UNlbPwlbl6cC/MK2XbXWitZmS
	 MZ+H7nmL51/ciAm6uORvQI3b6uzzQpDRPVn+eDRn1Q4SGg0TfFOSFYgy3zhSDsU/bi
	 xcV5fhyeMurXQ==
Date: Fri, 6 Mar 2026 17:44:04 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: memfd_luo: always make all folios uptodate
Message-ID: <aar2RJ3Bvs6Egmq8@kernel.org>
References: <20260223173931.2221759-1-pratyush@kernel.org>
 <20260223173931.2221759-2-pratyush@kernel.org>
 <aZ64ikDtz8tF_rFU@kernel.org>
 <2vxzqzpybqyd.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzqzpybqyd.fsf@kernel.org>
X-Rspamd-Queue-Id: 971A02241F9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223359-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.940];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 09:50:18AM +0100, Pratyush Yadav wrote:
> On Wed, Feb 25 2026, Mike Rapoport wrote:
> 
> > On Mon, Feb 23, 2026 at 06:39:28PM +0100, Pratyush Yadav wrote:
> [...]
> >> +
> >> +		/*
> >> +		 * If the folio is not uptodate, it was fallocated but never
> >> +		 * used. Saving this flag at prepare() doesn't work since it
> >> +		 * might change later when someone uses the folio.
> >> +		 *
> >> +		 * Since we have taken the performance penalty of allocating,
> >> +		 * zeroing, and pinning all the folios in the holes, take a bit
> >> +		 * more and zero all non-uptodate folios too.
> >> +		 *
> >> +		 * NOTE: For someone looking to improve preserve performance,
> >> +		 * this is a good place to look.
> >
> > I'd add a larger comment above memfd_luo_preserve_folios() that says that
> > it allocates, pins etc and fold the last two paragraphs of this comment
> > there.
> 
> How about this:
> 
> 	/*
> 	 * If the folio is not uptodate, it was fallocated but never
> 	 * used. Saving this flag at prepare() doesn't work since it
> 	 * might change later when the folio is used. Make it uptodate
> 	 * now to avoid this problem.
> 	 */
> 	if (!folio_test_uptodate(folio)) {
> 
> And the comment above memfd_pin_folios() gets this:
> 
> 	 * NOTE: For someone looking to improve preserve performance, this is a
> 	 * good place to look. Also look at the folio zeroing below.
 
Looks great to me

> [...]
> 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

