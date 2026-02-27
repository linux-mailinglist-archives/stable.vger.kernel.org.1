Return-Path: <stable+bounces-219962-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CiEJNKdoWl8ugQAu9opvQ
	(envelope-from <stable+bounces-219962-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 14:36:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E641B7BE7
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 14:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4D21311D970
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 13:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2463E30DD22;
	Fri, 27 Feb 2026 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c4Mz9iaG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3624A21;
	Fri, 27 Feb 2026 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772199138; cv=none; b=LcBE15yvdkn+n8C6g8KzRyigjg7Aa/qOxdoIqyG9i8Vf+uL9oPPZmEtL1JhcCm07gt01CHJUz4S04add3qusRxDLQAVVwCzUtImeVxXawM2lRIK1FSOBYf+CNfKQSWRhnVYlpZlVMvnz4KWaP8V8Vtpbqv5C9eEeuYS6yiXSi+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772199138; c=relaxed/simple;
	bh=4v/ytv5xwbA2puCFcpMPowsoVSJ5308PQ1Gfyq6ubbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/tGUNYNrnZ3Amwac6ZwiANwcd7GPas6e7lNiwhCTkJzdqZPVCAc7g/mZdG/N7EF5SjbMhHCP7GlCrIAJ3QRy+QNZ5ahdunuB6LCiJ/X49ewGfmn8RnoujIdVfueMLXtTlzyx8DnKwVbUZaWLpmDodOEMlnbLnAKSp+NQI9IgxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c4Mz9iaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD74C116C6;
	Fri, 27 Feb 2026 13:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772199138;
	bh=4v/ytv5xwbA2puCFcpMPowsoVSJ5308PQ1Gfyq6ubbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c4Mz9iaG2E746KVkhM76BcUAEdKrPTYLsxfIM9873L2jdD4j/INlVZRUyONdh5U/t
	 r/rTAAM8+sYAtRowMl3NDk9tGz2OlX0vQSA+bLhMFAw8IQpBqaF93hTTVWaIceuDsW
	 SefLvqG12NEsXr1ScKPZSM10v4LMp02m2lqpfFk0=
Date: Fri, 27 Feb 2026 08:32:07 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: Genes Lists <lists@sapience.com>
Cc: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>,
	akpm@linux-foundation.org, jslaby@suse.cz,
	linux-kernel@vger.kernel.org, lwn@lwn.net, stable@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: Linux 6.19.4 - Oops, regression
Message-ID: <2026022750-everyone-huff-8fd0@gregkh>
References: <2026022657-clambake-mountable-8175@gregkh>
 <eb2d1da9-0b4b-4887-83a4-0e2a65e703aa@moonlit-rail.com>
 <2026022612-buckskin-surfacing-d854@gregkh>
 <bb9ab61c-3bed-4c3d-baf0-0bce4e142292@moonlit-rail.com>
 <67d9f732a55a31f3073675164e8d7ada46da3dbe.camel@sapience.com>
 <0a77c13e74493b786c5fe4e1ebdf55b14e5ff496.camel@sapience.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a77c13e74493b786c5fe4e1ebdf55b14e5ff496.camel@sapience.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-219962-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: E7E641B7BE7
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 08:18:52AM -0500, Genes Lists wrote:
> On Fri, 2026-02-27 at 07:09 -0500, Genes Lists wrote:
> > On Fri, 2026-02-27 at 01:26 -0500, Kris Karas (Bug Reporting) wrote:
> > > Greg KH wrote:
> > > > 
> > 
> >   Linux version 7.0.0-rc1-custom-1-00124-g3f4a08e64442 ...
> >   ...
> >   In file included from /etc/nftables.conf:134:2-44:
> >   ./etc/nftables.d/set_filter.conf:1746:7-21: Error:
> >   Could not process rule: File exists
> 
> Sorry for noise, not kernel related.
> Resolved by updated userspace.
> 
> Resolved by rebuilding userspace nftables on 6.19.4. 
> I used git head for all.
> 
>  nft rules now load without error using:
> 
>  - nftables commit de904e22faa2e450d0d4802e1d9bc22013044f93
>  - libmnl   commit 54dea548d796653534645c6e3c8577eaf7d77411
>  - libnftnl commit 5c5a8385dc974ea7887119963022ae988e2a16cc

Yet 7.0-rc1 worked just fine?  That feels wrong...

