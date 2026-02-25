Return-Path: <stable+bounces-218032-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id o9abETxInmnXUQQAu9opvQ
	(envelope-from <stable+bounces-218032-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:54:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 861E018E6B2
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0814303D2F7
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 00:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA98213E02A;
	Wed, 25 Feb 2026 00:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jkjfVSwB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EB64A0C
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 00:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771980855; cv=none; b=bRwi1HsbdWP9ZR1+pnIgEHiiKzjdWLfSX0sm7XeVdPMwI6ARZm5IrbRESDapBWV71alsW63+A3Yxz8Pa3fKsv2E4Qdz6h9mDrrrZuDRun1iVgEJ/bgN6295CV0eFSVMf3/BjtNTC8y5CILgwX4t3i0pcfuub4fbZ2me/IqETANE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771980855; c=relaxed/simple;
	bh=8JeLwPVSgUzAyNGZgbJOIX6ssqujoC8EkLXZ1Bws/UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gceS1TPicPpSz3foxcg3iY0ujT9FIqkOR1NgBkZDjqiTdwCGAsUJA3UyQnbYcvCPDMz6/PXP+62wpOGygKd/VbpU5Vug+NHClV3djwmT8jeqeokfoGlzQghwkTVDZdS60DptWEeEaH8wer/mh3ne5pWcQ9lYqIAS74KCc0Xja3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jkjfVSwB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B91C116D0;
	Wed, 25 Feb 2026 00:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771980855;
	bh=8JeLwPVSgUzAyNGZgbJOIX6ssqujoC8EkLXZ1Bws/UY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jkjfVSwB63JS/hAjtpIH99jZpLITIXq/e2Squ32JZqvSRiUByZwjcQI15rvQV9kk8
	 +cLpcPeQtI4t3MFS47PPAH1JywJI9b8KTZdvuDUBLOOqjDejE4814c77y/QtqDTkem
	 BMd/MpNo77JHV5tcscKIOWmZ0qFQ0DO8OU3iFJdI=
Date: Tue, 24 Feb 2026 16:54:08 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Joanne Koong <joannelkoong@gmail.com>, stable@vger.kernel.org,
	clm@meta.com
Subject: Re: [PATCH] io_uring/rsrc: clean up buffer cloning arg validation
 (for 6.18-stable tree)
Message-ID: <2026022403-latter-wow-3f07@gregkh>
References: <CAJnrk1YA9hk5Mv0BXFe+TcWLXsNLpWtcA-gy+k03zDt4f0z7zg@mail.gmail.com>
 <ee96be6b-f0d9-479c-8ab1-f8c7e04ccdeb@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee96be6b-f0d9-479c-8ab1-f8c7e04ccdeb@kernel.dk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218032-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 861E018E6B2
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 08:33:24AM -0700, Jens Axboe wrote:
> On 2/20/26 11:19 AM, Joanne Koong wrote:
> > Commit id upstream: b8201b50e403815f941d1c6581a27fdbfe7d0fd4
> > ("io_uring/rsrc: clean up buffer cloning arg validation")
> > Link to the patch:
> > https://lore.kernel.org/io-uring/20251204215116.2642044-1-joannelkoong@gmail.com/#t
> > Kernel version to apply it to: 6.18-stable tree
> > 
> > Hi stable@,
> > 
> > Chris Mason recently detected that this patch is a required dependency
> > for commit 5b804b8f1e0d ("io_uring/rsrc: fix lost entries after cloned
> > range") in the 6.18-stable tree [1]. Without this patch, the changes
> > in commit 5b804b8f1e0d use an incorrect value for nbufs when it
> > assigns "i = nbufs" [2].
> > 
> > Could you please apply this patch to the 6.18-stable tree as a
> > dependency fix needed for commit 5b804b8f1e0d?	
> > 
> > Thanks,
> > Joanne
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-6.18.y&id=5b804b8f1e0d66413774d43f7a4b78bba0ca6272
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/io_uring/rsrc.c?h=linux-6.18.y#n1252.
> 
> FWIW, this is approved on my end. CC Greg.

Now queued up, thanks.

greg k-h

